<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글읽기</title>
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
               border: 1px solid black;
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
            
            #commentWrapper{
                width: 700px;
                height: 400px;
                margin: 100px auto;
            }
            #nameOfCommentBox{
                height: 10%;
            }
            #commentTop{
                width: 100%;
                height: 65%;
            }
            .oneOfComments{
                height: 20%;
                width: 100%;
                margin-left: 3px;
            }
            .pageNavi{
                height: 5%;
            }
            #commentBottom{
                width: 100%;
                height: 20%;
                margin-left: 3px;
            }
            #inputComment{
                width:100%;
                height: 100%;
                overflow-y: scroll;
            }
            #commentBtn{
                width: 100%;        
            }
        </style>
        <script>
        $(function(){
                
                $("#goBackBtn").on("click",function(){
                    $(location).attr("href","board?currentPage=1");
                })
                
                 $("#deleteBtn").on("click",function(){
                    $(location).attr("href","delete_MembersOnly?seq=${selectedArticle.seq}");
                })
                
                $("#editBtn").on("click",function(){
                	$(location).attr("href","editForm_MembersOnly?seq=${selectedArticle.seq}");
                })
               
                $("#commentBtn").on("click",function(){
                 	var c_seq = ${selectedArticle.seq};
                	
                 	var c_comments = $("#inputComment").val();
                	
                	$.ajax({
                		url:"insertComments",
                		type: "post",
                		dataType: "json",
                		contentType: "application/x-www-form-urlencoded; charset=UTF-8",  
                		data: {
                			seq:c_seq,
                			writer: "${loginId}",
                			comments:c_comments
                			}
                	
                	}).done(function(resp){
                		
                		console.log("resp.comments : " + resp.comments);
                		$(".oneOfComments").append("<div class='col-8 commentTitle'>"+resp.comments+"</div><div class='col-2 commentWriter'>"+resp.writer+"</div><div class='col-2 commentDate'></div>");
                	})
                })
                 
        })
        
 
        
         
        </script>
    </head>
    <body>
        <div class="container">
        <form action="write_MembersOnly" method="post" name="writeForm" id="writeForm" enctype="multipart/form-data">
            <div class="row" id="header">
             	<div class="col-2 headerTitle">
                     ${selectedArticle.seq}
               </div>
               <div class="col-10 headerTitle">
                     ${selectedArticle.title}
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
           
            <div class="row" id="contentsWrapper">
                <div class="col-12" id=contentsCol>
               <div id="inputContents">${selectedArticle.contents}</div>
                </div>
            </div>
            <div class="row" id="footer">
                <div class="col-12 btnsArea">
                <div class=leftBtns>
                    <button type="button" class="btn btns" id="goBackBtn">GoBack</button> 
                </div>   
	                <c:if test="${loginId==selectedArticle.writer }">                 
		                <div class="rightBtns">
		                	<button type="button" class="btn btns" id="deleteBtn">Delete</button>
		                    <button type="button" class="btn btns" id="editBtn">Edit</button>
		                </div>    
	                </c:if>
                </div>
            </div>
        </form>
    </div>
    
    
    
    <div id=commentWrapper>
        <div id="nameOfCommentBox"><p>댓글</p></div>
        <form>
            <div id=commentTop>
             	<div class="row oneOfComments" index="index">  
					<c:forEach var="commentsList" items="${commentsList}">
		                    <div class="col-8 commentTitle">${commentsList.comment}</div>
		                    <div class="col-2 commentWriter">${commentsList.writer}</div>
		                    <div class="col-2 commentDate">${commentsList.writeDate}</div>
					</c:forEach>
				  </div>
<!--            <div class="row oneOfComments">  
                    <div class="col-8 commentTitle"></div>
                    <div class="col-2 commentWriter"></div>
                    <div class="col-2 commentDate"></div>
                </div>
                <div class="row oneOfComments">  
                    <div class="col-8 commentTitle"></div>
                    <div class="col-2 commentWriter"></div>
                    <div class="col-2 commentDate"></div>
                </div>
                <div class="row oneOfComments">  
                    <div class="col-8 commentTitle"></div>
                    <div class="col-2 commentWriter"></div>
                    <div class="col-2 commentDate"></div>
                </div>
                <div class="row oneOfComments">  
                    <div class="col-8 commentTitle"></div>
                    <div class="col-2 commentWriter"></div>
                    <div class="col-2 commentDate"></div>
                </div>
                
-->
            </div>
            <div class="row pageNavi">
                페이지네비                
            </div>
            <div class="row" id="commentBottom">
                <div class="col-10">
                     <input type="text" id="inputComment" name="comment">
                </div>
                <div class="col-2">
                     <input type="button" class="btn btns" id="commentBtn" value="댓글등록">
                </div>
            </div>
        </form>
    </div>
    
</body>
</html>