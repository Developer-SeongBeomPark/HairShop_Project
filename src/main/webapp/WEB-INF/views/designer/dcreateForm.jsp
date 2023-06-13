<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="css/designer_createForm.css">
<style>
#idcheck, #emailcheck {
	color: red;
	width: 400px;
}
</style>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js"></script>
<script>
	$(function() {
		$('#selectBox').change(function() {
			let selected_value = $('#selectBox option:selected').val();
			if (selected_value == 2) {
				$("#div4").show();
				$("#div1").hide();
				$("#div2").hide();
				$("#div3").hide();
			} else {
				$("#div4").hide();
				$("#div1").show();
				$("#div2").show();
				$("#div3").show();
			}
		});
	});

	function idCheck(id) {
		if (id == '') {
			alert("아이디를 입력하세요");
			document.frm.did.focus();
		} else {
			var url = "idcheck";
			var param = "id=" + id;

			$.get(url, param, function(data, textStatus) {

				$("#idcheck").text(data.str);
			})
		}
	}

	function emailCheck(email) {
		if (email == '') {
			alert("email를 입력하세요");
			document.frm.demail.focus();
		} else {
			var url = "emailcheck";
			url += "?email=" + email;

			$.get(url, function(data, textStatus) {

				$("#emailcheck").text(data.str);

			})
		}
	}

	function sample6_execDaumPostcode() {
		new daum.Postcode(
				{
					oncomplete : function(data) {
						// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

						// 각 주소의 노출 규칙에 따라 주소를 조합한다.
						// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
						var addr = ''; // 주소 변수
						var extraAddr = ''; // 참고항목 변수

						//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
						if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
							addr = data.roadAddress;
						} else { // 사용자가 지번 주소를 선택했을 경우(J)
							addr = data.jibunAddress;
						}

						// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
						if (data.userSelectedType === 'R') {
							// 법정동명이 있을 경우 추가한다. (법정리는 제외)
							// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
							if (data.bname !== ''
									&& /[동|로|가]$/g.test(data.bname)) {
								extraAddr += data.bname;
							}
							// 건물명이 있고, 공동주택일 경우 추가한다.
							if (data.buildingName !== ''
									&& data.apartment === 'Y') {
								extraAddr += (extraAddr !== '' ? ', '
										+ data.buildingName : data.buildingName);
							}
							// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
							if (extraAddr !== '') {
								extraAddr = ' (' + extraAddr + ')';
							}
							// 조합된 참고항목을 해당 필드에 넣는다.
							//document.getElementById("sample6_extraAddress").value = extraAddr;

						} else {
							//document.getElementById("sample6_extraAddress").value = '';
						}

						// 우편번호와 주소 정보를 해당 필드에 넣는다.
						document.getElementById('sample6_postcode').value = data.zonecode;
						document.getElementById("sample6_address").value = addr;
						// 커서를 상세주소 필드로 이동한다.
						document.getElementById("sample6_detailAddress")
								.focus();
					}
				}).open();
	}

	function inCheck(f) {
		if($("#idcheck").text()==""){
			alert("아이디 중복체크를 해주세요");
			return false;
		}
		if($("#emailcheck").text()==""){
			alert("이메일 중복체크를 해주세요");
			return false;
		}
		if (f.did.value.length == 0) {
			alert("아이디를 입력하세요");
			f.did.focus();
			return false;
		}
		if (f.dpw.value.length == 0) {
			alert("비밀번호을 입력하세요");
			f.dpw.focus();
			return false;
		}
		if (f.repw.value.length == 0) {
			alert("비밀번호 확인을 입력하세요");
			f.repw.focus();
			return false;
		}
		if (f.dpw.value != f.repw.value) {
			alert("비번과 비번확인이 일치하지 않습니다.");
			f.dpw.value = "";
			f.repw.value = "";
			f.dpw.focus();
			return false;
		}
		if (f.dname.value.length == 0) {
			alert("이름을 입력하세요");
			f.dname.focus();
			return false;
		}

		if (f.demail.value.length == 0) {
			alert("이메일을 입력하세요");
			f.demail.focus();
			return false;
		}

		if (f.dphone.value.length == 0) {
			alert("전화번호를 입력하세요");
			f.dphone.focus();
			return false;
		}
		if (f.birth.value.length == 0) {
			alert("생년월일을 입력하세요");
			f.birth.focus();
			return false;
		}
		if (f.dzipcode.value.length == 0) {
			alert("주소를 입력하세요");
			f.dzipcode.focus();
			return false;
		}

	}
</script>
<title>회원가입</title>

</head>
<body>
	<form action="dcreate" method="post" name="frm"
		onsubmit="return inCheck(this)">
		<section class="h-100 h-custom gradient-custom-2">
			<div class="container py-5 h-100">
				<div
					class="row d-flex justify-content-center align-items-center h-100">
					<div class="col-12">
						<div class="card card-registration card-registration-2"
							style="border-radius: 15px;">
							<div class="card-body p-0">
								<div class="row g-0">
									<div class="col-lg-6">
										<div class="p-5">
											<h3 class="fw-normal mb-5" style="color: #4835d4;">디자이너
												회원가입</h3>

											<div class="row">
												<div class="col-md-6 mb-4 pb-2">
													<div class="form-outline">
														<label class="form-label" for="did">아이디</label> <input
															type="text" id="did" name="did"
															class="form-control form-control-lg" />
														<button type="button" class="btn btn-default col-sm-5"
															onclick="idCheck(document.frm.did.value)">ID
															중복확인</button>
														<div id="idcheck"></div>
													</div>
												</div>
											</div>

											<div class="mb-4 pb-2">
												<div class="form-outline">
													<label class="form-label" for="dpw">비밀번호</label> <input
														type="password" id="dpw" name="dpw"
														class="form-control form-control-lg" />

												</div>
											</div>

											<div class="mb-4 pb-2">
												<div class="form-outline">
													<label class="form-label" for="repw">비밀번호 확인</label> <input
														type="password" id="repw" name="repw"
														class="form-control form-control-lg" />

												</div>
											</div>

											<div class="mb-4 pb-2">
												<div class="form-outline">
													<label class="form-label" for="dname">이름</label> <input
														type="text" id="dname" name="dname"
														class="form-control form-control-lg" />

												</div>
											</div>

											<div class="row">
												<div class="mb-4">
													<div class="form-outline form-white">
														<label class="form-label" for="demail">이메일</label> <input
															type="email" id="demail" name="demail"
															class="form-control form-control-lg" />
														<button type="button" class="btn btn-default col-sm-3"
															onclick="emailCheck(document.frm.demail.value)">email
															중복확인</button>
														<div id="emailcheck"></div>
													</div>
												</div>
											</div>

											<div class="mb-4">
												<div class="form-outline form-white">
													<label class="form-label" for="dphone">전화번호</label> <input
														type="text" id="dphone" name="dphone"
														class="form-control form-control-lg" />
												</div>
											</div>

											<div class="mb-4">
												<div class="form-outline form-white">
													<label class="form-label" for="birth">생년월일 (예 :
														901225)</label> <input type="text" id="birth" name="birth"
														class="form-control form-control-lg" />
												</div>
											</div>

											<div class="mb-4">
												<div class="form-outline form-white">
													<label class="form-label" for="hairshop">헤어샵</label> <input
														type="text" id="hairshop" name="hairshop"
														class="form-control form-control-lg" />
												</div>
											</div>

											<div class="mb-4">
												<div class="form-outline form-white">
													<label class="form-label" for="sample6_postcode">우편번호</label>
													<input type="text" id="sample6_postcode" name="dzipcode"
														class="form-control form-control-lg" />
													<button type="button" class="btn btn-default col-sm-2"
														onclick="sample6_execDaumPostcode()">주소 검색</button>
												</div>
											</div>
											<br>
											<div class="mb-4">
												<div class="form-outline form-white">
													<label class="form-label" for="sample6_address">주소</label>
													<input type="text" id="sample6_address" name="address1"
														class="form-control form-control-lg" />
												</div>
											</div>

											<div class="mb-4">
												<div class="form-outline form-white">
													<label class="form-label" for="sample6_detailAddress">상세주소</label>
													<input type="text" id="sample6_detailAddress"
														name="address2" class="form-control form-control-lg" />
												</div>
											</div>


										</div>
									</div>
									<div class="col-lg-6 bg-indigo text-white">
										<div class="p-5">
											<h3 class="fw-normal mb-5">자격증 정보</h3>

											<div class="mb-4 pb-2" style="color: black;">
												<select class="selectBox" id="selectBox">
													<option value="1" selected="selected">수첩형 자격증</option>
													<option value="2">상장형 자격증</option>
												</select>
											</div>

											<div class="mb-4 pb-3" id="div1">
												<div class="form-outline form-white">
													<label class="form-label" for="licenseno">자격증 번호
														(예:12345678901A)</label> <input type="text" id="licenseno"
														name="licenseno" class="form-control form-control-lg" />
												</div>
											</div>

											<div class="mb-4 pb-3" id="div2">
												<div class="form-outline form-white">
													<label class="form-label" for="licensedate">발급(등록)연월일
														(예:20050101)</label> <input type="text" id="licensedate"
														name="licensedate" class="form-control form-control-lg" />
												</div>
											</div>

											<div class="mb-4 pb-3" id="div3">
												<div class="form-outline form-white">
													<label class="form-label" for="uniquecode1">자격증
														내지번호 (예:0901234567)</label> <input type="text" id="uniquecode1"
														name="uniquecode1" class="form-control form-control-lg" />
												</div>
											</div>

											<div class="mb-4 pb-4" id="div4" style="display: none;">
												<div class="form-outline form-white">
													<label class="form-label" for="uniquecode2">자격증
														관리번호</label> <input type="text" id="uniquecode2"
														name="uniquecode2" class="form-control form-control-lg" />
												</div>
											</div>

											<button type="submit" class="btn btn-light btn-lg"
												data-mdb-ripple-color="dark">등록</button>
											<button type="reset" class="btn btn-light btn-lg"
												data-mdb-ripple-color="dark">취소</button>

										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
	</form>
</body>
</html>