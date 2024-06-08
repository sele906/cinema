package com.example.cinema.dao;

import com.example.cinema.dto.MemberDTO;

public interface MypageDAO {
	public void update(MemberDTO dto);

	public boolean delete(String userid);

	public MemberDTO detail(String userid);

}
