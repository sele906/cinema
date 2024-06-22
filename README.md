# SpringBoot Project Cinema

CGV를 참고하여 만든 스프링부트 영화 예매 사이트 입니다.<br/>
개발 기간: 2024.02.08. ~ 2024.03.08.

## 프로젝트 설계

### 개발환경

**BackEnd**

<img src="https://img.shields.io/badge/springboot 3.2.3-6DB33F?style=for-the-badge&logo=spring&logoColor=white"> <img src="https://img.shields.io/badge/java 17-007396?style=for-the-badge&logo=java&logoColor=white"> <img src="https://img.shields.io/badge/jsp-F7DF1E?style=for-the-badge&logo=jsp&logoColor=black"> 
<img src="https://img.shields.io/badge/mysql 8.3.0-4479A1?style=for-the-badge&logo=mysql&logoColor=white"> <img src="https://img.shields.io/badge/mybatis-02303A?style=for-the-badge&logo=mybatis&logoColor=white"> <img src="https://img.shields.io/badge/apache tomcat 10.0-F8DC75?style=for-the-badge&logo=apachetomcat&logoColor=white"> <img src="https://img.shields.io/badge/gradle-02303A?style=for-the-badge&logo=gradle&logoColor=white"> <img src="https://img.shields.io/badge/linux-FCC624?style=for-the-badge&logo=linux&logoColor=black">
  
**FrontEnd**

<img src="https://img.shields.io/badge/html5-E34F26?style=for-the-badge&logo=html5&logoColor=white"> <img src="https://img.shields.io/badge/css3-1572B6?style=for-the-badge&logo=css3&logoColor=white"> <img src="https://img.shields.io/badge/javascript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black"> <img src="https://img.shields.io/badge/jquery-0769AD?style=for-the-badge&logo=jquery&logoColor=white">

**Tool**

<img src="https://img.shields.io/badge/intellijidea-181717?style=for-the-badge&logo=intellijidea&logoColor=white"> <img src="https://img.shields.io/badge/github-181717?style=for-the-badge&logo=github&logoColor=white">

<details>
<summary><b>ER 다이어그램</b></summary>
<div markdown="1">
  
![그림1](https://github.com/sele906/cinema/assets/81071162/052a4fda-ebbb-4d75-b84a-ff9db7a1954d)
</div>
</details>


## 구현기능


**로그인/회원가입**

- 로그인 시 세션 생성
- ID/PW 찾기
- ID 중복체크
- 주소 api 연동

**메인페이지**

- youtube 링크 연동
- 이미지 슬라이드
- kobis api 영화순위
- 이벤트 배너
- 스토어 상품 요약

**예매**

- kobis api 영화순위
- 영화관 선택 및 시간 선택
- 영화 선택 및 시간 선택
- 좌석 선택
- 카카오페이 결제
- 예매 내역

**스토어**

- 콤보, 팝콘, 음료, 스낵, 굿즈
- 바로구매
- 장바구니
- 카카오페이 결제

**이벤트**

- 할인, 영화, 굿즈
- 상세보기

**마이페이지**

- 회원정보 수정
- 회원등급
- 찜한 영화
- 작성한 리뷰
- 예매내역

**고객센터**

- 공지사항
- 자주묻는 질문

**관리자**

- 상품목록
- 상품 등록/수정/삭제
- 이벤트목록
- 이벤트 등록/수정/삭제
- 회원목록
- 회원정보 조회

























