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
					<form>
						<div id="customtemplateSearchAndButton">		
							<p>계획일자</p>
                  			<input id="startDate" type="date">&nbsp;&nbsp;-&nbsp;&nbsp;<input id="endDate" type="date">
							<br>
							
							<p>계획명</p>
							<input type="text" placeholder="검색어를 입력하세요" id ="searchPlanName" name="searchPlanName">
							
							<br>
							<button type="button" class="btn btn-info btn-icon-text" id="searchBtn">
								<i class="fas fa-search"></i>검색
							</button>
							<button type="reset" class="btn btn-info btn-icon-text" id="resetBtn">초기화</button>
		            	</div>
	            	</form>		
				</div>
				
				<p>생산 계획</p>
            	<div>
            		<button id="orderModal" class="btn btn-info btn-icon-text">주문서조회</button>
            		<button id="save" class="btn btn-info btn-icon-text">저장</button>
            		<button id="remove" class="btn btn-info btn-icon-text">삭제</button>
            	</div>
           		<div id="planGrid"></div>
           		
            	<p>상세 생산 계획</p>
            	<div>
            		<button id="deAdd" class="btn btn-info btn-icon-text">행추가</button>
            	</div>
           		<div id="planDeGrid"></div>
           		<div id="prcsGrid"></div>
	   		</div>
		</div>
	</div> 
	
	<div>
		<jsp:include page="../comFn/dateFormat.jsp"></jsp:include>
		<jsp:include page="../comFn/orderModal.jsp"></jsp:include>
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
	
	
	//검색 -> 상세생산계획에 주문서 조회 적용 후에는 생산계획 그리드 클릭 적용안되게 할 변수
	//상세계획 클릭시 'Y' / 주문서조회 -> 상세계획 클릭시 'N'
	var gridClick = null;
	
	//검색 -> 조건별 생산계획 조회
	function searchPlanList(){
		let planName = $('#searchPlanName').val();
		let sd = $('#startDate').val();
		let ed = $('#endDate').val();	 

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


	//저장 - 등록, 수정, 삭제 전부 가능
    function saveServer() {	
		//편집종료
//     	planGrid.blur();
//     	planDeGrid.blur();
//     	Remove focus from the focused cell.
//     	Save editing value and finishes to edit.
    	//생산계획 편집종료
		let rowKey = planGrid.getFocusedCell().rowKey;
		let columnName = planGrid.getFocusedCell().columnName;
		planGrid.finishEditing(rowKey, columnName);
		
		//상세생산계획 편집종료
		let rowKeyDe = planDeGrid.getFocusedCell().rowKey;
		let columnNameDe = planDeGrid.getFocusedCell().columnName;
		planDeGrid.finishEditing(rowKeyDe, columnNameDe);
    	
    	//그리드 createdRows, updatedRows, deletedRows 전부 가져오기
		let gridInfo = planGrid.getModifiedRows();
    	let deGridInfo = planDeGrid.getModifiedRows();
		
    	console.log(gridInfo);
    	console.log(deGridInfo);
		
		
    	
    	
    	
      	//let rowKey = planGrid.getFocusedCell();
    	let codeValue = planGrid.getValue(rowKey, 'prcsPlanCode');	
		if(codeValue == null){
			//insert
			planInsert();	
			
// 		} else{
// 			//update
			
// 			//alert 표시를 위한 변수
// 			let updateOk = false;
// 			let updateDeOk = false;
			
// 			planUpdate();
// 			planDeUpdate();
			
// 			if(updateOk == true && updateDeOk == true){
// 				alert('수정완료');
// 			}
		}
		
		
		
		//저장버튼 눌렀을때 그리드에 데이터가 비어있는지 확인할 변수
		let flag = true; 
		
		//update시 데이터 없는 경우 경고창 중복 방지할 변수
		let noDataAlert = false;
		
		//insert, update, delete 전부 가져오기
		$.each(gridInfo, function(field, array){				
// 			if(field == 'createdRows' && array.length != 0){				
// 				//insert
// 				$.each(array, function(i, obj){
// 					for(let field in obj){
// 						//console.log(field+'-'+obj[field]);
// 						if(obj[field] == null){
// 							flag = false;
// 						}
// 					}
// 				})

// 				$.each(deGridInfo, function(deField, deArray){					
// 					if(deField == 'createdRows' && deArray.length != 0){
// 						$.each(deArray, function(i, obj2){
// 							for(let field in obj2){
// 								//console.log('2'+field+'-'+obj2[field]);
// 								if(field != 'prcsPrio' && obj2[field] == null){
// 									flag = false;
// 								}
// 							}
// 						})
// 					}
// 				})
	
// 				if(flag){	
// 					planInsert();
// 				} else {
// 					alert('추가할 값이 입력되지 않았습니다.');
// 				}
				
// 			} else if(field == 'updatedRows' && array.length != 0){
			if(field == 'updatedRows' && array.length != 0){
				//update(planGrid)	
				$.each(array, function(i, obj){
					for(let field in obj){
						if(field == 'prcsPlanName' && obj['prcsPlanName'] == ''){
							flag = false;
							console.log('계획명:' + flag);
						} else if(field == 'empCode' && obj['empCode'] == ''){
							flag = false;
							console.log('담당자:' + flag);
						} else if(field == 'prcsStartDate' && obj['prcsStartDate'] == ''){
							flag = false;
							console.log('시작:' + flag);
						} else if(field == 'prcsEndDate' && obj['prcsEndDate'] == ''){
							flag = false;
							console.log('종료:' + flag);
						}
					}
				})

				if(flag){	
					planUpdate();
				} else {
					if(noDataAlert == false){
						alert('수정할 값이 입력되지 않았습니다.');
						noDataAlert = true;
					}
				}
				
			} else if(field == 'deletedRows' && array.length != 0){
				//delete
				let planCodeList = [];			
				$.each(array, function(i, obj){
					let planCode = array[i]['prcsPlanCode'];
					planCodeList.push(planCode);
				})
				console.log(planCodeList);
				
				$.ajax({
					url : 'prcsPlanDelete',
					method : 'POST',
					data : JSON.stringify(planCodeList),
					contentType : 'application/json',
					success : function(data){	
						//상세생산계획 그리드 지우기
						planDeGrid.clear();
						alert(data + "건 삭제가 완료되었습니다.");
					},
					error : function(reject){
			 			console.log(reject);
			 		}		
				})					
			}	
		})
		
		$.each(deGridInfo, function(deField, deArray){
			//update(planDeGrid)
			if(codeValue != null && deField == 'updatedRows' && deArray.length != 0){
				$.each(deArray, function(i, obj2){
					for(let field in obj2){
						if(field == 'prodCode' && obj2['prodCode'] == ''){
							flag = false;
							console.log('제품코드:' + flag);
						} else if(field == 'prcsRqAmt' && obj2['prcsRqAmt'] == ''){
							flag = false;
							console.log('주문수량:' + flag);
						} else if(field == 'prcsPlanAmt' && obj2['prcsPlanAmt'] == ''){
							flag = false;
							console.log('생산계획량:' + flag);
						}
					}
				})
				
				if(flag){	
					planDeUpdate();
				} else {
					//update에서 경고창이 떴다면 다시 뜨지 않게 조건 걸기 
					if (noDataAlert == false){		
						alert('수정할 값이 입력되지 않았습니다.');
						flag = false;
					}
				}
			}			
		})
		

  

	};

	//insert ajax
// 	function planInsert(){
// 		//생산계획 편집종료
// // 		let rowKey = planGrid.getFocusedCell().rowKey;
// // 		let columnName = planGrid.getFocusedCell().columnName;
// // 		planGrid.finishEditing(rowKey, columnName);
		
// 		let list = planGrid.getData();
// 		let object = list[0];
		
// 		$.ajax({
// 			url : 'prcsPlanInsert',
// 			method : 'POST',
// 			data : JSON.stringify(object),
// 			contentType : 'application/json',
// 			success : function(data){									
// 				//상세생산계획 편집종료
// // 				let rowKeyDe = planDeGrid.getFocusedCell().rowKey;
// // 				let columnNameDe = planDeGrid.getFocusedCell().columnName;
// // 				planDeGrid.finishEditing(rowKeyDe, columnNameDe);
				
// 				let deList = planDeGrid.getData();
// 				$.each(deList, function(i, objDe){
// 					deList[i]['prcsPlanCode'] = data;
			
// 				})
				
// 				$.ajax({
// 					url : 'prcsPlanDeInsert',
// 					method : 'POST',
// 					data : JSON.stringify(deList),
// 					contentType : 'application/json',
// 					success : function(data){
// 						//등록 후 그리드 내용 지우고, 행추가
// // 						planGrid.clear();
// // 						planGrid.appendRow();
// 						planDeGrid.clear();
// 						planDeGrid.appendRow();
						
// 						//주문서 테이블에 계획코드, 계획상태 update하기-> prcsPlanDeInsert controller에서 하면 될듯

// 						alert('등록이 완료되었습니다.');

// 					},
// 					error : function(reject){
// 			 			console.log(reject);
// 			 		}
// 				})				
// 			},
// 			error : function(reject){
// 	 			console.log(reject);
// 	 		}		
// 		})
		
// 	}

	
	
	
	
	function planInsert(){
		//저장버튼 눌렀을때 그리드에 데이터가 비어있는지 확인할 변수
		let inFlag = true; 
		let inFlagDe = true;
		
		let list = planGrid.getData();
		let object = list[0];
		
		//빈 데이터 있는지 체크
		$.each(list, function(i, obj){
			for(let field in obj){
				//console.log(field+'-'+obj[field]);
				if(field != 'prcsPlanCode' && obj[field] == null){
					inFlag = false;
				}
			}
		})

		if(inFlag){			
			$.ajax({
				url : 'prcsPlanInsert',
				method : 'POST',
				data : JSON.stringify(object),
				contentType : 'application/json',
				async : false, 
				success : function(data){									
					
					let deList = planDeGrid.getData();
					console.log(deList)
					$.each(deList, function(i, objDe){
						deList[i]['prcsPlanCode'] = data;
						//prcsPlanVO에 ordCode 추가
						
						//빈 데이터 있는지 체크
						for(let field in objDe){
							//console.log(field+'-'+objDe[field]);
							if(field != 'prcsPrio' && objDe[field] == null){
								inFlagDe = false;
							}
						}		
					})

					$.ajax({
						url : 'prcsPlanDeInsert',
						method : 'POST',
						data : JSON.stringify(deList),
						contentType : 'application/json',
						async : false, 
						success : function(data){
							//등록 후 그리드 내용 지우고, 행추가
	 						planGrid.clear();
	 						planGrid.appendRow();
							planDeGrid.clear()
							planDeGrid.appendRow();

							alert('등록이 완료되었습니다.');
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
		} else {
			alert('추가할 값이 입력되지 않았습니다.');
		}
	}
	

	
	
	//update(planGrid) ajax
	function planUpdate(){		
		//alert 표시를 위한 변수
		let updateOk = 0;
		
		//생산계획 update
		let list = planGrid.getData();

		$.ajax({
			url : 'prcsPlanUpdate',
			method : 'POST',
			data : JSON.stringify(list),
			contentType : 'application/json',
			async : false,  //data 모두 수신 후 변수 updateOk에 담기 위해 동기방식으로 처리
			success : function(data){	
				updateOk = updateOk + data;
				planDeGrid.clear();
				planDeGrid.appendRow();
			},
			error : function(reject){
	 			console.log(reject);
	 		}		
		})

		if(updateOk > 0){
			alert('ff :수정이 완료되었습니다.');
		}		
	}
	 
	
	//수정(planDeGrid) ajax
	function planDeUpdate(){
		//alert 표시를 위한 변수
		let updateOk = 0;
			
		//상세생산계획 update
		let deList = planDeGrid.getData();
	
		$.ajax({
			url : 'prcsPlanDeUpdate',
			method : 'POST',
			data : JSON.stringify(deList),
			contentType : 'application/json',
			async : false,
			success : function(data){
				updateOk = updateOk + data;
				planDeGrid.clear();
				planDeGrid.appendRow();
			},
			error : function(reject){
	 			console.log(reject);
	 		}			
		})
				
		if(updateOk > 0){
			alert('수정이 완료되었습니다.');
		}
	}
	
	
	
	//삭제
	function removeRow(){
		let message = confirm("정말 삭제하시겠습니까?");
		if(message) {		
			planGrid.removeCheckedRows(false);
		}
	}
	
	
	
	//삭제
// 	function removeRow(){
// 		let message = confirm("정말 삭제하시겠습니까?");
// 		if(message) {		
// 			//생산계획 -> delete (상세생산계획은 CASCADE로 삭제)
			
// 			//체크한 행들의 prcsPlanCode가 담긴 list 만들기
// 			let checkList = planGrid.getCheckedRows();
// 			let planCodeList = [];			
// 			$.each(checkList, function(i, obj){
// 				//let planCodeObj = {};
// 				//planCodeObj['prcsPlanCode'] = checkList[i]['prcsPlanCode'];
// 				planCode = checkList[i]['prcsPlanCode'];
// 				planCodeList.push(planCode);
// 				//planCodeList.push(planCodeObj);
// 			})
			
// 			$.ajax({
// 				url : 'prcsPlanDelete',
// 				method : 'POST',
// 				data : JSON.stringify(planCodeList),
// 				contentType : 'application/json',
// 				success : function(data){	
// 					//체크된 행 부분 삭제, 상세생산계획 그리드 지우기
// 					planGrid.removeCheckedRows(false);
// 					planDeGrid.clear();
// 					alert(data + "건 삭제하였습니다")
// 				},
// 				error : function(reject){
// 		 			console.log(reject);
// 		 		}		
// 			})	
// 		} 
// 	}
	

	
	//페이지 호출시 생산계획 등록하는 행 자동 생성
	window.onload = function addRow(){
		planGrid.appendRow();
		planDeGrid.appendRow();
	} 

	//행추가 버튼 클릭시 상세생산계획 행 추가
	function addDeRow(){
		planDeGrid.appendRow();
	}
		
	//생산계획 grid
    var planGrid = new tui.Grid({
        el: document.getElementById('planGrid'),
        scrollX: false,
        scrollY: false,
        minBodyHeight: 30,
        rowHeaders: ['rowNum', 'checkbox'],
        	pagination: true,
        	pageOptions: {
    			useClient: true,
    			perPage: 5,
    		},
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
//           {
//             header: '계획일자',
//             name: 'prcsPlanDate',
//             hidden:  true
//           },
          {
            header: '담당자',
            name: 'empCode',
            editor: 'text'
          },
//           {
// 			header: '생산지시여부',
//             name: 'prcsDirYn',
//             hidden: true
//           },
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
		pagination: true,
		pageOptions: {
			useClient: true,
			perPage: 5,
		},
		columns: [
			{
				header: '상세계획코드',
				name: 'prcsPlanDeCode',
				hidden: true
			},
			{
				header: '주문코드',
				name: 'ordCode',
				hidden: true
			},
			{
				header: '제품명',
				name: 'prodCode',
			},
// 			{
// 				header: '제품명',
// 				name: 'prodName',
// 				editor: 'text'
// 			},
			{
				header: '주문수량',
				name: 'prcsRqAmt',
				editor: 'text'
			},
			{
				header: '생산계획량',
				name: 'prcsPlanAmt',
				editor: 'text',
				formatter: function(value){
					//탈락량을 고려하여 주문수량의 10%를 더하여 생산계획량을 자동계산해서 기입. 수정 가능.
					const rowData = value.row;
                   	const prcsRqAmt = rowData.prcsRqAmt;
                   	value = Math.round(prcsRqAmt * 1.1);
					return value;
				}
			},
			{
				header: '우선순위',
				name: 'prcsPrio',
				editor: 'text'
			},
// 			{
// 				header: '지시수량',
// 				name: 'prcsDirAmt',
// 				hidden: true
// 			},
//      		{
// 				header: '지시상태',
// 				name: 'prcsDirSts',
// 				hidden: true
// 			},
// 			{
// 				header: '생산량',
// 				name: 'prcsAmt',
// 				hidden: true
//      		}
		]
	});
	
	
	

	//생산 계획 클릭시 해당 계획의 상세생산계획 조회
	planGrid.on('click', () => {
		
		//조건별 검색을 통한 조회일때 사용 (주문서 조회 적용시 -> 생산계획 그리드 클릭시 사용 안돼야함)
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