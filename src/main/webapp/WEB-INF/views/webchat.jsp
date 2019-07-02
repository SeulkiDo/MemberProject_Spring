<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
 <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
 
<title>Web Chat</title>
<!-- Client -->
<style>
	div{
/* 		border:1px solid black; */
		box-sizing: border-box;
	}
	.container{
		width:400px;
		height:500px;
		margin: 0 auto;
	}
	.contents{
		width:100%;
		height:90%;
		overflow-y: auto;
		border-top-left-radius: 5px;
		border-top-right-radius: 5px;
		background-color:#e7dcfc;
	
	}
	.control{
		width:100%;
		height:10%;
	}
	.control>input[type=text]{
		height:100%;
		width:78%;
		box-sizing: border-box;
		background-color:#f8f0fc;
	}
	.control>input[type=button]{
		height:100%;
		width:20%;
		box-sizing: border-box;
		background-color:#e7dcfc;
	}
	
	
	.me{
		border: none;
		text-align: right;
	}
	.someone{
		border:none;
		
	}
</style>

</head>
<body>
	
	<div class="container">
		<div class="contents">
		
		</div>
		<div class="control">
			<input type="text" id="input">
			<input type="button" id="send" value="send">
		</div>
	</div>
	
	<script>
		var socket = new WebSocket("ws://localhost/chat"); 
		socket.onmessage = function(event){
		/*2-1. 서버로부터 메시지가 도착한 경우 : contents에 받은 메세지 넣기*/
		$(".contents").append(event.data);
		$(".contents").scrollTop($(".contents")[0].scrollHeight);
		}
		/*2-2. 서버로 메세지를 보내는 경우*/
// 		$("#send").on("click",function(){
// 			var msg = $("#input").val();
// 			$("#input").val("");
// 			socket.send(msg);
// 		})
	
		$("#input").keydown(function(event){
			if(event.keyCode == 13){
				var msg = $("#input").val();
	 			$("#input").val("");
	 			socket.send(msg);
			}
		})
		
		
	
		
	</script>
</body>
</html>