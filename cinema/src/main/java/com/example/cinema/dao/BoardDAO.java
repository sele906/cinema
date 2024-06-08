package com.example.cinema.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.cinema.dto.BoardDTO;

@Repository
public class BoardDAO {
	
	@Autowired
	SqlSession sqlSession;
	
	public int count(String search_option, String keyword) {
		int result = 0;
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("search_option", search_option);
			map.put("keyword", keyword);
			result = sqlSession.selectOne("board.search_count", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public int count() {
		int result = 0;
		result = sqlSession.selectOne("board.count");
		return result;
	}
	
	public int numcount(int type) {
		int result = 0;
		try {
			result = sqlSession.selectOne("board.numcount", type);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public List<BoardDTO> list_search(String search_option, String keyword, int start, int end) {
		List<BoardDTO> list = null;
		try {
			Map<String, Object> map = new HashMap<>();

			map.put("search_option", search_option);
			map.put("keyword", keyword);
			map.put("start", start);
			map.put("end", end);
			list = sqlSession.selectList("board.search_list", map);
			for (BoardDTO dto : list) {
				String subject = dto.getSubject();
				String contents = dto.getContents();
				switch (search_option) {
				case "all":
					subject = subject.replace(keyword, "<span style='color:red'>" + keyword + "</span>");
					contents = contents.replace(keyword, "<span style='color:red'>" + keyword + "</span>");
					break;
				case "subject":
					subject = subject.replace(keyword, "<span style='color:red'>" + keyword + "</span>");
					break;
				case "contents":
					contents = contents.replace(keyword, "<span style='color:red'>" + keyword + "</span>");
					break;

				}
				dto.setContents(contents);
				dto.setSubject(subject);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public void see(int num) {
		sqlSession.update("board.see", num);
	}
	
	public List<BoardDTO> list(/* int pageStart, int pageEnd */) {
		List<BoardDTO> list = sqlSession.selectList("board.list");
		return list;
	}
	
	public void insert(BoardDTO dto) {
		sqlSession.insert("board.insert", dto);
	}
	
	public BoardDTO post(int num) {
		BoardDTO dto = sqlSession.selectOne("board.post", num);
		return dto;
	}
	
	public void update(BoardDTO dto) {
		sqlSession.update("board.update", dto);
	}
	
	public void delete(int num) {
		sqlSession.delete("board.delete", num);
	}
	
	public String getFilename(int num) {
		String result = null;
		result = sqlSession.selectOne("board.filename", num);
		return result;
	}
	
	public List<BoardDTO> list(int pageStart, int pageEnd) {
		Map<String, Object> map = new HashMap<>();
		map.put("start", pageStart);
		map.put("end", pageEnd);
		List<BoardDTO> list = sqlSession.selectList("board.list", map);
		return list;
	}
	
	public List<BoardDTO> noti(int type, int pageStart, int pageEnd) {
		Map<String, Object> map = new HashMap<>();
		map.put("type", type);
		map.put("start", pageStart);
		map.put("end", pageEnd);
		List<BoardDTO> list = sqlSession.selectList("board.noti", map);
		return list;
	}

}
