<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가입유형선택</title>
    <link rel="stylesheet" href="/css/user.css" />
    <style>
        .userchoice > button {
            width: 60%; height: 56px;
            line-height: 56px;
            background: rgb(67, 67, 255);
            border: solid rgb(67, 67, 255);
            font-size: 18px;
            color: white;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
	<section class="userchoice">
	    <h2>가입유형선택</h2>
	    <button onclick="location.href='/user/joinForm'">고객으로 회원가입</button><br>
	    <button onclick="location.href='/dcreate'">디자이너로 회원가입</button>
    </section>
</body>
</html>