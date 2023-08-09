<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품조회</title>
	<!-- 토스트 페이지 네이션 -->
    <script type="text/javascript" src="https://uicdn.toast.com/tui.code-snippet/latest/tui-code-snippet.js"></script>
    <link rel="stylesheet" href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css" />
    <script src="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.js"></script>
    <!-- 페이지 네이션 끝 -->
    <link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
    <script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
        
<style>
   body {
      font-family: 'Nanum Gothic', sans-serif;
      font-family: 'Noto Sans KR', sans-serif;
    }
    .search-container {
      display: flex;
      align-items: center;
      background-color: #fff;
      border-radius: 8px;
      padding: 5px 10px;
      margin-bottom: 10px;
    }

    .search-icon {
      margin-right: 10px;
      color: #888;
    }

    .search-input {
      border: none;
      outline: none;
      font-size: 16px;
      width: 100%;
      padding: 5px;
    }
    .col-lg-12 stretch-card{
       margin-top : 30px;
    }
    
    #customtemplateSearchAndButton{
       margin-bottom : 80px;
       float : left;   
    }
    
    #customtemplateSearchAndButton input, #modalTitle input{
       border : 1px solid black; 
       display : inline-block;
    }
    
    #customtemplateSearchAndButton p, #modalTitle p{
       display : inline-block;
       padding-bottom: 10px;
       padding-right : 10px;
    }
    
    #customtemplateSearchAndButton .blackcolorInputBox{
       background-color : #868e96;
    }
    
    .btn-icon-text{
       margin : 5px;
       padding : 7px;
       border-radius : 9px;
       height : 33px;
    }
    
    .excelDownload{
       margin-top : 120px;
       float : right;
    }
    
  
   /*모달시작*/
   #actModal{ 
     cursor:pointer;
   }
   
   .modal{ 
     position:absolute; width:100%; height:100%; background: rgba(0,0,0,0.8); top:0; left:0; display:none;
   }
   
   .modal_content{
     /*모달창 크기 조절*/
     width:600px; height:600px;
     background:#fff; border-radius:10px;
     /*모달창 위치 조절*/
     position:relative; top:33%; left:45%;
     margin-top:-100px; margin-left:-200px;
     text-align:center;
     box-sizing:border-box;
     line-height:23px;
   }
   
   .m_head{
        height: 10%;
        margin : 0;
        /*제목 높낮이 조절*/
        padding: 17px;
        display: flex;
        justify-content: space-between;
        background-color:rgb(232, 143, 33);
        border-top-left-radius: 10px;
        border-top-right-radius: 10px;
      }
      
      .close_btn{
        font-size: 20px;
        color: black;
        font-weight: 900;
        cursor: pointer;
      }
      
      .modal_btn{
        width: 80px;
        height: 30px;
        border-radius: 5px;
        text-align: center;
        font-size: 14px;
        font-weight: bolder;
        padding-top: 5px;
        margin-left: 5px;
        font-family: sans-serif;
      }
      .m_head{
        height: 10%;
        padding: 20px;
        display: flex;
        justify-content: space-between;
        border-top-left-radius: 10px;
        border-top-right-radius: 10px;
        font-family: sans-serif;
      }
      
      .m_body{
        height: 80%;
        padding: 20px;
      }
      
      .m_footer{
        height: 10%;
        padding: 15px;
        border-bottom-left-radius: 10px;
        border-bottom-right-radius: 10px;
        display: flex;
        justify-content: end;
      }
      .cancle{
        background-color: black;
        color: white;
      }
      .save{
        background-color: black;
        color: white;
      }
   /*모달끝*/
   
   /*날짜 input 크기*/
   input[type="date"]{
      width : 221px;
   }
</style>    
</head>
<body>
	<div class="black_bg"></div>
	<h3>거래처조회</h3>
	<div class="col-lg-12 stretch-card">
		<div class="card">
			<div class="card-body">
				<div class="table-responsive pt-3">
					<button type="button" class="btn btn-info btn-icon-text excelDownload">
		                Excel <i class="bi bi-printer"></i>                                                                              
					</button>
					<form>
						<div id="customtemplateSearchAndButton">		
							<p>거래처명</p>
							<input type="text" placeholder="검색어를 입력하세요" id="actSearch">
							<button type="button" class="btn btn-info btn-icon-text" id="searchBtn">
								<i class="fas fa-search"></i>검색
							</button>
							<button type="button" class="btn btn-info btn-icon-text">초기화</button>
		            	</div>
	            	</form>
	           		<div id="grid"></div>
				</div>
	   		</div>
		</div>
	</div> 

    
	<script>
	
	//제품검색조회
	
	$('#searchBtn').on('click', searchActIn);
   function searchActIn(e){
	   let content = $('#actSearch').val();
	   let search = { actName : content };
	   $.ajax({
		   url : 'ActCodeSearch',
		   method : 'GET',
		   data : search ,
		   success : function(data){
			   grid.resetData(data);
		   },
		   error : function(reject){
			   console.log(reject);
		   }
	   })
   }

    var grid = new tui.Grid({
        el: document.getElementById('grid'),
        data: [
	           <c:forEach items="${actList}" var="a" varStatus="status">
	           	{
	           		actCode : "${a.actCode}",
	           		actName :"${a.actName}",
	           		actNum :"${a.actNum}",
	           		actTel :"${a.actTel}",
	           		actSts : "${a.actSts}",
	           		commdeName : "${a.commdeName}",
	           		empName : "${a.empName}"
	           	} <c:if test="${not status.last}">,</c:if>
	           </c:forEach>
	          ],
        scrollX: false,
        scrollY: false,
        minBodyHeight: 30,
		rowHeaders: ['rowNum'],
		pagination: true,
		pageOptions: {
			useClient: true,
			perPage: 10,
		},
        columns: [
          {
            header: '거래처',
            name: 'actCode',
            filter: 'text'
          },
          {
            header: '거래처명',
            name: 'actName',
            filter: 'text'
          },
          {
            header: '사업자번호',
            name: 'actNum'
          },
          {
            header: '연락처',
            name: 'actTel'
          },
          {
            header: '거래여부',
            name: 'actSts'
          },
          {
              header: '거래처구분',
              name: 'commdeName'
            },
          {
              header: '담당자',
              name: 'empName'
            }
        ]
      })  

	
	</script>
</body>
</html>