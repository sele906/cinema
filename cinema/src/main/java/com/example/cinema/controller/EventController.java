package com.example.cinema.controller;

import com.example.cinema.dao.EventDAO;
import com.example.cinema.dto.EventDTO;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import page.PageUtil;

import java.util.List;

@Controller
@RequestMapping("/event/")
public class EventController {

    @Autowired
    EventDAO eventDAO;

    @GetMapping("list.do")
    public String list(
            @RequestParam(name = "cur_page", defaultValue = "1") int cur_page,
            @RequestParam(name = "subject", defaultValue = "") String subject,
            @RequestParam(name = "contents", defaultValue = "") String contents,
            @RequestParam(name = "type", defaultValue = "") String type,
            Model model,
            HttpSession session
    ) {
        int count = eventDAO.count(); // 게시판 글 갯수
        cur_page = 1;

        PageUtil page = new PageUtil(count, cur_page);
        int start = page.getPageBegin();
        int end = page.getPageEnd();
        List<EventDTO> list = eventDAO.list(start, end);

        model.addAttribute("list", list);
        model.addAttribute("page", page);

        return "event/list";
    }

    @PostMapping("insert.do")
    public String insert(
            @RequestParam(name = "file", required = false) String[] file,
            @RequestParam(name = "subject", defaultValue = "") String subject,
            @RequestParam(name = "contents", defaultValue = "") String contents,
            @RequestParam(name = "type", defaultValue = "") String type,
            Model model,
            HttpSession session,
            HttpServletRequest request,
            ServletContext application
    ) {
        EventDTO dto = new EventDTO();

        application = request.getSession().getServletContext();
        String img_path = application.getRealPath("/images/");
        String filename1 = "";
        String filename2 = ""; // 두 번째 파일 이름을 저장할 변수 추가
        try {
            int fileCount = 0; // 업로드된 파일 수를 추적하기 위한 변수 추가
            for (Part part : request.getParts()) {
                String filename = part.getSubmittedFileName();

                if (filename != null && !filename.trim().equals("")) {
                    // 두 개의 파일이 모두 업로드되었는지 확인
                    if (fileCount == 0) {
                        filename1 = filename;

                    } else if (fileCount == 1) {
                        filename2 = filename;

                    }
                    part.write(img_path + filename);
                    fileCount++;
                    // 두 개의 파일이 모두 업로드되면 루프 종료
                    if (fileCount == 2) {
                        break;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        dto.setSubject(subject);
        dto.setContents(contents);
        dto.setType(type);
        dto.setFilename1(filename1);
        dto.setFilename2(filename2); // 두 번째 파일 이름도 DTO에 설정

        eventDAO.insert(dto);

        return "redirect:/event/list.do";
    }

    @GetMapping("view.do")
    public String views(
            @RequestParam(name = "num", defaultValue = "")
            int num,
            Model model
    ) {
        EventDTO dto = eventDAO.view(num);
        model.addAttribute("dto", dto);
        return "event/view";
    }

    @GetMapping("delete.do")
    public String delete(
            @RequestParam(name = "num") int num
    ) {
        eventDAO.delete(num);
        return "redirect:/event/list.do";
    }

    @PostMapping("update.do")
    public String update(
            @RequestParam(name = "file", required = false) String[] file,
            @RequestParam(name = "subject", defaultValue = "") String subject,
            @RequestParam(name = "contents", defaultValue = "") String contents,
            @RequestParam(name = "type", defaultValue = "") String type,
            Model model,
            HttpSession session,
            HttpServletRequest request,
            ServletContext application
    ) {
        EventDTO dto = new EventDTO();
        application = request.getSession().getServletContext();
        String img_path = application.getRealPath("/images/");
        String filename1 = "";
        String filename2 = ""; // 두 번째 파일 이름을 저장할 변수 추가
        try {
            int fileCount = 0; // 업로드된 파일 수를 추적하기 위한 변수 추가
            for (Part part : request.getParts()) {
                String filename = part.getSubmittedFileName();

                if (filename != null && !filename.trim().equals("")) {
                    // 두 개의 파일이 모두 업로드되었는지 확인
                    if (fileCount == 0) {
                        filename1 = filename;

                    } else if (fileCount == 1) {
                        filename2 = filename;

                    }
                    part.write(img_path + filename);
                    fileCount++;
                    // 두 개의 파일이 모두 업로드되면 루프 종료
                    if (fileCount == 2) {
                        break;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        int num = Integer.parseInt(request.getParameter("num"));

        if(filename1=="") {
            System.out.println("sex");
        }else {
            System.out.println(filename1);
        }
        if(filename2=="") {
            System.out.println("fuck");
        }else {
            System.out.println(filename2);
        }

        dto.setNum(num);
        dto.setSubject(subject);
        dto.setContents(contents);
        dto.setType(type);
        dto.setFilename1(filename1);
        dto.setFilename2(filename2); // 두 번째 파일 이름도 DTO에 설정

        eventDAO.update(dto);
        return "redirect:/event/list.do";
    }

}
