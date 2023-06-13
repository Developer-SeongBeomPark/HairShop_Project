<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>style Page</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css"
	integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet"
	href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css"
	integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p"
	crossorigin="anonymous" />

<link rel="stylesheet" href="/css/styleUpload.css">
</head>
<body>
	<div class="container">
		<div class="upload-box">
			<h3>Upload File</h3>
			<div class="filearea">
				<div class="icon">
					<i class="fas fa-images"> </i>
				</div>
				<span class="header">Click Me</span>
				<span class="support">Supports:JPEG,JPG,PNG</span>

			</div>
			<form action="/style/designer" method="post"
				enctype="multipart/form-data" onsubmit="return formCheck()">
				<input type="file" name="file" id="input-file">
				<div class="form-radio">
				<label for="iwoman" class="ilabel"> <input type="radio" name="uploadgender" value="여자" id="iwoman"/>여자</label>
				<label for="iman" class="ilabel"> <input type="radio"	name="uploadgender" value="남자" id="iman"/>남자</label> 
				</div>
				
				<button>
					UP LOAD <i class="fa-solid fa-cloud-arrow-up"></i>
				</button>
			</form>

		</div>

		<div class="img-box">
			<h3>스타일</h3>
			<div class="radio-box">
			<label for="all" class="select-btn"><input type="radio" value="all" name="gender" id="all"/>전체 사진 </label>
			<label for="woman" class="select-btn"><input type="radio" value="여자" name="gender" id="woman"/>여성 사진모음</label>
			<label for="man" class="select-btn"><input type="radio" value="남자" name="gender" id="man"/>남성 사진모음</label>
			</div>
			<div class="img-area">
				<div class="all-img" id="styleBox">
				
				</div>
				<div class="woman-img" id="styleBox">
				
				</div>
				<div class="man-img" id="styleBox">
				
				</div>
				
			</div>
			<button class="add-btn">더보기</button>
		</div>
	</div>


		<script src="/js/styleUpload.js"></script>
</body>
</html>