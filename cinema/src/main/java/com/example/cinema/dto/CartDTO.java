package com.example.cinema.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CartDTO {
	private int cart_id;
	private String userid;
	private String filename;
	private int product_code;
	private int amount;
	private String product_name;
	private int price;
	private int money;
}
