<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>생산 계획 등록</title>

<!-- 토스트 그리드 데이트피커 -->
<link rel="stylesheet" href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />
<script src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
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
	<h2>생산 계획 관리</h2>
	<div class="col-lg-12 stretch-card">
		<div class="card">
			<div class="card-body">
				<div class="table-responsive pt-3">
					<button type="button" class="btn btn-info btn-icon-text excelDownload">
		                Excel <i class="bi bi-printer"></i>                                                                              
					</button>
					<form>
						<div id="customtemplateSearchAndButton">		
							<p>계획일자</p>
                  			<input id="startDate" type="date">&nbsp;&nbsp;-&nbsp;&nbsp;<input id="endDate" type="date">
							<br>
							
							<p>계획명</p>
							<input type="text" placeholder="검색어를 입력하세요" id ="searchPlanName" name="searchPlanName">
							
							<button type="button" class="btn btn-info btn-icon-text" id="searchBtn">
								<i class="fas fa-search"></i>검색
							</button>
							<button type="reset" class="btn btn-info btn-icon-text" id="resetBtn">초기화</button>
		            	</div>
	            	</form>
	            	<button id="deAdd">행추가</button>
	           		<button id="save">저장</button>
	            	<button id="remove">삭제</button>
	            	<button id="orderModal">주문서조회</button>
	            	
	           		<div id="planGrid"></div>
	           		<div id="planDeGrid"></div>
	           		<div id="prcsGrid"></div>
				</div>
	   		</div>
		</div>
	</div> 
	
	<div>
		<jsp:include page="../comFn/orderModal.jsp"></jsp:include>
		<jsp:include page="../comFn/dateFormat.jsp"></jsp:include>
	</div>
	
	<script>
	
	//검색
	document.getElementById('searchBtn').addEventListener('click', searchPlanList);
	//저장
	document.getElementById('save').addEventListener('click', saveServer);
	//행추가
	document.getElementById('deAdd').addEventListener('click', addDeRow);
	//삭제
	document.getElementById('remove').addEventListener('click', removeRow);
	
	
	//검색 -> 상세계획 클릭시 'Y' / 주문서조회 -> 상세계획 클릭시 'N'
	var gridClick = null;
	
	//검색 -> 조건별 생산계획 조회
	function searchPlanList(){
		let planName = $('#searchPlanName').val();
		let sd = $('#startDate').val();
		let ed = $('#endDate').val();	 
		
// 		//생산계획 -> insert
// 		let rowKey = planGrid.getFocusedCell().rowKey;
// 		let columnName = planGrid.getFocusedCell().columnName;
// 		//편집종료
// 		planGrid.finishEditing(rowKey, columnName);

		$.ajax({
			url : 'searchPlanList',
			method : 'GET',
			data : { searchPlanName : planName, startDate : sd , endDate : ed },
			success : function(data){				
				//날짜 츨력 포맷 변경
				$.each(data, function(i, objDe){
					let ppd = data[i]['prcsPlanDate'];
					let psd = data[i]['prcsStartDate'];
					let ped = data[i]['prcsEndDate'];
					data[i]['prcsPlanDate'] = getDate(ppd);
					data[i]['prcsStartDate'] = getDate(psd);
					data[i]['prcsEndDate'] = getDate(ped);
				})
				
				planGrid.resetData(data);
				planDeGrid.clear();	
				
				gridClick = 'Y';
			},
			error : function(reject){
			 	console.log(reject);
			}
		});
	}


	//저장
    function saveServer() {	
    	let rowKey = planGrid.getFocusedCell();
    	let codeValue = planGrid.getValue(rowKey, 'prcsPlanCode');
    	
		if(codeValue == null){
			//insert
			planInsert();
			
			//if -> 상세생산계획칸 비어있으면 작동X
			
		} else{
			//update
			planUpdate();
			
			//if -> 상세생산계획칸 비어있으면 작동X
			
		}

	};
	
	function planInsert(){
		//생산계획 -> insert
		let rowKey = planGrid.getFocusedCell().rowKey;
		let columnName = planGrid.getFocusedCell().columnName;
		//편집종료
		planGrid.finishEditing(rowKey, columnName);

		let list = planGrid.getData();
		let obj = list[0];

		$.ajax({
			url : 'prcsPlanInsert',
			method : 'POST',
			data : JSON.stringify(obj),
			contentType : 'application/json',
			success : function(data){					
				//상세생산계획 insert
				let rowKey = planDeGrid.getFocusedCell().rowKey;
				let columnName = planDeGrid.getFocusedCell().columnName;
				//편집종료
				planDeGrid.finishEditing(rowKey, columnName);
				
				let deList = planDeGrid.getData();
				$.each(deList, function(i, objDe){
					deList[i]['prcsPlanCode'] = data;
				})
				
				$.ajax({
					url : 'prcsPlanDeInsert',
					method : 'POST',
					data : JSON.stringify(deList),
					contentType : 'application/json',
					success : function(data){
						//등록 후 그리드 내용 지우고, 행추가
						planGrid.clear();
						planGrid.appendRow();
						planDeGrid.clear();
						planDeGrid.appendRow();
						
						//주문서 테이블에 계획코드, 계획상태 update하기
						
						alert('등록 성공');

					},
					error : function(reject){
			 			console.log(reject);
			 		}
				})				
			},
			error : function(reject){
	 			console.log(reject);
	 		}		
		})
		
	}

	function planUpdate(){
		//alert 표시를 위한 변수
		var updateOk;
		
		//생산계획 -> update
		let rowKey = planGrid.getFocusedCell().rowKey;
		let columnName = planGrid.getFocusedCell().columnName;
		//편집종료
		planGrid.finishEditing(rowKey, columnName);

		let list = planGrid.getData();

		$.ajax({
			url : 'prcsPlanUpdate',
			method : 'POST',
			data : JSON.stringify(list),
			contentType : 'application/json',
			async : false,  //data 모두 수신 후 변수 updateOk에 담기 위해 동기방식으로 처리
			success : function(data){	
				updateOk = data;

				//수정 후 그리드 내용 지우고, 행추가
				planGrid.clear();
				planGrid.appendRow();
			},
			error : function(reject){
	 			console.log(reject);
	 		}		
		})

		//상세생산계획 update
		let rowKeyDe = planDeGrid.getFocusedCell().rowKey;
		let columnNameDe = planDeGrid.getFocusedCell().columnName;
		//편집종료
		planDeGrid.finishEditing(rowKeyDe, columnNameDe);

		let deList = planDeGrid.getData();
		
		$.ajax({
			url : 'prcsPlanDeUpdate',
			method : 'POST',
			data : JSON.stringify(deList),
			contentType : 'application/json',
			async : false,
			success : function(data){
				updateOk = updateOk + data;
				
				//수정 후 그리드 내용 지우고, 행추가
				planDeGrid.clear();
				planDeGrid.appendRow();
			},
			error : function(reject){
	 			console.log(reject);
	 		}
		})
		
		if(updateOk > 0){
			alert('수정 성공');
		}
		
	}
	
	//삭제
	function removeRow(){
		let message = confirm("정말 삭제하시겠습니까?");
		if(message) {
			
			//생산계획 -> delete (상세생산계획은 CASCADE로 삭제)
			
			//체크한 행들의 prcsPlanCode가 담긴 list 만들기
			let checkList = planGrid.getCheckedRows();
			let planCodeList = [];			
			$.each(checkList, function(i, obj){
				//let planCodeObj = {};
				//planCodeObj['prcsPlanCode'] = checkList[i]['prcsPlanCode'];
				planCode = checkList[i]['prcsPlanCode'];
				planCodeList.push(planCode);
				//planCodeList.push(planCodeObj);
			})
			
			$.ajax({
				url : 'prcsPlanDelete',
				method : 'POST',
				data : JSON.stringify(planCodeList),
				contentType : 'application/json',
				success : function(data){	
					//체크된 행 부분 삭제, 상세생산계획 그리드 지우기
					planGrid.removeCheckedRows(false);
					planDeGrid.clear();
				},
				error : function(reject){
		 			console.log(reject);
		 		}		
			})

			
		} 
		
		
	
	}
	
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
// 	function saveServer() {	
// 		//생산계획 + 상세생산계획 -> insert
// 		let rowKey = planGrid.getFocusedCell().rowKey;
// 		let columnName = planGrid.getFocusedCell().columnName;
// 		//편집종료
// 		planGrid.finishEditing(rowKey, columnName);
		
// 		rowKey = planDeGrid.getFocusedCell().rowKey;
// 		columnName = planDeGrid.getFocusedCell().columnName;
// 		//편집종료
// 		planDeGrid.finishEditing(rowKey, columnName);
		
// 		let list = planGrid.getData();
// 		let deList = planDeGrid.getData();		
	
// 		$.ajax({
// 			url : 'prcsPlanInsert',
// 			method : 'POST',
// 			data : {"prcsPlanList" : JSON.stringify(list), "prcsPlanDeList" :JSON.stringify(deList)},
// 			contentType : 'application/json',
// 			success : function(data){
// 				console.log('data :', data)
// 				//등록 후 생산계획+상세생산계획 그리드 지우고, 행추가
// 				dirGrid.clear();
// 				dirGrid.appendRow();
// 				dirDeGrid.clear();
// 				dirDeGrid.appendRow();
// 			},
// 			error : function(reject){
// 	 			console.log(reject);
// 	 		}
// 		})
// 	};
	

	//생산계획 grid
    var planGrid = new tui.Grid({
        el: document.getElementById('planGrid'),
        scrollX: false,
        scrollY: false,
        minBodyHeight: 30,
        rowHeaders: ['rowNum', 'checkbox'],
        columns: [
          {
            header: '계획코드',
            name: 'prcsPlanCode',
            hidden: true
          },
          {
            header: '계획명',
            name: 'prcsPlanName',
            editor: 'text'
          },
          //지울부분
          {
            header: '계획일자',
            name: 'prcsPlanDate',
           	editor: {
		      type: 'datePicker',
		      options: {
		    	  language: 'ko'
		      }
		    }
           	
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
            editor: {
  		      type: 'datePicker',
  		      options: {
  		    	  language: 'ko'
  		      }
  		    }
          },
          {
            header: '예상생산종료일',
            name: 'prcsEndDate',
            editor: {
  		      type: 'datePicker',
  		      options: {
  		    	  language: 'ko'
  		      }
  		    }
          }
        ]
	});
	
	//상세생산계획 grid
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
				name: 'prodCode',
				editor: 'text'
			},
			{
				header: '주문수량',
				name: 'prcsRqAmt',
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
				name: 'prcsDirAmt',
			},
			//지울부분
     		{
				header: '지시상태',
				name: 'prcsDirSts',
			},
			//지울부분
			{
				header: '생산량',
				name: 'prcsAmt'
     		}
		]
	});
	

	//생산 계획 클릭시 해당 계획의 상세생산계획 조회
	planGrid.on('click', () => {
		
		//조건별 검색을 통한 조회일때 사용 (주문서 조회 적용시에는 사용X)
		if(gridClick == 'Y'){
	    	//클릭한 계획의 계획코드 가져오기
	    	let rowKey = planGrid.getFocusedCell().rowKey;
	    	let planCode = planGrid.getValue(rowKey, 'prcsPlanCode');
	
	    	$.ajax({
				url : 'prcsPlanDeList',
				method : 'GET',
				data : { prcsPlanCode : planCode },
				success : function(data){
					planDeGrid.resetData(data);
	 		    },
				error : function(reject){
		 			console.log(reject);
		 		}	
			})
		}
  	});
	

	

	
    </script>
</body>
</html>