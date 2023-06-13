<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="util" uri="/ELFunctions"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css"
	integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<script>
	function dmypage_update(did) {
		let url = "/dmypage_update";
	    url += "?did=";
	    url += did;
	    location.href = url;
	}
	
	function dmypage_photo_update() {
		let url = "/designer/dupdateFileForm/";
		location.href = url;
	}

	function dmypage_intro_update() {
		let url = "/dmypage_intro_update";
		location.href = url;
	}
	function delete_enroll(enrollno) {
		let url = "/designer/deleteEnroll/" + enrollno;
		location.href = url;
	}
	function reserve(){
		let url = "/reserve";
		url += "?did=${ddto.did}";
		location.href = url;
	}
</script>
<style>
label {
	font-size: 150%;
}

button {
	border: 1px solid;
	float: right;
}

td button {
	border: 1px solid;
}

.form {
	float: right;
}
</style>
<title>My page</title>
</head>
<body>
	<div style="width: 100%; height: 100%; display: flex;">
		<div style="width: 17%; height: 100%; padding-left: 2%; padding-top: 3%; float: left;">
			<img src="/designer/${ddto.dfilename }" style="width: 100%; height: 80%;">
			<div>
				<c:choose>
				<c:when test="${not empty sessionScope.uid }">
				
					<c:choose>
						<c:when test="${heart_chk == 0 }">
						<button class="btn btn-outline-success" id="whiteHeart" 
							style="width: 100%; border: 1px solid;"> 🤍좋아요(${ddto.likecnt })</button>
						</c:when>
						<c:when test="${heart_chk == 1 }">
							<button class="btn btn-outline-success" id="redHeart" 
							style="width: 100%; border: 1px solid;">❤️좋아요(${ddto.likecnt })</button>
						</c:when>
					</c:choose>
				</c:when>
				
				<c:otherwise>
					<button class="btn btn-outline-success" 
						style="width: 100%; border: 1px solid;" disabled>❤️좋아요(${ddto.likecnt })</button>
				</c:otherwise>
			</c:choose>
				<c:if test="${not empty sessionScope.uid}">
					<button class = "btn btn-outline-success" onclick="javascript:reserve('${ddto.did}')" style="width: 50%; border: 1px solid;">예약하기</button>
	                <button class = "btn btn-outline-success" style="width: 50%; border: 1px solid;">1:1 문의</button>
                </c:if>
			</div>
			<div style="font-size: 20px; font-weight: bold; text-align: center;">${ddto.hairshop }</div>
			<div style="font-size: 20px; font-weight: bold; text-align: center;">${ddto.dname }
				헤어 디자이너</div>
			<div style="text-align: center;">${ddto.introduction }</div>
			<div style="font-weight: bold; text-align: center;">문의📞 ${ddto.dphone }</div>
			<br>
			<div style="float: right">
			<c:if test="${not empty sessionScope.did}">
				<button class="btn btn-outline-success"
					style="border: 1px solid; margin-bottom: 2px; float:left;"
					onclick="dmypage_update('${ddto.did}')">디자이너 정보 수정</button>
				<button class="btn btn-outline-success" 
					style="border: 1px solid; margin-bottom: 2px; float: left;"
					onclick="dmypage_photo_update()">디자이너 사진 수정</button>
			</c:if>
			</div>
		</div> <!-- div left구역 end -->

		
		<div style="width: 80%; float: right;">

			<!-- 윗 목록 메뉴/스타일/리뷰 -->
			<div style="padding-top: 3%; padding-bottom: 3%; text-align: center; font-size: 20px; font-weight:bold">
				<ul id="nav2" class="nav justify-content-center">
					<li class="nav-item"><a class="nav-link active" href="/hairmenu/${ddto.did }">메뉴</a></li>
					<li class="nav-item"><a class="nav-link" href="/style/designer/${ddto.did }">스타일</a></li>
					<li class="nav-item"><a class="nav-link" href="/review/${ddto.did}/list">리뷰</a></li>
				</ul>
			</div>
			<!-- 윗 목록 END -->


			<div class="container">
				<div class="head">
					<div class="title" style="float:left; height:40px">
						<p style="font-size:25px; font-weight:bold">Review</p>
					</div>
					<div class="star-row" style="float:left; height:40px;">
						<div class="starsum">
						<c:if test = "${not empty starAvg }">
							<p style="font-size:25px; font-weight:bold">&nbsp ⭐ ${starAvg }&nbsp</p>
						</c:if>
						<c:if test = "${empty starAvg }">
							<p style="font-size:25px; font-weight:bold">&nbsp ⭐ ${starAvg0 }&nbsp</p>
						</c:if>
						</div>
						<!-- 평균 별점 -->
					</div>


					<form class="form-inline" action="./list" style="float:right">
						<div class="form-group">
							<select class="form-control" name="col">
								<option value="rtitle"
									<c:if test= "${col=='rtitle'}"> selected </c:if>>제목</option>
								<option value="rcontent"
									<c:if test= "${col=='rcontent'}"> selected </c:if>>내용</option>
								<option value="uid"
									<c:if test= "${col=='uid'}"> selected </c:if>>아이디</option>
								<option value="title_content"
									<c:if test= "${col=='title_content'}"> selected</c:if>>제목+내용</option>
								<option value="total"
									<c:if test= "${col=='total'}"> selected </c:if>>전체출력</option>
							</select>
						</div>
						<div class="form-group">
							<input type="text" class="form-control" placeholder="Enter 검색어"
								name="word" value="${word}">
						</div>
						<div class="form-group">
							<button type="submit" class="btn btn-default">검색</button>
						</div>
						<div class="form-group">
							<c:if test="${not empty sessionScope.uid}">
								<button type="button" class="btn btn-default" id="reviewCreate">등록</button>
							</c:if>
						</div>
					</form>
				</div> <!-- head END -->
				<br>
				<hr>

				<div class="contents">
					<c:forEach var='dto' items="${list }">
						<div class="row">
							<c:if test="${dto.rfilename != 'no.jpg'}">
								<div class="review-img">
									<a><img class='chat' data-rno="${dto.rno }"
										src="/hairReview/storage/${dto.rfilename}"
										style="width: 120px; height: 120px; border-radius: 5%;"></a>&nbsp
									&nbsp
								</div>
							</c:if>
							<div class="customer-review">
								<div class="star">
									${dto.uid } &nbsp &nbsp
									<c:if test="${dto.star == 1}">
										<i class="fa-solid fa-star"></i>
									</c:if>
									<c:if test="${dto.star == 2}">
										<i class="fa-solid fa-star"></i>
										<i class="fa-solid fa-star"></i>
									</c:if>
									<c:if test="${dto.star == 3}">
										<i class="fa-solid fa-star"></i>
										<i class="fa-solid fa-star"></i>
										<i class="fa-solid fa-star"></i>
									</c:if>
									<c:if test="${dto.star == 4}">
										<i class="fa-solid fa-star"></i>
										<i class="fa-solid fa-star"></i>
										<i class="fa-solid fa-star"></i>
										<i class="fa-solid fa-star"></i>
									</c:if>
									<c:if test="${dto.star == 5}">
										<i class="fa-solid fa-star"></i>
										<i class="fa-solid fa-star"></i>
										<i class="fa-solid fa-star"></i>
										<i class="fa-solid fa-star"></i>
										<i class="fa-solid fa-star"></i>
									</c:if>
									${dto.star } &nbsp &nbsp | &nbsp
									<div style="float: right;">${dto.rdate }</div>
								</div>


								<h3>${dto.rtitle } </h3> 
								<p data-rno="${dto.rno }" class='chat'>${dto.rcontent }</p>
							</div>
						</div>

						<!-- row end -->
						<hr>
					</c:forEach>
				</div>
				<!-- contents END -->
				<div>${paging }</div>
			</div>
			<!-- Modal -->
			<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-hidden="true">&times;</button>
							<h4 class="modal-title" id="myModalLabel">😊REVIEW😊</h4>
						</div>
						<div class="modal-body">
							<div class="form-group">
								<label>아이디</label> 
								<input class="form-control" name='uid' id="uid" disabled> 
								 <label id="lableDid">담당디자이너</label> 
									<input class="form-control" name='did' id="did" disabled><br>
								<div id="rating">
									<label>평점</label>&nbsp&nbsp <select name="star">
										<option value="5">아주 좋아요 &nbsp ★★★★★</option>
										<option value="4">맘에 들어요 &nbsp ★★★★☆</option>
										<option value="3">보통이에요 &nbsp&nbsp ★★★☆☆</option>
										<option value="2">그냥 그래요 &nbsp ★★☆☆☆</option>
										<option value="1">별로에요 &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
											★☆☆☆☆</option>
									</select>
								</div>

								<label class="modal-img">이미지 </label>
								<div class="review-img">
									<img class='modal-img' src="" name="rfilename"
										style="width: 150px; height: 150px; border-radius: 5%;">
									<input type="file" name="addfile">
								</div>
								<label>제목</label> <input class="form-control" name='rtitle' id="rtitle"> 
								<label>내용</label>
								<textarea cols="10" rows="10" class="form-control"
									name='rcontent' id="rcontent" ></textarea>
							</div>
						</div>
						<div class="modal-footer">
							<button id='modalModBtn' type="button" class="btn btn-warning">Modify</button>
							<button id='modalRemoveBtn' type="button" class="btn btn-danger">Remove</button>
							<button id='modalRegisterBtn' type="button" class="btn btn-primary">Register</button>
							<button id='modalCloseBtn' type="button" class="btn btn-default">Close</button>
						</div>
					</div>
					<!-- /.modal-content -->
				</div>
				<!-- /.modal-dialog -->
			</div>

		</div>
		<!-- container END -->

	</div>
	<!-- 오른쪽 div 구역 END -->

	<div style="width: 20%; float: right;"></div>
	<div></div>

	<!-- 맨처음 div -->
<script>let uid = '${sessionScope.uid}'</script>
<script>let did = '${ddto.did}'</script>
<script src="/js/reviewProducer.js"></script>
<script src="/js/reviewConsumer.js"></script>
<script src="/js/heart.js"></script>
</body>
</html>