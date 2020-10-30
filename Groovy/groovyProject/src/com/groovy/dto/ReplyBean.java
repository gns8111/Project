package com.groovy.dto;

public class ReplyBean {
	private int R_index;
	private int C_index;
	private String id;
	private String R_contents;
	private String R_date;
	private int R_likeN;
	
	public int getR_index() {
		return R_index;
	}
	public void setR_index(int r_index) {
		R_index = r_index;
	}
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
	public String getR_contents() {
		return R_contents;
	}
	public void setR_contents(String r_contents) {
		R_contents = r_contents;
	}
	public String getR_date() {
		return R_date;
	}
	public void setR_date(String r_date) {
		R_date = r_date;
	}
	public int getR_likeN() {
		return R_likeN;
	}
	public void setR_likeN(int r_likeN) {
		R_likeN = r_likeN;
	}
	
	
}
