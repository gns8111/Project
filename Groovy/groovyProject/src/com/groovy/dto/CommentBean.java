package com.groovy.dto;

public class CommentBean {

	private int c_index;
	private int p_index;
	private String id;
	private String c_date;
	private String c_contents;
	private int c_like;
	private int commnetInt;

	public int getCommnetInt() {
		return commnetInt;
	}

	public void setCommnetInt(int commnetInt) {
		this.commnetInt = commnetInt;
	}

	public int getC_index() {
		return c_index;
	}

	public void setC_index(int c_index) {
		this.c_index = c_index;
	}

	public int getP_index() {
		return p_index;
	}

	public void setP_index(int p_index) {
		this.p_index = p_index;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getC_date() {
		return c_date;
	}

	public void setC_date(String c_date) {
		this.c_date = c_date;
	}

	public String getC_contents() {
		return c_contents;
	}

	public void setC_contents(String c_contents) {
		this.c_contents = c_contents;
	}

	public int getC_like() {
		return c_like;
	}

	public void setC_like(int c_like) {
		this.c_like = c_like;
	}
}
