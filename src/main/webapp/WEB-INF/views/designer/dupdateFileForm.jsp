<%@ page contentType="text/html; charset=UTF-8" %> 
<!DOCTYPE html>
<html>
<head>
  <title>사진수정</title>
  <meta charset="utf-8">
</head>
<body>

<div class="container">

<h1 class="col-sm-offset-2 col-sm-10">사진수정</h1>
  <form class="form-horizontal" 
        action="/designer/dupdateFile"
        method="post"
        enctype="multipart/form-data"
        >   
    <input type="hidden" name="oldfile" value="${ddto.dfilename}">    
        
    <div class="form-group">
      <label class="control-label col-sm-2" for="oldfile">원본파일</label>
      <div class="col-sm-6">
        <img src="/designer/${ddto.dfilename }" 
        class="img-rounded" width="200px" height="200px">
      </div>
    </div>
    <div class="form-group">
      <label class="control-label col-sm-2" for="dfilenameMF">변경파일</label>
      <div class="col-sm-6">          
        <input type="file" class="form-control" id="dfilenameMF" 
        name="dfilenameMF" accept=".jpg,.png,.gif" required="required">
      </div>
    </div>
    <div class="form-group">        
      <div class="col-sm-offset-2 col-sm-8">
        <button type="submit" class="btn btn-default" id=modify>수정</button>
        <button type="button" class="btn btn-default" 
        onclick="history.back()">취소</button>
      </div>
    </div>
  </form>

</div>
</body>
</html>