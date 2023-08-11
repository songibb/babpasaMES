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
        
</head>
<body>
	<div class="black_bg"></div>
	<h3>품질검사코드조회</h3>
	<div class="col-lg-12 stretch-card">
		<div class="card">
			<div class="card-body">
				<div class="table-responsive pt-3">
					<button type="button" class="btn btn-info btn-icon-text excelDownload">
		                Excel <i class="bi bi-printer"></i>                                                                              
					</button>
					<form>
						<div id="customtemplateSearchAndButton">		
							<p>검사명</p>
							<input type="text" placeholder="검색어를 입력하세요" id="testSearch">
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
	
	$('#searchBtn').on('click', searchTestIn);
   function searchTestIn(e){
	   let content = $('#testSearch').val();
	   let search = { testName : content };
	   $.ajax({
		   url : 'testCodeSearch',
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
	           <c:forEach items="${testCodeList}" var="t" varStatus="status">
	           	{
	           		testCode : "${t.testCode}",
	           		testName :"${t.testName}",
	           		passValue :"${t.passValue}"
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
            header: '검사코드',
            name: 'testCode',
            filter: 'text'
          },
          {
            header: '검사명',
            name: 'testName',
            filter: 'text'
          },
          {
            header: '적합기준',
            name: 'passValue'
          }
        ]
      })  

	
	</script>
</body>
</html>