package com.info.model.info;

import com.info.model.DTO;

public class InfoDTO extends DTO{
	private int info_no;
	private String info_genre;
	private String info_title;
	private String info_cont;
	private int info_hit;
	private String info_date;
	private String info_file;

	public int getInfo_no() {
		return info_no;
	}

	public void setInfo_no(int info_no) {
		this.info_no = info_no;
	}

	public String getInfo_genre() {
		return info_genre;
	}

	public void setInfo_genre(String info_genre) {
		this.info_genre = info_genre;
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

	public int getInfo_hit() {
		return info_hit;
	}

	public void setInfo_hit(int info_hit) {
		this.info_hit = info_hit;
	}

	public String getInfo_date() {
		return info_date;
	}

	public void setInfo_date(String info_date) {
		this.info_date = info_date;
	}

	public String getInfo_file() {
		return info_file;
	}

	public void setInfo_file(String info_file) {
		this.info_file = info_file;
	}

}
