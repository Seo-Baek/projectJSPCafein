package com.info.model.info;

import com.info.model.DTO;

public class CountryDTO extends DTO{

	private int info_no;
	private int coun_no;
	private String coun_7;
	private String coun_add;
	private String info_title;
	private String info_cont;
	private String info_file;
	
	public int getInfo_no() {
		return info_no;
	}
	public void setInfo_no(int info_no) {
		this.info_no = info_no;
	}
	public int getCoun_no() {
		return coun_no;
	}
	public void setCoun_no(int coun_no) {
		this.coun_no = coun_no;
	}
	public String getCoun_7() {
		return coun_7;
	}
	public void setCoun_7(String coun_7) {
		this.coun_7 = coun_7;
	}
	public String getCoun_add() {
		return coun_add;
	}
	public void setCoun_add(String coun_add) {
		this.coun_add = coun_add;
	}
	public String getInfo_title() {
		return info_title;
	}
	public void setInfo_title(String info_title) {
		this.info_title = info_title;
	}
	public String getInfo_cont() {
		return info_cont;
	}
	public void setInfo_cont(String info_cont) {
		this.info_cont = info_cont;
	}
	public String getInfo_file() {
		return info_file;
	}
	public void setInfo_file(String info_file) {
		this.info_file = info_file;
	}

}
