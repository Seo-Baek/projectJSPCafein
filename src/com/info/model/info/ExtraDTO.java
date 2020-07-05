package com.info.model.info;

import com.info.model.DTO;

public class ExtraDTO extends DTO{

	private int info_no;
	private String extra_genre;
	private String info_title;
	private String info_cont;
	private String info_file;
	
	public int getInfo_no() {
		return info_no;
	}
	public void setInfo_no(int info_no) {
		this.info_no = info_no;
	}
	public String getExtra_genre() {
		return extra_genre;
	}
	public void setExtra_genre(String extra_genre) {
		this.extra_genre = extra_genre;
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
