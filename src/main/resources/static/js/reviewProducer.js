console.log("*****Reply Module........");

function get(rno) {  //조회
		//alert(rno);
        return fetch(`/review/list/${rno}`,{
			method: 'get'})
               .then(response => response.json())
               .catch(console.log);
}

function add(formData) {  //추가
	return fetch('/review/create', {
		method: 'post',
		body: formData
		//enctype="multipart/formData"
	})
		.then(response => response.json())
		.catch(console.log);
}

function update(formData) {  //수정
	return fetch(`/review/`, {
		method: 'put',
		body: formData,
		//headers: { 'Content-Type': "application/json; charset=utf-8" }
	})
		.then(response => response.text())
		.catch(console.log);
}

// 삭제
// 요청 uri이 같아도 reply 방식이 다르기 때문에 괜찮다(method=delete)
function remove(rno, oldfile) {
	return fetch(`/review/${rno}/${oldfile}`, { method: 'delete' })
		.then(response => response.text())
		.catch(console.log);
}