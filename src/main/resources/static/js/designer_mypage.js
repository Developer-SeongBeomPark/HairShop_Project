//####################################################################
// modal

function modal(reserveno){
            
    let rnum = reserveno;
            
    get(rnum)
    .then(reserve => {
        $("#uname").val(reserve.udto.uname);
        $("#gender").val(reserve.edto.hdto.hgender);
        $("#date").val(reserve.edto.enrolldate);
        $("#time").val(reserve.edto.enrolltime);
        $("#menu").val(reserve.edto.emenu);
        $("#price").val(reserve.edto.eprice);
        $("#message").val(reserve.message);
        $(".modal").modal("show");
            
    });
        
}

function get(rnum) {
    return fetch(`/reserve/${rnum}`,{method: 'get'})
           .then(response => response.json())
           .catch(console.log);
}


//#####################################################################
// redirect



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
function deleteEnroll(enrollno){
    let url = "/designer/deleteEnroll/" + enrollno;
    location.href = url;
}
function enroll(){
    let url = "/enroll/designer";
    location.href = url;
}
function dmypage_delete(did){
	let url = "/dmypage_delete";
	url += "?did=";
	url += did;
    location.href = url;
}
//#####################################################################
// reservation configuration

// $("#configBtn").on("click",function(){
    
// })

function config(reserveno){
    return fetch(`/dmypage/rconfig/${reserveno}`,{
        method:'get'})
        .then(res =>res.text())
        .then(res => {
            if(res == "true"){
                alert("예약 확인 성공");
                return fetch(`/rconfig/${reserveno}`,{method : "get"})
                .then(res => {
                    alert("예약 확인 메일이 정상적으로 발송되었습니다.");
                    location.href = "/dmypage";
                })
                
                .catch(console.log());
                
            }
            else{
                alert("예약 확인 실패");
            }
        })
        
        .catch(console.log());
}
