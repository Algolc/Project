package com.tarena.util;

import java.beans.PropertyEditorSupport;
import java.sql.Date;
import java.text.SimpleDateFormat;
/**
 * 格式化日期用的
 */
public class DateEditor extends PropertyEditorSupport {
	
	/***日期格式*/
	private String pattern = "yyyy-MM-dd";
	
	/**无参构造器*/
	public DateEditor() {}
	
	/**一个参数的构造器*/
	public DateEditor(String pattern) {
		this.pattern = pattern;
	}

	/**将数据格式化后存储*/
	@Override
	public void setAsText(String text)throws IllegalArgumentException {
		if(text == null || text.length() == 0) {
			setValue(null);
		} else {
			SimpleDateFormat sf = new SimpleDateFormat(this.pattern);
			String dateStr = sf.format(Date.valueOf(text));
			setValue(Date.valueOf(dateStr));
		}
	}

}
