<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ include file="../include/header.jsp" %>
<script src="${path}/ckeditor/ckeditor.js"></script>
</head>
<body>
<%@ include file="../include/menu.jsp" %>
<div class="container">
<h2 align="center">상품정보</h2>
<table class="table table-hover" width="80%">
	<tr>
		<td><img src="${path}/images/${dto.picture_url}"
		width="80%"></td>
		
		<td align="center">
			
			<table>
				<tr>
					<td>상품명</td>
					<td>${dto.product_name}</td>
				</tr>
				
				<tr>
					<td>가격</td>
					<td><fmt:formatNumber value="${dto.product_price}"
					pattern="###,###,###"/></td>
				</tr>
				
				<tr>
					<td>&nbsp;</td>
					<td>${dto.product_desc}</td>
				</tr>
				
				<tr>
					<td colspan="2">
						<form name="form1" method="post"
						action="${path}/shop/cart/insert.do">
							<input type="hidden" name="product_id" 
							value="${dto.product_id}">
							
							<select name="amount">
								<c:forEach begin="1" end="10" var="i">
									<option value="${i}">${i}</option>
								</c:forEach>
							</select>&nbsp;개
							<input type="submit" value="장바구니에 담기">
						</form>
						<a href="${path}/shop/product/list.do">상품목록</a>
					</td>
				</tr>
			</table>
			
		</td>
	</tr>
</table>
</div>

</body>
</html>