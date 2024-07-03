package com.example.cinema.controller;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.cinema.api.ApiCaller;
import com.example.cinema.dao.MemberDAO;
import com.example.cinema.dao.SeatDAO;
import com.example.cinema.dao.TimeDAO;
import com.example.cinema.dto.MemberDTO;
import com.example.cinema.dto.SeatDTO;
import com.example.cinema.dto.TimeDTO;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/ticket/")
public class TicketController {
	
	@Autowired
	SeatDAO seatDao;
	
	@Autowired
	TimeDAO timeDao;
	
	@Autowired
	MemberDAO memberDao;


	//예매 버튼 클릭시 예매 페이지로 전환
	@GetMapping("book_tickets.do")
	public String BookTickets(@RequestParam(name = "movie_cd") int movie_cd, Model model) {
		
		String movie_title = null;
		String imgpath;
		
		//// API 사용
	
		// API 호출에 필요한 정보 설정
		String api_url = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json";
		String api_key = "f13c0057896b0be1847c420d8c9d265b";
	
		// 매개변수 설정 (필요에 따라 수정)
		Map<String, String> params = new HashMap<>();
		params.put("key", api_key);
		params.put("movieCd", String.valueOf(movie_cd));
	
		try {
			// API 호출
			String api_response = ApiCaller.callApi(api_url, params);
	
			// JSON 파싱을 위한 JSONObject 사용
			JSONParser parser = new JSONParser();
			JSONObject json_response = (JSONObject) parser.parse(api_response);
	
			// 필요한 데이터 추출 (info)
			JSONObject movie_info_result = (JSONObject) json_response.get("movieInfoResult");
			JSONObject movie_info = (JSONObject) movie_info_result.get("movieInfo");
	
			// 영화 정보에서 제목 가져오기
			movie_title = (String) movie_info.get("movieNm"); // 제목
	
		} catch (Exception e) {
			// API 호출 중 예외 처리
			System.out.println("API 호출 중 오류 발생: " + e.getMessage());
		}
	
		// api 정보를 db에 입력
		imgpath = movie_cd + ".jpg";
	
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("movie_cd", movie_cd);
		map.put("movie_title", movie_title);
		map.put("imgpath", imgpath);
	
		// 영화 중복확인
		if (timeDao.same_movie(movie_cd) < 1) { // 기존 영화db에 영화가 없으면 영화 삽입
			timeDao.insert_movie_info(map);
		}
	
		Map<String, Object> infomap = timeDao.get_movie_info(movie_cd);
	
		////

		//데이터 전달
		model.addAttribute("movie_cd", movie_cd);
		model.addAttribute("map", infomap);
		
		return "ticket/index";
	}
	
	// 영화 장소 선택시 날짜 보여주기
	@PostMapping("movie_day.do")
	public String MoviePlace( 
			@RequestParam(name = "movie_title") String movie_title,
			@RequestParam(name = "cinema_place") String cinema_place,
			Model model
	) {
		TimeDTO dto = new TimeDTO();
		dto.setMovie_title(movie_title);
		dto.setCinema_place(cinema_place);

		List<TimeDTO> list_days = null;
		list_days = timeDao.choose_place(dto); //영화관 선택시 날짜 반환
		model.addAttribute("list", list_days); //데이터 전달
		
		return "ticket/time_table";
	}
	
	// 영화 날짜 선택시 시간 보여주기
	@PostMapping("movie_time.do")
	public String MovieTime(
			@RequestParam(name = "title") String title,
			@RequestParam(name = "place") String place,
			@RequestParam(name = "day") String day,
			Model model
	) {

		TimeDTO timeDto = new TimeDTO();
		timeDto.setMovie_title(title);
		timeDto.setCinema_place(place);
		timeDto.setTime(day);

		List<TimeDTO> list_time = null;
		list_time = timeDao.choose_time(timeDto); //날짜 선택시 시간 반환
		model.addAttribute("list", list_time); //데이터 전달
		
		return "ticket/choose_time";
	}
	
	// 좌석 선택
	@PostMapping("seats.do")
	public String Seats(
			HttpSession session,
			@RequestParam(name = "movieCd") int movieCd,
			@RequestParam(name = "idx") int idx,
			Model model
	) {

		// 세션 설정
		String userid = (String) session.getAttribute("userid");

		// 만약 아이디값 없을 때
		if (userid == null || userid.equals("")) {

			String page = "ticket/book_tickets.do";
			return "redirect:/" + page + "?movie_cd=" + movieCd + "&message=error";

		} else {

			Map<String, Object> map = null;
			map = timeDao.user_movie(idx); //시간 테이블 idx로 영화 정보 가져오기

			int theater_num = Integer.parseInt(map.get("theater_num").toString());
			String cinema_place = map.get("cinema_place").toString();
			Timestamp sqldate = change_time_sql(map.get("time").toString()); //문자열 시간 sql로 변환

			//db에서 저장된 좌석 불러오기
			SeatDTO dto = new SeatDTO();
			dto.setTheater_num(theater_num);
			dto.setCinema_place(cinema_place);
			dto.setTime(sqldate);

			List<SeatDTO> list = seatDao.saved_seats(dto);

			//데이터 전달
			model.addAttribute("time_idx", idx);
			model.addAttribute("map", map);
			model.addAttribute("list", list);
		
			return "ticket/theater_seats";
		}
		
	}
	
	// 좌석 선택 화면 ajax로 데이터 보내주기
	// 좌석 선택 ui는 vanilla js로 구성 > 메뉴 ui의 jquery와 충돌 > 하나의 화면에서 메뉴 ui와 좌석 선택 ui를 구분해줄 필요가 있음
	@PostMapping("seat_screen.do")
	public String SeatScreen(
			HttpSession session,
			@RequestParam(name = "imgpath") String imgpath,
			@RequestParam(name = "movie_title") String movie_title,
			@RequestParam(name = "movie_price") int movie_price,
			@RequestParam(name = "theater_num") int theater_num,
			@RequestParam(name = "cinema_place") String cinema_place,
			@RequestParam(name = "time_idx") int time_idx,
			@RequestParam(name = "movie_time") String movie_time,
			Model model
	) {
		//세션
		String userid = (String) session.getAttribute("userid");

		Timestamp sqldate = change_time_sql(movie_time); //문자열 시간 sql로 변환
		
		model.addAttribute("id", userid);
		model.addAttribute("imgpath", imgpath);
		model.addAttribute("movie_title", movie_title);
		model.addAttribute("movie_price", movie_price);
		model.addAttribute("movie_time", movie_time);
		model.addAttribute("theater_num", theater_num);
		model.addAttribute("time_idx", time_idx);
		model.addAttribute("cinema_place", cinema_place);

		// db에서 저장된 좌석 불러오기
		SeatDTO dto = new SeatDTO();
		dto.setTheater_num(theater_num);
		dto.setCinema_place(cinema_place);
		dto.setTime(sqldate);

		List<SeatDTO> list = seatDao.saved_seats(dto);
		model.addAttribute("list", list); //데이터 전달
		
		return "/ticket/theater_seats_screen";
	}
	
	//좌석 데이터 저장 후 > 예매내역 페이지
	@PostMapping("insert.do")
	public String SeatInsert(
			HttpSession session,
			@RequestParam(name = "movie_price") int buy,
			@RequestParam(name = "theater_num") int theater_num,
			@RequestParam(name = "cinema_place") String cinema_place,
			@RequestParam(name = "movie_time") String movie_time,
			@RequestParam(name = "time_idx") int time_idx,
			@RequestParam(name = "seat_pos") String seat_pos,
			Model model
	) {
		//세션
		String userid = (String) session.getAttribute("userid");
		
		MemberDTO dto = new MemberDTO();
		dto.setUserid(userid);
		dto.setBuy(buy);
		memberDao.buy(dto);	//멤버 테이블에서 총 구입금액에 티켓금액 더하기

		Timestamp sqldate = change_time_sql(movie_time); //문자열 시간 sql로 변환

		//문자열로 저장된 여러 좌석위치를 쉽표로 split 하여 문자배열로 바꾸기
		String[] seat_list = seat_pos.split(",");
		SeatDTO Sdto = new SeatDTO();
		for (int i = 0; i < seat_list.length; i++) { // 선택한 좌석 수만큼 반복

			Sdto.setUserid(userid);
			Sdto.setTheater_num(theater_num);
			Sdto.setSeat_name(seat_list[i]);
			Sdto.setCinema_place(cinema_place);
			Sdto.setTime(sqldate);

			seatDao.insert_seat(Sdto); // 좌석 데이터베이스에 추가

			int ticket_idx = seatDao.getTicketIdx(Sdto); // 추가하면서 생성된 ticket_idx(기본키) 가져오기

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("ticket_idx", ticket_idx);
			map.put("time_idx", time_idx);
			map.put("userid", userid);

			seatDao.insert_tickets(map); // 예약 테이블에 티켓 추가
		}

		// 예매 리스트 불러오기
		List<Map<String, Object>> book_tickets = seatDao.tickets(userid);
		model.addAttribute("book_tickets", book_tickets);

		// 예매내역 페이지
		return "ticket/result";
	}

	//예매내역
	@GetMapping("list.do")
	public String list(Model model, HttpSession session) {
		//세션
		String userid = (String) session.getAttribute("userid");
				
		// 예매 리스트 불러오기
		List<Map<String, Object>> book_tickets = seatDao.tickets(userid);
		model.addAttribute("book_tickets", book_tickets);
		
		return "ticket/result";
	}
	
	//예매내역 삭제
	@PostMapping("delete.do")
	public String TicketDelete(
			HttpSession session,
			@RequestParam(name = "t_num") ArrayList<String> t_num_values,
			Model model
	) {
		//세션
		String userid = (String) session.getAttribute("userid");

		//티켓번호 가져오기
		for (String value : t_num_values) {
			int t_num = Integer.parseInt(value);
			seatDao.cancel_seat(t_num); // 좌석 테이블에서 데이터 삭제
			seatDao.cancel_ticket(t_num); // 예약 테이블에서 데이터 삭제
		}

		// 예매 리스트 불러오기
		List<Map<String, Object>> book_tickets = seatDao.tickets(userid);
		model.addAttribute("book_tickets", book_tickets);

		// 예매내역 페이지
		return "ticket/result";
	}
	
	//영화관 선택 후 좌석 선택 페이지로 전환
	@PostMapping("movie_find.do")
	public String movie_find(
			HttpSession session, 
			@RequestParam(name = "cinema_place") String cinema_place,
			@RequestParam(name = "movie_cd") int movie_cd,
			@RequestParam(name = "time1") String time1,
			@RequestParam(name = "theater_num") int theater_num,
			Model model
	) {
		
		//세션
		String userid = (String) session.getAttribute("userid");
		
		// 영화코드를 영화이름으로 바꾸기
		Map<String, Object> movie_map = new HashMap<String, Object>();
		movie_map = timeDao.get_movie_info(movie_cd);
		String movie_title = movie_map.get("movie_title").toString();
		
		//시간 idx 가져오기 위해 필요한 정보 dto에 넣기
		TimeDTO Tdto = new TimeDTO();
		Tdto.setMovie_title(movie_title);
		Tdto.setCinema_place(cinema_place);
		Tdto.setTheater_num(theater_num);
		Timestamp sqltimestamp = change_time_sql(time1); //문자열 시간 sql로 변환
		Tdto.setDatetime1(sqltimestamp);

		// 시간 인덱스 가져오기
		int time_idx = timeDao.get_time_idx(Tdto);

		// 시간 데이터 중복확인
		if (time_idx == 0) { // 만약 가져올 시간 인덱스가 없으면
			timeDao.insert_time(Tdto); // 시간 테이블에 데이터 추가하고
			time_idx = timeDao.get_time_idx(Tdto); // 새롭게 생성된 기본키 가져오기
		}

		// 시간 인덱스로 예매내용 임시 생성
		Map<String, Object> map = new HashMap<String, Object>();
		map = timeDao.user_movie(time_idx);

		// 만약 아이디값 없을 때
		if (userid == null || userid.equals("")) {

			String page = "ticket/book_tickets.do";
			return "redirect:/" + page + "?movie_cd=" + movie_cd + "&message=error";

		} else { // 로그인된 상태면

			//db에서 저장된 좌석 불러오기
			SeatDTO dto = new SeatDTO();
			dto.setTheater_num(theater_num);
			dto.setCinema_place(cinema_place);
			dto.setTime(sqltimestamp);

			List<SeatDTO> list = seatDao.saved_seats(dto);

			model.addAttribute("map", map);
			model.addAttribute("movie_cd", movie_cd);
			model.addAttribute("list", list);
			model.addAttribute("time_idx", time_idx);

			// 좌석 선택 페이지로 보내기
			return "ticket/theater_seats";
		}
	}


	// 문자열 시간을 sql 시간으로 바꾸는 함수
	// java.sql.Date로 변환할시 날짜는 출력되지만 시간이 포함되지 않음
	// 따라서 timestamp로 바꿔야함
	public Timestamp change_time_sql(String time) {
		SimpleDateFormat date_format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		java.util.Date datetime;
		Timestamp sqldate = null;
		try {
			datetime = date_format.parse(time);
			sqldate = new Timestamp(datetime.getTime());

		} catch (ParseException e) {
			e.printStackTrace();
		}
		return sqldate;
	}
	
	
}
