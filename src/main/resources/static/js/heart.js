let whiteHeart = $("#whiteHeart");
let redHeart = $("#redHeart");


 function update1(uid,did) {   // 좋아요 추가
	 return fetch(`/plusHeart/${uid}/${did}`, {
		 method: 'get',
		 //body: JSON.stringify(uid, did),
		 headers: { 'Content-Type': "application/json; charset=utf-8" }
	 })
		 .then(response => response.text())
		 .catch(console.log);
 }
 
 whiteHeart.on("click", function(e){   // 좋아요 추가
		 
	 update1(uid, did)
		 .then(result => {
 
		 location.reload();
		 
	 });
 
 })
 
 function update2(uid,did) {   // 좋아요 취소
	 return fetch(`/minusHeart/${uid}/${did}`, {
		 method: 'get',
		 //body: JSON.stringify(did),
		 headers: { 'Content-Type': "application/json; charset=utf-8" }
	 })
		 .then(response => response.text())
		 .catch(console.log);
 }
 
 redHeart.on("click", function(e){  // 좋아요 취소
	 
	 update2(uid, did)
		 .then(result => {
			 
		location.reload();
		 
	 });
	 
 })
