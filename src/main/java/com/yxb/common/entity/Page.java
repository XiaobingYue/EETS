package com.yxb.common.entity;

import java.util.List;

public class Page<T> {
	private List<T> datas;
	private Integer totalsize;
	private Integer totalno;
	private Integer pageno;
	private Integer pagesize;
	public List<T> getDatas() {
		return datas;
	}
	public void setDatas(List<T> datas) {
		this.datas = datas;
	}
	public Integer getTotalsize() {
		return totalsize;
	}
	public void setTotalsize(Integer totalsize) {
		this.totalsize = totalsize;
	}
	public Integer getTotalno() {
		return totalno;
	}
	public void setTotalno(Integer totalno) {
		this.totalno = totalno;
	}
	public Integer getPageno() {
		return pageno;
	}
	public void setPageno(Integer pageno) {
		this.pageno = pageno;
	}
	public Integer getPagesize() {
		return pagesize;
	}
	public void setPagesize(Integer pagesize) {
		this.pagesize = pagesize;
	}
	
}
