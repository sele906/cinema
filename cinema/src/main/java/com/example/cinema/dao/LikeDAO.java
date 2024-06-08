package com.example.cinema.dao;

import java.util.List;

import com.example.cinema.dto.LikeDTO;

public interface LikeDAO {
	public void insertLike(LikeDTO dto);

	public List<LikeDTO> listLike(String userid);

	public void deleteLikes(LikeDTO dto);

	public LikeDTO heart(LikeDTO dto);
}
