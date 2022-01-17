<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>   
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardWrite</title>
</head>
<script type="text/javascript">
	$j(document).ready(function(){
		var index = 0;
		//select ������ ���� ���� 
		$j("select[name=boardType]").change(function(){
			  console.log($j(this).val()); //value�� ��������
			  console.log($j("select[name=boardType] option:selected").text()); //text�� ��������
		});
		
		$j("#submit").on("click",function(){
			
			var $frm = $j('.boardWrite :input');
			var param = $frm.serialize();
			
			console.log("param",param);
			var splitParam = param.split('&');
			
			console.log("len : " + splitParam.length);
			
			for(var i = 0 ; i< splitParam.length;i++){
				
				var strArray = splitParam[i].split('.');
				console.log("arr0 ",strArray[0]);
				console.log("arr1 ",strArray[1]);
				
				if(strArray[1] == "boardTitle=" || strArray[1] == "boardComment=" ){
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
		
		function addRow(i){
			var addText = '<tr>'+
			'<td width="120" align="center">'+
			'Title'+
			'<input type="checkbox" name="checkList">'+
			'</td>'+
			         '<td width="400">'+
			         '<input name="boardVoList['+i+'].boardTitle" type="text" size="50" value="${board.boardTitle}">'+ 
			         '</td>'+
			      '</tr>'   +
			      '<tr name="trComment">'+
			         '<td height="300" align="center">'+
			         'Comment'+
			         '</td>'+
			         '<td valign="top">'+
			         '<textarea name="boardVoList['+i+'].boardComment"  rows="20" cols="55" value="${board.boardComment}"/>'+
			         '</td>'+
			      '</tr>';		
			console.log("addText:" +addText);
			var trHtml = $j("tr[name=trComment]:last");
			trHtml.after(addText);
		}
		

		$j("#addRow").on("click",function(){
			index++;
			console.log("index:" +index);
			addRow(index);
		});
		
		
		$j("#deleteRow").on("click",function(){
			var checkedNum = $j("input:checkbox[name=checkList]:checked").length
			
			if(checkedNum == 0 ) { //�ϳ��� üũ ���ϰ� ���� ��ư ������ �� �˸��� �ָ� ������!!
				alert("������ ���� üũ�ϼ���");
				return;
			}
			
			$j("input:checkbox[name=checkList]:checked").each(function(i,val){
				var titleTag = val.parentElement.parentElement;
				var commentTag =val.parentElement.parentElement.nextElementSibling;
				$j(titleTag).remove();
				$j(commentTag).remove();
			});
		});
	});
</script>
<body>
<form:form commandName="boardVo" class="boardWrite" >
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
					<tr>
						<td width="120" align="center">
						Type
						</td>
						<td width="400">
							<select name="boardType">
								<c:forEach items="${menuList}" var="list">
									<option value=${list.menuId}> ${list.menuName} </option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<td width="120" align="center">
						Title
						</td>
						<td width="400">
						<input name="boardVoList[0].boardTitle" type="text" size="50" value="${board.boardTitle}"> 
						</td>
					</tr>
					<tr name="trComment">
						<td height="300" align="center">
						Comment
						</td>
						<td valign="top">
						<textarea name="boardVoList[0].boardComment"  rows="20" cols="55">${board.boardComment}</textarea>
						</td>
					</tr>
					
					<tr>
						<td align="center">
						Writer
						</td>
						<td>
						<c:choose>
							<c:when test="${login == null}">
							</c:when>
							<c:when test="${login != null}">
								<a>${login.userName}</a>
								<input name="boardVoList[0].creator" type="hidden" value=${login.userId}>
							</c:when>
						</c:choose> 
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

</form:form>
</body>
</html>