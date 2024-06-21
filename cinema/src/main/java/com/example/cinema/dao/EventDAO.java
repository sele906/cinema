package com.example.cinema.dao;

import com.example.cinema.dto.EventDTO;
import jakarta.servlet.http.HttpSession;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class EventDAO {

    @Autowired
    SqlSession sqlSession;

    public int count(String search_option, String keyword) {
        int result = 0;
        try {
            Map<String, Object> map = new HashMap<>();
            map.put("search_option", search_option);
            map.put("keyword", keyword);
            result = sqlSession.selectOne("event.search_count", map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public String getFilename(int num) {
        String result = null;
        try {
            result = sqlSession.selectOne("event.filename", num);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public void plus_down(int num) {
        try {
            sqlSession.update("event.plus_down", num);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String check_pwd(int num, String passwd) {
        String result = null;
        try {
            Map<String, Object> map = new HashMap<>();
            map.put("num", num);
            map.put("passwd", passwd);
            result = sqlSession.selectOne("event.check_pwd", map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public void update(EventDTO dto) {
        try {
            sqlSession.update("event.update", dto);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void delete(int num) {
        try {
            sqlSession.delete("event.delete", num);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<EventDTO> list(int pageStart, int pageEnd) {
        List<EventDTO> list = null;
        try {
            Map<String, Object> map = new HashMap<>();
            map.put("start", pageStart);
            map.put("end", pageEnd);
            list = sqlSession.selectList("event.list_event", map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int count() {
        int result = 0;
        try {
            result = sqlSession.selectOne("event.count");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public void insert(EventDTO dto) {
        try {
            sqlSession.insert("event.insert", dto);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void plus_hit(int num, HttpSession count_session) {
        try {
            long read_time = 0;
            if (count_session.getAttribute("read_time_" + num) != null) {
                read_time = (long) count_session.getAttribute("read_time_" + num);
            }
            long current_time = System.currentTimeMillis(); if (current_time - read_time > 5 * 1000) {
                sqlSession.update("event.plus_hit", num);
                count_session.setAttribute("read_time_" + num, current_time);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public EventDTO view(int num) {
        EventDTO dto = null;
        try {
            dto = sqlSession.selectOne("event.view", num);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return dto;
    }

    public void update_order(int group_num, int re_order) {
        try {
            Map<String, Object> map = new HashMap<>();
            map.put("group_num", group_num);
            map.put("re_order", re_order);
            sqlSession.update("event.update_order", map);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void insert_reply(EventDTO dto) {
        try {
            sqlSession.insert("event.insert_reply", dto);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

//    @Transactional
//    public void insertFiles(ProductDTO dto, String[] files ) {
//        if (files == null) return;
//
//        for (String file : files) {
//            // 리뷰의 ID를 가져옵니다.
//            int p_id = adminDao.p_id();
//
//            // 파일을 저장하는 메서드 호출
//            adminDao.insert_p_attach(new String[] { file }, p_id);
//        }
//    }
}
