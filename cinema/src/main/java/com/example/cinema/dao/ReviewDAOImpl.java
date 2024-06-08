package com.example.cinema.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.cinema.dto.ReviewDTO;

@Repository
public class ReviewDAOImpl implements ReviewDAO {
	@Autowired
	SqlSession sqlSession;

	@Override
	public void insert(ReviewDTO dto) {
		sqlSession.insert("review.insert", dto);
	}

	@Override
	public List<ReviewDTO> list(String userid) {
		List<ReviewDTO> list = sqlSession.selectList("review.list", userid);
		return list;
	}

	@Override
	public void delete(ReviewDTO dto) {
		sqlSession.delete("review.delete", dto);
	}

	@Override
	public List<ReviewDTO> listAll(int pageStart, int pageEnd, String moviecode) {
		Map<String, Object> map = new HashMap<>();
		map.put("start", pageStart);
		map.put("end", pageEnd);
		map.put("moviecode", moviecode);
		List<ReviewDTO> list = sqlSession.selectList("review.listAll", map);
		return list;
	}

	@Override
	public int count(String moviecode) {
		int result = 0;
		result = sqlSession.selectOne("review.count", moviecode);
		return result;
	}

}
