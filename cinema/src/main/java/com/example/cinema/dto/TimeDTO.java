package com.example.cinema.dto;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class TimeDTO {
	private int time_idx;
	private String cinema_place;
	private String movie_title;
	private String time;
	private int theater_num;
	private Date datetime1;
}
