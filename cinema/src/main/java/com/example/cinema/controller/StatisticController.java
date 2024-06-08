package com.example.cinema.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

@Controller
@RequestMapping("/statistic/*")
public class StatisticController {
	
	@GetMapping("test")
	public String testscreen() {
		return "test/test";
	}
	
	@ResponseBody
	@GetMapping("test.do")
	public List<Map<String, Object>> test(@RequestParam(name = "movieTitle") String title) {
		
		List<Map<String, Object>> resultlist = new ArrayList<>();
		 List<HashMap<String, Object>> bodyList = new ArrayList<>();
		 String[] dateArray = new String[7];
		 
		 Calendar calendar = Calendar.getInstance();
		 for (int i = 0; i < 7; i++) {
			 
			 Calendar c = Calendar.getInstance();
			 c.setTime(calendar.getTime());
		        int year = c.get(Calendar.YEAR);
		        int month = c.get(Calendar.MONTH) + 1; 
		        int day = c.get(Calendar.DAY_OF_MONTH);
		        dateArray[6-i] = String.format("%04d%02d%02d", year, month, day);
			 
			 calendar.add(Calendar.DAY_OF_MONTH, -1);
		 }
		
		for (int i=0; i<7; i++) {
			String targetDt = dateArray[i]; 
			
			String apiUrl = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json";
	        String apiKey = "975639d7befb5ab3b079a6f057165314";
	        String itemPerPage = "10";

	        UriComponentsBuilder builder = UriComponentsBuilder.fromHttpUrl(apiUrl)
	                .queryParam("key", apiKey)
	                .queryParam("targetDt", targetDt)
	        		.queryParam("itemPerPage", itemPerPage);

	        RestTemplate restTemplate = new RestTemplate();
	        ResponseEntity<HashMap> resultMap = restTemplate.getForEntity(builder.toUriString(), HashMap.class);

	        HashMap<String, Object> body = resultMap.getBody();
	        bodyList.add(body);
		}
		
		for (HashMap<String, Object> body : bodyList) {
			
			HashMap<String, Object> boxOfficeResult = (HashMap<String, Object>) body.get("boxOfficeResult");
	        ArrayList<Map<String, Object>> dailyBoxOfficeList = (ArrayList<Map<String, Object>>) boxOfficeResult.get("dailyBoxOfficeList");
	        
	        String showRange = (String) boxOfficeResult.get("showRange");
	        String[] dates = showRange.split("~");
	        String date = dates[0];
	        
	     // 년, 월, 일 추출
	        String Dyear = date.substring(0, 4);
	        String Dmonth = date.substring(4, 6);
	        String Dday = date.substring(6);

	        // 원하는 형식의 문자열 생성
	        String Fdate = Dyear + "-" + Dmonth + "-" + Dday;
	        //System.out.println(dailyBoxOfficeList);
	        
	        List<Map<String, Object>> listFMovieName = dailyBoxOfficeList.stream()
            .filter(movie -> title.equals(movie.get("movieNm")))
            .collect(Collectors.toList());
	        
			for (Map<String, Object> movie : listFMovieName) {
				        	
	        	String movieCd = (String) movie.get("movieCd");
	        	String movieTitle = (String) movie.get("movieNm");
	        	String audiCnt = (String) movie.get("audiCnt");
	        	String audiInten = (String) movie.get("audiInten");
	        	String audiChange = (String) movie.get("audiChange");
	        	String audiAcc = (String) movie.get("audiAcc");
	        	
	        	Map<String, Object> map = new HashMap<>();
	        	
	        	map.put("movieCd", movieCd);
	        	map.put("movieTitle", movieTitle);
	        	map.put("audiCnt", audiCnt);
	        	map.put("audiInten", audiInten);
	        	map.put("audiChange", audiChange);
	        	map.put("audiAcc", audiAcc);
	        	map.put("date", Fdate);
	        	
	        	resultlist.add(map);
			}
	        
		}
	    return resultlist;
	}
}
