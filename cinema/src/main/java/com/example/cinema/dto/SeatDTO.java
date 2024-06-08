package com.example.cinema.dto;

import java.util.Date;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SeatDTO {
	private int ticket_idx;
	private int theater_num;
	private String seat_name;
	private String userid;
	private String cinema_place;
	private Date time;
	private String datetime;
}
