package com.example.cinema.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.cinema.dto.LikeDTO;

@Repository
public class LikeDAOImpl implements LikeDAO {
	@Autowired
	SqlSession sqlSession;

	@Override
	public void insertLike(LikeDTO dto) {
		sqlSession.insert("like.insert", dto);
	}

	@Override
	public List<LikeDTO> listLike(String userid) {
		return sqlSession.selectList("like.list", userid);
	}

	@Override
	public void deleteLikes(LikeDTO dto) {
		sqlSession.delete("like.delete", dto);

	}

	@Override
	public LikeDTO heart(LikeDTO dto) {
		return sqlSession.selectOne("like.heart", dto);

	}

}
