package com.tarena.dao;

import java.util.ArrayList;
import java.util.List;

import com.tarena.entity.Cost;
import com.tarena.entity.page.CostPage;

public class Test {
	public static void main(String[] args) {
		CostPage page=new CostPage();
//		page.setBaseDurationSort("desc");
		/*page.setBaseCostSort("asc");
		page.setCurrentPage(2);
		page.setPageSize(4);*/
		Test dao=new Test();
		page.setRows(50);
		List<Cost> costs=dao.findByPage(page);
		for (Cost cost : costs) {
			System.out.println(cost);
		}
	}
	
	
	public List<Cost> findByPage(CostPage page){
		List<Cost> costs=new ArrayList<Cost>();
		Cost cost=new Cost();
		cost.setCost_id(1);
		cost.setName("zz");
		costs.add(cost);
		cost.setCost_id(2);
		cost.setName("zz2");
		costs.add(cost);
		return costs;
	}
}
