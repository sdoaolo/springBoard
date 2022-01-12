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
		
		//비밀번호 6~12자리, 일치여부 확인
		function chkPw (){
			var pw = $j("#pw").val();
			var pwCheck = $j("#pwCheck").val();
			
			if(pw.length < 6 || pw.length > 12){
				alert("비밀번호는 6~12 자리 이내로 입력해주세요");
				return false;
			}else if(pw != pwCheck){
				alert("비밀번호가 일치하지 않습니다.");ㅌ
				return false;
			}
		}
		function checkValid(){
			var postRegExp = /^\d{3}-\d{3}$/;
			var phoneRegExp = /^\d{4}$/;
			
			var postNo = $j('input[name="userAddr1"]').val();
			var phone2 = $j('input[name="userPhone2"]').val();
			var phone3 = $j('input[name="userPhone3"]').val();
			
			var validChk=0;
			if(postNo.length > 0){
				if(!postRegExp.test(postNo)) {            
	           		alert("postNo의 형식은 숫자로 xxx-xxx입니다.");
	           		validChk += 1;
				}
			}
			if(!phoneRegExp.test(phone2) || !phoneRegExp.test(phone3)){
				alert("phone은 4자리 숫자로 입력해주세요");
				validChk += 1;
			}
			if(validChk != 0)return false;
			
		}
		
		$j("#join").on("click",function(){
			
			//필수값 체크, 없으면alert
			$j(".necVal").each(function(){
				console.log($j(this).val());
				if($j(this).val()== ""){
					alert($j(this).attr('id') + " : 필수 값입니다");
				}
			});
			
			
			chkPw();
			checkValid();
			
			var $frm = $j('.userJoin :input');
			var param = $frm.serialize();
			
			console.log("param",param);
			
			$j.ajax({
			    url : "/board/userJoinAction.do",
			    dataType: "json",
			    type: "POST",
			    data : param,
			    success: function(data, textStatus, jqXHR)
			    {
					alert("Join 후 AJAX success ");
					
					alert("메세지:"+data.success);
					
					//location.href = "/board/boardList.do?";
			    },
			    error: function (jqXHR, textStatus, errorThrown)
			    {
			    	alert("실패");
			    }
			});
		});
		
		$j("#checkIdOverlap").on("click",function(){
			//기존 아이디들과 중복체크 ID 중복 미 확인시 회원가입 불가 alert창 / 중복메세지 출력
			
			
			
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
						<input id="checkIdOverlap" type="button" size="15" value="중복확인"> 
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




