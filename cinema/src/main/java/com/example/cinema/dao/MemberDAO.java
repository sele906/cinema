package com.example.cinema.dao;

import java.util.List;

import com.example.cinema.dto.MemberDTO;

public interface MemberDAO {
	public List<MemberDTO> listMember();

	public MemberDTO detailMember(String userid);

	public void insert(MemberDTO dto);

	public String findId(MemberDTO dto);

	public String findPwd(MemberDTO dto);

	public String check(String userid);

	public MemberDTO login(MemberDTO dto);

	public void buy(MemberDTO dto);

	public MemberDTO edit(String userid);

	public void update(MemberDTO dto);
}
