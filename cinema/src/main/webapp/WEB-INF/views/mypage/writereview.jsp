<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 작성</title>
<style>
input, textarea, select, button {
    font-size: 13px;
    line-height: 1.2;
    color: #666;
    font-family: 'Noto Sans KR', 'CJONLYONENEW', '맑은 고딕', '돋움', Dotum,
        sans-serif;
    font-weight: 400;
}

body {
    background-color: #333;
}

.bigtable table {
    font-size: 13px;
    line-height: 1.2;
    color: #666;
    font-family: 'Noto Sans KR', 'CJONLYONENEW', '맑은 고딕', '돋움', Dotum,
        sans-serif;
    font-weight: 400;
    width: 100%;
    table-layout: fixed;
}

.bigtable table td:nth-child(1) {
    width: 30%;
}

.bigtable table td:nth-child(2) {
    width: 70%;
}


.bigsection1 {
    background-color: #eee;
    margin: 0;
    height: 360px;
}

.bigsection1 .head {
    margin: 0 50px;
    color: white;
}

.bigsection1 .section1 {
    margin: 0 50px;
    width: 520px;
    
    background-color: #ddd;
}

.bigsection1 .section1 .contents {
    font-size: 13px;
    line-height: 1.2;
    color: #666;
    font-family: 'Noto Sans KR', 'CJONLYONENEW', '맑은 고딕', '돋움', Dotum,
        sans-serif;
    font-weight: 400;
    background-color: #ddd;
}

.star {
    cursor: pointer;
}

.selected {
    color: orange;
}

#opinion::placeholder {
                color: #bbb; /* 원하는 색상으로 변경 */
            }
            
</style>
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<c:if test="${message=='close'}">
    <script>
        window.close();
        window.opener.location.reload();
    </script>
</c:if>
<script>
function update() {
    document.getElementById('form1').action = "/review/review.do";
    document.getElementById('form1').submit();
}
function cancelEdit() {
    window.close();
}
    
document.addEventListener('DOMContentLoaded', function() {
    const stars = document.querySelectorAll('.star');
    const ratingInput = document.getElementById('rating');

 // 여기에 초기 값을 설정할 변수를 추가
    const initialRating = 5;
    
    stars.forEach((star, index) => {
        star.addEventListener('click', () => {
            const value = star.dataset.value;
            ratingInput.value = value;

            // 모든 별표에 대해서 선택 클래스를 제거
            stars.forEach(s => s.classList.remove('selected'));

            // 클릭된 별 포함하여 그 이전 별표까지 색상 변경
            for (let i = 0; i <= index; i++) {
                stars[i].classList.add('selected');
            }
        });
    });
    
 // 초기 값으로 설정
    setInitialRating(initialRating);

    // 초기 값을 설정하는 함수
    function setInitialRating(initialRating) {
        ratingInput.value = initialRating;

        // 클릭된 별 포함하여 그 이전 별표까지 색상 변경
        stars.forEach((star, index) => {
            star.classList.toggle('selected', index < initialRating);
        });
    }
});

</script>

<script> // 윈도우 창 크기 조절하는 스크립트
document.addEventListener('DOMContentLoaded', function() {
    // 여기에 원하는 창 크기를 설정
    const desiredWidth = 660;
    const desiredHeight = 520;

    // 현재 창의 너비와 높이를 가져옴
    const currentWidth = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
    const currentHeight = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;

    // 창 크기가 설정된 크기와 다를 경우 창 크기를 조절
    if (currentWidth !== desiredWidth || currentHeight !== desiredHeight) {
        window.resizeTo(desiredWidth, desiredHeight);
    }
    
	 // 창을 화면 가운데로 이동
	    const leftPosition = (window.screen.width - desiredWidth) / 2;
	    const topPosition = (window.screen.height - desiredHeight) / 2;
	
	    window.moveTo(leftPosition, topPosition);
    
});
</script>

<script> // 댓글 창 크기 고정하는 스크립트
    document.addEventListener('DOMContentLoaded', function() {
        const opinionTextarea = document.getElementById('opinion');
        opinionTextarea.style.resize = 'none';
        opinionTextarea.style.width = '300px';
        opinionTextarea.style.height = '80px';

     // 텍스트 영역에 포커스가 주어지면 힌트 텍스트를 지움
        opinionTextarea.addEventListener('focus', function() {
            opinionTextarea.placeholder = '';
        });

        // 텍스트 영역에서 포커스가 빠지면 힌트 텍스트를 다시 설정
        opinionTextarea.addEventListener('blur', function() {
            opinionTextarea.placeholder = '  - 리뷰를 남겨주세요 -';
        });
        
    });
</script>

<script>
    function clearPlaceholder() {
        var textarea = document.getElementById('opinion');
        if (textarea.value.trim() === textarea.getAttribute('placeholder').trim()) {
            textarea.value = '';
        }
    }
</script>

</head>
<body>
<header> 
<h3 style="border: 1px solid white; margin: 5px 0">
    <div style="margin: 10px 50px; color: white;">리뷰 작성</div>
</h3>
</header>
<div class="bigsection1">
    <div class="head">
        <br>
        <div style="color: black; margin-bottom: 20px; font-size: 20px;">
            ${sessionScope.userid}님
        </div>
    </div>
    <div class="section1">
        <div class="contents">
            <form id="form1" name="form1" method="post">
         <table>
			    <tr>
			        <td>
			            <img src="/resources/images/poster/<%=request.getParameter("moviecode")%>.jpg"
			                onerror="this.onerror=null; this.src='/resources/images/basic.png';"
			                style="overflow: hidden;" width="140px" height="200px">
			        </td>
			        
			        <td>
			            <table class="bigtable" style="padding: 20px;">
			                <tr>
			                    <td style="font-size : 20px; font-weight:bold;"><%=request.getParameter("movieTitle")%></td>
			                    <td><input type="hidden" name="movieTitle" value="<%=request.getParameter("movieTitle")%>" readonly></td>
			                    <td><input type="hidden" name="moviecode" value="<%=request.getParameter("moviecode")%>" style = "padding : 20px;"></td>
			                </tr>
			
			                <tr>
			                    <td>
			                        <div class="rating" style=" margin: 7px 0 12px 0;">
			                            <span class="star" data-value="1" style="font-size: 18px;">&#9733;</span>
			                            <span class="star" data-value="2" style="font-size: 18px;">&#9733;</span>
			                            <span class="star" data-value="3" style="font-size: 18px;">&#9733;</span>
			                            <span class="star" data-value="4" style="font-size: 18px;">&#9733;</span>
			                            <span class="star" data-value="5" style="font-size: 18px;">&#9733;</span>
			                        </div>
			                    </td>
			                    <td><input type="hidden" id="rating" name="rating" value="5" required"></td>
			                </tr>
			
			                <tr>
			                    <td><textarea id="opinion" name="opinion" rows="4" cols="50"  placeholder="  - 리뷰를 남겨주세요 -" onclick="clearPlaceholder()"></textarea></td>
			                </tr>
			                
			                
			                
			            </table>
			        </td>
			    </tr>
			</table>
			
            </form>
        </div>
    </div>
    <div style="display: flex; justify-content: center; margin: 20px 0 0 0;">
        <button type="button" onclick="update()" style="margin:0 15px 0 0; font-size: 14px;">등록하기</button>
        <button type="button" onclick="cancelEdit()" style="font-size: 14px;">취소</button>
    </div>
    <br> <br> <br>
</div>
</body>
</html>
