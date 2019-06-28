<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글수정</title>
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
                border-top-left-radius: 5px;
               border-top-right-radius: 5px;
            }
            #header input{
            	 background-color: #edda9e;
            	 border:none;
            	 height:90%;
            	 width:90%;
            }
           
           
            #title *{
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
                     border-bottom-left-radius: 5px;
               border-bottom-right-radius: 5px;
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
                
                $("#goBackBtn").on("click",function(){
                    $(location).attr("href","/");
                })
                
                $("#imageFile").on("input",function(){
                	var formData = new FormData();
                	formData.append("formData",$(this)[0].files[0]);
                	$.ajax({
                		url:"showImage",
                		type: "post",
                		processData: false,
                		contentType: false,
                		data: formData
                	}).done(function(resp){
                		console.log(resp);
                		$("#inputContents").append("<img src='/image/" + resp + "'>");
                	})
                })
                
                
                $("#editBtn").on("click",function(){
                	var inputContents = $("#inputContents").html();
                	console.log("inputContents : " + inputContents);
                	$("#contents").val(inputContents);
                	$("#editForm").submit();
                })
                  
                 
        })
        
 
        
         
        </script>
    </head>
    <body>
        <div class="container">
        <form action="edit" method="post" name="editForm" id="editForm" enctype="multipart/form-data">
            <div class="row" id="header">
            	<input type="hidden" value="${selectedArticle.seq}" name="seq">
               <div class="col-12 headerTitle">
                     <input type=text value="${selectedArticle.title}" name="title">
               </div>
            </div>
            <div class="row" id="title">
                <div class="col-9">
                   ${selectedArticle.writer}
                </div>
                 <div class="col-2">
		              ${selectedArticle.writeDate}
                 </div>
                <div class="col-1">
                      ${selectedArticle.viewCount}
                </div>
            </div>
           
           <div class="row" id="imageArea">
                <div class="col-6">
                     <input type="file" name=imageFile accept="image/jpg, image/jpeg, image/gif, image/png" id=imageFile>
                </div>
            </div>
           
            <div class="row" id="contentsWrapper">
                <div class="col-12" id=contentsCol>
                    <div contenteditable="true" id="inputContents">
                   		${selectedArticle.contents}
                    </div>
               		<input type=hidden name=contents id="contents">
                </div>
            </div>
            <div class="row" id="footer">
                <div class="col-12 btnsArea">
                <div class=leftBtns>
                    <button type="button" class="btn btns" id="goBackBtn">GoBack</button> 
                </div>                           
                <div class="rightBtns">
                    <button type="button" class="btn btns" id="editBtn">Edit</button>
                </div>    
                </div>
            </div>
        </form>
        </div>
</body>
</html>