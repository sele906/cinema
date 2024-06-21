package com.example.cinema.dao;

import com.example.cinema.dto.MemberDTO2;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AdminDAO {

    @Autowired
    SqlSession sqlSession;

    public String login(MemberDTO2 dto) {
        String name = sqlSession.selectOne("admin.login", dto);
        return name;
    }
}
