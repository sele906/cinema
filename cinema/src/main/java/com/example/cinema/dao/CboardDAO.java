package com.example.cinema.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.cinema.dto.CboardDTO;

@Repository
public class CboardDAO {
	
	@Autowired
	SqlSession sqlSession;
	
	public int count(String search_option, String keyword) {
		int result = 0;
		try {
	        Map<String, Object> map = new HashMap<>();
	        map.put("search_option", search_option);
	        map.put("keyword", keyword);
	        result = sqlSession.selectOne("cboard.search_count", map);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return result;
	}
	
	public List<CboardDTO> list_search(String search_option, String keyword, int start, int end) {
		List<CboardDTO> list = null;
		try {
	        Map<String, Object> map = new HashMap<>();
	        map.put("search_option", search_option);
	        map.put("keyword", keyword);
	        map.put("start", start);
	        map.put("end", end);
	        list = sqlSession.selectList("cboard.search_list", map);
	        for (CboardDTO dto : list) {
	            String contents = dto.getContents();
	            String subject = dto.getSubject();
	            switch (search_option) {
	                case "all":
	                    contents = contents.replace(keyword, "<span style='color:red'>" + keyword + "</span>");
	                    subject = subject.replace(keyword, "<span style='color:red'>" + keyword + "</span>");
	                    break;
	                case "contents":
	                    contents = contents.replace(keyword, "<span style='color:red'>" + keyword + "</span>");
	                    break;
	                case "subject":
	                    subject = subject.replace(keyword, "<span style='color:red'>" + keyword + "</span>");
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
	
	public List<CboardDTO> list(int pageStart, int pageEnd) {
		List<CboardDTO> list = null;
		try {
	        Map<String, Object> map = new HashMap<>();
	        map.put("start", pageStart);
	        map.put("end", pageEnd);
	        list = sqlSession.selectList("cboard.list", map);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}
	
	public int count() {
		int result = 0;
		try {
	        result = sqlSession.selectOne("cboard.count");
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return result;
	}
	
	public void see(int num) {
		sqlSession.update("cboard.see", num);
	}
	
	public CboardDTO view(int num) {
		CboardDTO dto = null;
	    try {
	        dto = sqlSession.selectOne("cboard.view", num);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return dto;
	}
	
	public int ccount(String csearch_option, String keyword) {
		int result = 0;
		try {
	        Map<String, Object> map = new HashMap<>();
	        map.put("csearch_option", csearch_option);
	        map.put("keyword", keyword);
	        result = sqlSession.selectOne("cboard.csearch_count", map);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return result;
	}
	
	public List<CboardDTO> list_csearch(String csearch_option, String keyword, int start, int end) {
		List<CboardDTO> list = null;
		try {
	        Map<String, Object> map = new HashMap<>();
	        map.put("csearch_option", csearch_option);
	        map.put("keyword", keyword);
	        map.put("start", start);
	        map.put("end", end);
	        list = sqlSession.selectList("cboard.csearch_list", map);
	        for (CboardDTO dto : list) {
	            String contents = dto.getContents();
	            String subject = dto.getSubject();
	            switch (csearch_option) {
	                case "all":
	                    contents = contents.replace(keyword, "<span style='color:red'>" + keyword + "</span>");
	                    subject = subject.replace(keyword, "<span style='color:red'>" + keyword + "</span>");
	                    break;
	                case "contents":
	                    contents = contents.replace(keyword, "<span style='color:red'>" + keyword + "</span>");
	                    break;
	                case "subject":
	                    subject = subject.replace(keyword, "<span style='color:red'>" + keyword + "</span>");
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

}
