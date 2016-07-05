package com.tarena.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DBUtil {/**专门用于连接数据库*/
	//将数据库驱动引入
	static{try {//QQ群: 174510984
			Class.forName("oracle.jdbc.driver.OracleDriver");
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			}
	}
	/**专门用来连接oracle数据库*/
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
			}//用try-catch处理此异常
		}
	}
	
	
	
	public static void main(String[] args) {//测试数据库连接
		Connection conn=DBUtil.getConnection();
		System.out.println(conn);
	}
}
