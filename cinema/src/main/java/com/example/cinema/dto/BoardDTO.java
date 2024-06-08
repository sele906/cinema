package com.example.cinema.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString

public class BoardDTO {

	private int num;
	private String contents;
	private String subject;
	private String reg_date;
	private int type;
	private int see;
	private String filename;
	private int filesize;
	

}
