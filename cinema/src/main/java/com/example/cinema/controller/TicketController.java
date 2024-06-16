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
	
	
	
	// 예매 페이지로 전환
	@GetMapping("book_tickets.do")
	public String BookTickets(@RequestParam(name = "movieCd") int movieCd, Model model) { 
		
		String movieTitle = null;
		String imgpath = null;
		
		//// API 사용
	
		// API 호출에 필요한 정보 설정
		String apiUrl = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json";
		String apiKey = "f13c0057896b0be1847c420d8c9d265b"; // 실제 API 키로 교체
	
		// 매개변수 설정 (필요에 따라 수정)
		Map<String, String> params = new HashMap<>();
		params.put("key", apiKey);
		params.put("movieCd", String.valueOf(movieCd));
	
		try {
			// API 호출
			String apiResponse = ApiCaller.callApi(apiUrl, params);
	
			// JSON 파싱을 위한 JSONObject 사용
			JSONParser parser = new JSONParser();
			JSONObject jsonResponse = (JSONObject) parser.parse(apiResponse);
	
			// 필요한 데이터 추출 (info)
			JSONObject movieInfoResult = (JSONObject) jsonResponse.get("movieInfoResult");
			JSONObject movieInfo = (JSONObject) movieInfoResult.get("movieInfo");
	
			// 영화 정보를 테이블에 출력
			movieTitle = (String) movieInfo.get("movieNm"); // 제목
	
		} catch (Exception e) {
			// API 호출 중 예외 처리
			System.out.println("API 호출 중 오류 발생: " + e.getMessage());
		}
	
		// api 정보를 db에 입력
		imgpath = movieCd + ".jpg";
	
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("movieCd", movieCd);
		map.put("movieTitle", movieTitle);
		map.put("imgpath", imgpath);
	
		// 영화 중복확인
		if (timeDao.sameMovie(movieCd) < 1) { // 기존 영화db에 영화가 없으면 영화 삽입
			timeDao.insertMovieInfo(map);
		}
	
		Map<String, Object> infomap = timeDao.getMovieInfo(movieCd);
	
		////
		
		model.addAttribute("movieCd", movieCd);
		model.addAttribute("map", infomap);
		
		return "ticket/index";
	}
	
	// 영화 장소 선택
	@PostMapping("movie_place.do")
	public String MoviePlace( 
			@RequestParam(name = "movie_title") String movie_title,
			@RequestParam(name = "cinema_place") String cinema_place,
			Model model
	) {
		TimeDTO dto = new TimeDTO();
		dto.setMovie_title(movie_title);
		dto.setCinema_place(cinema_place);

		List<TimeDTO> list_place = null;
		list_place = timeDao.choosePlace(dto);
		model.addAttribute("list", list_place);
		
		return "ticket/time_table";
	}
	
	// 영화 날짜 선택
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
		list_time = timeDao.chooseTime(timeDto);
		model.addAttribute("list", list_time);
		
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
		if (userid == null || userid == "") {

			String page = "ticket/book_tickets.do";
			return "redirect:/" + page + "?movieCd=" + movieCd + "&message=error";

		} else {

			model.addAttribute("time_idx", idx);

			Map<String, Object> map = null;
			map = timeDao.userMovie(idx);

			model.addAttribute("map", map);

			int theaterNum = Integer.parseInt(map.get("theater_num").toString());
			String cinemaPlace = map.get("cinema_place").toString();

			// 문자열 time 을 date 타입으로 바꾸기
			String time = map.get("time").toString();
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			java.util.Date datetime = null;
			Timestamp sqlDate = null;
			try {
				datetime = dateFormat.parse(time);
				// java.util.Date를 java.sql.Date로 변환
				sqlDate = new Timestamp(datetime.getTime());
			} catch (ParseException e) {
				e.printStackTrace();
			}

//		db에서 저장된 좌석 불러오기
			SeatDTO dto = new SeatDTO();
			dto.setTheater_num(theaterNum);
			dto.setCinema_place(cinemaPlace);
			dto.setTime(sqlDate);

			List<SeatDTO> list = seatDao.savedSeats(dto);
			model.addAttribute("list", list);
		
			return "ticket/theater_seats";
		}
		
	}
	
	// 좌석 선택 화면 ajax로 데이터 보내주기
	@PostMapping("seat_screen.do")
	public String SeatScreen(
			HttpSession session,
			@RequestParam(name = "imgpath") String imgpath,
			@RequestParam(name = "movieTitle") String movieTitle,
			@RequestParam(name = "moviePrice") int moviePrice,
			@RequestParam(name = "theaterNum") int theaterNum,
			@RequestParam(name = "cinemaPlace") String cinemaPlace,
			@RequestParam(name = "time_idx") int time_idx,
			@RequestParam(name = "movieTime") String movieTime,
			Model model
	) {
		
		//세션
		String userid = (String) session.getAttribute("userid");
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		java.util.Date datetime = null;
		Timestamp sqlDate = null;
		try {
			datetime = dateFormat.parse(movieTime);
			// java.util.Date를 java.sql.Date로 변환
			sqlDate = new Timestamp(datetime.getTime());
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		model.addAttribute("id", userid);
		model.addAttribute("imgpath", imgpath);
		model.addAttribute("movieTitle", movieTitle);
		model.addAttribute("moviePrice", moviePrice);
		model.addAttribute("movieTime", movieTime);
		model.addAttribute("theaterNum", theaterNum);
		model.addAttribute("time_idx", time_idx);
		model.addAttribute("cinemaPlace", cinemaPlace);

		// db에서 저장된 좌석 불러오기
		SeatDTO dto = new SeatDTO();
		dto.setTheater_num(theaterNum);
		dto.setCinema_place(cinemaPlace);
		dto.setTime(sqlDate);

		List<SeatDTO> list = seatDao.savedSeats(dto);
		model.addAttribute("list", list);
		
		return "/ticket/theater_seats_screen";
	}
	
	//좌석 데이터 저장 후 > 예매 페이지
	@PostMapping("insert.do")
	public String SeatInsert(
			HttpSession session,
			@RequestParam(name = "moviePrice") int buy,
			@RequestParam(name = "theaterNum") int theaterNum,
			@RequestParam(name = "cinemaPlace") String cinemaPlace,
			@RequestParam(name = "movieTime") String movieTime,
			@RequestParam(name = "time_idx") int time_idx,
			@RequestParam(name = "seatPos") String seatPos,
			Model model
	) {
		//세션
		String userid = (String) session.getAttribute("userid");
		
		MemberDTO dto=new MemberDTO();
		dto.setUserid(userid);
		dto.setBuy(buy);
		
		//UPDATE member SET buy=buy + #{buy} WHERE userid = #{userid}
		
		memberDao.buy(dto);	
		
		
		// 문자열 time 을 date 타입으로 바꾸기
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		java.util.Date datetime = null;
		Timestamp sqlDate = null;
		try {
			datetime = dateFormat.parse(movieTime);
			// java.util.Date를 java.sql.Date로 변환
			sqlDate = new Timestamp(datetime.getTime());
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		String[] seatList = seatPos.split(",");
		SeatDTO Sdto = new SeatDTO();
		for (int i = 0; i < seatList.length; i++) { // 선택한 좌석 수만큼 반복

			Sdto.setUserid(userid);
			Sdto.setTheater_num(theaterNum);
			Sdto.setSeat_name(seatList[i]);
			Sdto.setCinema_place(cinemaPlace);
			Sdto.setTime(sqlDate);

			seatDao.insert_seat(Sdto); // 좌석 데이터베이스에 추가

			int ticket_idx = seatDao.getTicketIdx(Sdto); // 추가하면서 생성된 ticket_idx 가져오기

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("ticket_idx", ticket_idx);
			map.put("time_idx", time_idx);
			map.put("userid", userid);

			seatDao.insert_tickets(map); // 예약 테이블에 티켓 추가
		}

		// 예매 리스트 불러오기
		List<Map<String, Object>> bookTickets = seatDao.Tickets(userid);
		model.addAttribute("bookTickets", bookTickets);

		// 마이페이지와 연결
		return "ticket/result";
	}
	
	@GetMapping("list.do")
	public String list(Model model, HttpSession session) {
		//세션
		String userid = (String) session.getAttribute("userid");
				
		// 예매 리스트 불러오기
		List<Map<String, Object>> bookTickets = seatDao.Tickets(userid);
		model.addAttribute("bookTickets", bookTickets);
		
		return "ticket/result";
	}
	
	// 좌석 예매 삭제
	@PostMapping("delete.do")
	public String TicketDelete(
			HttpSession session,
			@RequestParam(name = "Tnum") ArrayList<String> TnumValues,
			Model model
	) {
		//세션
		String userid = (String) session.getAttribute("userid");

		for (String value : TnumValues) {
			int Tnum = Integer.parseInt(value);
			seatDao.cancel_seat(Tnum); // 좌석 데이터 삭제
			seatDao.cancel_ticket(Tnum); // 예약데이터 삭제
		}

		// 예매 리스트 불러오기
		List<Map<String, Object>> bookTickets = seatDao.Tickets(userid);
		model.addAttribute("bookTickets", bookTickets);

		// 마이페이지와 연결
		return "ticket/result";
	}
	
	@PostMapping("MovieF.do")
	public String MovieF(
			HttpSession session, 
			@RequestParam(name = "cinema_place") String cinema_place,
			@RequestParam(name = "movieCd") int movieCd,
			@RequestParam(name = "time1") String time1,
			@RequestParam(name = "theater_num") int theater_num,
			Model model
	) {
		
		//세션
		String userid = (String) session.getAttribute("userid");
		
		// 영화코드를 영화이름으로 바꾸기
		Map<String, Object> Mmap = new HashMap<String, Object>();
		Mmap = timeDao.getMovieInfo(movieCd);
		String movie_title = Mmap.get("movie_title").toString();
		
		// 데이터 넣기
		TimeDTO Tdto = new TimeDTO();
		Tdto.setMovie_title(movie_title);
		Tdto.setCinema_place(cinema_place);
		Tdto.setTheater_num(theater_num);
		
		// 문자열 time 을 date 타입으로 바꾸기
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		java.util.Date datetime = null;
		Timestamp sqlTimestamp = null;
		try {
			datetime = dateFormat.parse(time1);
			// java.util.Date를 java.sql.Date로 변환
			sqlTimestamp = new Timestamp(datetime.getTime()); //날짜만 가져오는게 아니라 시간 분도 가져와야함
		} catch (ParseException e) {
			e.printStackTrace();
		}

		Tdto.setDatetime1(sqlTimestamp);

		// 시간 인덱스 가져오기
		int time_idx = timeDao.getTimeIdx(Tdto);

		// 시간 데이터 중복확인
		if (time_idx == 0) { // 만약 가져올 시간 인덱스가 없으면
			timeDao.insertTime(Tdto); // 시간 데이터 새로 추가
			time_idx = timeDao.getTimeIdx(Tdto); // 시간 인덱스 새로갱신
		}

		// 시간 인덱스 보내기
		model.addAttribute("time_idx", time_idx);

		// 시간 인덱스로 예매내용 임시 생성
		Map<String, Object> map = new HashMap<String, Object>();
		map = timeDao.userMovie(time_idx);
		model.addAttribute("map", map);
		model.addAttribute("movieCd", movieCd);

		// 만약 아이디값 없을 때
		if (userid == null || userid == "") {

			String page = "ticket/book_tickets.do";
			return "redirect:/" + page + "?movieCd=" + movieCd + "&message=error";

		} else { // 로그인된 상태면

			int theaterNum = Integer.parseInt(map.get("theater_num").toString());
			String cinemaPlace = map.get("cinema_place").toString();

			// 문자열 time 을 date 타입으로 바꾸기
			String time = map.get("time").toString();
			SimpleDateFormat dateFormat1 = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			java.util.Date datetime1 = null;
			Timestamp sqlDate1 = null;
			try {
				datetime1 = dateFormat1.parse(time);
				// java.util.Date를 java.sql.Date로 변환
				sqlDate1 = new Timestamp(datetime1.getTime());
			} catch (ParseException e) {
				e.printStackTrace();
			}

//        db에서 저장된 좌석 불러오기
			SeatDTO dto = new SeatDTO();
			dto.setTheater_num(theaterNum);
			dto.setCinema_place(cinemaPlace);
			dto.setTime(sqlDate1);

			List<SeatDTO> list = seatDao.savedSeats(dto);
			model.addAttribute("list", list);

			// 좌석 선택 페이지로 보내기
			return "ticket/theater_seats";
		}
	}
	
	
	
	
	
}
