package com.tarena.util;

import java.beans.PropertyEditorSupport;
import java.sql.Date;
import java.text.SimpleDateFormat;
/**
 * ��ʽ�������õ�
 */
public class DateEditor extends PropertyEditorSupport {
	
	/***���ڸ�ʽ*/
	private String pattern = "yyyy-MM-dd";
	
	/**�޲ι�����*/
	public DateEditor() {}
	
	/**һ�������Ĺ�����*/
	public DateEditor(String pattern) {
		this.pattern = pattern;
	}

	/**�����ݸ�ʽ����洢*/
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
