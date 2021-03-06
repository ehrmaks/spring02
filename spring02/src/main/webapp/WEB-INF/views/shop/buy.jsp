<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../include/header.jsp"%>
<title>Insert title here</title>
<script type="text/javascript">
	$(function() {
		$("#btnList").click(function() {
			// 장바구니 목록으로 이동
			location.href = "${path}/shop/product/list.do";
		});

		$("#btnMypage").click(function() {
			// 장바구니 목록으로 이동
			location.href = "${path}/member/mypage.do";
		});
	});
</script>

</head>
<body>
	<%@ include file="../include/menu.jsp"%>

	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<div class="container" style="width: 80%; overflow: scroll;" align="center">
			<div style="width: 80%; text-align: center;">
				<h1 style="color: gray; text-align: center;">주문해주셔서 감사합니다.</h1>
				<br>
				<br>
				<br>
				<table border="1" class="table table-hover">
					<tr>
						<th>
							<div class="container">
								<h3>구매자 정보</h3>
							</div>
						</th>
						<th>
							<div class="container">
								<h3>상품 정보</h3>
							</div>
						</th>
					</tr>

					<tr>
						<td>
							<div class="row">
								&nbsp;&nbsp;<span>구매자 : ${map.name}</span>
							</div> <br>
							<div class="row">
								&nbsp;&nbsp;<span>휴대폰 : ${map.phone}</span>
							</div> <br>
							<div class="row">
								&nbsp;&nbsp;<span>주소 : ${map.address1} ${map.address2}</span>
							</div>

						</td>

						<td>
							<div class="row">
								&nbsp;&nbsp;<span>상품구매액 : ₩<fmt:formatNumber value="${map.sumMoney}"
										pattern="###,###,###"></fmt:formatNumber>원
								</span>
							</div> <br>
							<div class="row">
								&nbsp;&nbsp;<span>배송비 : ₩<fmt:formatNumber value="${map.fee}"
										pattern="###,###,###"></fmt:formatNumber>원
								</span>
							</div>
							<br>
							<div class="row">
								&nbsp;&nbsp;<span>결제금액 : ₩<fmt:formatNumber
										value="${map.total_amount}" pattern="###,###,###"></fmt:formatNumber>원
								</span>
							</div>
							<br>
							<div class="row">
								&nbsp;&nbsp;<span>적립금 : <img src="/images/point.png">
								<fmt:formatNumber value="${map.point}" pattern="###,###,###"></fmt:formatNumber></span>
							</div>
						</td>
					</tr>
				</table>
		
				<!-- <table class="table table-hover" align="center">
				    <tr>
				    	<td> -->
				    		<button type="button" id="btnList"
							class="btn btn-default btn-info">상품목록</button>
						&nbsp;&nbsp;
							<button type="button" id="btnMypage"
							class="btn btn-default btn-info">마이페이지</button>
							<br>
							<br>
							<br>
				    	<!-- <!-- </td>
				    </tr>
				</table> -->
		</div>
	</div>
</body>
</html>