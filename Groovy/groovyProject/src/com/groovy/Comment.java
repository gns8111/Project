package com.groovy;

public class Comment {
	private int C_index;
	private String id;
	private String C_date;
	private String C_contents;
	private int C_like;
	
	public int getC_index() {
		return C_index;
	}
	public void setC_index(int c_index) {
		C_index = c_index;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getC_date() {
		return C_date;
	}
	public void setC_date(String c_date) {
		C_date = c_date;
	}
	public String getC_contents() {
		return C_contents;
	}
	public void setC_contents(String c_contents) {
		C_contents = c_contents;
	}
	public int getC_like() {
		return C_like;
	}
	public void setC_like(int c_like) {
		C_like = c_like;
	}
	
}
