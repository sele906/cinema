package com.example.cinema.dao;

import java.util.List;

import com.example.cinema.dto.ReviewDTO;

public interface ReviewDAO {
	public void insert(ReviewDTO dto);

	public List<ReviewDTO> list(String userid);

	public void delete(ReviewDTO dto);

	public List<ReviewDTO> listAll(int pageStart, int pageEnd, String moviecode);

	public int count(String moviecode);
}
