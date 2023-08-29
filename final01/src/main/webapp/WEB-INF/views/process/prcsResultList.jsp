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
       
<style type="text/css">
.yellow-background {
	background-color: rgb(255,253,235);
}

form p{
	width: 110px;
	display: inline-block;
	font-size: 20px;
}
input[type="text"] {
  width: 15%;
  padding: 6px;
  margin-bottom: 15px;
  border: 1px solid #ccc;
  border-radius: 4px;
}
input[type="date"]{
  width: 15%;
  padding: 5px;
  margin-bottom: 35px;
  border: 1px solid #ccc;
  border-radius: 4px;
}
h1{
	margin-left: 15px;
}
h1, h2{
	font-weight: 800;
}
h2{
	display: inline-block;
}
#resultGridHeader{
	display: flex;
	justify-content: space-between;
}

#prodNameFix, #prcsNameFix {
	background-color : #868e96;
	border-color: #868e96;
}
.excelDownload{
	margin-top : 0;
	float : right;
}
</style>  
</head>
<body>
	<div class="black_bg"></div>
	<h1>공정 실적 조회</h1>
	<div class="col-lg-12 stretch-card">
		<div class="card">
			<div class="card-body">
				<div class="table-responsive pt-3">
					<form>	
						<p>제품명</p>
           				<input type="text" id="searchProdCode">
           				<i class="bi bi-search" id="prodModal"></i> <!-- 돋보기 아이콘 -->
           				<input type="text" class="blackcolorInputBox" id="prodNameFix" readonly>
						<br>
						<p>공정명</p>
           				<input type="text" id="searchPrcsCode">
           				<i class="bi bi-search" id="prcsModal"></i> <!-- 돋보기 아이콘 -->
           				<input type="text" class="blackcolorInputBox" id="prcsNameFix" readonly>
           				<br>
						<p>지시일자</p>
                		<input type="date" id="startDate" name="startDate" value="">&nbsp;&nbsp;-&nbsp;&nbsp;<input type="date" id="endDate" name="endDate" value="">
						
						<button type="button" class="btn btn-info btn-icon-text" id="searchBtn">
							<i class="fas fa-search"></i>검색
						</button>
						<button type="reset" class="btn btn-info btn-icon-text" id="resetBtn">초기화</button>						
	            	</form>
				</div>
				
				<div id="resultGridHeader">
					<h2>공정 실적 목록</h2>
					<div>
						<button type="button" class="btn btn-info btn-icon-text excelDownload">
		                	Excel <i class="bi bi-printer"></i>                                                                              
						</button>
					</div>
				</div>
					
           		<div id="resultGrid"></div>
	   		</div>
		</div>
	</div> 
	
	
	<div>
		<jsp:include page="../comFn/dateFormat.jsp"></jsp:include>
		<jsp:include page="../comFn/prodModal.jsp"></jsp:include>
		<jsp:include page="../comFn/prcsModal.jsp"></jsp:include>
	</div>
    
	<script>
	//검색
	document.getElementById('searchBtn').addEventListener('click', searchResultList);
	
	function searchResultList(){
		let searchObj = {};
		searchObj['searchProdCode'] = $('#searchProdCode').val();
		searchObj['searchPrcsCode'] = $('#searchPrcsCode').val();
		searchObj['startDate'] = $('#startDate').val();
		searchObj['endDate'] = $('#endDate').val();	   

		$.ajax({
			url : 'selectPrcsResultList',
			method : 'GET',
			data : searchObj,
			success : function(data){	
				resultGrid.resetData(data);
			},
			error : function(reject){
				 console.log(reject);
			}
		});
};
	
	
 	//공정 실적 조회
	var resultGrid = new tui.Grid({
		el: document.getElementById('resultGrid'),
        scrollX: false,
        scrollY: false,
        minBodyHeight: 400,
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
            header: '제품명',
            name: 'prodName'
          },
          {
            header: '공정명',
            name: 'prcsName'
          },
          {
            header: '설비명',
            name: 'eqName'
          },
          {
            header: '투입량',
            name: 'inputAmt',
            formatter(e) {
            	if (e['value'] != null){
	                val = e['value']
	                    .toString()
	                    .replace(/\B(?=(\d{3})+(?!\d))/g, ',');
	                return val;
            	}
            }
          },
          {
            header: '불량량',
            name: 'errAmt',
            formatter(e) {
            	if (e['value'] != null){
	                val = e['value']
	                    .toString()
	                    .replace(/\B(?=(\d{3})+(?!\d))/g, ',');
	                return val;
            	}
            }
          },
          {
            header: '생산량',
            name: 'prcsAmt',
            formatter(e) {
            	if (e['value'] != null){
	                val = e['value']
	                    .toString()
	                    .replace(/\B(?=(\d{3})+(?!\d))/g, ',');
	                return val;
            	}
            }
          },
          {
            header: '작업시작시간',
            name: 'prcsStartTime',
            className: 'yellow-background',
            width: 'auto'
          },
          {
            header: '작업종료시간',
            name: 'prcsEndTime',
            className: 'yellow-background',
            width: 'auto'
          },
          {
             header: '지시등록일자',
             name: 'prcsDirDate',
             className: 'yellow-background',
             width: 'auto'
          },
        ]
	})  
 	
 	
	let searchObj = {};
 	searchObj['searchProdCode'] = $('#searchProdCode').val();
 	searchObj['startDate'] = $('#startDate').val();
 	searchObj['endDate'] = $('#endDate').val();

	$.ajax({
        url : "selectPrcsResultList",
        method :"GET",
        data : searchObj,
        success : function(data){
        	resultGrid.resetData(data);
        },
        error : function(reject){
 			console.log(reject);
 		}
	});

 	
 	
 	
	//엑셀 다운로드
	const excelDownload = document.querySelector('.excelDownload');
	   
	document.addEventListener('DOMContentLoaded', ()=>{
		excelDownload.addEventListener('click', function(e){
			resultGrid.export('xlsx');
		})
	})
 	
 	
 	
	//이전 날짜 선택불가
    $('#startDate').on('change', function() {
		$('#endDate').attr('min', $('#startDate').val());
    });
	//이후날짜 선택불가
    $('#endDate').on('change', function() {
		$('#startDate').attr('max', $('#endDate').val());
	});
	</script>

</body>
</html>