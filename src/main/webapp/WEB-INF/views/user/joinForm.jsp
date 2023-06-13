<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>join_user</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="/css/user.css" />
    <style>
        .join > div {
            padding-top:10px;
            padding-bottom: 10px;
        }
        table {
            width: 60%;
            margin-left:auto;
            margin-right:auto;
            border: 1px ;
            border-collapse: collapse;
        }
        th,td {
            border: 1px ;
            padding: 5px;
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
        #idcheck, #emailcheck{
        	color: red;
        }
    </style>
    <script type="text/javascript">
    	function idCheck(uid){
    		if(uid==''){
    			alert("아이디를 입력하세요");
    			document.frm.uid.focus();
    		}else{
    			let url = "idcheck";
    			let param = "uid="+uid;
    			
    			$.get(url,param,function(data,textStatus){
    				$("#idcheck").text(data.str);
    			})
    		}
    	}
    	function emailCheck(uemail){
    		if(uemail==''){
    			alert("이메일을 입력하세요");
    			document.frm.uemail.focus();
    		}else{
    			let url = "emailcheck";
    			url += "?uemail="+uemail;
    			
    			$.get(url,function(data,textStatus){
    				$("#emailcheck").text(data.str);
    			})
    		}
    	}
    	function inCheck(f){
    		if($("#idcheck").text()==""){
    			alert("아이디 중복체크를 해주세요");
    			return false;
    		}
    		if($("#emailcheck").text()==""){
    			alert("이메일 중복체크를 해주세요");
    			return false;
    		}
    		if(f.uid.value.length==0){
    			alert("아이디를 입력하세요");
    			f.uid.focus();
    			return false;
    		}
    		if(f.upw.value.length==0){
    			alert("비밀번호를 입력하세요");
    			f.upw.focus();
    			return false;
    		}
    		if(f.repwd.value.length==0){
    			alert("비밀번호 확인란을 입력하세요");
    			f.repwd.focus();
    			return false;
    		}
    		if(f.upw.value != f.repwd.value){
    			alert("비밀번호 확인이 일치하지 않습니다.");
    			f.upw.value="";
    			f.repwd.value="";
    			f.upw.focus();
    			return false;
    		}
    		if(f.uname.value.length==0){
    			alert("이름을 입력하세요");
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
    <form class="join" action="join" 
    	method="post" name="frm" onsubmit="return inCheck(this)">
        <h2>회원가입</h2>
        <table>
            <tr>
                <th><label class="control-label" for="uid">아이디</label></th>
                <td><input type="text" id="uid" name="uid" placeholder="아이디입력">
                <div id="idcheck"></div></td>
                <td><button type="button" class="btn" onclick="idCheck(document.frm.uid.value)">아이디 중복확인</button></td>
            
            </tr>
                      
            <tr>
                <th><label class="control-label" for="upw">비밀번호</label></th>
                <td><input type="password" id="upw" name="upw" placeholder="비밀번호입력"></td>
            </tr>
            <tr>
                <th><label class="control-label" for="repwd">비밀번호확인</label></th>
                <td><input type="password" id="repwd" name="repwd" placeholder="비밀번호확인"></td>
            </tr>
            <tr>
                <th><label class="control-label" for="uname">이름</label></th>
                <td><input type="text" id="uname" name="uname" placeholder="이름입력"></td>
            </tr>
            <tr>
                <th><label class="control-label" for="uemail">이메일</label></th>
                <td><input type="email" id="uemail" name="uemail" placeholder="이메일입력">
                <div id="emailcheck"></div></td>
                <td><button type="button" class="btn" onclick="emailCheck(document.frm.uemail.value)">이메일 중복확인</button></td>
            </tr>
            <tr>
                <th><label class="control-label" for="uphone">전화번호</label></th>
                <td><input type="text" id="uphone" name="uphone" placeholder="전화번호입력"></td>
            </tr>
        </table>
        <div> 
            <button type="submit" class="btn">등록</button>
            <button type="button" class="btn" onclick="history.back()">뒤로가기</button>
        </div>
    </form>
</body>
</html>