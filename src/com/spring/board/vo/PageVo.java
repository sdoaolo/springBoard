package com.spring.board.vo;

public class PageVo {
	
	private int pageNo = 0;
	private String type; 
	private String typeList[];

	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}
	
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	public String[] getTypeList() {
		return typeList;
	}

	public void setTypeList(String[] typeList) {
		this.typeList = typeList;
	}
}
