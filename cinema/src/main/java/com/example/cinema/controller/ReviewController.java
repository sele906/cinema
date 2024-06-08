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

import com.example.cinema.dao.ReviewDAO;
import com.example.cinema.dto.ReviewDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.websocket.Session;
import page.PageUtil;

@Controller
public class ReviewController {
	@Autowired
	ReviewDAO reviewDao;

	@GetMapping("/review/list.do")
	public ModelAndView review_list(HttpSession session, ModelAndView mav) {
		String userid = (String) session.getAttribute("userid");
		List<ReviewDTO> items = reviewDao.list(userid);
		mav.setViewName("mypage/list");
		mav.addObject("list", items);
		mav.addObject("type", "review");
		return mav;
	}

	@GetMapping("/review/noheart.do")
	public ModelAndView moviedetail(ModelAndView mav, HttpServletRequest request) {
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
		mav.setViewName("movie/moviedetail");
		mav.addObject("page", page);
		mav.addObject("list2", list2);
		mav.addObject("movieCd", moviecode);
		return mav;
	}
	
	@PostMapping("/review/delete.do")
	public String delete(@RequestParam(name = "review_id") int review_id, HttpSession session) {
		String userid= (String) session.getAttribute("userid");
		
		ReviewDTO dto = new ReviewDTO();
		dto.setUserid(userid);
		dto.setReview_id(review_id);
		reviewDao.delete(dto);
		
		return "mypage/list";
	}
	
	@PostMapping("/review/review.do")
	public String review(
			HttpSession session,
			@RequestParam(name = "moviecode") String moviecode,
			@RequestParam(name = "movieTitle") String movieTitle,
			@RequestParam(name = "rating") String value,
			@RequestParam(name = "opinion") String content,
			Model model
	) {
		String userid= (String) session.getAttribute("userid");
		
		ReviewDTO dto = new ReviewDTO();
		dto.setUserid(userid);
		dto.setMovieTitle(movieTitle);
		dto.setValue(value);
		dto.setContent(content);
		dto.setMoviecode(moviecode);
		reviewDao.insert(dto);
		
		model.addAttribute("message", "close");
		return "mypage/writereview";
	}
	
	@GetMapping("/review/write.do")
	public String write(
			@RequestParam(name = "movieTitle") String movieTitle,
			@RequestParam(name = "moviecode") String moviecode
	) {
		return "mypage/writereview";
	}
	
	
	
}
