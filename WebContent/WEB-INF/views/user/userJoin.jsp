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
				<table id="joinTbl"' border ="1"> 
					<tr>
						<td width="120" align="center">
						id
						</td>
						<td width="300">
						<input name="userId" type="text" size="15" value="${user.userId}"> 
						<input name="checkIdOverlap" type="button" size="15" value="중복확인"> 
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
					<tr>
						<td width="120" align="center">
						pw check
						</td>
						<td width="300">
						<input name="userPwCheck" type="text" size="20" > 
						</td>
					</tr>
					<tr>
						<td width="120" align="center">
						name
						</td>
						<td width="300">
						<input name="userName" type="text" size="20" value="${user.userName}"> 
						</td>
					</tr>
					<tr>
						<td width="120" align="center">
						phone
						</td>
						<td width="300">
							<select name="userPhone1">
								<c:forEach items="${menuList}" var="list">
									<option value=${list.menuId}> ${list.menuName} </option>
								</c:forEach>
							</select>
							-
							<input name="userPhone2" type="text" size="4" > 
							-
							<input name="userPhone3" type="text" size="4" > 
						</td>
					</tr>
					<tr>
						<td width="120" align="center">
						postNo
						</td>
						<td width="300">
						<input name="userPostNo" type="text" size="20" > 
						</td>
					</tr>
					<tr>
						<td width="120" align="center">
						address
						</td>
						<td width="300">
						<input name="userAddr1" type="text" size="20" value="${user.userAddr1}"> 
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
			<input type="button" value="Join">
		</td>
	</tr>	
	</table>
</form>
</body>
</html>




