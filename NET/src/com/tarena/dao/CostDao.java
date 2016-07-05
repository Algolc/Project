package com.tarena.dao;

import java.util.List;

import com.tarena.annotation.MyBatisRepository;
import com.tarena.entity.Cost;
import com.tarena.entity.page.Page;

@MyBatisRepository
public interface CostDao {

	List<Cost> findAll();

	void addCost(Cost cost);

	Cost findById(int id);

	void updateCost(Cost cost);

	void deleteCost(int id);
	
	List<Cost> findByPage(Page page);
	
	int findRows();

}
