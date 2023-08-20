<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	body{
  font-family: 'Montserrat', sans-serif;
  background:white;
}

.container{
  display:block;
  max-width:680px;
  width:80%;
  margin:120px auto;
  background-color : #a3d179;
  height : 600px;
  padding : 5px;
  border-radius : 40px;
}

h1{
  color:#e91e63;
  font-size:48px;
  letter-spacing:-3px;
  text-align:center;
  margin:120px 0 80px 0 ;
  transition:.2s linear;
}


	p{
		display : inline-block;
		width: 150px;
		font-size : 20px;
		text-align : center;
	}
	
	
	
	


form{
  width:100%;
  max-width:680px;
  margin:40px auto 10px;
  .input__block{
     margin:20px auto;
     display:block;
     position:relative;
     &.first-input__block{
        &::before{
          content:"";
          position:absolute;
          top:-15px;
          left:50px;
          display:block;
          width:0;
          height:0;
        background:transparent;
          border-left:15px solid transparent;
          border-right:15px solid transparent;
          border-bottom:15px solid rgba(#0f132a,.1);
          transition:.2s linear;
        }
     }
     &.signup-input__block{
      &::before{
        content:"";
        position:absolute;
        top:-15px;
        left:150px;
        display:block;
        width:0;
        height:0;
        background:transparent;
        border-left:15px solid transparent;
        border-right:15px solid transparent;
        border-bottom:15px solid rgba(#0f132a,.1);
        transition:.2s linear;
        }
     }
     input{
        display:block;
        width:90%;
        max-width:700px;
        height:50px;
        margin:0 auto;
        border-radius:8px;
        border:none;
        background: rgba(#0f132a,.1);
        color : rgba(#0f132a,.3);
        padding:0 0 0 15px;
        font-size:14px;
        font-family: 'Montserrat', sans-serif;
        &:focus,
        &:active{
          outline:none;
          border:none;
          color : rgba(#0f132a,1);
        }
       &.repeat__password{
         opacity : 0;
         display : none;
         transition:.2s linear;
       }
     }
  }
  
  .signin__btn{
     background:#e9d21e;
     color:white;
     display:block;
     width:92.5%;
     max-width:680px;
     height:50px;
     border-radius:8px;
     margin:0 auto;
     border:none;
     cursor:pointer;
     font-size:14px;
     font-family: 'Montserrat', sans-serif;
     box-shadow:0 15px 30px rgba(#e91e63,.36);
    transition:.2s linear;
    &:hover{
      box-shadow:0 0 0 rgba(#e91e63,.0);
    }
  }
}

label{
	margin-left : 130px;
	color : white;
	font-weight : bold;
}



</style>
</head>
<body>
	
    <div class="container">
  <!-- Heading -->
  
  <h1><img src="/app/resources/img/babpasa_logo_01.png" alt="logo"></h1>

  <!-- Form -->
  <form method="post" action="${pageContext.request.contextPath}/login">
    <!-- email input -->
    <div class="first-input input__block first-input__block">
       <label for="username"><p>아이디<p><input type="text" placeholder="Emp_Code" name="username" id="username"/></label>
    </div>
    <!-- password input -->
    <div class="input__block">
       <label for="password"><p>비밀번호<p><input type="password" placeholder="Password" class="input" name="password" id="password"/></label>
    </div>
    <!-- sign in button -->
    <button type="submit" class="signin__btn">
      로그인
    </button>
  </form>
</div>

</body>
</html>