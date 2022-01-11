<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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