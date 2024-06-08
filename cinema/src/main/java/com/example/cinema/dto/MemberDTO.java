package com.example.cinema.dto;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString

public class MemberDTO {
	private String userid;
	private String pwd1;
	private String pwd2;
	private String name;
	private String tel;
	private String email;
	private String birth;
	private String gender;
	private String addr1;
	private String addr2;
	private Date join_date;
	private int buy;
	private String filename;
}
