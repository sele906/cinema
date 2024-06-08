package com.example.cinema.api;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Map;

public class ApiCaller {
	public static String callApi(String apiUrl, Map<String, String> params) throws IOException {
		// API 호출 및 응답을 문자열로 반환하는 코드 작성
		// params는 API 요청에 필요한 매개변수를 담고 있을 수 있습니다.

		// 예시 코드 (추가적인 설정이 필요할 수 있음)
		StringBuilder urlBuilder = new StringBuilder(apiUrl);
		boolean firstParam = true;

		for (Map.Entry<String, String> entry : params.entrySet()) {
			if (firstParam) {
				urlBuilder.append("?");
				firstParam = false;
			} else {
				urlBuilder.append("&");
			}
			urlBuilder.append(entry.getKey()).append("=").append(entry.getValue());
		}

		URL url = new URL(urlBuilder.toString());
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");

		BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		StringBuilder response = new StringBuilder();
		String line;

		while ((line = br.readLine()) != null) {
			response.append(line);
		}

		br.close();
		conn.disconnect();

		return response.toString();
	}
}
