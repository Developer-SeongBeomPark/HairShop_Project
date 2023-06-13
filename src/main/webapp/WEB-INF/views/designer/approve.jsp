<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>관리자-자격승인</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="/css/user.css" />
    <style>
        div {
            padding-top:10px;
            padding-bottom: 10px;
        }
        table {
            width: 60%;
            margin-left:auto;
            margin-right:auto;
            border: 1px solid black;
            border-collapse: collapse;
        }
        th,td {
            border: 1px ;
            padding: 10px;
            text-align: justify;
        }
        caption {
            text-align: center;
            padding:10px;
        }
    </style>
</head>
<body>
    <form class="approve" name="approve" action="/dapprove" method="post">
        <h2>자격승인</h2>
        <table>
            <tr>
                <th>이름</th>
                <td>${ddto.dname }</td>            
            </tr>
            <tr>
                <th>생년월일</th>
                <td>${ddto.birth }</td>
            </tr>
            </table>
        <table>
            <caption><b>자격정보</b><button type="button" class="btn" onclick="window.open('https://www.q-net.or.kr/qlf006.do?id=qlf00601&gSite=Q&gId=')">진위확인</button></caption>
            <input type="hidden" name="did" id="did" value="${ddto.did }">
            <tr>
                <th>자격증 종류</th>
                <td>
                <c:choose>
	                <c:when test="${empty cdto.uniquecode2 && not empty cdto.uniquecode1}">
	                수첩형 자격증 
	                </c:when>
	                <c:when test="${empty cdto.uniquecode1 && not empty cdto.uniquecode2}">
	                상장형 자격증
	                </c:when>
	            </c:choose>
	            </td>
            </tr>
			<c:choose>
			<c:when test="${empty cdto.uniquecode2 }">
            <!--수첩형 자격증-->
            <tr> 
                <th>자격증 번호</th> <td>${cdto.licenseno }  </td>            
            </tr>
            <tr>
                <th>발급(등록)연월일</th> <td>${cdto.licensedate }</td>
            </tr>
            <tr>
                <th>자격증내지번호</th> <td>${cdto.uniquecode1 }</td>
            </tr>
            </c:when>
            <c:otherwise>
            <!--상장형 자격증-->
            <tr>
                <th>자격증 관리번호</th> <td> ${cdto.uniquecode2} </td>  
            </tr>
            </c:otherwise>
            </c:choose>
        </table>
            <div>
                <button type="submit" class="btn">승인</button>
                <button type="button" class="btn" onclick="history.back()">반려</button>
            </div>      
    </form>
</body>
</html>