package com.example.cinema.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ReviewDTO {
	public int review_id;
	public String userid;
	public String movieTitle;
	public String moviecode;
	public String value;
	public String content;
	public String filename;
}
