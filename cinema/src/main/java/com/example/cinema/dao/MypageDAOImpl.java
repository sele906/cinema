package com.example.cinema.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.cinema.dto.MemberDTO;

@Repository
public class MypageDAOImpl implements MypageDAO {
	@Autowired
	SqlSession sqlSession;

	@Override
	public void update(MemberDTO dto) {
		sqlSession.update("mypage.update", dto);
	}

	@Override
	public boolean delete(String userid) {
		sqlSession.delete("mypage.delete", userid);
		return false;
	}

	@Override
	public MemberDTO detail(String userid) {
		MemberDTO dto= sqlSession.selectOne("mypage.detail",userid);
		return dto;
	}

}
