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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://kit.fontawesome.com/320c5e3232.js" crossorigin="anonymous"></script>
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
	function delete_enroll(enrollno){
		let url = "/designer/deleteEnroll/" + enrollno;
		location.href = url;
	}
	function enroll(){
		let url = "/enroll/designer";
		location.href = url;
	}
	function reserve(){
		let url = "/reserve";
		url += "?did=${ddto.did}";
		location.href = url;
	}
	//function modal(){
	//	$("#staticBackdrop").modal("show");
	//}
	
	function get(rnum) {
	    return fetch(`/reserve/${rnum}`,{method: 'get'})
	           .then(response => response.json())
	           .catch(console.log);
	}
	
	let modalInputContent = $(".modal").find("p[id='message']");
	
	$("#reserve_modal").on("click", function (e) {
		 
		  let rnum = $(this).data("rnum");
		 
		   get(rnum)
		    .then(reserve => {
		      
		      modalInputContent.val(reserve.message);
			  $(".modal").modal("show");
		 
		    });
		});
	
	//클릭 시 
	function hairenrollCheck(f){
		if (f.menu.value == ""){
			alert("시술 이름을 입력하세요");
			f.menu.focus()
            return false;
		}
		if (f.price.value == ""){
			alert("가격을 입력하세요");
			f.price.focus()
            return false;
		}
		
		if (f.price.value != "" && f.menu.value !=""){
			let url = "/hairmenu/" ;
			location.href = url;
		}
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

a:link {
	color: maroon;
	border-radius:5px
}

a:hover, a:active {
	background-color: #87CEFA;
}
.nav-link.active{
	color : purple;
	font-weight: 900;
}
</style>
<title>My page</title>
</head>
<body>
	<div style="width: 100%; height: 100%; display: flex;">
		<div
			style="width: 30%; height: 100%; padding-left: 2%; padding-top: 3%; float: left;">
			<img src="/designer/${ddto.dfilename }"
				style="width: 100%; height: 80%;">
			<div>
			<button class="btn btn-outline-success"
				style="width: 100%; border: 1px solid;" id="heart">❤️좋아요(${ddto.likecnt })</button>
				<c:if test="${not empty sessionScope.uid}">
					<button class = "btn btn-outline-success" onclick="javascript:reserve('${ddto.did}')" style="width: 50%; border: 1px solid;">예약하기</button>
                	<button class = "btn btn-outline-success" style="width: 50%; border: 1px solid;">1:1 문의</button>
                </c:if>
			</div>
			<div style="font-size: 20px; font-weight: bold; text-align: center;">${ddto.hairshop }</div>
			<div style="font-size: 20px; font-weight: bold; text-align: center;">${ddto.dname } 헤어 디자이너</div>
			<div>${ddto.introduction }</div>
			<div style="float: right">
			<c:if test="${not empty sessionScope.did}">
				<button class="btn btn-outline-success"
					style="border: 1px solid; margin-bottom: 2px;"
					onclick="dmypage_update()">디자이너 정보 수정</button>
				<button class="btn btn-outline-success" style="border: 1px solid;"
					onclick="dmypage_photo_update()">디자이너 사진 수정</button>
			</c:if>
			</div>
		</div>


		<!-- 오른쪽 구역 START -->
		 <div style="width : 80%; float : right;">
		 
            <div style="padding-top: 3%; padding-bottom: 3%; text-align: center; 
            font-size: 20px; font-weight: bold; ">
              <ul id="nav2" class="nav justify-content-center">
                <li class="nav-item"><a class="nav-link active" href="/hairmenu/${ddto.did }">메뉴</a></li>
					<li class="nav-item"><a class="nav-link" href="/style/designer/${ddto.did }">스타일</a></li>
					<li class="nav-item"><a class="nav-link" href="/review/${ddto.did}/list">리뷰</a></li>
				</ul>
            </div>
			

              <section class="vh-100">
                <div class="container py-5 h-150" style="margin-left: 5%">
                    <form action="./hairmenuEnroll" method="post" onsubmit="return hairenrollCheck(this)">
                        <div class = "form-group">
                            <label for = "cateno">카테고리</label>
                            <div>
                                <select name="cateno" id="cateno" class = "form-control" aria-label="Default select example">
                                    <option value="1">커트&드라이</option>
                                    <option value="2">펌</option>
                                    <option value="3">염색</option>
                                    <option value="4">클리닉</option>
                                    <option value="5">기타</option>
                                </select>
                            </div>
                          </div>

                        <div class = "form-group">
                          <label for = "hgender">성별</label>
                            <div>

                              <select name="hgender" id="hgender" class = "form-control" aria-label="Default select example">
                                  <option value="FEMALE">여자</option>
                                  <option value="MALE">남자</option>
                              </select>
                            </div>
                        </div>

                        
                        <div class="form-group">
                          <label for="menu">시술 이름</label>
                          <input type="text" class="form-control" name="menu" id="menu" placeholder="시술 이름">
                        </div>
                        <div class="form-group">
                          <label for="price">가격</label>
                          <input type="text" class="form-control" name="price" id="price" placeholder="가격">
                        </div>
                        
                        <div class="form-group" style = "float: center; ">
                          <button class="btn btn-outline-success"
	                        	style="border: 1px solid; visibility : hidden;">hidden</button><!-- 위치맞추기 버튼(숨김) -->
                        </div>
                        
                        <c:if test="${not empty sessionScope.did}">
	                        <div style = "float: center; ">
	                        	<button class="btn btn-outline-success" type="submit" onclick="hairmenu()"
	                        	style="border: 1px solid">등록하기</button>
			                </div>
			            </c:if>
	              </form>
                </div>
              </section>

        </div>
<div style="width: 20%; float: right;"></div>
    </div>
</body>
</html>