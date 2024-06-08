package com.example.cinema.dao;

import com.example.cinema.dto.EventDTO;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ShowImpl implements ShowDAO{

    @Autowired
    private SqlSession sqlSession;

    public List<EventDTO> list_Event() {
        return sqlSession.selectList("show.list_event");
    }

    public EventDTO detail_Event(int num) {
        return sqlSession.selectOne("show.detail_event", num);
    }

    public List<EventDTO> listEvent(String type) {
        return sqlSession.selectList("show.listevent", type);
    }
}
