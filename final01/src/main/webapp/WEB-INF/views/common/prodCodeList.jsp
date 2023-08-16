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
	<h3>제품조회</h3>
	<div class="col-lg-12 stretch-card">
		<div class="card">
			<div class="card-body">
				<div class="table-responsive pt-3">
					<button type="button" class="btn btn-info btn-icon-text excelDownload">
		                Excel <i class="bi bi-printer"></i>                                                                              
					</button>
					<form>
						<div id="customtemplateSearchAndButton">		
							<p>제품명</p>
							<input type="text" placeholder="검색어를 입력하세요" id="prodSearch">
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
	
	$('#searchBtn').on('click', searchProdIn);
   function searchProdIn(e){
	   let content = $('#prodSearch').val();
	   let search = { prodName : content };
	   $.ajax({
		   url : 'getProdCodeFilter',
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
	           <c:forEach items="${prodList}" var="p" varStatus="status">
	           	{
	           		prodCode : "${p.prodCode}",
	           		prodName :"${p.prodName}",
	           		prodKind :"${p.kindName}",
	           		prodUnit :"${p.prodUnit}",
	           		prodStd : "${p.prodStd}"
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
            header: '제품코드',
            name: 'prodCode',
            filter: 'text'
          },
          {
            header: '제품명',
            name: 'prodName',
            filter: 'text'
          },
          {
            header: '반/완제품구분',
            name: 'prodKind',
            filter: 'select'
          },
          {
            header: '단위',
            name: 'prodUnit'
          },
          {
            header: '규격',
            name: 'prodStd'
          }
        ]
      })  

	
	</script>
</body>
</html>