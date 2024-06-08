<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript">
google.charts.load('current', {'packages':['corechart']});
google.charts.setOnLoadCallback(init);

function init() {
  // 데이터 가져오고 그래프 그리기
  getDataAndDrawChart();
}

function getDataAndDrawChart() {
	var movieTitle = document.getElementById("title").value;
  // 데이터 가져오기
  $.ajax({
    url: '/statistic/test.do',
    type: 'GET',
    dataType: 'json',
    data: { movieTitle: movieTitle },
    success: function(data) {
      drawChart(data);
    }, 
    error: function(xhr, status, error) {
      console.error('Error fetching data:', error);
    }
  });
}

function drawChart(data) {
  // 데이터를 Google Charts에 적용
  
  //데이터 이름
  var dataTable = new google.visualization.DataTable();
  dataTable.addColumn('string', 'Date');
   dataTable.addColumn('number', '누적관객수');
   dataTable.addColumn('number', '관객증감비율');
  dataTable.addColumn('number', '관객수');
  dataTable.addColumn('number', '관객증감분');

  //데이터
  for (var i = 0; i < data.length; i++) {
    var row = [
    	data[i].date, 
     	parseInt(data[i].audiAcc), 
     	parseFloat(data[i].audiChange), 
    	parseInt(data[i].audiCnt), 
    	parseInt(data[i].audiInten)
    ];
    dataTable.addRow(row);
  }

  var options = {
    title: '관객 통계',
    curveType: 'function',
    legend: { position: 'bottom' }
  };

  var chart = new google.visualization.LineChart(document.getElementById('chart'));
  chart.draw(dataTable, options);
}
</script>
</head>
<body>
<input name="movieTitle" id="title" value="쿵푸팬더4">
<div id="chart" style="width: 900px; height: 500px"></div>
</body>
</html>