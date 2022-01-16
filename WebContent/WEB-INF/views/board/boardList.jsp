<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<%
	//인코딩
	 request.setCharacterEncoding("EUC-KR");
%>
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
			

			console.log(param); //string
			
			$j.ajax({
			    url : "/board/boardListAction.do",
			    dataType: "html",	
			    type: "POST",
			    data : param,
			    success: function(data)
			    {
			    	$j("#boardTable").empty();
			    	$j("#boardTable").html(data); 
			    },
			    error:function(request,status,error){
			        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			    }
			});
		});
		
		$j("#Logout").on("click",function(){
			//sessiion 없어지게 해야하는데 데이터가 움직일 필요는 없으니 view delete랑 비슷하게 해줌 됨.
			$j.ajax({
			    url : "/user/userLogout.do",
			    dataType: "json",
			    type: "GET",
			    success: function(data, textStatus, jqXHR)
			    {	
			    	if(data.success == "Y"){
			    		alert("로그아웃 되었습니다.")
			    	}
					location.href = "/board/boardList.do"; 
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
<table  align="center">
	<tr>
			<td align="left">
				<c:choose>
					<c:when test="${login == null}">
						<a href="../user/userLogin.do">login</a>
						<a href="../user/userJoin.do">join</a>
					</c:when>
					<c:when test="${login != null}">
						<a>${login.userName}</a>
					</c:when>
				</c:choose></td>
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
			<c:choose>
					<c:when test="${login == null}">
					</c:when>
					<c:when test="${login != null}">
						<a href ="/board/boardWrite.do">글쓰기</a>
						<input type="button" id="Logout" value="Logout" >
					</c:when>
			</c:choose>
		</td>
	</tr>	
	<tr>
      <td align="left" id="menuName"> 
      	<input type="checkbox" name="alltype" value="전체"> 전체
          <form>
          <c:forEach items="${menuList}" var="menuList" >
          	<input type="checkbox" name="type" value=${menuList.menuId}>   ${menuList.menuName}
          </c:forEach> 
          <input type="Button" id="typeSearch" value="조회">
          </form>
      </td>
   </tr>
</table>	
</body>
</html>