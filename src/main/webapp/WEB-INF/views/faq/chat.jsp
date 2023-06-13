<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" />
<title></title>
<link rel="stylesheet" href="/css/notice.css">


<%-- WebSocket 관련 설정 --%>
<script src="/js/sockjs.min.js"></script>
<%--/static 폴더 기준 --%>
<script src="/js/stomp.min.js"></script>
<%--/static 폴더 기준 --%>

<script type="text/JavaScript" src="/js/app.js"></script>
<%--/static 폴더 기준 --%>

</head>
<body>
	<div id="main-content" class="container">
		<div class="board_wrap">
			<div class="board_title">
				<strong>FAQ</strong>
				<p>자주 묻는 질문입니다.</p>
				<p style="align:right";><a href="https://cut-toucan-5da.notion.site/BeomHair-3bb2c884c94d4a80941db4d8789934b4">*기타 문의하기</a></p>
			</div>
			
			<form class="form-inline">
				<div class="form-group" style="width: 90%;">
					<label for="msg">문의: </label>
					
					<%--<input type="text" id="msg"
						class="form-control" placeholder="내용을 입력하세요...."
						value="JAVA에 대해서 알려주세요." style="width: 90%;"> --%>
						<select id="msg" class="form-control" style="width: 90%;">
							<option value="">--질문을 선택하세요--</option>
							<option value="" disabled>- - - - - - - - 페이지 안내 - - - - - - - -</option>
							<option value="메인(홈)페이지 안내">메인(홈)페이지 안내</option>
							<option value="메뉴 페이지가 궁금해요">메뉴 페이지가 궁금해요</option>
							<option value="스타일 페이지가 궁금해요">스타일 페이지가 궁금해요</option>
							<option value="리뷰 페이지가 궁금해요">리뷰 페이지가 궁금해요</option>
							<option value="" disabled>- - - - - - - - 예   약 - - - - - - - -</option>
							<option value="예약은 어떻게 하나요?">예약은 어떻게 하나요?</option>
							<option value="고객이 예약 신청 하였을때 확정은 어떻게 하나요?">고객이 예약 신청 하였을때 확정은 어떻게 하나요?</option>
							<option value="예약을 신청했습니다. 확인은 어떻게 하나요?">예약을 신청했습니다. 확인은 어떻게 하나요?</option>
							<option value="예약을 취소하려면 어떻게 해야되나요?">예약을 취소하려면 어떻게 해야되나요?</option>
							<option value="예약 가능한 시간 및 정보는 어떻게 등록 하나요?">예약 가능한 시간 및 정보는 어떻게 등록 하나요?</option>
							<option value="예약 등록한 정보를 지우고 싶습니다.">예약 등록한 정보를 지우고 싶습니다.</option>
							<option value="" disabled>- - - - - - - - 회원/디자이너 정보 - - - - - - - -</option>
							<option value="회원 정보 수정/비밀번호 수정 방법">회원 정보 수정/비밀번호 수정 방법</option>
							<option value="디자이너 정보 수정/사진 수정 방법">디자이너 정보 수정/사진 수정 방법</option>							
							<option value="디자이너 정보는 어떻게 볼 수 있나요?">디자이너 정보는 어떻게 볼 수 있나요?</option>
							<option value="" disabled>- - - - - - - - 회원가입/탈퇴 - - - - - - - -</option>
							<option value="회원가입 방법">회원가입 방법</option>
							<option value="회원탈퇴 방법">회원탈퇴 방법</option>
							<option value="디자이너 탈퇴 방법">디자이너 탈퇴 방법</option>
							<option value="" disabled>- - - - - - - - 로그인 / 로그아웃 - - - - - - - -</option>
							<option value="로그인은 어떻게 하나요">로그인은 어떻게 하나요</option>
							<option value="로그인이 되지 않습니다.">로그인이 되지 않습니다.</option>
							<option value="로그아웃 방법">로그아웃 방법</option>
							<option value="" disabled>- - - - - - - - 아이디 / 비밀번호찾기 - - - - - - - -</option>
							<option value="아이디 찾는 방법">아이디 찾는 방법</option>
							<option value="비밀번호 찾는 방법">비밀번호 찾는 방법</option>
						</select>
						
				</div>
				<button id="send" class="btn btn-default" disabled type="submit">검색</button>
			</form>
			
			<div class="row">
				<div class="col-md-12">
					<table id="conversation" class="table table-striped">
						<thead>
							<tr>
								<th>메세지</th>
							</tr>
						</thead>
						<tbody id="communicate">
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</body>
</html>