package com.tarena.entity;

import java.io.Serializable;
/**Ȩ�޶�Ӧ����Ӧ����(��Ӧĳ��Ȩ�޵�ģ��)*/
public class Module implements Serializable{
	private static final long serialVersionUID = 1L;
	/**ģ����*/
	private Integer module_id;
	/**Ȩ����*/
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
