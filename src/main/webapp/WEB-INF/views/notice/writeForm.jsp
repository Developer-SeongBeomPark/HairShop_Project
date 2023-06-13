<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>notice</title>
<meta charset="utf-8">
<link rel="stylesheet" href="/css/notice.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<script type="text/JavaScript">
        
function checkIn(f){
    if (f.ntitle.value == ""){
         alert("글제목을 입력하세요");
         f.ntitle.focus()
         return false;
    }
    if (f.ncontent.value == ""){
         alert("내용을 입력하세요");
         f.ncontent.focus();
         return false;
    }
}
</script>
</head>
<body>
	<div class="board_wrap">
		<div class="board_title">
			<strong>공지생성</strong>
		</div>
		<form class="form-horizontal" action="/notice/write" method="post"
			onsubmit="return checkIn(this)">
			<div class="form-group">
				<label class="control-label col-sm-2" for="uid">작성자</label>
				<div class="col-sm-8">
					<input type="text" name="uid" id="uid" class="form-control" value="${sessionScope.uid}" readonly >
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2" for="ntitle">제목</label>
				<div class="col-sm-8">
					<input type="text" name="ntitle" id="ntitle" class="form-control">
				</div>
			</div>

			<div class="form-group">
				<label class="control-label col-sm-2" for="ncontent">내용</label>
				<div class="col-sm-8">
					<textarea rows="12" cols="7" id="ncontent" name="ncontent"
						class="form-control"></textarea>
				</div>
			</div>

			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-5">
					<button type="submit" class="btn">등록</button>
					<button type="reset" class="btn">취소</button>
				</div>
			</div>
		</form>
	</div>
</body>
</html>
