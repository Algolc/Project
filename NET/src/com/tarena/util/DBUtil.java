package com.tarena.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DBUtil {/**ר�������������ݿ�*/
	//�����ݿ���������
	static{try {//QQȺ: 174510984
			Class.forName("oracle.jdbc.driver.OracleDriver");
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			}
	}
	/**ר����������oracle���ݿ�*/
	public static Connection getConnection(){
		Connection conn=null;
		try {
			conn=DriverManager.getConnection(
			"jdbc:oracle:thin:@localhost:1521:xe",
			"yangyu","123456");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return conn;
	}
	
	public static void closeConn(Connection conn){
		if(conn!=null){
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}//��try-catch������쳣
		}
	}
	
	
	
	public static void main(String[] args) {//�������ݿ�����
		Connection conn=DBUtil.getConnection();
		System.out.println(conn);
	}
}
