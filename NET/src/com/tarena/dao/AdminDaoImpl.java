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
		Connection conn = DBUtil.getConnection();// ��һ��:��ȡ���ݿ�����
		Admin admin = null;// ��ȥ������ɵ�½,��ҳ,�޸���������ҳ��//�ڶ���:��
		try {// 2.1.��sql����װ��pstmt�����в����͵�oracle���ݿ�
			PreparedStatement pstmt = conn.prepareStatement(findAdmin);
			pstmt.setString(1, ADMIN_CODE);// 2.2.��sql��������
			ResultSet rs = pstmt.executeQuery();// 2.3.ִ��oracle�е�sql
			while (rs.next()) {// 2.4.��ȡ��ѯ�������(rs)�е����ݲ�����
				admin = new Admin();// cost������
				admin.setAdmin_id(rs.getInt("ADMIN_ID"));
				admin.setAdmin_code(rs.getString("ADMIN_CODE"));
				admin.setName(rs.getString("NAME"));
				admin.setPassword(rs.getString("PASSWORD"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}// ��������������к��д��־
		return admin;// 2.5.����cost����
	}
	
	
	
	
	
String findAdminRole = "select * from module_info where module_id in ("+
"select rm.module_id from admin_role ar inner join role_info ri on ri.role_id=ar.role_id "+
"inner join role_module rm on rm.role_id=ri.role_id where ar.admin_id=?"+
") order by module_id";
	public List<Module> findModulesByAdmin(int admin_id) {
		Connection conn = DBUtil.getConnection();// ��һ��:��ȡ���ݿ�����
		Module module = null;// ��ȥ������ɵ�½,��ҳ,�޸���������ҳ��//�ڶ���:��
		List<Module> list=new ArrayList<Module>();
		try {// 2.1.��sql����װ��pstmt�����в����͵�oracle���ݿ�
			PreparedStatement pstmt = conn.prepareStatement(findAdminRole);
			pstmt.setInt(1, admin_id);// 2.2.��sql��������
			ResultSet rs = pstmt.executeQuery();// 2.3.ִ��oracle�е�sql
			
			while (rs.next()) {// 2.4.��ȡ��ѯ�������(rs)�е����ݲ�����
				module = new Module();// cost������
				module.setModule_id(rs.getInt(1));
				module.setName(rs.getString(2));
				list.add(module);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}// ��������������к��д��־
		return list;// 2.5.����cost����
	}
	
	
	
	public static void main(String[] args) {
		System.out.println(new AdminDaoImpl().findModulesByAdmin(5000));
//		System.out.println(admin);
	}

}
