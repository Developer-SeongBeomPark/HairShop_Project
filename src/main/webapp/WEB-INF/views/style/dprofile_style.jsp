<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


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
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css"
	integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet"
	href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css"
	integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p"
	crossorigin="anonymous" />

<link rel="stylesheet" href="/css/styleUpload.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<script src="/js/designer_mypage.js"></script>


<style>
button {
	border: 1px solid;
	float: right;
}
</style>
<title>Style</title>
</head>
<body>
	<div style="width: 100%; height: 100%; display: flex;">
		<div
			style="width: 19.2%; height: 100%; padding-left: 2%; padding-top: 3%; float: left;">
			<div style="width: 100%; height: 100%;">
				<img src="/designer/${ddto.dfilename }"
					style="width: 100%; height: 80%;">
			</div>
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
					<button type=button onclick="javascript:reserve('${ddto.did}')" class = "btn btn-outline-success" style="width: 50%; border: 1px solid;">예약하기</button>
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
					style="border: 1px solid; margin-bottom: 2px; float: left;"
					onclick="dmypage_update('${ddto.did}')">디자이너 정보 수정</button>
				<button class="btn btn-outline-success" 
					style="border: 1px solid; margin-bottom: 2px; float: left;"
					onclick="dmypage_photo_update()">디자이너 사진 수정</button>
			</c:if>
			</div>
		</div>




		<div style="width: 80%; float: right;">
			<div
				style="padding-top: 3%; padding-bottom: 3%; text-align: center; font-size: 20px; font-weight: bold; margin-left: 14%;">
				<ul id="nav2" class="nav justify-content-center">
					<li class="nav-item"><a class="nav-link active"
						href="/hairmenu/${ddto.did }">메뉴</a></li>
					<li class="nav-item"><a class="nav-link"
						href="/style/designer/${ddto.did }">스타일</a></li>
					<li class="nav-item"><a class="nav-link" href="/review/${ddto.did}/list">리뷰</a>
					</li>
				</ul>
			</div>

			<div class="container" style="margin-left: 5%;">
				<c:if test="${sessionScope.did != null }">
					<div class="upload-box" id="upload">
						<h3>Upload File</h3>
						<div class="filearea">
							<div class="icon">
								<i class="fas fa-images"> </i>
							</div>
							<span class="header">Click Me</span> <span class="support">Supports:JPEG,JPG,PNG</span>

						</div>
						<form action="/style/designer" method="post"
							enctype="multipart/form-data" onsubmit="return formCheck()">
							<input type="file" name="file" id="input-file">
							<div class="form-radio">
								<label for="iwoman" class="ilabel"> <input type="radio"
									name="uploadgender" value="FEMALE" id="iwoman" />여자
								</label> <label for="iman" class="ilabel"> <input type="radio"
									name="uploadgender" value="MALE" id="iman" />남자
								</label>
							</div>

							<button>
								UPLOAD <i class="fa-solid fa-cloud-arrow-up"></i>
							</button>
						</form>
					</div>
				</c:if>




				<div class="img-box">
					<h3>스타일</h3>
					<div class="radio-box">
						<label for="all" class="select-btn"><input type="radio"
							value="all" name="gender" id="all" />전체 사진 </label> <label for="woman"
							class="select-btn"><input type="radio" value="FEMALE"
							name="gender" id="woman" />여성 사진모음</label> <label for="man"
							class="select-btn"><input type="radio" value="MALE"
							name="gender" id="man" />남성 사진모음</label>
					</div>
					<div class="img-area">
						<div class="all-img" id="styleBox"></div>
						<div class="woman-img" id="styleBox"></div>
						<div class="man-img" id="styleBox"></div>

					</div>
					<button class="add-btn">더보기</button>
				</div>
			</div>




		</div>

		<div style="width: 15%; float: right;"></div>
	</div>

	<script>
		let did = "${sessionScope.did}";
		let style_did = "";
		if(did != "") {
			style_did = "${sessionScope.did}";
		}else{
			style_did = "${ddto.did}";
		}
	</script>

<script src="/js/styleUpload.js"></script>
<script src="/js/heart.js"></script>
<script>let uid = '${sessionScope.uid}'</script>
<script>did = '${ddto.did}'</script>
</body>
</html>