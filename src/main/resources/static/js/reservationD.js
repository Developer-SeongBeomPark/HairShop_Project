// 바로실행
$(function() {
	updateProgress();
});
$("#sub_mit").click(function(){
	formSubmit();
})

function formSubmit(){
	let category = $("#category option:selected").val();
	let gender = $("#gender").val();
	let menuprice = $("#price option:selected").val();
	let time = $("#time").val();
	let date = $("#startDate").val();
	let splitJoin = menuprice.split(' ').join('');
	let twoData = splitJoin.split(':');
	let menu = twoData[0];
	let price = twoData[1];
	
	
	//form 을 생성해서 submit
	let form = document.createElement("form");
	form.setAttribute("method","post");
	form.setAttribute("action","/designerMypage");
	document.charset ="utf-8";
	
	
	let values = [category,gender,menu,price,time,date];
	let names = ["category","gender","menu","price","time","date"];
	console.log(values[0]);
	for(let i = 0 ; i < values.length; i++){
		let input = document.createElement("input");
		input.setAttribute('type','hidden');
		input.setAttribute('name',names[i]);
		input.setAttribute('value',values[i]);
		form.appendChild(input);
	}
	
    document.body.appendChild(form);
	form.submit();
	form.remove();
	
}

function CategoryGender(gender, category) {
	return fetch(`/datareq/${gender}/${category}`)
		.then((res) => res.json()).catch((error) => console.log(error));
}
let selectTag = $('#price');
$("#gender").change(function() {
	updateProgress();
	let gender = $("#gender").val();
	let category = $("#category option:selected").val();
	
	CategoryGender(gender, category).then(list => {
		let str = "";
		selectTag.html(str);
		str += "<option>시술 선택</option>";

		if(list.length == 0){
			selectTag.html(str);
		}
		else{
			for (let i = 0; i < list.length; i++) {
				str += "<option>" + list[i].menu + " : " + list[i].price + "</option>";
				selectTag.html(str);
				console.log(str);
			}
		}
	});
});


//날짜
$("#startDate").datepicker({
	minDate: new Date(),
	showOn: "both",
	buttonImage:
		"/svg/calendar.svg",
	buttonImageOnly: true,
	buttonText: "Click Here",
	dateFormat: "yy-mm-dd",
	changeMonth: true,
	changeYear: true,
	nextText: "다음 달",
	prevText: "이전 달",
	showAnim: "drop",
	showButtonPanel: true,
	currentText: "오늘 날짜",
	closeText: "닫기",
	autoSize: true,
	dayNames: [
		"월요일",
		"화요일",
		"수요일",
		"목요일",
		"금요일",
		"토요일",
		"일요일",
	],
	dayNamesMin: ["일", "월", "화", "수", "목", "금", "토"],
	monthNamesShort: [
		"1월",
		"2월",
		"3월",
		"4월",
		"5월",
		"6월",
		"7월",
		"8월",
		"9월",
		"10월",
		"11월",
		"12월",
	],
});

//체크박스 radio
$("input[type='radio']").checkboxradio();


$("#sub_mit").button({
	disabled: true,
});
//progress var 진행율
$("#progress").progressbar({
	value: 0,
});
// 시술선택을 변경하면 성별과 가격이 다시 초기값으로 세팅 된다
$("#category").change(function() {
	updateProgress();
	$('#gender option:eq(0)').prop("selected",true);
	$('#price option:eq(0)').prop("selected",true);
	
});
$("input").change(function() {
	updateProgress();
});
$("select").change(function() {
	updateProgress();
});

function updateProgress() {
	let $progress = 0,
		$itemCount = 5,
		$itemCompleted = 0;

	let $category = $("#category option:selected").val();
	let $gender = $("#gender option:selected").val();
	let $price = $("#price option:selected").val();
	let $time = $("input[type='time']").val();
	let $date = $("#startDate").val();
	//let $referrer = $('input[type="radio"]:checked').val();

	if ($gender != "성별 선택") $itemCompleted++;
	if ($category != "카테고리 선택") $itemCompleted++;
	if ($time) $itemCompleted++;
	if ($date) $itemCompleted++;
	if ($price != "시술 선택") $itemCompleted++;
	$progress = ($itemCompleted / $itemCount) * 100;
	$("#progress").progressbar("option", "value", $progress);
	$("#progress").progressbar("option", "color", "green");
	$(".pct span").text($progress);
	if ($progress == 100) {
		$("#sub_mit").button({
			disabled: false,
		});
	}
}

function go_back(){
	let url = "/dmypage";
	location.href = url;
}
