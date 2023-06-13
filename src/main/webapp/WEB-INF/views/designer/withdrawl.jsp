<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>디자이너 탈퇴</title>
    <link rel="stylesheet" href="/css/user.css" />
    <style>
        .withdrawl div{
            padding-top:10px;
        }
        .withdrawl button{
            margin-right: 4px;
            display: inline;
            align-items: center;
            height: 34px;
            padding: 0 12px;
            border: 1px solid #d5d5d5;
            border-radius: 4px;
            font-size: 14px;
            color: #333;
            text-align: center;
        }
        .pw-text {
            height: 34px;
            padding: 0 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
            outline: none;
            box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.75);
            font-size: 16px;
        }
        .pw-text:focus {
            border-color: #000;
        }
    </style>
    <script>
    	function chk(){
    		if(document.frm.chk_warning.checked == false){
    			alert('안내사항에 동의해야 탈퇴가 가능합니다.');
    			return false;
    		}
    	}
    </script>
</head>
<body>
    <form class="withdrawl" action="/dmypage_delete" method="post" onsubmit="return chk()" name="frm">
        <h2>디자이너탈퇴</h2>
        <p>
            탈퇴 전 확인하세요! <br>
            탈퇴하면 모든 정보가 사라지게 되며 복구할 수 없습니다. <br>
            - 프로필, 예약, 스타일, 리뷰 등 모든 등록 정보 삭제<br>
        </p>
        <div>
            <input type="checkbox" id="chk_warning" for="chk_warning">
            안내사항을 모두 확인하였으며 동의합니다.
       </div>
       <div>
            <label for="dpw">비밀번호</label>
            <input type="password" id="dpw" name="dpw" class="pw-text" placeholder="비밀번호를 입력해주세요">
       </div>
            <div>
                <button type="submit" class="btn">확인</button>
                <button type="button" class="btn" onclick="history.back()">취소</button>
            </div>
    </form>
</body>
</html>