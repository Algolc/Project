package com.tarena.entity;

import java.sql.Date;
import java.sql.Timestamp;

public class Cost {

	private Integer cost_id;
	private String name;
	private Integer base_duration;
	private Double base_cost;
	private Double unit_cost;
	private String status;
	private String descr;
	private Date creatime;
	private Date startime;
	private String cost_type;
	
	public Cost() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Cost(Integer costId, String name, Integer baseDuration,
			Double baseCost, Double unitCost, String status, String descr,
			Date creatime, Date startime, String costType) {
		super();
		cost_id = costId;
		this.name = name;
		base_duration = baseDuration;
		base_cost = baseCost;
		unit_cost = unitCost;
		this.status = status;
		this.descr = descr;
		this.creatime = creatime;
		this.startime = startime;
		cost_type = costType;
	}

	public Integer getCost_id() {
		return cost_id;
	}

	public void setCost_id(Integer cost_id) {
		this.cost_id = cost_id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getBase_duration() {
		return base_duration;
	}

	public void setBase_duration(Integer base_duration) {
		this.base_duration = base_duration;
	}

	public Double getBase_cost() {
		return base_cost;
	}

	public void setBase_cost(Double base_cost) {
		this.base_cost = base_cost;
	}

	public Double getUnit_cost() {
		return unit_cost;
	}

	public void setUnit_cost(Double unit_cost) {
		this.unit_cost = unit_cost;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getDescr() {
		return descr;
	}

	public void setDescr(String descr) {
		this.descr = descr;
	}

	public Date getCreatime() {
		return creatime;
	}

	public void setCreatime(Date creatime) {
		this.creatime = creatime;
	}

	public Date getStartime() {
		return startime;
	}

	public void setStartime(Date startime) {
		this.startime = startime;
	}

	public String getCost_type() {
		return cost_type;
	}

	public void setCost_type(String cost_type) {
		this.cost_type = cost_type;
	}

	@Override
	public String toString() {
		return "Cost [base_cost=" + base_cost + ", base_duration="
				+ base_duration + ", cost_id=" + cost_id + ", cost_type="
				+ cost_type + ", creatime=" + creatime + ", descr=" + descr
				+ ", name=" + name + ", startime=" + startime + ", status="
				+ status + ", unit_cost=" + unit_cost + "]";
	}
	

}
