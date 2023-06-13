let checkBtn;
let tr;
let td;
let enrolldate;
let enrolltime;
let enrollno;
let menu;
let price;
let gender;
let tdArr;
$("input[id='enrollbtn']").on("click", function() {
	let uid = document.getElementById("hiddenUid").value;
	let message = document.getElementById("message").value;
	checkBtn = $(this);
	enrollno = checkBtn.val();
	enrollnoCheck(enrollno).then(res => {
		console.log(res);
		if (res == "예약불가") {
			alert("이미 예약이 찼습니다.다른예약을 선택해주세요");
			tr = checkBtn.parent().parent();
			td = tr.children();
			tr.css("color","red");
			td.text("X");
		}else{
			
			tr = checkBtn.parent().parent();
			td = tr.children();
			enrolldate = td.eq(0).text();
			enrolltime = td.eq(1).text();
			menu = td.eq(2).text();
			price = td.eq(3).text();
			gender = td.eq(4).text();
			tdArr = [enrolldate, enrolltime, menu, price, gender]; //예약확인을 confirm 창으로 보여주기위한 처리일뿐 컨트롤러에 데이터를 보내진않는다.
		}
	})
})
function enrollnoCheck(enrollno) {
	let result = fetch(`/enrollnoCheck/${enrollno}`,{method:"POST"}).then(res=>res.text()).catch(error=>{console.log(error)});
	return result;
}
$("#sub_mit").click(function() {
	if (!$('input:radio[name="radioCheck"]').is(":checked")) {
		alert("예약 체크를 해주세요.")
	} else {
		if (confirm("예약일 : " + enrolldate + "\n" + "예약시간 : "
			+ enrolltime + "\n" + "시술 :" + menu + "\n" +
			"위 예약정보를 확인하셨습니까?")) {
			alert("예약성공")
			let uid = document.getElementById("hiddenUid").value;
			let message = document.getElementById("message").value;
			// 고객예약신청 리스트를 reserve 테이블에 저장하기위해 해당 예약체크된 enrollno ,uid,message 를 form 을생성해서 POST 방식으로 전송
			let form = document.createElement("form");
			form.setAttribute("method", "post");
			form.setAttribute("action", "/reserve");
			document.charset = "utf-8";
			let values = [enrollno, message];
			console.log(enrollno);
			console.log(message);
			let names = ["enrollno", "message"];
			for (let i = 0; i < values.length; i++) {
				let input = document.createElement("input");
				input.setAttribute('type', 'hidden');
				input.setAttribute('name', names[i]);
				input.setAttribute('value', values[i]);
				form.appendChild(input);
			}
			document.body.appendChild(form);
			form.submit();
			form.remove();
		}
	}
})



function CategoryGender(gender, category) {
	return fetch(`/datareq/${gender}/${category}`)
		.then((res) => res.json()).catch((error) => console.log(error));
}