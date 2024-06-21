package com.example.cinema.controller;

import com.example.cinema.dao.AdminDAO;
import com.example.cinema.dto.MemberDTO2;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/admin/")
public class AdminController {

    @Autowired
    AdminDAO adminDAO;

    @PostMapping("login.do")
    public String login(
            @RequestParam(value = "userid") String userid,
            @RequestParam(value = "pwd1") String pwd1,
            HttpSession session,
            Model model
    ) {
        MemberDTO2 dto = new MemberDTO2();
        dto.setUserid(userid);
        dto.setPwd1(pwd1);
        String name = adminDAO.login(dto);
        if (name == null) {
            model.addAttribute("message","error");
            String page = "/shop/admin_login";
            return "redirect:" + page;
        } else {
            session.setAttribute("admin_userid", dto.getUserid());
            session.setAttribute("admin_name", name);
            session.setAttribute("userid", userid);
            session.setAttribute("name", name);
            session.setAttribute("result", name + "님환영합니다.");

            String page = "/shop/admin_result";
            return page;

        }
    }

    @GetMapping("logout.do")
    public String logout(
            HttpSession session,
            Model model
    ) {
        session.invalidate();
        model.addAttribute("message","logout");
        String page = "/shop/admin_login";
        return "redirect:" + page;
    }
}
