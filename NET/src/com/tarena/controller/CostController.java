package com.tarena.controller;

import java.sql.Date;
import java.util.List;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.tarena.dao.CostDao;
import com.tarena.dao.CostDaoImpl;
import com.tarena.entity.Cost;
import com.tarena.entity.page.CostPage;


@Controller//标记本类是自定义控制器
@RequestMapping("/cost")//给出资费功能的路径
public class CostController {
	//@Resource//表示此处需要注入一个CostDao类型的一个对象
	//CostDao costDao;//用来操作资费数据的类
	@RequestMapping("/findCost.do")
	public String findCost(CostPage page,Model model){
		CostDaoImpl costDao=new CostDaoImpl();
		//Page对象存储分页信息(当前页码，当前页中的数据)
		//(Model用来存储数据的，可以将Page对象存入Model中)
		page.setRows(costDao.findRows());
		//用costDao查询cost表总共有多少条数据，并将数据总量放入page
		//对象中
		model.addAttribute("costPage",page);//将封装页码数据的page对象存入
		List<Cost> list=costDao.findByPage(page);
		for (Cost cost : list) {
			System.out.println(cost);
		}
		model.addAttribute("costs",list);//根据page对象的页码信息
		return "cost/cost_list";//查询出一页信息并存入model中
		//将model中的数据显示到cost/cost_list.jsp中
	}//jdbc.properties中密码如果不对就要改(oracle数据库的密码)
	
	
	//1.在浏览器输入http://localhost:8088/tr_net24_cost/cost/findCost.do
	//2.通过localhost找到一台电脑，  8088找到tomcat
	//项目名字到tomcat的webapps下找要执行的项目
	//根据cost/findCost.do找标注有cost的类下得标注有findCost的方法
	//3.执行此方法
	
	
	
	//访问添加页面的方法
	@RequestMapping("/toAddCost.do")
	public String toAddCost(){
		return "cost/add_cost";
	}
	
	
	//提交添加数据的方法
	@RequestMapping("/addCost.do")
	public String addCost(Cost cost){
		CostDao costDao=new CostDaoImpl();
		cost.setStatus("1");
		cost.setCreatime(
		new Date(System.currentTimeMillis()));
		costDao.addCost(cost);
		return "redirect:findCost.do";
	}
	//添加操作
	//显示所有资费数据的操作
	//所以需要用到redirect
	
	
	
	
	
	//删除Cost数据
	@RequestMapping("/deleteCost.do")
	public String deleteCost(@RequestParam("id")int id){
		CostDao costDao=new CostDaoImpl();
		//@RequestParam("id")表示接受网页发送的变量名为id的数据
		//int id是给存储此数据的变量重新起一个名字
		costDao.deleteCost(id);
		//使用costDao对象根据cost的id(资费信息的id)删除cost数据
		return "redirect:findCost.do";
		//删除成功后跳转到查询所有cost数据的页面
	}
	
	//@RequestMapping给toUpdate方法添加标记//通过此
	@RequestMapping("toUpdateCost.do")//标记就可以
	public String toUpdateCost(//找到此方法
			@RequestParam("id")int id,//@RequestParam
			Model model){//("id")接受网页传递的参数,
		CostDao costDao=new CostDaoImpl();
		//int id是给此参数重新起一个名字//
		Cost cost=costDao.findById(id);//根据id从数据库
		model.addAttribute("cost",cost);//查询本条数据
		return "cost/update_cost";//并存储到model中
	}//然后跳转到修改页面(在修改页面会获取model中的数据)
	//显示到表单中
	@RequestMapping("/updateCost.do")
	public String updateCost(Cost cost){
		CostDao costDao=new CostDaoImpl();
		costDao.updateCost(cost);//使用costdao修改提交
		return "redirect:findCost.do";//的数据并
	}//让网页跳转到显示所有资费数据的页面
}
