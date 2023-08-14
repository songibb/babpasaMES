<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<script type="text/javascript">
		function getDate(sec){    //서버에서 숫자로 넘어온 날짜를 다시 날짜로 바꾸기
		    let date = new Date(sec);  //매개변수값으로 숫자를 넘겨주면 날짜로 변환
		    
		    let year = date.getFullYear();
		    let month = ('0' + (date.getMonth() + 1)).substr(-2);   //month 0부터 시작하기때문에 1을 더함, '0'을 앞에 붙여서 두자리로 표현
		    let day = ('0' + date.getDate()).substr(-2);    //'0'을 앞에 붙여서 두자리로 표현
		    //substr(음수) : 오른쪽 부터 잘라냄 -> 원래 두자리 숫자는 0을 제외하고 잘라와서 그대로 표현 
		
		    return year + '-' + month + '-' + day;
		}	
	</script>

</body>
</html>