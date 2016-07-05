package com.tarena.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.tarena.entity.Admin;
import com.tarena.entity.Module;
import com.tarena.util.DBUtil;

public class AdminDaoImpl {
	String findAdmin = "select * from admin_info where admin_code=?";
	public Admin findAdmin(String ADMIN_CODE) {
		Connection conn = DBUtil.getConnection();// 第一步:获取数据库连接
		Admin admin = null;// 回去继续完成登陆,主页,修改密码三个页面//第二步:查
		try {// 2.1.将sql语句封装到pstmt对象中并发送到oracle数据库
			PreparedStatement pstmt = conn.prepareStatement(findAdmin);
			pstmt.setString(1, ADMIN_CODE);// 2.2.给sql设置条件
			ResultSet rs = pstmt.executeQuery();// 2.3.执行oracle中的sql
			while (rs.next()) {// 2.4.获取查询结果对象(rs)中的数据并放入
				admin = new Admin();// cost对象中
				admin.setAdmin_id(rs.getInt("ADMIN_ID"));
				admin.setAdmin_code(rs.getString("ADMIN_CODE"));
				admin.setName(rs.getString("NAME"));
				admin.setPassword(rs.getString("PASSWORD"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}// 这个方法正常运行后就写日志
		return admin;// 2.5.返回cost对象
	}
	
	
	
	
	
String findAdminRole = "select * from module_info where module_id in ("+
"select rm.module_id from admin_role ar inner join role_info ri on ri.role_id=ar.role_id "+
"inner join role_module rm on rm.role_id=ri.role_id where ar.admin_id=?"+
") order by module_id";
	public List<Module> findModulesByAdmin(int admin_id) {
		Connection conn = DBUtil.getConnection();// 第一步:获取数据库连接
		Module module = null;// 回去继续完成登陆,主页,修改密码三个页面//第二步:查
		List<Module> list=new ArrayList<Module>();
		try {// 2.1.将sql语句封装到pstmt对象中并发送到oracle数据库
			PreparedStatement pstmt = conn.prepareStatement(findAdminRole);
			pstmt.setInt(1, admin_id);// 2.2.给sql设置条件
			ResultSet rs = pstmt.executeQuery();// 2.3.执行oracle中的sql
			
			while (rs.next()) {// 2.4.获取查询结果对象(rs)中的数据并放入
				module = new Module();// cost对象中
				module.setModule_id(rs.getInt(1));
				module.setName(rs.getString(2));
				list.add(module);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}// 这个方法正常运行后就写日志
		return list;// 2.5.返回cost对象
	}
	
	
	
	public static void main(String[] args) {
		System.out.println(new AdminDaoImpl().findModulesByAdmin(5000));
//		System.out.println(admin);
	}

}
