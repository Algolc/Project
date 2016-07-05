package com.tarena.controller;

import org.springframework.web.bind.WebDataBinder;
import com.tarena.util.DateEditor;

public class BaseController {
	public void initBinder(WebDataBinder binder){
		binder.registerCustomEditor(java.sql.Date.class, new DateEditor());
	}
}
