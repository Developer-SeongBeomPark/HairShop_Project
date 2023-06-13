<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="util" uri="/ELFunctions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 수정</title>
<link rel="stylesheet" href="/css/notice.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="board_wrap">
		<div class="board_title">
			<strong>공지사항</strong>
			<p>공지사항 수정</p>
		</div>
		<form class="form-horizontal" action="/notice/edit" method="post">
		<input type="hidden" name="noticeno" value="${dto.noticeno}">
			<div class="board_write_wrap">
				<div class="board_write">
					<div class="title">
						<dl>
							<dt>
								<label for="ntitle">제목</label>
							</dt>
							<dd>

								<input type="text" id="ntitle" name="ntitle" placeholder=""
									value="${dto.ntitle}">

							</dd>
						</dl>
					</div>
					<div class="info">
						<dl>
							<dt>글쓴이</dt>
							<dd>
								<input type="text" id="uid" name="uid" value="${dto.uid}" disabled>
							</dd>
						</dl>

					</div>
					<div class="cont">
						<textarea placeholder="내용 입력" id="ncontent" name="ncontent">
                    	${dto.ncontent}
                    	</textarea>
					</div>
				</div>
				<div class="bt_wrap">
					<button type="submit" class="on">수정</button>
					<button onclick='history.back()'>취소</button>
				</div>
			</div>
		</form>
	</div>
</body>
</html>