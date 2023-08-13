<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="false" %>

<!DOCTYPE html>
<html>
<head>

	 <!-- 토스트 페이지 네이션 -->
	 <script type="text/javascript" src="https://uicdn.toast.com/tui.code-snippet/latest/tui-code-snippet.js"></script>
	 <link rel="stylesheet" href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css" />
	 <script src="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.js"></script>
	 
	 <!-- 페이지 네이션 끝 -->
	 <link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
	 <script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
	 <link rel="preconnect" href="https://fonts.googleapis.com">
	 <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	 <link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@700&family=Noto+Sans+KR&display=swap" rel="stylesheet">
	 

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

    
</style>
</head>
<body>
<form>
	<div class="black_bg"></div>
	<h1>설비 조회</h1>
	<div class="col-lg-12 stretch-card">
    	<div class="card">
        	<div class="card-body">
            	<div class="table-responsive pt-3">
            		<div id="customtemplateSearchAndButton">
						<p>설비명</p>
  							<input type="text" placeholder="검색어를 입력하세요" id="equipSearch">
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
		
		    var grid = new tui.Grid({
		        el: document.getElementById('grid'),
		        data :[
		        	<c:forEach items="${EquipList}" var="equip"  varStatus="status">
		        	{
		        		eqCode : "${equip.eqCode}",
		        		actCode : "${equip.actCode}",
		        		eqName :"${equip.eqName}", 
		        		modelName : "${equip.modelName}",
		        		makeDate : "<fmt:formatDate value='${equip.makeDate}' pattern='yyyy-MM-dd'/>",		        		
		        		buyDate : "<fmt:formatDate value='${equip.buyDate}' pattern='yyyy-MM-dd'/>",
		        		chkCycle : "${equip.chkCycle}",
		        		eqSts : "${equip.eqSts}",
		        		eqType : "${equip.eqType}",
		        		highTemp : "${equip.highTemp}",
		        		lowTemp : "${equip.lowTemp}",   		
		        	}<c:if test="${not status.last}">,</c:if>
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
			        columns:  [
		 	      	  {
			 	        header: '설비코드',
			 	        name: 'eqCode'
			 	      
			 	      },
			 	      {
			 	    	  header : '설비업체명',
			 	    	  name : 'actCode'		 	    	  
			 	      },
			 	      {
			 	        header: '설비명',
			 	        name: 'eqName',
			 	        filter: 'text'
			 	      },
			 	      {
			 	        header: '모델명',
			 	        name: 'modelName'
			 	      },
			 	      {
			 	    	  header :'제작일자',
			 	    	  name : 'makeDate'
			 	      },
			 	      {
			 	    	  header :'구입일자',
			 	    	  name : 'buyDate'
			 	      },
			 	      {
			 	    	  header : '점검주기',
			 	    	  name : 'chkCycle'
			 	      },
			 	      
			 	      {
			 	        header: '설비상태',
			 	        name: 'eqSts'
			 	      },
			 	      {
			 	        header: '설비구분',
			 	        name: 'eqType'
			 	      },
			 	      {
			 	    	  header :'최고온도',
			 	    	  name : 'highTemp'
			 	      },
			 	      {
			 	    	 hedaer : '최저온도',
			 	    	 name : 'lowTemp'
			 	      }
			 	      
			 	    ]
		      })  
			
		    //검색
		    $('#searchBtn').on('click', searchProdIn);
		    function searchProdIn(e){
		 	   let content = $('#equipSearch').val();
		 	   let search = { eqName : content };
		 	   $.ajax({
		 		   url : 'searchEquip',
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

		

	</script>
</body>
</html>	
