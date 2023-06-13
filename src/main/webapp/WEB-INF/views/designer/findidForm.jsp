<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
    <link rel="stylesheet" href="/css/user.css" />
    <style>
        .find > div input {
            width: 60%;
            height: 46px;
            box-sizing: border-box;
            text-indent: 16px;
        }
        .find > div input::-webkit-input-placeholder {
            font-size:16px;
            color: #9fa19f;
            text-indent: 16px;
        }
        div button {
            display: flex;
            width: 60%; height: 56px;
            background: rgb(67, 67, 255);
            border: solid rgb(67, 67, 255);
            font-size: 18px;
            color: white;
            margin: auto;
            align-items:center;
            justify-content: center;
        }
        div {
            padding-bottom: 10px;
        }
    </style>
    <script>
	  	$(function(){
	  		$("#okbtn").click(function(){
	  			
	  			let dname = document.getElementById("dname").value;
	  			let demail = document.getElementById("demail").value;
	  			
	  			if(dname==null || dname==""){
	  				alert("이름을 입력하세요");
	  				$("#dname").focus();
	  				return;	
	  			}else if(demail==null || demail==""){
	  				alert("이메일을 입력하세요");
	  				$("#demail").focus();
	  				return;
	  			}

	  			alert("수초~수분이 소요됩니다. 다음 알림까지 기다려주세요");
	  			
		  		return fetch(`/dfindidmail?dname=\${dname}&demail=\${demail}`)
					.then(response => response.text())
		  			.then(text=> alert(text))//알림창 속도 느림
		  			.catch(console.log);
	  		});
	  	});	  
    </script>
</head>
<body>
    <form class="find">
        <h2>ID찾기</h2>
        <div>
            <input type="text" id="dname" name="dname" placeholder="이름">
        </div>
        <div>
            <input type="email" id="demail" name="demail" placeholder="이메일">
        </div>
        <div>
            <button type="button" id="okbtn">확인</button><br>
            <button type="button" onclick="location.href='/dfindpw'">PW찾기</button><br>
        	<button type="button" onclick="location.href='/dlogin'">로그인으로 이동</button>     
        </div>
    </form>
</body>
</html>