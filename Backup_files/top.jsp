<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }"/>
<c:choose>
	<c:when test="${not empty sessionScope.dname}">
		<c:set var='str'>안녕하세요  ${sessionScope.dname } 님!</c:set>
	</c:when>
	<c:otherwise>
		<c:set var="str">기본 페이지 입니다.</c:set>
	</c:otherwise>
</c:choose>
<!DOCTYPE html> 
<html> 
<head>
<script src="https://kit.fontawesome.com/320c5e3232.js" crossorigin="anonymous"></script>
  <title>hair</title>
  <meta charset="utf-8">
  <link rel="stylesheet" href="/css/main.css">
  <link rel="stylesheet" href="/css/reset.css">
  <link rel="stylesheet" href="/css/style2.css">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
  <style type="text/css">
  #grade{
  
   color :white;
  }  
  </style>

</head>
<body> 
<!--상단메뉴-->
<header class="section">
            <div class="inner clearfix">

                <div class="menu-group float--left">
                    <div class="logo">
                        <a href="#">GitHub</a>
                    </div>
                    <ul class="main-menu">
                        <li><a href="#">TeamBUM</a></li>
                        <li><a href="#">Story</a></li>
                        <li><a href="#">Developer</a></li>
                        <li><a href="#">Support</a></li>
                    </ul>
                </div>

                <div class="sign-group float--right">
                    <div class="btn-group">
                        <a href="#" class="btn sign-in">Sign in</a>
                        <a href="#" class="btn sign-up">Sign up</a>
                        <a href="/logout" class="btn sign-up">Logout</a>
                    </div>
                    <form id="search-form" action="" method="POST">
                        <input type="text" id="search" class="search-text" placeholder="search designer">
                        <button value="Submit" id="search-btn">Find</button>
                    </form>
                    <ul class="sub-menu">
                        <li><a href="#">Menu</a></li>
                        <li><a href="#">Designer</a></li>
                        <li><a href="#">FAQ</a></li>
                    </ul>
                </div>
                
            </div>
        </header>
</body>
</html>