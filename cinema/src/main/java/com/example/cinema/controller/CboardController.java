package com.example.cinema.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.cinema.dao.CboardDAO;
import com.example.cinema.dto.CboardDTO;

import jakarta.servlet.http.HttpSession;
import page.PageUtil;

@Controller
@RequestMapping("/cboard/*")
public class CboardController {

	@Autowired
	CboardDAO cboardDao;
	
	@GetMapping("main.do")
	public String main() {
		return "cboard/customercenter";
	}
	
	@GetMapping("index.do")
	public String index() {
		return "cboard/index";
	}
	
	@GetMapping("qnaindex.do")
	public String qnaindex() {
		return "cboard/qnaindex";
	}
	
	@GetMapping("list.do")
	public String list(@RequestParam(value = "cur_page", defaultValue = "1") int cur_page, Model model) {
		int count = cboardDao.count();
		PageUtil page = new PageUtil(count, cur_page);
		int start = page.getPageBegin();
		int end = page.getPageEnd();
		List<CboardDTO> list = cboardDao.list(start, end);
		model.addAttribute("list", list);
		model.addAttribute("page", page);
		return "cboard/noti";
	}
	
	@GetMapping("qna.do")
	public String qna(@RequestParam(value = "cur_page", defaultValue = "1") int cur_page, Model model) {
		int count = cboardDao.count();
		PageUtil page = new PageUtil(count, cur_page);
		int start = page.getPageBegin();
		int end = page.getPageEnd();
		List<CboardDTO> list = cboardDao.list(start, end);
		model.addAttribute("list", list);
		model.addAttribute("page", page);
		return "cboard/qna";
	}
	
	@GetMapping("view.do")
	public String view(@RequestParam(name = "num") int num, HttpSession session, Model model) {
		cboardDao.see(num);
		CboardDTO dto = cboardDao.view(num);
		model.addAttribute("dto", dto);
		return "cboard/view";
	}
	
	@PostMapping("search.do")
	public String search(
			@RequestParam(name = "search_option") String search_option,
			@RequestParam(name = "keyword") String keyword,
			@RequestParam(value = "cur_page", defaultValue = "1") int cur_page,
			Model model
			) {
		int count = cboardDao.count(search_option, keyword);
		PageUtil page = new PageUtil(count, cur_page);
		int start = page.getPageBegin();
		int end = page.getPageEnd();
		List<CboardDTO> list = cboardDao.list_search(search_option, keyword, start, end);
		model.addAttribute("list", list);
		model.addAttribute("search_option", search_option);
		model.addAttribute("keyword", keyword);
		model.addAttribute("page", page);
		
		return "cboard/noti";
	}
	
	@GetMapping("cearch.do")
	public String cearch(
			@RequestParam(name = "csearch_option", defaultValue = "") String csearch_option,
			@RequestParam(name = "keyword", defaultValue = "") String keyword,
			@RequestParam(value = "cur_page", defaultValue = "1") int cur_page,
			Model model
			) {
		int count=cboardDao.ccount(csearch_option,keyword);
		PageUtil page = new PageUtil(count, cur_page);
		int start = page.getPageBegin();
		int end = page.getPageEnd();
		List<CboardDTO> list = cboardDao.list_csearch(csearch_option, keyword, start, end);
		
		model.addAttribute("list", list);
		model.addAttribute("csearch_option", csearch_option);
		model.addAttribute("keyword", keyword);
		model.addAttribute("page", page);
		
		return "cboard/qna";
	}
	
}
