<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<title>MyPage</title>
<style>
   #wrapper {
      margin: 0px auto;
      width: 300px;
   }
   
   table {
      width: 500px;
   }
   
   #profile,#image{
      text-align: center;
   }
   
   
   tr>td:first-child {
      text-align: right;
   }
   
   #profileImage{
      width: 300px;
      height:300px;
   }
   
   
   
   #idCheckMsg {
      font-size: 9px;
   }
   
   #postcode, #addr1 {
      background-color: lightgray;
   }
</style>
<script>
   $(function(){
      $("#goMainBtn").on("click",function(){
         $(location).attr("href","/");
      })
//       $("#updateImage").on("click",function(){
//          window.open("updateImagePopUp","","width=400,height=400");
//       })
      
      $("#image").on("change",function(){
    	  var formData = new FormData();
    	  formData.append("formData",$(this)[0].files[0]);
    	  $.ajax({
    		  url:"updateImage",
    		  type:"post",
    		  processData:false,
    		  contentType:false,
    		  data: formData
    	  }).done(function(resp){
    		  //console.log(resp);
    		  //console.log(image);
    		  var time = new Date().getTime();
              console.log("time : " + time);
    		  $("#profile").html("<img src='/image/"+resp+"?time="+time+"'>");
//               $("#profile").html("<img src='/image/"+resp + "'>");
    	  })
      })

      
   })
</script>
</head>
<body>
<div id="wrapper">
      <form action="updateMyInfo" method="post" id=myPageForm name=myPageForm enctype="multipart/form-data">
         <table border=1>
            <tr>
               <th colspan=2>마이페이지</th>
            </tr>
            <tr>
               <td colspan=2><div id=profile><img src="/image/${myInfo.profileImage }"></div>
               <input type="file" accept="image/jpg, image/jpeg, image/gif, image/png" id=image name=image value="${myInfo.profileImage }">
                              
            </tr>
            <tr>
               <td><label>아이디 :</label>
               <td>${myInfo.id }
               <span id=idDuplCheck></span>
            </tr>
            <tr>
               <td>비밀번호 :
               <td><input type=password name=pw id=pw required>
            </tr>
            <tr>
               <td>비밀번호 확인 :
               <td><input type=password name=pwCheck id=pwCheck required>
                  <span id=pwCheckMsg></span>
            </tr>
            <tr>
               <td>이름 :
               <td>${myInfo.name }
            </tr>
            <tr>
               <td>전화번호 :
               <td><input type=text name=phone value="${myInfo.phone }">
            </tr>
            <tr>
               <td>이메일 :
               <td><input type=text name=email value="${myInfo.email }">
            </tr>
            <tr>
               <td>우편번호 :
               <td><input type=text name=postcode id=postcode value="${myInfo.zipcode }" readonly>
                  <input type=button id=search value="찾기">
            </tr>
            <tr>
               <td>주소1 :
               <td><input type=text name=address1 id=addr1 value="${myInfo.address1 }" readonly>
            </tr>
            <tr>
               <td>주소2 :
               <td><input type=text name=address2 id=addr2 value="${myInfo.address2 }">
            </tr>
            <tr>
               <td colspan=2><input type=submit id="submitBtn" value="수정하기">
               <input type=reset name=reset id=reset value="다시입력">
            </tr>
         </table>
      </form>
      <input type=button id=goMainBtn value="메인으로">
   </div>
</body>
</html>