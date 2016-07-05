package com.tarena.dao;

import java.util.List;
import com.tarena.entity.Admin;
import com.tarena.entity.Module;
import com.tarena.annotation.MyBatisRepository;

@MyBatisRepository
public interface AdminDao {
	Admin findByCode(String adminCode);//////
	List<Module> findModulesByAdmin(int adminId);///////
}
