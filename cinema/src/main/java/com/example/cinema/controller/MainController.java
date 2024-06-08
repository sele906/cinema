package com.example.cinema.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MainController {
	@GetMapping("/")
	public String main() {
		return "home";
	}

	@GetMapping("/login.do")
	public String login() {
		return "member/login";
	}
	@GetMapping("/moviechart.do")
	public String moviechart() {
		return "movie/moviechart";
	}
	@GetMapping("/findcinema.do")
	public String findcinema() {
		return "movie/findcinema";
	}
	@GetMapping("heart.do")
    public String heart(Model model) {
        return "movie/moviedetail";
    }
    @RequestMapping(value = "/gomovie", method = RequestMethod.GET)
    public String goMovie() {
        return "redirect:/review_servlet/noheart.do?movieCd={movieCd}";
    }
    
    @GetMapping("noheart")
    public String noheart() {
        return "redirect:/review_servlet/noheart.do?movieCd={movieCd}";
    }
    
    
    @GetMapping("register.do")
    public String join(Model model) {
        return "member/register";
    }
    
    @GetMapping("mypage.do")
    public String mypage(Model model) {
        return "mypage/mypage";
    }
    
    @GetMapping("center.do")
    public String center(Model model) {
        return "mm/center";
    }
}
