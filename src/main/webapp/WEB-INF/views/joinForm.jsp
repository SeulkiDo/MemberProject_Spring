<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>SignUpForm</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<style>
#wrapper {
   margin: 0px auto;
   width: 300px;
}

table {
   width: 500px;
}

tr>td:first-child {
   text-align: right;
}

#profileImage{
   width: 300px;
   height:300px;
}

#profile{
	width: 300px;
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
      /*비밀번호 확인*/
      $("#pwCheck").on("click",function(){
         var pw = $("#pw").val();
         var pwCheck = $("#pwCheck").val();
         if(pw==pwCheck){
            $("#pwCheckMsg").text()="패스워드 일치";
            $("#pwCheckMsg").css("color","blue");
         }else{
            $("#pwCheckMsg").text()="패스워드 불일치";
            $("#pwCheckMsg").css("color","red");
         }
      })
            /*우편번호 검색*/
//       $("#search").on("click",function() {
//           new daum.Postcode({
//               oncomplete : function(data) {

//                  var roadAddr = data.roadAddress; // 도로명 주소 변수
//                  var extraRoadAddr = ''; // 참고 항목 변수

//                  if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
//                     extraRoadAddr += data.bname;
//                  }

//                  if (data.buildingName !== '' && data.apartment === 'Y') {
//                     extraRoadAddr += (extraRoadAddr !== '' ? ', '
//                           + data.buildingName : data.buildingName);
//                  }

//                  if (extraRoadAddr !== '') {
//                     extraRoadAddr = ' (' + extraRoadAddr + ')';
//                  }

//                  $("#postcode").val() = data.zonecode;
//                  $("#addr1").val() = roadAddr;

//               }
//            }).open();
//         })
      
      /*아이디중복확인*/
      $("#id").on("input", function(){
         $.ajax({
            url:"idDuplCheck",
            type: "post",
            data: {inputId : $("#id").val()}
         }).done(function(resp){
            if(resp=="o"){
               $("#idDuplCheck").text("사용가능");
               $("#idDuplCheck").css("color","blue");
            }else{
              $("#idDuplCheck").text("사용불가"); 
              $("#idDuplCheck").css("color","red");
            }
        }).fail(function(resp){
         });
         
      })
      
      /*실시간 이미지*/
     $("#image").on("input",function(){
        var formData = new FormData();
       // alert($(this)[0].files[0]);
        formData.append("formData",$(this)[0].files[0]);
        $.ajax({
           url:"profileImageUpload",
           type: "post",
           processData: false, 
           contentType: false,
           data: formData
           
        }).done(function(resp){
           console.log(resp);
           
           console.log(image);
          var time = new Date().getTime();
          console.log("time : " + time);
           $("#profile").html("<img src='/image/profileImages/"+resp+"?time="+time+"'>");
        });
     })
      
       /*회원가입 제출*/
//       $("#submitBtn").on("click",function() {
//           var pw = $("#pw").val();
//           var pwCheck = $("#pwCheck").val();
          
//           var joinCheck = confirm("정말 가입하시겠습니까?");
          
//           if (pw != pwCheck) {
//              alert("비밀번호가 일치하지 않습니다. 다시 입력해주세요.");
//              $("#pwCheck").value="";
//           }else if($("#name").val() == ''){
//              alert("이름을 입력해주세요.")
//           }
//           else if(joinCheck==false){
//              alert("가입이 취소되었습니다.");
//           }else{
//              $("#joinForm").submit();
//           }
//      })

      
      
   })
   
   
</script>

</head>
<body>
   <div id="wrapper">
      <form action="join" method="post" id=joinForm name=joinForm enctype="multipart/form-data">
         <table border=1>
            <tr>
               <th colspan=2>회원 가입 정보</th>
            </tr>
            <tr>
               <td colspan=2><input type="file" name=image accept="image/jpg, image/jpeg, image/gif, image/png" id=image>
               <div id=profile></div>
            </tr>
            <tr>
               <td><label>아이디 :</label>
               <td><input type=text name=id id=id>
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
               <td><input type=text name=name id=name required>
            </tr>
            <tr>
               <td>전화번호 :
               <td><input type=text name=phone>
            </tr>
            <tr>
               <td>이메일 :
               <td><input type=text name=email>
            </tr>
            <tr>
               <td>우편번호 :
               <td><input type=text name=zipcode id=postcode readonly>
                  <input type=button id=search value="찾기">
            </tr>
            <tr>
               <td>주소1 :
               <td><input type=text name=address1 id=addr1 readonly>
            </tr>
            <tr>
               <td>주소2 :
               <td><input type=text name=address2 id=addr2>
            </tr>
            <tr>
               <td colspan=2><input type=submit id="submitBtn" value="회원가입">
               <input type=reset name=reset id=reset value="다시입력">
            </tr>
         </table>
      </form>
   </div>
   
   <script>
      /*우편번호 검색*/
       document.getElementById("search").onclick = searchAddress;
       function searchAddress() {
          new daum.Postcode({
             oncomplete : function(data) {
      
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수
      
                if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                   extraRoadAddr += data.bname;
                }
      
                if (data.buildingName !== '' && data.apartment === 'Y') {
                   extraRoadAddr += (extraRoadAddr !== '' ? ', '
                         + data.buildingName : data.buildingName);
                }
      
                if (extraRoadAddr !== '') {
                   extraRoadAddr = ' (' + extraRoadAddr + ')';
                }
      
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById('addr1').value = roadAddr;
      
             }
          }).open();
      
      }
   </script>
</body>
</html>