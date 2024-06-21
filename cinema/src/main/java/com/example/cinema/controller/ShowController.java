package com.example.cinema.controller;

import com.example.cinema.dao.ShowImpl;
import com.example.cinema.dto.EventDTO;
import com.example.cinema.dao.ShowDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/show/")
public class ShowController {

    @Autowired
    private ShowImpl showDao;

    @GetMapping("/list.do")
    public String list(Model model) {
        List<EventDTO> items = showDao.list_Event();
        model.addAttribute("list", items);
        return "show/event_list";
    }

    @GetMapping("/detail.do")
    public String detail(@RequestParam("num") int num, Model model) {
        EventDTO item = showDao.detail_Event(num);
        model.addAttribute("item", item);
        return "show/event_detail";
    }

    @GetMapping("/category.do")
    public String category(@RequestParam("type") String type, Model model) {
        List<EventDTO> items = showDao.listEvent(type);
        model.addAttribute("list", items);
        model.addAttribute("type", type);
        return "show/type";
    }
}
