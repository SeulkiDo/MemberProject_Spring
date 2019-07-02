<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판</title>
<link rel="stylesheet"
   href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script
   src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
   src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
   rel="stylesheet">

<style>
div {
/*      border: 1px solid black;  */
   box-sizing: border-box;
}

#wrapper{
	margin: 50px auto;
}

.top{
   text-align: center;
   color: #edda9e; 
	margin-bottom: 30px;
}

.boardName{
	   font-size: 50px
}


   /*검색*/
      #dropdownforSearch {
         float: left;
        height: 40px;
        border: solid lightgrey 1px;
        border-top-left-radius: 15px;
        border-bottom-left-radius: 15px;
        padding-left: 9px;
   }
   
   .searchWord {
       width: 300px;
        height: 40px;
        border: solid lightgrey 1px;
        border-top-right-radius: 15px;
        border-bottom-right-radius: 15px;
        padding-left: 10px;
   }
   
   .searchBtn {
      background-color: #1ebdd8;
      border-color: #1ebdd8;
      color: #FFF;
      height:40px;
        border-radius:15px;
        margin-left: 3px;
   }
   
   .searchBtn:hover {
      border-color: #28a39f;
      background-color: #28a39f;
      color: #FFF;
   }
     
   .noneListRow div{
      margin: auto;
      text-align: center;
      font-family: "Do Hyeon";
      font-size: 20px;
   }
   
   .searchBox {
    margin-bottom: 50px;
    width: 100%;
   margin-right: 190px;
   }
   .search{
      min-width: 500px;
   }





.container {
   width: 100%;
   text-align: center;
   color: #193446;

}

#header {
   width: 100%;
   height: 50px;
   background-color: #edda9e;
}






#navi {
   width: 100%;
   border-top-left-radius: 20px;
   border-top-right-radius: 20px;
}

.no{
 border-top-left-radius: 20px;
}
.viewCount{
   border-top-right-radius: 20px;
}
 #title {
    border: 1px #1d3447; 
    margin-bottom: 5px;
 } 

#title div {
   width:100%;
   height: 40px;
   line-height: 2;
   background-color: #baccd1;
   float:left;
}

.images{
   height: 140px;
   width: 140px;
   border-radius: 10px;
   margin-top: 5px;
}
.titles{
   color:#1d3447;
}
.titles:hover{
   cursor: pointer;
    font-weight: bold;
    color:#1d3447;
}

#contents{
   line-height: 9;
}
#contents div {
   width:100%;
   height: 150px;
   background-color: #f2f1ed;
}

#navi .row:nth-of-type(2n){
  background-color: #f5ebdd !important;
}

.row{
/*    border: 1px solid darkgray; */
}

#num_box {
   width: 100%;
   height: 40px;
   background-color: #baccd1;
}

#num_box a {
   margin-top: 5px;
   background-color: #f2f1ed;
   color: #1d3447;
   height: 25px;
   line-height: 13px;
   border-color: lightgray;
}
#num_box a:hover{
   font-weight: bold;
   color:#1d3447;
   background-color: #edda9e; 
}

#footer {
   width: 100%;
   height: 50px;
   background-color: #baccd1;
/*    background-color: #edda9e; */
       border-bottom-left-radius: 20px;
    border-bottom-right-radius: 20px;
}

#writeBtn {
   border-color: #1d3447;
   color: #1d3447;
   font-weight: bold;
   font-family: sans-serif;
   width: 60px;
   height: 80%;
   line-height: 1px;
   margin-top: 5px;
   padding-right: 50px;
   margin-right: 5%;
}
#goBackBtn{
   border-color: #1d3447;
   color: #1d3447;
   font-weight: bold;
   font-family: sans-serif;
   width: 60px;
   height: 80%;
   line-height: 1px;
   margin-top: 5px;
   padding-right: 67px;
    margin-right: 2%; 
}
#writeBtn:hover,#goBackBtn:hover {
   background-color: #1d3447;
   color: #edda9e;
}

#num_box>* {
   margin-top: 2px;
}

.num_box {
   background-color: #baccd1;
}
</style>
<script>
   $(function() {
      $("#writeBtn").on("click", function() {
         location.href = "writeForm_MembersOnly";
      })
      $("#goBackBtn").on("click",function(){
          $(location).attr("href","/");
      })
      $(".titles").on("click",function(){
         var seq = $(this).attr("value")
         $(location).attr("href","read?seq="+seq);
      })
      
//       $(document).on("click",".title",function(){   
//          var title = $(this).text();
//          location.href = "ReadContents.board?title="+ title + "&board_seq=" + this.name;
//       })
   
   })

</script>
</head>
<body>

   <div id="wrapper">
         <div class="top"><p class="boardName">자유게시판</p></div>
      
<!--   <form id="searchForm"> -->
<!--          <input type="hidden" name="currentPage" value="1"> -->
<%--          <c:choose> --%>
<%--             <c:when test="${classification=='ongoing' }"> --%>
<!--                <input type="hidden" name="classification" value="ongoing">    -->
<%--             </c:when> --%>
<%--             <c:otherwise> --%>
<!--                <input type="hidden" name="classification" value="closed"> -->
<%--             </c:otherwise> --%>
<%--          </c:choose> --%>
   
<!--             <div class="col-6 d-flex justify-content-end search searchBox"> -->
<!--             <select name="searchOption" id="dropdownforSearch"> -->
<!--                <option name="searchOption" class="searchOption" value="b_title">제목</option> -->
<!--                <option name="searchOption" class="searchOption" value="b_contents">내용</option> -->
<!--                <option name="searchOption" class="searchOption" -->
<!--                   value="b_title or b_contents">제목+내용</option> -->
<!--             </select> <input type="text" name="searchWord" class="searchWord" -->
<!--                placeholder="검색할 내용 입력"> -->
<!--                <input style="VISIBILITY: hidden; WIDTH: 0px"> -->
<!--             <button type="button" class="btn searchBtn">검색</button> -->
<!--             </div> -->
<!--    </form> -->

   <div class="container p-0">
   
      <div class="row d-flex justify-content-center p-0 m-0" id="navi">
         <div class="row col-12 p-0 m-0" id=title>
	          <div class="col-lg-1 col-sm-1 no">No.</div>
	          <div class="col-lg-3 col-sm-5">Image</div>
	          <div class="col-lg-4 col-sm-6 titleTitle">Title</div>
	          <div class="col-lg-1 col-sm-4">Writer</div>
	          <div class="col-lg-2 col-sm-4">Date</div>
	          <div class="col-lg-1 col-sm-4 viewCount">Views</div>
         </div>
         <div class="row col-12 p-0 m-0" id=contents>
            <c:forEach var="list" items="${boardList }">
	               <div class="col-lg-1 col-sm-1">${list.seq}</div>
	               <div class="col-lg-3 col-sm-5 imageBox"><img src="/images/boardImages/${list.writer}/${list.image}" class="images"></div>
	               <div class="col-lg-4 col-sm-6 titles" value="${list.seq}">${list.title}</div>
	               <div class="col-lg-1 col-sm-4">${list.writer}</div>
	               <div class="col-lg-2 col-sm-4">${list.writeDate}</div>
	               <div class="col-lg-1 col-sm-4">${list.viewCount}</div>
            </c:forEach>
         </div>
      </div>


      <div class="row  p-0 m-0" id="num_box">
         <div class="col-12 d-flex justify-content-center">
            <nav aria-label="Page navigation example">
               <ul class="pagination pagination-sm">
                  <li class="page-item"><a class="page-link" href="#"
                     aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
                        ${getNavi }
               </ul>
            </nav>      
         </div>
      </div>
      <div class="row p-0 m-0" id="footer">
         <div class="col-12 d-flex justify-content-end">
            <button type="button" class="btn" id="goBackBtn">GoBack</button>
            <button type="button" class="btn" id="writeBtn">Write</button>
         </div>
      </div>
   </div>
</div>

</body>
</html>