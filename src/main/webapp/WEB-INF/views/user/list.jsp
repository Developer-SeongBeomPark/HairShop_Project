<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*,com.study.user.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>관리자 - User List</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
    <style>
        h2 {
            padding: 0 0 20px;
            font-size: 32px;
            color: #111;
            border-bottom: 2px solid #111;
            text-align: left;
            line-height: 1;
        }
        table {
            width: 90%;
            border-top: 1px solid black;
            border-collapse: collapse;
        }
        th,td {
            border-bottom: 1px solid black;
            padding: 10px;
            text-align: center;
        }
        th{
        	font-weight: bold;
        }
        div{
            padding: 10px;
        }
        #word {
            height: 34px;
                    padding: 0 10px;
                    border: 1px solid #ddd;
                    border-radius: 5px;
                    box-sizing: border-box;
                    outline: none;
                    box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.75);
                    font-size: 16px;
        }
    </style>
    <script type="text/javascript">
    	function update(uid){
    		let url = "/admin/user/update";
    		url += "?uid="+uid;
    		location.href = url;
    	}
    	function del(uid){
    		if(confirm('회원을 강제탈퇴 처리하시겠습니까? 모든 정보가 지워집니다.')){
	    		let url = "/admin/udelete/"+uid;
	    		location.href = url;
    		}
    	}
    </script>
</head>
<body>
	<div class="container">
		<h2>일반회원 목록</h2>
		<form class="form-inline" action="/admin/user/list">
			<div class="form-group" id="search">
				<select class="form-control" name="col">
					<option value="uname"
					<c:if test="${col='uname'}"> selected </c:if>
					>성명</option>
					<option value="uid"
					<c:if test="${col='uid'}"> selected </c:if>
					>아이디</option>
					<option value="uemail"
					<c:if test="${col='uemail'}"> selected </c:if>
					>이메일</option>
					<option value="uphone"
					<c:if test="${col='uphone'}"> selected </c:if>
					>전화번호</option>
					<option value="total"
					<c:if test="${col='total'}"> selected </c:if>
					>전체출력</option>
				</select>
			</div>
			<div class="form-group">
				<input type="text" class="form-control" name="word" id="word" placeholder="검색어 입력" value="${word }">
			</div>
			<button type="submit" class="btn btn-default">검색</button>
			<button type="button" class="btn btn-default" onclick="location.href='/user/joinForm'">등록</button>
		</form>
		<table class="table table-hover">
			<thead class="table-light">
				<tr>
					<th>성명</th>
					<th>아이디</th>
					<th>이메일</th>
					<th>전화번호</th>
					<th>수정/삭제</th>
				</tr>
			</thead>
			<tbody>
			<c:choose>
			<c:when test="${empty list }">
				<tr><td colspan="6">등록된 회원이 없습니다.</td></tr>
			</c:when>
			<c:otherwise>
			<c:forEach var="dto" items="${list }">		
			<tr>
					<td>${dto.uname }</td>
					<td>${dto.uid }</td>
					<td>${dto.uemail }</td>
					<td>${dto.uphone }</td>
					<td><button type="button" class="btn" onclick="javascript:update('${dto.uid}')">수정</button>
						<button type="button" class="btn" onclick="javascript:del('${dto.uid}')">삭제</button></td>
			</tr>
			</c:forEach>
			</c:otherwise>
			</c:choose>
			</tbody>
		</table>

		<div class="text-center">
			${paging }
		</div>
	</div>
</body>
</html>