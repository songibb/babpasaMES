<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>생산 계획 등록</title>

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
	<h2>생산 계획 등록</h2>
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
	           		<button id="save">저장</button>
	            	<button id="deAdd">행추가</button>
	            	<button id="orderModal">주문서조회</button>
	            	
	           		<div id="planGrid"></div>
	           		<div id="planDeGrid"></div>
	           		<div id="prcsGrid"></div>
				</div>
	   		</div>
		</div>
	</div> 
	
	<div>
		<jsp:include page="../modal/orderModal.jsp"></jsp:include>
	</div>
	
	<script>
	
	document.getElementById('save').addEventListener('click', saveServer);
	document.getElementById('deAdd').addEventListener('click', addDeRow);
	

	//페이지 호출시 생산계획 등록하는 행 자동 생성
	window.onload = function addRow(){
		planGrid.appendRow();
		planDeGrid.appendRow();
	} 

	//행추가 버튼 클릭시 상세생산계획 행 추가
	function addDeRow(){
		planDeGrid.appendRow();
	}
		
	//저장 버튼 클릭시 실행 될 함수 -> insert 실행
	function saveServer() {	
		
		//생산계획 + 상세생산계획 -> insert
		let rowKey = planGrid.getFocusedCell().rowKey;
		let columnName = planGrid.getFocusedCell().columnName;
		//편집종료
		planGrid.finishEditing(rowKey, columnName);
		
		rowKey = planDeGrid.getFocusedCell().rowKey;
		columnName = planDeGrid.getFocusedCell().columnName;
		//편집종료
		planDeGrid.finishEditing(rowKey, columnName);
		
		let list = planGrid.getData();
		console.log(list);
		let deList = planDeGrid.getData();
		console.log(deList);
		
		const totalList = Object.assign({}, list, deList);
		console.log(totalList);
		
		$.ajax({
			url : 'prcsPlanInsert',
			method : 'POST',
			data : JSON.stringify(totalList),
			contentType : 'application/json',
			success : function(data){
				//등록 후 생산계획+상세생산계획 그리드 지우고, 행추가
				dirGrid.clear();
				dirGrid.appendRow();
				dirDeGrid.clear();
				dirDeGrid.appendRow();
			},
			error : function(reject){
	 			console.log(reject);
	 		}
		})
	};
	
	
	
	//생산계획 form
    var planGrid = new tui.Grid({
        el: document.getElementById('planGrid'),
        scrollX: false,
        scrollY: false,
        minBodyHeight: 30,
		rowHeaders: ['rowNum'],		
        columns: [
          {
            header: '계획코드',
            name: 'prcsPlanCode'
          },
          {
            header: '계획명',
            name: 'prcsPlanName',
            editor: 'text'
          },
          //지울부분
          {
            header: '계획일자',
            name: 'prcsPlanDate'
          },
          {
            header: '담당자',
            name: 'empCode',
            editor: 'text'
          },
        	//지울부분
          {
			header: '생산지시여부',
            name: 'prcsDirYn'
          },
          {
            header: '예상생산시작일',
            name: 'prcsStartDate',
            editor: 'text'
          },
          {
            header: '예상생산종료일',
            name: 'prcsEndDate',
            editor: 'text'
          }
        ]
	});
	
	//상세생산계획 form
	var planDeGrid = new tui.Grid({
        el: document.getElementById('planDeGrid'),
        scrollX: false,
        scrollY: false,
        minBodyHeight: 30,
		rowHeaders: ['rowNum'],
        columns: [
          {
            header: '상세계획코드',
            name: 'prcsPlanDeCode'
          },
          {
            header: '제품코드',
            name: 'prodCode'
          },
          {
            header: '주문수량',
            name: 'ordTotalAmt',
            editor: 'text'
          },
          {
            header: '생산계획량',
            name: 'prcsPlanAmt',
            editor: 'text'
          },
          {
            header: '우선순위',
            name: 'prcsPrio',
            editor: 'text'
          },
        //지울부분
          {
            header: '지시수량',
            name: 'prcsDirAmt'
          },
        //지울부분
          {
            header: '지시상태',
            name: 'prcsDirSts'
          },
          //지울부분
          {
            header: '생산량',
            name: 'prcsAmt'
          }
        ]
      });
	

	
    </script>
</body>
</html>