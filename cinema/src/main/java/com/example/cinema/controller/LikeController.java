package com.example.cinema.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.cinema.dao.LikeDAO;
import com.example.cinema.dao.ReviewDAO;
import com.example.cinema.dto.LikeDTO;
import com.example.cinema.dto.ReviewDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import page.PageUtil;

@Controller
public class LikeController {
	@Autowired
	LikeDAO likeDao;
	@Autowired
	ReviewDAO reviewDao;

	@GetMapping("/like/heart.do")
	public ModelAndView heart(ModelAndView mav, HttpServletRequest request, HttpSession session) {
		String moviecode = request.getParameter("movieCd");
		int count = reviewDao.count(moviecode);
		int cur_page = 1;
		if (request.getParameter("cur_page") != null) {
			cur_page = Integer.parseInt(request.getParameter("cur_page"));
		}
		PageUtil page = new PageUtil(count, cur_page);
		int start = page.getPageBegin();
		int end = page.getPageEnd();
		List<ReviewDTO> list2 = reviewDao.listAll(start, end, moviecode);
		LikeDTO dto = new LikeDTO();
		String userid = (String) session.getAttribute("userid");
		dto.setUserid(userid);
		dto.setMoviecode(moviecode);
		LikeDTO list = likeDao.heart(dto);
		mav.setViewName("movie/moviedetail");
		mav.addObject("page", page);
		mav.addObject("list2", list2);
		mav.addObject("list", list);
		mav.addObject("movieCd", moviecode);
		return mav;
	}

	@PostMapping("/like/insert.do")
	@ResponseBody
	public String insert(HttpServletRequest request, HttpSession session) {
		String moviecode = request.getParameter("moviecode");
		String movieTitle = request.getParameter("movieTitle");
		LikeDTO dto = new LikeDTO();
		String userid = (String) session.getAttribute("userid");
		dto.setUserid(userid);
		dto.setMoviecode(moviecode);
		dto.setMovieTitle(movieTitle);
		likeDao.insertLike(dto);
		return "success";
	}

	@PostMapping("/like/delete.do")
	@ResponseBody
	public String delete(HttpServletRequest request, HttpSession session) {
		String moviecode = request.getParameter("moviecode");
		LikeDTO dto = new LikeDTO();
		String userid = (String) session.getAttribute("userid");
		dto.setUserid(userid);
		dto.setMoviecode(moviecode);
		likeDao.deleteLikes(dto);
		return "delete";
	}
}
