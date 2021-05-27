package com.ss.sample.util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class DBDataUtils {

	private DBUtils dbUtils;

	@Autowired
	DBDataUtils(DBUtils dbUtils) {
		this.dbUtils = dbUtils;
	}



}
