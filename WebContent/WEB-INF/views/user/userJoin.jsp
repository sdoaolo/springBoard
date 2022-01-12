<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>join</title>
</head>
<script type="text/javascript">
	
	$j(document).ready(function(){
		
		function checkValid(){
			var postRegExp = /^\d{3}-\d{3}$/;
			var phoneRegExp = /^\d{4}$/;
			
			var postNo = $j('input[name="userAddr1"]').val();
			var phone2 = $j('input[name="userPhone2"]').val();
			var phone3 = $j('input[name="userPhone3"]').val();
			
			var pw = $j("#pw").val();
			var pwCheck = $j("#pwCheck").val();
			
			var validChk=0;
			
			//postNo, phone ���� üũ
			if(postNo.length > 0){
				if(!postRegExp.test(postNo)) {            
	           		alert("postNo�� ������ ���ڷ� xxx-xxx�Դϴ�.");
	           		validChk += 1;
				}
			}
			if(!phoneRegExp.test(phone2) || !phoneRegExp.test(phone3)){
				alert("phone�� 4�ڸ� ���ڷ� �Է����ּ���");
				validChk += 1;
			}
			
			//��й�ȣ 6~12�ڸ�, ��ġ���� Ȯ�� 
			if(pw.length < 6 || pw.length > 12){
				alert("��й�ȣ�� 6~12 �ڸ� �̳��� �Է����ּ���");
				validChk += 1;
			}else if(pw != pwCheck){
				alert("��й�ȣ�� ��ġ���� �ʽ��ϴ�.");��
				validChk += 1;
			}
			
			//�ʼ��� üũ
			$j(".necVal").each(function(){
				if($j(this).val()== ""){
					alert($j(this).attr('id') + " : �ʼ� ���Դϴ�");
					validChk += 1;
				}
			});
			
			return validChk;
		}
		
		
		$j("#join").on("click",function(){
			var check = checkValid();
			
			if(check == 0){
				dataSubmit();
			}
		});
		
		function dataSubmit(){
			if(idCheckComplete==true){
				var $frm = $j('.userJoin :input');
				var param = $frm.serialize();
				
				$j.ajax({
				    url : "/board/userJoinAction.do",
				    dataType: "json",
				    type: "POST",
				    data : param,
				    success: function(data, textStatus, jqXHR)
				    {
						alert("Join �� AJAX success ");
						
						console.log(data.success);
						
						location.href = "/board/boardList.do?";
				    },
				    error: function (jqXHR, textStatus, errorThrown)
				    {
				    	alert("����");
				    }
				});
			}else{
				alert("���̵� �ߺ� Ȯ���� �ϼ���");
			}
		}
		
		var idCheckComplete = false;
		
		$j("#checkIdOverlap").on("click",function(){
			//���� ���̵��� �ߺ�üũ ID �ߺ� �� Ȯ�ν� ȸ������ �Ұ� alertâ / �ߺ��޼��� ���
			console.log("check Id overlap");
			
			var $frm = $j('.userJoin :input[name="userId"]');
			var param = $frm.serialize();

			console.log("test: "+ param);
			
			$j.ajax({
			    url : "/board/userCheck.do",
			    dataType: "json",
			    type: "POST",
			    data : param,
			    success: function(data, textStatus, jqXHR)
			    {
					console.log(data.success);
					
					if(data.success == "NotUnique"){
						alert("�̹� �����ϴ� ���̵� �Դϴ�.");
					}else{
						alert("��밡���� ���̵� �Դϴ�.");
						idCheckComplete = true;
					}
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
	<form class="userJoin" >
	<table align="center">
		<tr>
			<td align="left">
				<a href="/board/boardList.do">List</a>
			</td>
		</tr>
		
		<tr>
			<td>
				<table id="joinTbl" border ="1"> 
					<tr>
						<td width="120" align="center">
						id
						</td>
						<td width="300">
						<input name="userId" type="text" size="15" class="necVal" id="id" value="${user.userId}"> 
						<input id="checkIdOverlap" type="button" size="15" value="�ߺ�Ȯ��"> 
						</td>
					</tr>
					<tr>
						<td width="120" align="center">
						pw
						</td>
						<td width="300">
						<input name="userPw" type="text" size="20"  class="necVal"  id="pw" value="${user.userPw}"> 
						</td>
					</tr>
					<tr>
						<td width="120" align="center">
						pw check
						</td>
						<td width="300">
						<input name="userPwCheck" type="text"  class="necVal" id="pwCheck" size="20" > 
						</td>
					</tr>
					<tr>
						<td width="120" align="center">
						name
						</td>
						<td width="300">
						<input name="userName" type="text" size="20"   class="necVal" id="name" value="${user.userName}"> 
						</td>
					</tr>
					<tr>
						<td width="120" align="center">
						phone
						</td>
						<td width="300">
							<select name="userPhone1"  class="necVal" >
								<c:forEach items="${menuList}" var="list">
									<option value=${list.menuId}> ${list.menuName} </option>
								</c:forEach>
							</select>
							-
							<input name="userPhone2" type="text" size="4" class="necVal"  id="phone-2"maxlength='4' > 
							-
							<input name="userPhone3" type="text" size="4"  class="necVal" id="phone-3" maxlength='4' > 
						</td>
					</tr>
					<tr>
						<td width="120" align="center">
						postNo
						</td>
						<td width="300">
						<input name="userAddr1" type="text" size="20" > 
						</td>
					</tr>
					<tr>
						<td width="120" align="center">
						address
						</td>
						<td width="300">
						<input name="userAddr2" type="text" size="20" value="${user.userAddr1}"> 
						</td>
					</tr>
					<tr>
						<td width="120" align="center">
						company
						</td>
						<td width="300">
						<input name="userCompany" type="text" size="20" value="${user.userAddr1}"> 
						</td>
					</tr>
					
				</table>
			</td>
		</tr>
		<tr>
		<td align="right">
			<input id="join" type="button" value="Join">
		</td>
	</tr>	
	</table>
</form>
</body>
</html>




