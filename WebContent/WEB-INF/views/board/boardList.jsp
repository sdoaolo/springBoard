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
			
			//어떤 데이터가 가는지 확인해보자.	
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
			    	var mydata ="";//조회한 json객체안의 모든 데이터를 꺼내서 추가할 변수
			    	
			    	$j("#boardTable").empty();
			    	
			    	mydata = 
			    		'<tr><td width="80" align="center">Type</td>'+
					'<td width="40" align="center">No</td>'+
					'<td width="300" align="center">Title</td></tr>';
			    	
					for(var i = 0; i<data.success.length;i++){
						mydata = mydata + '<tr>'+
						'<td align="center" id="boardType">'+
							data.success[i].boardTypeName +
						'</td>'+
						'<td>'+
					 		data.success[i].boardNum +
						'</td>'+
						'<td>'+
						'<a href = "/board/' + data.success[i].boardType + '/' + data.success[i].boardNum +'/boardView.do?pageNo=${pageNo}">'+ data.success[i].boardTitle +'</a>'+
						'</td>'+
						'</tr>';
					}
			    	
			    	$j("#boardTable").append(mydata);
			    	
			    	
			    	
			    	//data에 리스트가 있어서 여기에서 처리해야한다. 
			    	console.log("data.success",data.success);
					//console.log("data.success[0]", data.success[0].boardNum);
			    	//console.log("data[0].boardNum",data[0].boardNum);
			    	/*
			    	for (var i = 0 ; i< data.success.length;i++){
			    		console.log("boardType ", i ," : ", data.success[i].boardType);
			    		console.log("boardTitle ", i ," : ", data.success[i].boardTitle);
			    		console.log("boardComment ", i ," : ", data.success[i].boardComment);
			    	}
			    	*/
					alert("listttest")
			    			    	
					//아래거 없이 나오도록  코딩하기!!!!!!!!
					//그러면 여기에서 이부분에 ->>   <a href = "/board/${list.boardType}/${list.boardNum}/boardView.do?pageNo=${pageNo}">${list.boardTitle}</a>
					//데이터 값을 넣어주어야 하나
					//location.href = "/board/boardList.do?"+param;
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
		<td align="left">
			<a href ="../user/userLogin.do">login</a>
			<a href ="../user/userJoin.do">join</a>
		</td>
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
				<test id = "test">
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
				</test>
			</table>
		</td>
	</tr>
	<tr>
		<td align="right">
			<a href ="/board/boardWrite.do">글쓰기</a>
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