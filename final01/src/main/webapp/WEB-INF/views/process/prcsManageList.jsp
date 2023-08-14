<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공정 관리</title>

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
	<h2>공정 관리</h2>
	<div class="col-lg-12 stretch-card">
		<div class="card">
			<div class="card-body">
				<div class="table-responsive pt-3">
					<button type="button" class="btn btn-info btn-icon-text excelDownload">
		                Excel <i class="bi bi-printer"></i>                                                                              
					</button>
					<form>
						<div id="customtemplateSearchAndButton">		
							<p>검색</p>
							<input type="text" placeholder="검색어를 입력하세요" name="prcsSearch" value="">
							
							<button type="button" class="btn btn-info btn-icon-text" >
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
	
	//공정관리 조회
	$.ajax({
        url : "selectPrcsManageList",
        method :"GET",
        success : function(result){
            grid.resetData(result);
        },
        error : function(reject){
 			console.log(reject);
 		}
	});
	
	
	//공정관리 조회 - 검색
	$('button:contains("검색")').on('submit', ajaxSearch);
	
	function ajaxSearch(e){
		e.preventDefault();
		
		$.ajax({
			url : "selectPrcsManageSearch",
	        method :"post",      
	        data : $('form').serialize(),
	        success : function(result){
	            grid.resetData(result);
	        },
	        error : function(reject){
	 			console.log(reject);
	 		}
		});

	}
	
	
    var grid = new tui.Grid({
        el: document.getElementById('grid'),
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
            header: '공정코드',
            name: 'prcsCode',
          },
          {
            header: '공정구분',
            name: 'prcsType',
          },
          {
            header: '공정이름',
            name: 'prcsName'
          },
          {
            header: '반제품',
            name: 'semiYn'
          }		          
        ]
      })  


	</script>
</body>
</html>