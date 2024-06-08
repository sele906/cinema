package com.example.cinema.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.cinema.dto.MemberDTO;

@Repository
public class MemberDAOImpl implements MemberDAO {
	@Autowired
	SqlSession sqlSession;

	@Override
	public List<MemberDTO> listMember() {
		List<MemberDTO> list = sqlSession.selectList("member.list_member");
		return list;
	}

	@Override
	public MemberDTO detailMember(String userid) {
		MemberDTO dto = sqlSession.selectOne("member.detail", userid);
		return dto;
	}

	@Override
	public void insert(MemberDTO dto) {
		try {
			sqlSession.insert("member.insert", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public String findId(MemberDTO dto) {
		String foundId = sqlSession.selectOne("member.findId", dto);
		return foundId;
	}

	@Override
	public String findPwd(MemberDTO dto) {
		String foundPwd = sqlSession.selectOne("member.findPwd", dto);
		return foundPwd;
	}

	@Override
	public String check(String userid) {
		String str = "";
		try {
			str = sqlSession.selectOne("member.check", userid);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return str;
	}

	@Override
	public MemberDTO login(MemberDTO dto) {
		MemberDTO member = sqlSession.selectOne("member.login", dto);
		return member;
	}

	@Override
	public void buy(MemberDTO dto) {
		sqlSession.update("member.buy", dto);
	}

	@Override
	public MemberDTO edit(String userid) {
		MemberDTO member = sqlSession.selectOne("member.edit", userid);
		return member;
	}

	@Override
	public void update(MemberDTO dto) {
		sqlSession.update("member.update", dto);
	}

}
