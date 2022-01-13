<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>login</title>
</head>
<script type="text/javascript">

	$j(document).ready(function(){
		$j("#login").on("click",function(){
			
			var inputId = $j('input[name="userId"]').val();
			var inputPw = $j('input[name="userPw"]').val();
			
			var $frm = $j('.userLogin :input');
			var param = $frm.serialize();
			
			$j.ajax({
			    url : "/board/userLoginAction.do",
			    dataType: "json",
			    type: "POST",
			    data : param,
			    success: function(data, textStatus, jqXHR)
			    {
					if(!!data.success){
						console.log("data 존재")
						console.log("data.success:" + data.success.userId);
						//console.log("data:" + data)
						alert("로그인 성공");
			
						//var url = "/board/boardList.do?userId="+data.success.userId
						location.href = "/board/boardList.do?";
					}else{
						console.log("data 없음")
						alert("아이디 또는 패스워드가 틀렸습니다.");
						
					}
			    },
			    error: function (jqXHR, textStatus, errorThrown)
			    {
			    	alert("실패");
			    }
			});
		});
	});

</script>
<body>
	<form class="userLogin" >
	<table align="center">
		<tr>
			<td align="left">
				<a href="/board/boardList.do">List</a>
			</td>
		</tr>
		
		<tr>
			<td>
				<table id="joinTbl"' border ="1"> 
					<tr>
						<td width="120" align="center">
						id
						</td>
						<td width="300">
						<input name="userId" type="text" size="20" value="${user.userId}"> 
						</td>
					</tr>
					<tr>
						<td width="120" align="center">
						pw
						</td>
						<td width="300">
						<input name="userPw" type="text" size="20" value="${user.userPw}"> 
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
		<td align="right">
			<input id="login" type="button" value="login">
		</td>
	</tr>	
	</table>

</form>
</body>
</html>