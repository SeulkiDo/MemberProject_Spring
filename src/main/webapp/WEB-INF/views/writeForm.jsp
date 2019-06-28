<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글작성</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
   <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-bs4.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-bs4.js"></script>
  
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

        <style>
            div{
               border: 1px solidc black;
                box-sizing: border-box;
               
            }
            .container{
               width:700px;
               margin-top:50px;
            }
            #header{
                background-color: #edda9e;
                height:70px;
                padding-top: 20px;
            }
            .headerTitle{
               text-align: center;
            }
            #titleBox *{
                background-color: #baccd1;
                border: none;
            }
            .title{
               width: 300px;
               height:50px;
               margin-left: 50px;
            }
            #imageArea btn{
            text-align: right;
            }
            
            #contentsWrapper,#contentsCol{
              background-color: #f2f1ed;
              width:700px;
              height:500px;
            }
            #contents{
               background-color: #f2f1ed;
                   overflow-y: scroll;
            }
           #inputContents{ 
                height: 500px; 
                overflow-y: scroll; 
              
             } 
           
            /**/ textarea{
               background-color: #f2f1ed;
           
            }
     
            #footer{
                 background-color: #baccd1;
            }
            .btnsArea{
                height: 50px;
             }    
            
            .btns{
                border-color: #1d3447;
                background-color:  #edda9e;
                color: #1d3447;
                font-weight: bold;
                font-family: sans-serif;
                font-size: 13px;
                 width: 70px;
                height: 80%;
                margin-top: 5px;
                
            }
            .btns:hover{
                background-color: #1d3447;
                color: #edda9e;
            }
            .leftBtns{
               float: left;
            }
            .rightBtns{
            float:right;            
            }
        </style>
        <script>
        $(function(){
//               $("#writeBtn").on("click",function(){
//                  $(location).attr("href","write");
//                   location.href="Write.board?title="+$(".title").val()+"&contents="+ $("#summernote").summernote("code");                
//                   $("#writeForm").submit();
                  
//                 })
                
                $("#imageFile").on("change",function(){
                   var formData = new FormData();
                   formData.append("formData",$(this)[0].files[0]);
                   $.ajax({
                      url: "showImage",
                      type: "post",
                      processData: false,
                      contentType: false,
                      data: formData
                   }).done(function(resp){
                      console.log(resp);
                      var time = new Date().getTime();
//                       $("#inputContents").append("<img src='/image/" + resp + "?time="+time + "'>");
                      $("#inputContents").append("<img src='/image/" + resp + "'>");
                   })
                })
                
                
                $("#goBackBtn").on("click",function(){
                    $(location).attr("href","/");
                })
//                  $("#contents").on("input",function(){
//                     console.log($(this).html());
//                     $.ajax({
//                        url:"write",
//                        type: "post",
//                        data: {contents : $(this).html()}
//                     })
//                  })
                 $("#writeBtn").on("click",function(){
                    var inputContents = $("#inputContents").html();
                    
                    $("#contents").val(inputContents);
                    $("#writeForm").submit();
                 })
                 
        })
        
 
        
         
        </script>
    </head>
    <body>
        <div class="container">
        <form action="write" method="post" id="writeForm" enctype="multipart/form-data">
            <div class="row" id="header"><div class="col-12 headerTitle"><h3>글작성</h3></div></div>
            <div class="row" id="titleBox">
                <div class="col-12">
                <input type="text" name="title" class="title" placeholder="글제목">
                </div>
            </div>
            <div class="row" id="imageArea">
                <div class="col-6">
                     <input type="file" name=imageFile accept="image/jpg, image/jpeg, image/gif, image/png" id=imageFile>
                </div>
<!--                 <div class="col-6 d-flex justify-content-right"> -->
<!--                    <button type="button" class="btn uploadBtn" id="imageUploadBtn">Upload</button> -->
<!--                 </div> -->
            </div>
            <div class="row" id="contentsWrapper">
                <div class="col-12" id=contentsCol>
<!--                     <div contenteditable="true" id="summernote" name="summernote"></div> -->
               <div contenteditable="true" id="inputContents"></div>
               <input type=hidden name=contents id="contents">
                </div>
            </div>
            <div class="row" id="footer">
                <div class="col-12 btnsArea">
                <div class=leftBtns>
                    <button type="button" class="btn btns" id="goBackBtn">GoBack</button> 
                </div>                           
                <div class="rightBtns">
                    <button type="button" class="btn btns" id="writeBtn">Write</button>
                     <button type="reset" class="btn btns" id="cancelBtn">Cancel</button>
                </div>    
                   
                    
                </div>
            </div>
        </form>
        </div>
</body>
</html>