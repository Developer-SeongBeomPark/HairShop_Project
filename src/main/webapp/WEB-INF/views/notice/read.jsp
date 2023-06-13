<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="util" uri="/ELFunctions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link rel="stylesheet" href="/css/notice.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
    <script type="text/javascript">
    function editM(){
      var url = "/admin/notice/edit";
      url += "?noticeno=${dto.noticeno}";
      location.href=url;
    }
    function deleteM(){
      if(confirm("정말 삭제하시겠습니까?")){
    	  var url = "/admin/notice/delete";
          url += "?noticeno=${dto.noticeno}";
          location.href=url;
      }
      
    }
    
    
    function listM(){
        var url = "list";
        url += "?nowPage=${param.nowPage}";
        url += "&col=${param.col}";
        url += "&word=${param.word}";
        location.href = url;
    }
</script>
</head>
<body>
	<div class="board_wrap">
        <div class="board_title">
            <strong>공지사항</strong>
            <p>공지사항을 빠르고 정확하게 안내해드립니다.</p>
        </div>
        <div class="board_view_wrap">
            <div class="board_view">
                <div class="title">${dto.ntitle}</div>
                <div class="info">
                    <dl>
                        <dt>번호</dt>
                        <dd>${dto.noticeno}</dd>
                    </dl>
                    <dl>
                        <dt>글쓴이</dt>
                        <dd>${dto.uid}</dd>
                    </dl>
                    <dl>
                        <dt>작성일</dt>
                        <dd>${dto.ndate}</dd>
                    </dl>
                    <dl>
                        <dt>조회</dt>
                        <dd>${dto.viewcnt}</dd>
                    </dl>
                </div>
                <div class="cont">${dto.ncontent}</div>
            </div>
            <div class="bt_wrap">
                <a href="list" class="on">목록</a>
                <c:if test="${sessionScope.grade=='A'}">
                <a href="javascript:editM()">수정</a>
                <a href="javascript:deleteM()">삭제</a>
                </c:if>
            </div>
        </div>
    </div>
</body>
</html>