package com.example.cinema.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.cinema.dto.SeatDTO;

@Repository
public class SeatDAO {
	
	@Autowired
	SqlSession sqlSession;
	
	public List<SeatDTO> savedSeats(SeatDTO dto) {
		List<SeatDTO> list = sqlSession.selectList("seat.saved", dto);
		return list;
	}
	
	public List<Map<String, Object>> Tickets(String userid) {
		List<Map<String, Object>> list = sqlSession.selectList("seat.book_ticket", userid);
		return list;
	}
	
	public void insert_tickets(Map<String, Object> map) {
		sqlSession.insert("seat.book_ticket_insert", map);
	}
	
	public void insert_seat(SeatDTO dto) {
		sqlSession.insert("seat.insert", dto);
	}
	
	public void cancel_seat(int ticket_idx) {
		sqlSession.delete("seat.seat_delete", ticket_idx);
	}
	
	public void cancel_ticket(int ticket_idx) {
		sqlSession.delete("seat.booking_delete", ticket_idx);
	}
	
	public int getTicketIdx(SeatDTO dto) {
		int ticket_idx = sqlSession.selectOne("seat.ticket_idx", dto);
		return ticket_idx;
	}
}












