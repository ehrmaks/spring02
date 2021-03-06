<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Jinseok's Portfolio</title>
<%@ include file="include/header.jsp" %>
</head>
<body onload="printClock()">
<%@ include file="include/menu.jsp" %>

<c:if test="${sessionScope.userid != null}">
	<h2 class="text-center">
		${sessionScope.name}(${sessionScope.userid})님의 방문을 환영합니다.
	</h2>
</c:if>

<br>
<h1 class="text-center">
	Jinseok's PORTFOLIO!  
</h1>
<br>
<%-- <P class="text-center">  The time on the server is ${serverTime}. </P><br> --%>

<div align="center" class="container-fluid">
	<div style="border:1px solid #dedede; width:80%; height:150px; line-height:150px; color:#666;font-size:40px; text-align:center;" id="clock">
	</div>
</div>



<!-- 실제로 서비스되는 디렉토리(배포 디렉토리) -->
<%//=application.getRealPath("/WEB-INF/views/images/") %>

<script>
	function printClock() {
		 var clock = document.getElementById("clock");            // 출력할 장소 선택
		    var currentDate = new Date();                                     // 현재시간
		    var calendar = currentDate.getFullYear() + "-" + (currentDate.getMonth()+1) + "-" + currentDate.getDate() // 현재 날짜
		    var amPm = 'AM'; // 초기값 AM
		    var currentHours = addZeros(currentDate.getHours(),2); 
		    var currentMinute = addZeros(currentDate.getMinutes() ,2);
		    var currentSeconds =  addZeros(currentDate.getSeconds(),2);
		    
		    if(currentHours >= 12){ // 시간이 12보다 클 때 PM으로 세팅, 12를 빼줌
		    	amPm = 'PM';
		    	currentHours = addZeros(currentHours - 12,2);
		    }

		    if(currentSeconds >= 50){// 50초 이상일 때 색을 변환해 준다.
		       currentSeconds = '<span style="color:#de1951;">'+currentSeconds+'</span>'
		    }
		    clock.innerHTML = currentHours+":"+currentMinute+":"+currentSeconds +" <span style='font-size:30px;'>"+ amPm+"</span>"; //날짜를 출력해 줌
		    
		    setTimeout("printClock()",1000);         // 1초마다 printClock() 함수 호출

	}
	function addZeros(num, digit) { // 자릿수 맞춰주기
		  var zero = '';
		  num = num.toString();
		  if (num.length < digit) {
		    for (i = 0; i < digit - num.length; i++) {
		      zero += '0';
		    }
		  }
		  return zero + num;
	}


</script>

</body>
</html>
