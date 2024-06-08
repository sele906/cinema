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

	public List<TimeDTO> choosePlace(TimeDTO dto) {
		List<TimeDTO> daytable = null;
		daytable = sqlSession.selectList("time.cinema_place", dto);
		return daytable;
	}

	public List<TimeDTO> chooseTime(TimeDTO dto) {
		List<TimeDTO> timelist = null;
		timelist = sqlSession.selectList("time.time", dto);
		return timelist;
	}

	public Map<String, Object> userMovie(int time_idx) {
		Map<String, Object> map = new HashMap<>();
		map = sqlSession.selectOne("time.userMovie", time_idx);
		return map;
	}

	public void insertMovieInfo(Map<String, Object> map) {
		sqlSession.insert("movie_info_insert", map);
	}

	public int sameMovie(int movieCd) {
		int count = 0;
		try {
			count = sqlSession.selectOne("time.movie_same_count", movieCd);
			return count;
		} catch (Exception e) {
			return count;
		}
	}

	public Map<String, Object> getMovieInfo(int movieCd) {
		Map<String, Object> movie_info = new HashMap<String, Object>();
		movie_info = sqlSession.selectOne("time.movie_info", movieCd);
		return movie_info;
	}

	public int getTimeIdx(TimeDTO dto) {
		int Tidx = 0;
		try {
			Tidx = sqlSession.selectOne("time.getTimeIdx", dto);
			return Tidx;
		} catch (Exception e) {
			return Tidx;
		}
	}

	public void insertTime(TimeDTO dto) {
		sqlSession.insert("time.insertTime", dto);
	}

}
