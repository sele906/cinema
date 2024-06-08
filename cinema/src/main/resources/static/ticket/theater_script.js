let theater = document.getElementById('theater_wrap');
let seats = document.querySelectorAll('#seats .seat');
let firstrow = document.querySelector('.row');
let col_num = firstrow.querySelectorAll('.seat').length; //첫번째줄의 의자개수
let seatMemory = [];


const ABC = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P",  "Q", "R", "S", "T", "U", "V", "W", "X", "Y" , "Z"];


//저장된 데이터 선택된 좌석으로 보이게
let Savedseats = document.querySelectorAll('.SavedseatNum');
for (i=0; i<Savedseats.length; i++) {
	let Savedseat = document.getElementsByClassName("SavedseatNum")[i].innerHTML.trim();
	let SavedseatNum = StringtoNum(Savedseat, col_num);
	seats[SavedseatNum].className = "seat choose";
}


//좌석 숫자 위치 > 좌석 문자 위치
function NumtoString(num, colnum) {
	let rowString = ABC[Math.floor(num/colnum)];
	let colNumber = num%colnum + 1;
	let idx = rowString + colNumber;
	return idx;
}

//좌석 문자 위치 > 좌석 숫자 위치
function StringtoNum(idx, colnum) {
	let seatchar = idx.charAt(0);
	let seatnum = Number(idx.match(/\d+/)[0]);
	let row = ABC.indexOf(seatchar);
	let idxnum = row * colnum + seatnum - 1;
	return idxnum;
}

//좌석 번호 세팅
for (i=0; i<seats.length; i++) {
	seats[i].innerHTML = NumtoString(i, col_num);
	seats[i].style.fontSize = "0.8rem";
	seats[i].style.color = "white";
	seats[i].style.display = "flex";
	seats[i].style.alignItems = "center";
	seats[i].style.justifyContent = "center";
	
}




//좌석 수 세기
function updateSelectedCount() {
	let selectedSeats = document.querySelectorAll('.row .seat.select');
	
	//좌석 위치
	let seatsIndex = [...selectedSeats].map(seat => [...seats].indexOf(seat));

	for (i=0; i<seatsIndex.length; i++) {
		
		let num = seatsIndex[i];
		let idx = NumtoString(num, col_num);
		seatMemory.push(idx);
		
	}
	
	document.getElementById("seat_position").value = seatMemory;
	
	//좌석수 세기
	let selectedSeatsCount = selectedSeats.length;
	document.getElementById("seat_count").value = selectedSeatsCount;
	
	 //영화 금액 바꾸기
   Mprice = document.getElementById("price").value;
   document.getElementById("movie_price").value = Mprice * selectedSeatsCount;
}


theater.addEventListener('click', e => {
	if (e.target.classList.contains('seat') && !e.target.closest('.seat.choose')) {
		
		seatMemory.length = 0;
		e.target.classList.toggle('select');
		updateSelectedCount();
	}
});

//폼의 기본동작 막기
document.getElementById('form1').addEventListener('submit', function(event) {
	event.preventDefault(); // 폼의 기본 동작을 막음
	confirm();
});

//데이터 보내기
function confirm() {
	let seat_count = document.getElementById('seat_count').value;
	let seat_position = document.getElementById('seat_position').value;
	if (seat_count == "" || seat_count == 0 || seat_position == "" || seat_position == 0) {
		// 새 창 열기
		/*var newWindow = window.open('', '_blank', 'width=400,height=300');*/
		
		//창 위치조정
		var parentWindow = window;
        var width = 300;
        var height = 120;
        var left = (parentWindow.screen.width - width) / 2;
        var top = (parentWindow.screen.height - height) / 2;ABC
        
        //경고창열기
        var newWindow = window.open('', '_blank', 'width=' + width + ',height=' + height + ',left=' + left + ',top=' + top);
        
        //경고창처럼 보이게
        newWindow.document.write(`
        	<!DOCTYPE html>
			<html lang="en">
			<head>
			    <meta charset="UTF-8">
			    <meta name="viewport" content="width=device-width, initial-scale=1.0">
			    <title>경고</title>
			    <style>
		        body {
		            text-align: center;
				    margin: 0 50px;
				    padding: 0;
				    display: flex;
				    flex-direction: column;
				    align-items: center;
				    justify-content: center;
		        }
		        p {
    				font-size: 1.1em;
    				margin-bottom: 30px;
				}
		        button {
					width: 90px;
				    padding: 5px;
				    color: white;
				    background-color: cornflowerblue;
				    border: none;
				}
		    	</style>
				</head>
				<body>
				    <p>좌석을 선택하세요</p>
				    <button onclick="closeWindow()">닫기</button>
	                <script>
	                    function closeWindow() {
	                        window.close();
	                    }
	                </script>
				</body>
				</html>
       	`);
		
	} else {
		document.form1.action = "${path}/ticket/insert.do";
		document.form1.submit();
	}
}







