<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form class="form-signin" method="post" action="${pageContext.request.contextPath}/login">
<input type="text" id="username" name="username">
<input type="password" id="password" name="password">
<button type="submit">확인</button>
</form>
</body>
</html>