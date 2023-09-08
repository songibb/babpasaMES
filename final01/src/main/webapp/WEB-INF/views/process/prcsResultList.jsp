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

#prodNameFix, #prcsNameFix, #prcsDirNameFix{
	background-color : #868e96;
	border-color: #868e96;
}
.excelDownload{
	margin-top : 0;
	float : right;
}

.selected-cell{
	background-color: #ffd09e;
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
						<p>생산지시코드</p>
           				<input type="text" id="searchPrcsDirCode">
           				<i class="bi bi-search" id="prcsDirModal"></i> <!-- 돋보기 아이콘 -->
           				<input type="text" class="blackcolorInputBox" id="prcsDirNameFix" readonly>
						<br>
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
						<p>지시등록일자</p>
                		<input type="date" id="startDate" name="startDate" value="">&nbsp;&nbsp;-&nbsp;&nbsp;<input type="date" id="endDate" name="endDate" value="">
						
						<button type="button" class="btn btn-info btn-icon-text" id="todayBtn">오늘</button>
						<button type="button" class="btn btn-info btn-icon-text" id="weekBtn">일주일</button>
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
		<jsp:include page="../comFn/prcsDirModal.jsp"></jsp:include>
		<jsp:include page="../comFn/prodModal.jsp"></jsp:include>
		<jsp:include page="../comFn/prcsModal.jsp"></jsp:include>
	</div>
    
	<script>
	//검색
	document.getElementById('searchBtn').addEventListener('click', searchResultList);
	//오늘
	document.getElementById('todayBtn').addEventListener('click', todayInput);
	//일주일
	document.getElementById('weekBtn').addEventListener('click', weekInput);

	//오늘 버튼 클릭시 input태그에 오늘 날짜 입력
	function todayInput(){
		$('#startDate').val(getToday());
		$('#endDate').val(getToday());;
	}
	
	//일주일 버튼 클릭시 input태그에 일주일 날짜 입력
	function weekInput(){
		$('#startDate').val(getWeek());
		$('#endDate').val(getToday());;
	}
	
	//검색 버튼 클릭시
	function searchResultList(){
		let searchObj = {};
		searchObj['searchPrcsDirCode'] = $('#searchPrcsDirCode').val();
		searchObj['searchProdCode'] = $('#searchProdCode').val();
		searchObj['searchPrcsCode'] = $('#searchPrcsCode').val();
		searchObj['startDate'] = $('#startDate').val();
		searchObj['endDate'] = $('#endDate').val();	   

		$.ajax({
			url : 'selectPrcsResultList',
			method : 'GET',
			data : searchObj,
			success : function(data){	
				//날짜 츨력 포맷 변경
				$.each(data, function(i, objDe){
					let pdd = data[i]['prcsDirDate'];
					data[i]['prcsDirDate'] = getDate(pdd);
				})
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
            name: 'prcsListCode',
            align: 'center'
          },
          {
            header: '상세지시코드',
            name: 'prcsDirDeCode',
            align: 'center'
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
            },
            align: 'right'
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
            },
            align: 'right'
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
            },
            align: 'right'
          },
          {
            header: '작업시작시간',
            name: 'prcsStartTime',
            className: 'yellow-background',
            width: '160',
            align: 'center'
          },
          {
            header: '작업종료시간',
            name: 'prcsEndTime',
            className: 'yellow-background',
            width: '160',
            align: 'center'
          },
          {
             header: '지시등록일자',
             name: 'prcsDirDate',
             className: 'yellow-background',
             align: 'center'
          },
        ]
	})  
 	
 	
	//공정실적 조회(오늘 날짜)
	let searchObj = {};
 	searchObj['startDate'] = getToday();
 	searchObj['endDate'] = getToday();

	$.ajax({
        url : "selectPrcsResultList",
        method :"GET",
        data : searchObj,
        success : function(data){
        	todayInput();
        	//날짜 츨력 포맷 변경
			$.each(data, function(i, objDe){
				let pdd = data[i]['prcsDirDate'];
				data[i]['prcsDirDate'] = getDate(pdd);
			})
        	resultGrid.resetData(data);
        },
        error : function(reject){
 			console.log(reject);
 		}
	});

	
	resultGrid.on('click', () => {	
		//선택한 행 색깔 바꾸기
		let selectKey = resultGrid.getFocusedCell().rowKey;
		resultGrid.addRowClassName(selectKey, 'selected-cell');
		//다른 행 선택시 기존에 클릭했던 행은 class제거
    	resultGrid.on('focusChange', () => {
    		resultGrid.removeRowClassName(selectKey, 'selected-cell');
	    })	
	})
 	
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