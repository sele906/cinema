package com.example.cinema.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.cinema.dto.TimeDTO;

@Repository
public class TimeDAO {

	@Autowired
	SqlSession sqlSession;


	public List<TimeDTO> choose_place(TimeDTO dto) {
		List<TimeDTO> daytable = null;
		daytable = sqlSession.selectList("time.cinema_place", dto);
		return daytable;
	}

	public List<TimeDTO> choose_time(TimeDTO dto) {
		List<TimeDTO> timelist = null;
		timelist = sqlSession.selectList("time.time", dto);
		return timelist;
	}

	public Map<String, Object> user_movie(int time_idx) {
		Map<String, Object> map = new HashMap<>();
		map = sqlSession.selectOne("time.userMovie", time_idx);
		return map;
	}

	public void insert_movie_info(Map<String, Object> map) {
		sqlSession.insert("time.movie_info_insert", map);
	}

	public int same_movie(int movie_cd) {
		int count = 0;
		try {
			count = sqlSession.selectOne("time.movie_same_count", movie_cd);
			return count;
		} catch (Exception e) {
			return count;
		}
	}

	public Map<String, Object> get_movie_info(int movie_cd) {
		Map<String, Object> movie_info = new HashMap<String, Object>();
		movie_info = sqlSession.selectOne("time.movie_info", movie_cd);
		return movie_info;
	}

	public int get_time_idx(TimeDTO dto) {
		int Tidx = 0;
		try {
			Tidx = sqlSession.selectOne("time.getTimeIdx", dto);
			return Tidx;
		} catch (Exception e) {
			return Tidx;
		}
	}

	public void insert_time(TimeDTO dto) {
		sqlSession.insert("time.insertTime", dto);
	}

}
