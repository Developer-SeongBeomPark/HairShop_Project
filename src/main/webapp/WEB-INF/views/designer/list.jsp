<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*,com.study.designer.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>관리자 - Designer List</title>
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
    	function update(did){
    		let url = "/admin/dupdate";
    		url += "?did="+did;
    		location.href = url;
    	}
    	function approve(did){
    		let url = "/admin/approve";
    		url += "?did="+did;
    		location.href = url;
    	}
    	function del(did){
    		if(confirm('디자이너를 강제탈퇴 처리하시겠습니까? 모든 정보가 지워집니다.')){
	    		let url = "/admin/ddelete/"+did;
	    		location.href = url;
    		}
    	}
    </script>
</head>
<body>
	<div class="container">
		<h2>디자이너 목록</h2>
		<form class="form-inline" action="/admin/designer/list">
			<div class="form-group" id="search">
				<select class="form-control" name="col">
					<option value="dname"
					<c:if test="${col='dname'}"> selected </c:if>
					>성명</option>
					<option value="did"
					<c:if test="${col='did'}"> selected </c:if>
					>아이디</option>
					<option value="address1"
					<c:if test="${col='address1'}"> selected </c:if>
					>주소</option>
					<option value="hairshop"
					<c:if test="${col='hairshop'}"> selected </c:if>
					>미용실명</option>
					<option value="total"
					<c:if test="${col='total'}"> selected </c:if>
					>전체출력</option>
				</select>
			</div>
			<div class="form-group">
				<input type="text" class="form-control" name="word" id="word" placeholder="검색어 입력" value="${word }">
			</div>
			<button type="submit" class="btn btn-default">검색</button>
			<button type="button" class="btn btn-default" onclick="location.href='/dcreate'">등록</button>
		</form>
		<table class="table table-hover">
			<thead class="table-light">
				<tr>
					<th>성명</th>
					<th>아이디</th>
					<th>주소</th>
					<th>미용실명</th>
					<th>좋아요</th>
					<th>자격승인여부</th>
					<th>상세정보 / 삭제</th>
				</tr>
			</thead>
			<tbody>
			<c:choose>
			<c:when test="${empty list }">
				<tr><td colspan="7">등록된 디자이너가 없습니다.</td></tr>
			</c:when>
			<c:otherwise>
			<c:forEach var="ddto" items="${list }">		
			<tr>
					<td>${ddto.dname }</td>
					<td>${ddto.did }</td>
					<td>${ddto.address1 }</td>
					<td>${ddto.hairshop }</td>
					<td>${ddto.likecnt }</td>
					<td>
					<c:choose>
						<c:when test="${ddto.validation}">
						O
						</c:when>
						<c:when test="${not ddto.validation}">
						<a href="javascript:approve('${ddto.did }')">X</a> 
						</c:when>
					</c:choose>
					</td>
					<td><button type="button" class="btn" onclick="javascript:update('${ddto.did}')">상세정보</button>
						<button type="button" class="btn" onclick="javascript:del('${ddto.did}')">삭제</button></td>
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