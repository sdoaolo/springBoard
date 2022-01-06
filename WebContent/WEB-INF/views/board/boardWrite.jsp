<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardWrite</title>
</head>
<script type="text/javascript">
	$j(document).ready(function(){
		
		
		$j("#submit").on("click",function(){
			
			var $frm = $j('.boardWrite :input');
			var param = $frm.serialize();
			
			console.log("param",param);
			var splitParam = param.split('&');
			//console.log("len : " + splitParam.length);
			
			for(var i = 0 ; i< splitParam.length;i++){
				if(splitParam[i] == "boardTitle=" || splitParam[i] == "boardComment=" ){
					alert("��ĭ ���� �Է����ּ���");
					return false;
				}
			}
			
			$j.ajax({
			    url : "/board/boardWriteAction.do",
			    dataType: "json",
			    type: "POST",
			    data : param,
			    success: function(data, textStatus, jqXHR)
			    {
					alert("�ۼ��Ϸ�");
					
					alert("�޼���:"+data.success);
					
					location.href = "/board/boardList.do?";
			    },
			    error: function (jqXHR, textStatus, errorThrown)
			    {
			    	alert("����");
			    }
			});
		});
		
		var addText = '<tr>'+
			'<td width="120" align="center">'+
			'Title'+
			'<input type="checkbox" name="checkList">'+
			'</td>'+
			'<td width="400">'+
			'<input name="boardTitle" type="text" size="50" value="${board.boardTitle}">'+ 
			'</td>'+
		'</tr>'	+
		'<tr name="trComment">'+
			'<td height="300" align="center">'+
			'Comment'+
			'</td>'+
			'<td valign="top">'+
			'<textarea name="boardComment"  rows="20" cols="55" value="${board.boardComment}"/>'+
			'</td>'+
		'</tr>';
	
		$j("#addRow").on("click",function(){
			var trHtml = $j("tr[name=trComment]:last");
			trHtml.after(addText);
		});
		
		
		$j("#deleteRow").on("click",function(){
			
			//�ϳ��� üũ ���ϰ� ���� ��ư ������ �� �˸��� �ָ� ������!!
			var checkedNum = $j("input:checkbox[name=checkList]:checked").length
			
			if(checkedNum == 0 ) {
				alert("������ ���� üũ�ϼ���");
				return;
			}
			
			$j("input:checkbox[name=checkList]:checked").each(function(i,val){
				console.log("val = ", val.parentElement.parentElement);
				console.log("val = ", val.parentElement.parentElement.nextElementSibling);
				var titleTag = val.parentElement.parentElement;
				var commentTag =val.parentElement.parentElement.nextElementSibling;
				$j(titleTag).remove();
				$j(commentTag).remove();
			});
			
			console.log("checkNum : ",checkedNum);
			
			
		});
		
	});
</script>
<body>
<form class="boardWrite">
	<table align="center">
		<tr>
			<td align="right">
				<input id="addRow" type="button" value="���߰�">
				<input id="deleteRow" type="button" value="�����">
				<input id="submit" type="button" value="�ۼ�">
			</td>
		</tr>
		<tr>
			<td>
				<table id="boardTbl"' border ="1"> 
					<set>
					<tr>
						<td width="120" align="center">
						Title
						</td>
						<td width="400">
						<input name="boardTitle" type="text" size="50" value="${board.boardTitle}"> 
						</td>
					</tr>
					<tr name="trComment">
						<td height="300" align="center">
						Comment
						</td>
						<td valign="top">
						<textarea name="boardComment"  rows="20" cols="55">${board.boardComment}</textarea>
						</td>
					</tr>
					</set>
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
			</td>
		</tr>
	</table>
</form>	
</body>
</html>