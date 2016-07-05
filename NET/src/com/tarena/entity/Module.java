package com.tarena.entity;

import java.io.Serializable;
/**权限对应的相应操作(对应某个权限的模块)*/
public class Module implements Serializable{
	private static final long serialVersionUID = 1L;
	/**模块名*/
	private Integer module_id;
	/**权限名*/
	private String name;

	public Integer getModule_id() {
		return module_id;
	}

	public void setModule_id(Integer module_id) {
		this.module_id = module_id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Override
	public String toString() {
		return "Module [module_id=" + module_id + ", name=" + name + "]";
	}
	
}
