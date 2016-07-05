package com.tarena.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.tarena.entity.Cost;
import com.tarena.entity.page.CostPage;
import com.tarena.entity.page.Page;
import com.tarena.util.DBUtil;

public class CostDaoImpl implements CostDao{
	String findAll="select * from cost order by cost_id";
	public List<Cost> findAll(){
		List<Cost> costs=new ArrayList<Cost>();
		Connection conn = DBUtil.getConnection();
		try {
			PreparedStatement pstmt = conn.prepareStatement(findAll);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				Cost cost=new Cost();
				cost.setBase_cost(rs.getDouble("BASE_COST"));
				cost.setBase_duration(rs.getInt("BASE_DURATION"));
				cost.setCost_id(rs.getInt("COST_ID"));
				cost.setName(rs.getString("NAME"));
				cost.setBase_cost(rs.getDouble("BASE_COST"));
				cost.setUnit_cost(rs.getDouble("UNIT_COST"));
				cost.setStatus(rs.getString("STATUS"));
				cost.setDescr(rs.getString("DESCR"));
				cost.setCreatime(rs.getDate("CREATIME"));
				cost.setStartime(rs.getDate("STARTIME"));
				cost.setCost_type(rs.getString("COST_TYPE"));
				costs.add(cost);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}// 这个方法正常运行后就写日志
		return costs;// 2.5.返回cost对象
	}
	
	//,?,?,?,?,?,?,?
	String addCost="insert into cost values(cost_seq.nextVal,?,?)";//////////////////////////////////////////////////////////
	public void addCost(Cost cost){////////////////////////////////////////////////////////////////////////////
		Connection conn = DBUtil.getConnection();
		PreparedStatement pstmt=null;
		try {
			pstmt = conn.prepareStatement(addCost);
			if(cost.getName().equalsIgnoreCase("")||cost.getName()==null){
				pstmt.setString(1, null);
			}else{
				pstmt.setString(1, cost.getName());
			}System.out.println(cost.getBase_duration()==null);
			if(cost.getBase_duration()==null||cost.getBase_duration()==0){
				pstmt.setInt(2, 0);
			}else{
				pstmt.setInt(2, cost.getBase_duration());
			}
			/*pstmt.setInt(2, cost.getBase_duration());
			pstmt.setDouble(3, cost.getBase_cost());
			pstmt.setDouble(4, cost.getUnit_cost());
			pstmt.setString(5,cost.getStatus());
			pstmt.setString(6, cost.getDescr());
			Date d=new Date(System.currentTimeMillis());
			pstmt.setDate(7, d);
			pstmt.setDate(8, cost.getStartime());
			pstmt.setString(9, cost.getCost_type());*/
			pstmt.executeUpdate();
			conn.commit();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	
	String findById="select * from cost where cost_id=?";
	public Cost findById(int id){
		Connection conn = DBUtil.getConnection();
		Cost cost=new Cost();
		try {
			PreparedStatement pstmt = conn.prepareStatement(findById);
			pstmt.setInt(1, id);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				cost.setBase_cost(rs.getDouble("BASE_COST"));
				cost.setBase_duration(rs.getInt("BASE_DURATION"));
				cost.setCost_id(rs.getInt("COST_ID"));
				cost.setName(rs.getString("NAME"));
				cost.setBase_cost(rs.getDouble("BASE_COST"));
				cost.setUnit_cost(rs.getDouble("UNIT_COST"));
				cost.setStatus(rs.getString("STATUS"));
				cost.setDescr(rs.getString("DESCR"));
				cost.setCreatime(rs.getDate("CREATIME"));
				cost.setStartime(rs.getDate("STARTIME"));
				cost.setCost_type(rs.getString("COST_TYPE"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return cost;
	}
	
	String updateCost="update cost set name=?,base_duration=?,base_cost=?,"+
			"unit_cost=?,descr=?,cost_type=? where cost_id=?";
	public void updateCost(Cost cost){
		Connection conn = DBUtil.getConnection();
		PreparedStatement pstmt=null;
		try {
			pstmt = conn.prepareStatement(updateCost);  
			pstmt.setString(1, cost.getName());
			pstmt.setInt(2, cost.getBase_duration());
			pstmt.setDouble(3, cost.getBase_cost());
			pstmt.setDouble(4, cost.getUnit_cost());
			pstmt.setString(5, cost.getDescr());
			pstmt.setString(6, cost.getCost_type());
			pstmt.setInt(7, cost.getCost_id());
			pstmt.executeUpdate();
			conn.commit();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	
	
	
	String deleteCost="delete from cost where cost_id=?";
	public void deleteCost(int costId){
		Connection conn = DBUtil.getConnection();
		PreparedStatement pstmt=null;
		try {
			pstmt = conn.prepareStatement(deleteCost);
			pstmt.setInt(1, costId);
			pstmt.executeUpdate();
			conn.commit();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	
	
	String findByPage="select * from ("+
						"select a.*,rownum r from ("+
							"select * from cost order by ";
	public List<Cost> findByPage(CostPage page){///////////////////////////////////////////////////////////////////////////////////////
		List<Cost> costs=new ArrayList<Cost>();
		Connection conn = DBUtil.getConnection();
		if(page.getBaseDurationSort()!=null){
			if(page.getBaseDurationSort().equals("asc")){
				findByPage=findByPage+"base_duration asc";
			}else{
				findByPage=findByPage+"base_duration desc";
			}
			if(page.getBaseCostSort()!=null){
				findByPage=findByPage+",";
			}
		}else if(page.getBaseCostSort()!=null){
			if(page.getBaseCostSort().equals("asc")){
				findByPage=findByPage+"base_cost asc";
			}else{
				findByPage=findByPage+"base_cost desc";
			}
		}else{
			findByPage=findByPage+"cost_id";
		}
		findByPage=findByPage+") a"+
		") where r<"+page.getEnd()+" and r>"+page.getBegin();
		try {
			PreparedStatement pstmt = conn.prepareStatement(findByPage);
			ResultSet rs = pstmt.executeQuery();
			int i=0;
			while (rs.next()) {
				Cost cost=new Cost();
				cost.setCost_id(rs.getInt("COST_ID"));
				cost.setName(rs.getString("NAME"));
				cost.setBase_duration(rs.getInt("BASE_DURATION"));
				cost.setBase_cost(rs.getDouble("BASE_COST"));
				cost.setBase_cost(rs.getDouble("BASE_COST"));
				cost.setUnit_cost(rs.getDouble("UNIT_COST"));
				cost.setStatus(rs.getString("STATUS"));
				cost.setDescr(rs.getString("DESCR"));
				cost.setCreatime(rs.getDate("CREATIME"));
				cost.setStartime(rs.getDate("STARTIME"));
				cost.setCost_type(rs.getString("COST_TYPE"));
				i++;
				costs.add(cost);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return costs;
	}
	
	
	
	
	
	
	
	
	
	
	String findCount="select count(*) from cost";
	public int findRows(){
		Connection conn = DBUtil.getConnection();
		int rows=0;
		try {
			PreparedStatement pstmt = conn.prepareStatement(findCount);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				rows=rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return rows;
	}
	
	
	
	
	
	public static void main(String[] args) {
		CostDaoImpl dao=new CostDaoImpl();
		/*List <Cost>list=dao.findAll();
		for (Cost c : list) {
			System.out.println(c);
		}*/
		//Cost c=new Cost(100,"包月xx10",100,100.0,10.0,"1","good2",null,null,"1");
//		dao.addCost(c);
//		System.out.println(dao.findById(9));
//		dao.updateCost(c);
//		dao.deleteCost(100);
//		System.out.println(dao.findRows());
		CostPage page=new CostPage();
//		page.setBaseDurationSort("desc");
		page.setBaseCostSort("asc");
		page.setCurrentPage(2);
		page.setPageSize(4);
		page.setRows(dao.findRows());
		List<Cost> costs=dao.findByPage(page);
		for (Cost cost : costs) {
			System.out.println(cost);
		}
	}




	
	public List<Cost> findByPage(Page page) {
		// TODO Auto-generated method stub
		return null;
	}



}
