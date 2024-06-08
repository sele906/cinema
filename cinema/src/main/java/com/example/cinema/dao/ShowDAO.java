package com.example.cinema.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.example.cinema.dto.EventDTO;
@Repository
public interface ShowDAO {
    List<EventDTO> list_Event();
    EventDTO detail_Event(int num);
    List<EventDTO> listEvent(String type);
}
