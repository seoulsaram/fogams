package com.finals.fogams.model.biz;

import java.util.List;

import com.finals.fogams.model.dto.CompanyDto;

public interface CompanyBiz {

public List<CompanyDto> selectList();
	
	public CompanyDto selectOne(int company_no);
	
	public int insert(CompanyDto dto);
	
	public int update(CompanyDto dto);
	
	public int delete(int company_no);
	
}