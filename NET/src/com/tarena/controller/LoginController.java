package com.tarena.controller;

import java.awt.image.BufferedImage;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tarena.dao.AdminDaoImpl;
import com.tarena.entity.Admin;
import com.tarena.entity.Module;
import com.tarena.util.ImageUtil;

@Controller
@RequestMapping("/login")
public class LoginController{
	
	@RequestMapping("/toLogin.do")
	public String toLogin(){
		return "main/login";
	}
	
	@RequestMapping("/toIndex.do")
	public String toIndex(){
		return "main/index";
	}
	
	public static final int success=0;
	public static final int admin_code_error=1;
	public static final int password_error=2;
	public static final int image_code_error=3;
	@RequestMapping("/login.do")
	@ResponseBody
	public Map<String,Object> login(String adminCode,String password,String code,HttpSession session){
		Map<String,Object> result=new HashMap<String,Object>();
		String imageCode=(String)session.getAttribute("imageCode");
		//System.out.println(adminCode+"--"+password+"--"+code);
		if(code==null||!imageCode.equalsIgnoreCase(code)){
			result.put("flag", image_code_error);
			return result;
		}
		AdminDaoImpl adminDao=new AdminDaoImpl();
		Admin admin=adminDao.findAdmin(adminCode);
		if(admin == null) {
			result.put("flag", admin_code_error);
			return result;
		} else if (!admin.getPassword().equals(password)) {
			result.put("flag", password_error);
			return result;
		} else {
			session.setAttribute("admin", admin);
			List<Module> modules = 
				adminDao.findModulesByAdmin(admin.getAdmin_id());/////////////////////////////////
			System.out.println(modules);
//			adminDao.findModulesByAdmin(admin.getId());
			session.setAttribute("allModules",modules);
			result.put("flag", success);
			return result;
		}
	}
	
	
	/*	
	if(adminCode.equalsIgnoreCase(admin.getAdmin_code())&&"123".equalsIgnoreCase(admin.getPassword())){
		result.put("flag", success);
		return result;
	}else{
		result.put("flag", 4);
		return result;
	}
	*/
	
	
	@RequestMapping("/createImage.do")
	public void createImage(HttpServletResponse response, HttpSession session)
			throws Exception {//System.out.println("ÑéÖ¤Âí");
		Map<String, BufferedImage> imageMap = ImageUtil.createImage();
		String code = imageMap.keySet().iterator().next();
		session.setAttribute("imageCode", code);
		BufferedImage image = imageMap.get(code);
		response.setContentType("image/jpeg");
		OutputStream ops = response.getOutputStream();
		ImageIO.write(image, "jpeg", ops);
		ops.close();
	}
	
}
