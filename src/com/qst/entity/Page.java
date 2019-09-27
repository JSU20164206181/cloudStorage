/**
 * 
 */
package com.qst.entity;

/**
 * @ClassName: Page.java
 * @version: v1.0.0
 * @author: ZYL
 * @date: 2019年8月29日 下午8:55:13
 * @Description: 分页实体类
 */
public class Page {
	private int page = 1;
	private int pageSize = 5;

	public int getPage() {
		return (page - 1) * pageSize;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	@Override
	public String toString() {
		return "Page [page=" + page + ", pageSize=" + pageSize + "]";
	}

}
