package com.example.cinema.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.web.multipart.MultipartFile;

@Getter
@Setter
@ToString
public class EventDTO {
	private int num;
	private String type;
	private String subject;
	private String reg_date;
	private int hit;
	private String contents;
	private String filename1;
	private String filename2;
}