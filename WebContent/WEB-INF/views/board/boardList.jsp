<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>list</title>
</head>
<script type="text/javascript">

	$j(document).ready(function(){
		$j("input:checkbox[name=alltype]").change(function(){
   			if($j("input:checkbox[name=alltype]").is(":checked")){
   				$j("input:checkbox[name='type']").prop("checked", true);
    		}else{
    			$j("input:checkbox[name='type']").prop("checked", false);
    		}
		});
		
		$j("input:checkbox[name='type']").click(function(){ 
			if($j("input:checkbox[name='type']:checked").length==4){ 
			    $j("input:checkbox[name=alltype]").prop("checked",true);
			}else{ 
			    $j("input:checkbox[name=alltype]").prop("checked",false); 
			} 
		});

		
		$j("#typeSearch").on("click",function(){
			
			var $frm = $j('#menuName :input[name="type"]');
			var param = $frm.serialize();
			
			//� �����Ͱ� ������ Ȯ���غ���.	
			console.log(param); //string
			//var urlText = "/board/boardList.do?"+ param;
			
			console.log()
			
			$j.ajax({
			    url : "/board/boardListAction.do",
			    dataType: "json",
			    type: "POST",
			    data : param,
			    success: function(data, textStatus, jqXHR)
			    {
			    	//data�� ����Ʈ�� �־ ���⿡�� ó���ؾ��Ѵ�. 
			    	console.log("data", data);
			    	//console.log("data[0]" data[0])
			    	
					alert("listttest")
					alert("�޼���:"+data.success);
			    			    	
					
					location.href = "/board/boardList.do?"+param;
			    },
			    error:function(request,status,error){
			        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			    }

			});
		
		});
		
	});

</script>
<body>
<table  align="center">
	<tr>
		<td align="right">
			total : ${totalCnt}
		</td>
	</tr>
	<tr>
		<td>
			<table id="boardTable" border = "1">
				<tr>
					<td width="80" align="center">
						Type
					</td>
					<td width="40" align="center">
						No
					</td>
					<td width="300" align="center">
						Title
					</td>
				</tr>
				
				<c:forEach items="${boardList}" var="list">
					<tr>
						<td align="center" id="boardType">
							${list.boardTypeName}
						</td>
						<td>
							${list.boardNum}
						</td>
						<td>
							<a href = "/board/${list.boardType}/${list.boardNum}/boardView.do?pageNo=${pageNo}">${list.boardTitle}</a>
						</td>
					</tr>	
				</c:forEach>
			</table>
		</td>
	</tr>
	<tr>
		<td align="right">
			<a href ="/board/boardWrite.do">�۾���</a>
		</td>
	</tr>	
	<tr>
      <td align="left" id="menuName"> 
      	<input type="checkbox" name="alltype" value="��ü"> ��ü
          <form>
          <c:forEach items="${menuList}" var="menuList" >
          	<input type="checkbox" name="type" value=${menuList.menuId}>   ${menuList.menuName}
          </c:forEach> 
          <input type="Button" id="typeSearch" value="��ȸ">
          </form>
      </td>
   </tr>
</table>	
</body>
</html>