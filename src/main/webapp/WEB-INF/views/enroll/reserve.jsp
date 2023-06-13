<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객예약신청</title>
<link rel="stylesheet" href="/css/reserve.css" />
</head>
<body>
	<div class="container" style = "width : 40%;">
		<h3>예약가능 리스트</h3>
		<input type="hidden" id="hiddenUid" value="${sessionScope.uid}" />
		<table>
			<thead>
				<tr>
					<th>예약날짜</th>
					<th>예약시간</th>
					<th>시술이름</th>
					<th>가격</th>
					<th>성별</th>
					<th>예약선택</th>
				</tr>

			</thead>
			<c:choose>
				<c:when test="${empty list}">
					<tbody>
						<td colspan="6">등록된 예약이없습니다.</td>
					</tbody>
				</c:when>
				<c:otherwise>
					<tbody id="tbody">
						<c:forEach var="dto" items="${list}">
							<c:forEach var="innerdto" items="${dto.hairmenu}">
								<tr id="tr">
									<td>${dto.enrolldate}</td>
									<td>${dto.enrolltime}</td>
									<td>${dto.emenu}</td>
									<td>${dto.eprice}</td>
									<td>${innerdto.hgender}</td>
									<td><input type="radio" id="enrollbtn" name="radioCheck" value="${dto.enrollno}">예약체크</button></td>
								<tr>
							</c:forEach>
						</c:forEach>
					</tbody>
				</c:otherwise>
			</c:choose>
		</table>
		<div class="area-box">
			<p>고객요청사항</p>
			<textarea name="textArea" id="message" style="width: 100%; height: 100%;"></textarea>
		</div>
		<button id="sub_mit" type="submit">예약신청</button>
		<button id="goback" type="button" onclick="history.back()">뒤로가기</button>

		<p>
			예약 확정시 정보는 등록된 <strong>@Email 주소 </strong>로 확인 할수있습니다.
		</p>

	</div>
	
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
	<script src="/js/reserve.js"></script>


</body>
</html>