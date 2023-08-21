<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공정 실적 조회</title>

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
	<h2>공정 실적 조회</h2>
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
							
							<br>
							<p>업체명</p>
			                  <input type="text" placeholder="검색어를 입력하세요" id="actCodeInput">
			                    <i class="bi bi-search" id="actModal"></i>
			                  <input type="text" class="blackcolorInputBox" id="actNameFix" readonly>
			                <br>
							
							
							<button type="button" class="btn btn-info btn-icon-text" >
								<i class="fas fa-search"></i>검색
							</button>
							<button type="button" class="btn btn-info btn-icon-text">초기화</button>
		            	</div>
	            	</form>
	           		<div id="resultGrid"></div>
				</div>
	   		</div>
		</div>
	</div> 
	
	
	<div>
		<jsp:include page="../comFn/dateFormat.jsp"></jsp:include>
	</div>
    
	<script>

 	//공정 실적 조회
	var resultGrid = new tui.Grid({
        el: document.getElementById('resultGrid'),
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
            header: '공정실적관리코드',
            name: 'prcsListCode'
          },
          {
            header: '상세지시코드',
            name: 'prcsDirDeCode'
          },
          {
            header: '제품코드',
            name: 'prodCode',
            hidden: true
          },
          {
            header: '제품명',
            name: 'prodName'
          },
          {
            header: '공정코드',
            name: 'prcsCode',
            hidden: true
          },
          {
            header: '공정명',
            name: 'prcsName'
          },
          {
            header: '설비코드',
            name: 'eqCode',
            hidden: true         
          },
          {
            header: '설비명',
            name: 'eqName'
          },
          {
            header: '투입량',
            name: 'inputAmt'
          },
          {
            header: '불량량',
            name: 'errAmt'
          },
          {
            header: '생산량',
            name: 'prcsAmt'
          },
          {
            header: '작업시작시간',
            name: 'prcsStartTime'
          },
          {
            header: '작업종료시간',
            name: 'prcsEndTime'
          },
        ]
      })  
 	
	$.ajax({
        url : "selectPrcsResultList",
        method :"GET",
        success : function(data){
        	resultGrid.resetData(data);
        },
        error : function(reject){
 			console.log(reject);
 		}
	});

    
	</script>

</body>
</html>