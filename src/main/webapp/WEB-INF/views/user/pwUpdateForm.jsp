<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>pwUpdate</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="/css/user.css" />
    <style>
        .pwUpdate > div {
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
    </style>
    <script type="text/javascript">
    	function inCheck(f){
    		if(f.upw.value.length==0){
    			alert("현재 비밀번호를 입력하세요");
    			f.upw.focus();
    			return false;
    		}
    		if(f.newpw.value.length==0){
    			alert("새 비밀번호를 입력하세요");
    			f.newpw.focus();
    			return false;
    		}
    		if(f.repwd.value.length==0){
    			alert("새 비밀번호 확인란을 입력하세요");
    			f.repwd.focus();
    			return false;
    		}
    		if(f.newpw.value != f.repwd.value){
    			alert("비밀번호 확인이 일치하지 않습니다.");
    			f.newpw.value="";
    			f.repwd.value="";
    			f.newpw.focus();
    			return false;
    		}
    	}
    </script>
</head>
<body>
    <form class="pwUpdate" action="/pwUpdate" 
    	method="post" name="frm" onsubmit="return inCheck(this)">
        <h2>비밀번호 수정</h2>
        <table>
            <tr>
                <th><label class="control-label" for="upw">현재 비밀번호</label></th>
                <td><input type="password" id="upw" name="upw" placeholder="현재 비밀번호 입력"></td>
            </tr>
            <tr>
                <th><label class="control-label" for="newpw">새 비밀번호</label></th>
                <td><input type="password" id="newpw" name="newpw" placeholder="새 비밀번호 입력"></td>
            </tr>
            <tr>
                <th><label class="control-label" for="repwd">새 비밀번호확인</label></th>
                <td><input type="password" id="repwd" name="repwd" placeholder="새 비밀번호 확인"></td>
            </tr>
        </table>
        <div> 
            <button type="submit" class="btn">변경</button>
            <button type="button" class="btn" onclick="history.back()">뒤로가기</button>
        </div>
    </form>
</body>
</html>