package com.example.cinema.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.example.cinema.dao.LikeDAO;
import com.example.cinema.dao.MypageDAO;
import com.example.cinema.dto.LikeDTO;
import com.example.cinema.dto.MemberDTO;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/mypage/*")
public class MypageController {
	@Autowired
	MypageDAO mypageDao;
	@Autowired
	LikeDAO likeDao;

	@GetMapping("detail.do")
	public ModelAndView detail(HttpSession session, ModelAndView mav) {
		String userid = (String) session.getAttribute("userid");
		try {
			MemberDTO dto = mypageDao.detail(userid);
			mav.setViewName("mypage/mypage");
			mav.addObject("dto", dto);
		} catch (Exception e) {
			mav.setViewName("member/login");
		}
		
		return mav;
	}

	@GetMapping("list.do")
	public ModelAndView list(HttpSession session, ModelAndView mav) {
		String userid = (String) session.getAttribute("userid");
		List<LikeDTO> items = likeDao.listLike(userid);
		mav.setViewName("mypage/list");
		mav.addObject("list", items);
		mav.addObject("type", "like");
		return mav;
	}
	
	@GetMapping("delete.do")
	public String delete(HttpSession session) {
		String userid = (String) session.getAttribute("userid");
		mypageDao.delete(userid);
		return "mypage/list";
	}
	
	
	
}
