package com.wirelesscity.service;

import java.util.List;

import org.springframework.jdbc.support.rowset.SqlRowSet;

import com.pager.Pager;
import com.wirelesscity.exception.HibernateDaoSupportException;

public interface JdbcService{
	
	public SqlRowSet getResultSet(String sql);
	
	@SuppressWarnings({ "rawtypes" })
	public List getList(String sql) ;
	
	/**
	 * 带有数组参数的查询
	 * @param sql
	 * @param args
	 * @return
	 */
	public List getResultWithArgs(String sql,Object[] args);
	
	public Pager findPagerBySql(String querySql, String queryCondtion,
			int currentPage, int pageSize) throws HibernateDaoSupportException;
	
}
