const filearea= document.querySelector(".filearea");
const dragArea = document.querySelector(".header");
const styleButton = document.querySelector(".select-btn");
let input = document.getElementById("input-file");
const allImg = document.querySelector(".all-img");
const womanImg = document.querySelector(".woman-img");
const manImg = document.querySelector(".man-img");
let file;
// 파일이름 저장된 fileName ---------------------------
let fileName;
let promiseData;
let dto;


$(function() {
	
	

	$('#input-file').hide();
	fetchAPI(allImg, "all");
	$('.woman-img').empty();
	$('.man-img').empty();
})
//사진더보기 button 이벤트 css 변경 함수

$('.add-btn').click(function() {
	$('.img-area').css('overflow','auto');
	$('.img-area').css('overflowX','hidden');
	$(".add-btn").css("background-color","#0155b4");
	$(".img-area").animate({scrollTop:$(".img-area")[0].scrollHeight},1500);
})



//form submit check 함수
function formCheck() {
	let bool = $('input:radio[name="uploadgender"]').is(":checked");
	if (bool) {
		$('.all-img').empty(); //all-img 영역 비워주고
		fetchAPI(allImg, "all"); //list 비동기재요청
		return true;
	} else {
		return false;
	}
}

//input radio 변경될때마다 val 체크
$('input:radio[name="gender"]').change(function() {

	let gender = $('input:radio[name="gender"]:checked').val();
	if (gender == "FEMALE") {
		fetchAPI(womanImg, gender);
		$('.all-img').empty();
		$('.man-img').empty();
	} else if (gender == "MALE") {
		fetchAPI(manImg, gender);
		$('.all-img').empty();
		$('.woman-img').empty();
	} else {
		fetchAPI(allImg, gender);
		$('.woman-img').empty();
		$('.man-img').empty();
	}

})

function fetchAPI(genderTag, gender) {
	promiseData = styleGet(gender)
	promiseData.then(list => {
		for (let i = 0; i < list.length; i++) {
			let img = document.createElement("img");
			img.src = "data:" + list[i].imagetype + ";base64," + list[i].imagecode;
			img.data = list[i].imageno;
			img.value = list[i].imageno;
			img.classList = "images";
			if(did != ""){
				img.onclick = function() {
					let imageno = $(this).val();
					console.log(imageno);
					if (confirm("사진을 삭제하시겠습니까?")) {
						let text = deleteStyle(imageno);
						text.then(res => alert(res));
						location.reload(); // 새로고침
					}
				}
			}
			
			genderTag.append(img);
		}
	})

}
function styleGet(gender) {
	return fetch(`/style/list/${gender}/${style_did}`).then((res) => res.json()).catch((error) => console.log(error));
}
function deleteStyle(imgno) {
	return fetch(`/style/delete/${imgno}`).then(res => res.text()).catch(error => console.log(error));
}
//드래그영역 클릭시 숨어있는 input 클릭
filearea.onclick = () => {
	input.click();
};
//파일을 클릭해서 선택할때
input.addEventListener("change", function() {
	file = this.files[0];

	//file.name 을 데이터베이스에 저장하면되겠다.
	dragArea.classList.add('active');
	displayFile(file);
});
function displayFile(file) {
	let fileType = file.type;
	let validExtensions = ["image/jpeg", "image/jpg", "image/png"];
	if (validExtensions.includes(fileType)) {
		let fileReader = new FileReader();
		fileReader.onload = (e) => {
			//fileName 에 해당파일 이름 저장
			fileName = file.name;
			console.log(fileName);
			//fileUrl 은  img Tag 를만들고 속성 src에 값을 준다 매우긴URL 코드가나온다
			let fileURL = fileReader.result;
			let imgTag = `<img src="${fileURL}" alt="">`;
			dragArea.innerHTML = imgTag;
		};
		fileReader.readAsDataURL(file);
	} else {
		alert("이 파일은 이미지가 아닙니다.");
		dragArea.classList.remove("active");
	}
}
