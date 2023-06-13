
function replaceAll(str, searchStr, replaceStr) { // replaceAll 함수 
	return str.split(searchStr).join(replaceStr); // split으로 나눠서 배열로 만들고 join으로 하나의 문자열로 만듦
}

let reviewUL = $(".chat");//클래스가 chat인거 ->ul
let reviewPageFooter = $(".panel-footer");//클래스가 panel-footer인거 
let modal = $(".modal");

// 객체 가져오기
//let rtitle=$("#rtitle").val();
let modalInputRcontent = modal.find("textarea[name='rcontent']");
let modalInputRtitle = modal.find("input[name='rtitle']");
let modalInputUid = modal.find("input[name='uid']");
let modalInputDid = modal.find("input[name='did']");
let modalInputStar = modal.find("select[name='star']");
let modalInputRfilename = modal.find("img[name='rfilename']");  //모달 이미지 보여지는 부분


let addFile = modal.find("input[name='addfile']");  // 모달 파일선택 버튼
let labelImg = $(".modal-img");   // 모달 '이미지'글자 부분
let labelDid = $("#lableDid");   // 모달 '이미지'글자 부분


let modalModBtn = $("#modalModBtn");
let modalRemoveBtn = $("#modalRemoveBtn");
let modalRegisterBtn = $("#modalRegisterBtn");

//리뷰 삭제
modalRemoveBtn.on("click", function(e) {

	let rno = modal.data("rno");
	let oldfile = modalInputRfilename.val();
	remove(rno,oldfile)
		.then(result => {
			
			modal.modal("hide");
			window.location.reload();
		});
});//remove


// 리뷰 수정
modalModBtn.on("click", function(e) {
	
	if (modalInputRtitle.val() == '') {
		alert("제목을 입력하세요");
		return;
	}
	if (modalInputRcontent.val() == '') {
		alert("내용을 입력하세요")
		return;
	}

	const formData = new FormData();
	const rfilename = document.querySelector('input[type="file"]');
	let rno = modal.data("rno");
	
	formData.append('rno', rno);
	formData.append('uid', modalInputUid.val());
	formData.append('did', modalInputDid.val());
	formData.append('rtitle', modalInputRtitle.val());
	formData.append('rcontent', modalInputRcontent.val());
	formData.append('star', modalInputStar.val());
	formData.append('oldfile', modalInputRfilename.val());
	
	if(rfilename.files[0] != undefined) {   // 파일이 undefined가 아닐경우에만 데이터 보내줌
		formData.append('addfile', rfilename.files[0]);

	}
	
	update(formData)
		.then(result => {
			
			modal.modal("hide");
			setTimeout(function(){
				location.reload();
			},2000);
         	//window.location.reload();

		});

});//modify


// 등록 버튼을 눌렀을 때
$("#reviewCreate").on("click", function(e) {
	
	//이미지 네모 구역은 안보이게
	modalInputRfilename.hide();  
	
	modalInputUid.val(uid);
	modalInputDid.val(did);
	modalInputRtitle.val("");
	modalInputRcontent.val("");
	modal.find("button[id !='modalCloseBtn']").hide();
	modalInputDid.hide();// 디자이너부분 숨기기
	labelDid.hide();

	modalRegisterBtn.show();

	$(".modal").modal("show");

});

// 리뷰 등록 Register 버튼 클릭시
modalRegisterBtn.on("click", function(e) { 
	//alert(modalInputStar.val());
	
	if (modalInputRtitle.val() == '') {
		alert("제목을 입력하세요");
		return;
	}
	if (modalInputRcontent.val() == '') {
		alert("내용을 입력하세요");
		return;
	}

	const formData = new FormData();
	const rfilename = document.querySelector('input[type="file"]');

	formData.append('uid', modalInputUid.val());
	formData.append('did', modalInputDid.val());
	formData.append('rtitle', modalInputRtitle.val());
	formData.append('rcontent', modalInputRcontent.val());
	formData.append('star', modalInputStar.val());
	if(rfilename.files[0] != undefined) {
		formData.append('addfile', rfilename.files[0]);

	}
	
	
	add(formData)
		.then(result => {
			
			//alert(rfilename.files[0]);
			
			modal.modal("hide");
		    setTimeout(function(){
				location.reload('/review/list');
			},2000);
			//window.location.reload();

		}); //end add

}); //end modalRegisterBtn.on


//리뷰 조회
$(".chat").on("click", function (e) {
	
 modal.modal({backdrop: 'static', keyboard: false})    //모달 외부 클릭 방지
  
  let rno = $(this).data("rno");
  //alert(rno);
  
  get(rno)  //조회
    .then(review => { 
			//alert(modalInputUid.val(review.uid));
			//alert(modalInputDid.val(review.did));
			
			$("#rtitle").val(review.rtitle);
			modalInputRcontent.val(review.rcontent);
			modalInputUid.val(review.uid);
			modalInputDid.val(review.did);
			modalInputStar.val(review.star);
			modalInputRfilename.attr('src',`/hairReview/storage/${review.rfilename}`);
			modalInputRfilename.val(review.rfilename);
			modal.data("rno", review.rno);
			modal.find("button[id !='modalCloseBtn']").hide();
			modalInputDid.hide();  // 디자이너부분 숨기기
			labelDid.hide();
			
			if (review.rfilename == "no.jpg" && uid == review.uid ) {   // 올린 이미지 없이 조회할때 이미지구역 숨기기
				
				modalInputRfilename.hide();
			}
			
			if (review.rfilename == "no.jpg"  && uid != review.uid) {   // 올린 이미지 없이 조회할때 이미지구역 숨기기
				
				modalInputRfilename.hide();
		 		addFile.hide();  // 모달 파일선택 버튼
				labelImg.hide();
			}
			
			if (uid == review.uid) {    // 리뷰쓴 id랑 세션아이디랑 같을때만 수정, 삭제버튼 보이게
				
				modalModBtn.show();
				modalRemoveBtn.show();
			}
			
			if (uid != review.uid) {    // 리뷰쓴 id랑 세션아이디랑 다를때 
				
				addFile.hide();
				$("#rtitle").attr('disabled',true);
				modalInputRcontent.attr('disabled', true);
				modalInputStar.attr('disabled', true);
			}
			
			//modalModBtn.show();
			//modalRemoveBtn.show();
 			$(".modal").modal("show");
 			
 		});
    })

//close버튼 눌렀을 때
$("#modalCloseBtn").on("click", function (e) {
   modal.modal('hide'); //모달숨기기
   window.location.reload();
});