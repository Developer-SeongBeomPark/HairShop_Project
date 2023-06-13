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
     function read(noticeno){ //	페이징/검색을 유지하는 read
       var url = "read";
       url += "?noticeno="+noticeno;
       url += "&col=${col}";
       url += "&word=${word}";
       url += "&nowPage=${nowPage}";
       location.href=url;
     }  
  </script>
</head>
<body>
	<div class="board_wrap">
        <div class="board_title">
            <strong>공지사항</strong>
            <p>공지사항을 빠르고 정확하게 안내해드립니다.</p>
        </div>
        <form class="form-inline" action="./list">
    <div class="form-group">
      <select class="form-control" name="col">
        <option value="uid"
        <c:if test= "${col=='uid'}"> selected </c:if>
        >아이디</option>
        <option value="ntitle"
        <c:if test= "${col=='ntitle'}"> selected </c:if>
        >제목</option>
        <option value="ncontent"
        <c:if test= "${col=='ncontent'}"> selected </c:if>
        >내용</option>
        <option value="title_content"
        <c:if test= "${col=='title_content'}"> selected</c:if>
        >제목+내용</option>
        <option value="total"
        <c:if test= "${col=='total'}"> selected </c:if>
        >전체출력</option>       
     </select>
     </div>
    <div class="form-group">
      <input type="text" class="form-control" placeholder="Enter 검색어" 
      name="word" value="${word}">
    </div>
    <button type="submit" class="btn btn-default" >검색</button>
    <c:if test="${sessionScope.grade=='A'}">
    <button type="button" class="btn btn-default" onclick="location.href='${root}/admin/notice/write'">등록</button>
  	</c:if>
  </form>
  <br>
        <div class="board_list_wrap">
            <div class="board_list">
                <div class="top">
                    <div class="num">번호</div>
                    <div class="title">제목</div>
                    <div class="writer">글쓴이</div>
                    <div class="date">작성일</div>
                    <div class="count">조회</div>
                </div>
                
 				<c:choose>
 					<c:when test="${empty list}">
   						<tr><td colspan="6">등록된 글이 없습니다.</td>
					</c:when>
                
                <c:otherwise>
                	<c:forEach var="dto" items="${list}">
                	<div>
                		<div class="num">${dto.noticeno}</div>
                		<div class="title"><a href="javascript:read('${dto.noticeno}')">${dto.ntitle}</a></div>
                		<div class="writer">${dto.uid}</div>
                		<div class="date">${dto.ndate}</div>
                		<div class="count">${dto.viewcnt}</div>
                	</div>
                	</c:forEach>
                </c:otherwise>
                </c:choose>
                	
                	
               
            </div>
            <div >
                ${paging}
            </div>
            <div class="bt_wrap">
            </div>
        </div>
    </div>
</body>
</html>