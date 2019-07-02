<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
   <title>Home</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
   
   <style>
      #profileImage{
         width: 300px;
         height:300px;
      }
      
      
   </style>
   
   <script>
      $(function(){
         $("#joinBtn").on("click",function(){
            $(location).attr("href","joinForm");            
         })
         $("#logoutBtn").on("click",function(){
            $(location).attr("href","logout");
         })
         $("#myPageBtn").on("click",function(){
            $(location).attr("href","myInfo");
         })
         $("#boardBtn").on("click",function(){
            $(location).attr("href","board?currentPage=1");
         })
         $("#toChatBtn").on("click",function(){
            $(location).attr("href","webchat");            
         })
      })
   </script>
</head>
<body>

   <c:choose>
      <c:when test="${loginResult>0}">
         ${loginId} 님 환영합니다.  <br>
         <div id="profileImage">
            프로필사진
            <img src="/images/profileImages/${loginId }/${profileImage }" name="image" width="300px">
         </div>   
         <input type="button" value="toChat" id="toChatBtn">
         <input type="button" value="board" id="boardBtn">
         <input type="button" value="myPage" id="myPageBtn">
         <input type="button" value="Logout" id="logoutBtn">
              
      </c:when>   
      <c:otherwise>
      <form action="login" method="post">
           <input type=text name=id placeholder="ID"><br>
           <input type="password" name="pw" placeholder="PASSWORD"> <br>
           <input type=submit value="Login" id="LoginBtn">
           <input type=button value="Join" id="joinBtn">
       </form>
       <span name=msg></span>
       </c:otherwise>
    </c:choose>
</body>
</html>