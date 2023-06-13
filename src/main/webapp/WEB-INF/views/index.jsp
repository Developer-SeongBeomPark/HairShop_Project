<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:choose>
	<c:when test="${not empty sessionScope.did}">
		<c:set var='str'>안녕하세요  ${sessionScope.did } 님!</c:set>
	</c:when>
	<c:otherwise>
		<c:set var="str">기본 페이지 입니다.</c:set>
	</c:otherwise>
</c:choose>

<!DOCTYPE html>
<html>
<head>
<title>BeomHair</title>
<script src="/js/slide.js"></script>


<meta charset="utf-8">
<link rel="stylesheet" href="/css/index.css">
<link rel="stylesheet" href="/css/slide.css">
<link rel="stylesheet" href="/css/notice.css">


</head>
<body>
	<br>
	<section class="section section--visual">
		<div class="inner slideshow-container">
			<div class="picture mySlideDiv fade active"></div>
			<div class="picture2 mySlideDiv fade"></div>
			<div class="picture3 mySlideDiv fade"></div>
			<a class="prev" onclick="prevSlide()">&#10094;</a> <a class="next"
				onclick="nextSlide()">&#10095;</a>
		</div>
	</section>
	<br>
	<div class="map_wrap">
		<div id="map"
			style="width: 100%; height: 500px; position: relative; overflow: hidden;"></div>

		<div id="menu_wrap" class="bg_white">
			<div class="option">
				<div>
					<form commandName="ddto" method="get" name="listForm" id="listForm"
						action="/">
						키워드 : <input type="text" class="text" id="searchWrd"
							name="searchWrd" placeholder="검색어를 입력해주세요"
							value="${ddto.searchWrd }" size="15">
						<button type="submit" onclick="test()">검색하기</button>
						<br>
						<button type="button" onclick="currentlocation()">현 위치</button>
					</form>
					<script>
						test();
					</script>
				</div>
			</div>
			<hr>
			<ul id="placesList"></ul>
			<div id="pagination"></div>
		</div>

		<!-- 지도타입 컨트롤 div 입니다 -->
		<div class="custom_typecontrol radius_border">
			<span id="btnRoadmap" class="selected_btn"
				onclick="setMapType('roadmap')">지도</span> <span id="btnSkyview"
				class="btn" onclick="setMapType('skyview')">스카이뷰</span>
		</div>
		<!-- 지도 확대, 축소 컨트롤 div 입니다 -->
		<div class="custom_zoomcontrol radius_border">
			<span onclick="zoomIn()"> <img
				src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/ico_plus.png"
				alt="확대"></span> <span onclick="zoomOut()"> <img
				src="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/ico_minus.png"
				alt="축소"></span>
		</div>
	</div>

	<div class="board_wrap">
		<div class="board_title"></div>
		<br>
		<div class="board_list_wrap">
			<div class="board_list">
				<div class="top">
					<div class="writer">이름</div>
					<div class="num">미용실</div>
					<div class="title">주소</div>
				</div>

				<c:choose>
					<c:when test="${empty test}">
						<tr>
							<td colspan="6"></td>
					</c:when>

					<c:otherwise>
						<c:forEach var="ddto" items="${test}">
							<div>
								<div class="writer">${ddto.dname}</div>
								<div class="num">
									<a href="javascript:info('${ddto.did}')">${ddto.hairshop}</a>
								</div>
								<div class="title">${ddto.address1}</div>
							</div>
						</c:forEach>
					</c:otherwise>
				</c:choose>

			</div>
			<div>${paging}</div>
			<div class="bt_wrap"></div>
		</div>
	</div>

	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e434ef30388bc9bd7f3af763f071ff66&libraries=services"></script>
	<script>
		function info(did) {
			let url = "/hairmenu/" + did;
			location.href = url;
		}
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
		mapOption = {
			center : new kakao.maps.LatLng(37.503515, 127.049713), // 지도의 중심좌표
			level : 3
		// 지도의 확대 레벨
		};
		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		function setMapType(maptype) {
			var roadmapControl = document.getElementById('btnRoadmap');
			var skyviewControl = document.getElementById('btnSkyview');
			if (maptype === 'roadmap') {
				map.setMapTypeId(kakao.maps.MapTypeId.ROADMAP);
				roadmapControl.className = 'selected_btn';
				skyviewControl.className = 'btn';
			} else {
				map.setMapTypeId(kakao.maps.MapTypeId.HYBRID);
				skyviewControl.className = 'selected_btn';
				roadmapControl.className = 'btn';
			}
		}
		function zoomIn() {
			map.setLevel(map.getLevel() - 1);
		}
		// 지도 확대, 축소 컨트롤에서 축소 버튼을 누르면 호출되어 지도를 확대하는 함수입니다
		function zoomOut() {
			map.setLevel(map.getLevel() + 1);
		}
		//주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();
		var addressList = new Array();
		var hairshopList = new Array();
		var didList = new Array();
		var ShopList = JSON.parse('${ShopListJson}');
		for ( var k in ShopList) {
			var $obj = ShopList[k];
			var aa = $obj.address1;
			var bb = $obj.hairshop;
			var cc = $obj.did;
			addressList.push(aa);
			hairshopList.push(bb);
			didList.push(cc);
			console.log(didList);
		}
		//주소 리스트 

		function test() {
			addressList.forEach(function(addr, index) {
				// 주소로 좌표를 검색합니다
				geocoder.addressSearch(addr, function(result, status) {
					// 정상적으로 검색이 완료됐으면 
					if (status === kakao.maps.services.Status.OK) {
						var coords = new kakao.maps.LatLng(result[0].y,
								result[0].x);
						// 결과값으로 받은 위치를 마커로 표시합니다
						var marker = new kakao.maps.Marker({
							map : map,
							position : coords
						});
						var content = '<div class="overlay_info">';
						content += '  <a href="javascript:info(\''
								+ didList[index] + '\')"><strong>  '
								+ hairshopList[index] + '</strong></a>';
						content += '    <div class="desc">';
						content += '        <span class="address">'
								+ addressList[index] + '</span>';
						content += '    </div>';
						content += '</div>';
						// 인포윈도우로 장소에 대한 설명을 표시합니다
						var infowindow = new kakao.maps.InfoWindow({
							//  content: cmpnmList[index], 
							content : content,
							disableAutoPan : true
						});
						infowindow.open(map, marker);
						// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
						if (index == 0) {
							map.setCenter(coords);
						}
					}
				});
			});
		}
		test();
		function currentlocation() {
			if (navigator.geolocation) {

				// GeoLocation을 이용해서 접속 위치를 얻어옵니다
				navigator.geolocation.getCurrentPosition(function(position) {

					var lat = position.coords.latitude, // 위도
					lon = position.coords.longitude; // 경도

					var locPosition = new kakao.maps.LatLng(lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
					message = '<div style="padding:5px;">현재위치</div>'; // 인포윈도우에 표시될 내용입니다

					// 마커와 인포윈도우를 표시합니다
					displayMarker(locPosition, message);

				});

			} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다

				var locPosition = new kakao.maps.LatLng(33.450701, 126.570667), message = 'geolocation을 사용할수 없어요..'

				displayMarker(locPosition, message);
			}

			// 지도에 마커와 인포윈도우를 표시하는 함수입니다
			function displayMarker(locPosition, message) {

				// 마커를 생성합니다
				var marker = new kakao.maps.Marker({
					map : map,
					position : locPosition
				});

				var iwContent = message, // 인포윈도우에 표시할 내용
				iwRemoveable = true;

				// 인포윈도우를 생성합니다
				var infowindow = new kakao.maps.InfoWindow({
					content : iwContent,
					removable : iwRemoveable
				});

				// 인포윈도우를 마커위에 표시합니다 
				infowindow.open(map, marker);

				// 지도 중심좌표를 접속위치로 변경합니다
				map.setCenter(locPosition);
			}
		}
	</script>
</body>
</html>