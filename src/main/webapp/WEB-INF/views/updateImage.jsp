<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<title>이미지 수정</title>
</head>
<body>
   <form action="updateImage" id="updateImageForm" method="post" enctype="multipart/form-data">
      <input type="file" name=image accept="image/jpg, image/jpeg, image/gif, image/png" id=image>
      <input type=submit id="submitBtn" value="변경하기">
   </form>
   
   <script>
//       $("#submitBtn").on("click",function(){
//          $("#updateImageForm").submit();
//          window.close();
//       })
   </script>
</body>
</html>