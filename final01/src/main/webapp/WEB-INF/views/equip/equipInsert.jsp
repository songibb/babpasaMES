<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>설비 등록 페이지</title>
</head>
<body>
<form name="insertForm" action="equipInsert" method="post">
		<table>

			<tr>
				<th>제목</th>
				<td><input type="text" name="title"></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea name="contents"></textarea></td>
			</tr>
			<tr>
				<td>작성자</td>
				<th><input type="text" name="writer"></th>
			</tr>
			<tr>
				<td>첨부이미지</td>
				<th><input type="text" name="image"></th>
			</tr>
			<tr>
				<td>등록일자</td>
				<th><input type="date" name="regdate"></th>
			</tr>
			
		</table>
			<button type="submit">등록</button>
			<button type="button">목록</button>
	</form>
</body>
</html>