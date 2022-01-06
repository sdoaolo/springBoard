<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardView</title>
</head>
<script  type="text/javascript">
$j(document).ready(function(){
	
	$j("#delete").on("click",function(){
		//JQUERY���� ���� �� �����ؼ� �־��ֱ� / �޷��� ���ڿ������� �� ����� �� �ִµ� �׾ȿ� 
		$j.ajax({
		    url : "/board/${board.boardType}/${board.boardNum}/boardDelete.do",
		    dataType: "json",
		    type: "GET",
		    success: function(data, textStatus, jqXHR)
		    {	
		    	if(data.success == "N"){
		    		alert("�̹� ������ �Խñ��Դϴ�.")
		    	}
				location.href = "/board/boardList.do"; 
		    },
		    error: function (jqXHR, textStatus, errorThrown)
		    {
		    	alert("����");
		    }
		});
	});
});
</script>
<body>
<table align="center">
	<tr>
		<td>
			<table border ="1">
				<tr>
					<td width="120" align="center">
					Title
					</td>
					<td width="400">
					${board.boardTitle}
					</td>
				</tr>
				<tr>
					<td height="300" align="center">
					Comment
					</td>
					<td>
					${board.boardComment}
					</td>
				</tr>
				<tr>
					<td align="center">
					Writer
					</td>
					<td>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td align="right">
			<a href="/board/boardList.do">List</a>
			<a href = "/board/${board.boardType}/${board.boardNum}/boardUpdate.do?pageNo=${pageNo}">update</a>
			<input id="delete" type="button" value="����">
		</td>
	</tr>
</table>
</body>
</html>