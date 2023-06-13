<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원정보수정</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="/css/user.css" />
    <style>
        table {
            width: 70%;
            margin-left:auto;
            margin-right:auto;
            border: 1px ;
            border-collapse: collapse;
        }
        th,td {
            border: 1px ;
            padding: 10px;
            text-align: justify;
        }
        input {
            height: 34px;
            padding: 0 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
            outline: none;
            box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.75);
            font-size: 16px;
        }
        input:read-only{
        	background-color: #f5f5f5;
        }
    </style>
    <script type="text/javascript">
 		function inCheck(f){
 			if(f.uname.value.length==0){
 				alert("이름를 입력하세요");
 				f.uname.focus();
 				return false;
 			}
    		if(f.uemail.value.length==0){
    			alert("이메일을 입력하세요");
    			f.uemail.focus();
    			return false;
    		}
 			if(f.uphone.value.length==0){
 				alert("전화번호를 입력하세요");
 				f.uphone.focus();
 				return false;
 			}
 		}   
    </script>
</head>
<body>
	<form class="update" action="/user/update" method="post" name='frm' onsubmit="return inCheck(this)">
		<h2>회원정보 수정</h2>
		<table>
			<tr>
				<th><label for="uid">아이디</label></th>
				<td><input type="text" id="uid" name="uid" value="${dto.uid }" readonly></td>
			</tr>
			<tr>
				<th><label for="uname">이름</label></th>
				<td>
				<c:choose>
				<c:when test="${not empty sessionScope.uid && sessionScope.grade == 'A' }">
					<input type="text" id="uname" name="uname" value="${dto.uname }">
				</c:when>
				<c:when test="${not empty sessionScope.uid && sessionScope.grade != 'A'}">
					<input type="text" id="uname" name="uname" value="${dto.uname }" readonly>
				</c:when>
				</c:choose>
				</td>
			</tr>
			<tr>
				<th><label for="uemail">이메일</label></th>
				<td><input type="text" id="uemail" name="uemail" value="${dto.uemail }"></td>
			</tr>
			<tr>
				<th><label for="uphone">전화번호</label></th>
				<td><input type="text" id="uphone" name="uphone" value="${dto.uphone}"></td>
			</tr>
		</table>
		<div>
			<button type="submit" class="btn">수정</button>
			<button type="button" class="btn" onclick="history.back()">취소</button>
		</div>
	</form>
</body>
</html>