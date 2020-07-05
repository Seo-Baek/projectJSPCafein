package com.info.model.beans;

import com.info.model.DTO;

public class QueDTO extends DTO{
	
	private int que_no;
	private String que_genre;
	private String que_title;
	private int que_hit;
	
	public int getQue_no() {
		return que_no;
	}
	public void setQue_no(int que_no) {
		this.que_no = que_no;
	}
	public String getQue_genre() {
		return que_genre;
	}
	public void setQue_genre(String que_genre) {
		this.que_genre = que_genre;
	}
	public String getQue_title() {
		return que_title;
	}
	public void setQue_title(String que_title) {
		this.que_title = que_title;
	}
	public int getQue_hit() {
		return que_hit;
	}
	public void setQue_hit(int que_hit) {
		this.que_hit = que_hit;
	}

}
