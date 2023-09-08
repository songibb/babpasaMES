<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>생산 계획 관리</title>

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

<style type="text/css">

#btnContainer{ 
	display: flex; 
 	justify-content: space-between; 
} 
#planContainer{ 
 	display: flex; 
 	justify-content: space-between; 
} 
#leftGrid{ 
	width: 800px; 
	margin-right: 20px; 
} 
#leftGridHeader{ 
 	height: 45px; 
 	display: flex; 
 	justify-content: space-between; 
} 
#rightGrid{ 
	width: 800px; 
} 
#rightGridHeader{ 
 	height: 45px; 
 	display: flex; 
 	justify-content: space-between; 
} 

.yellow-background {
	background-color: rgb(255,253,235);
}
input[type="text"] { 
	width: 15%; 
	padding: 6px; 
	margin-bottom: 15px; 
	border: 1px solid #ccc; 
	border-radius: 4px; 
} 
input[type="date"] { 
	width: 150px; 
	padding: 5px; 
	margin-bottom: 35px; 
	border: 1px solid #ccc; 
	border-radius: 4px; 
} 
.table-responsive p{ 
 	width: 80px; 
 	display: inline-block; 
 	font-size: 20px; 
} 
h1{ 
 	margin-left: 15px; 
} 
h1, h2{ 
 	font-weight: 800; 
 } 
 
.selected-cell{
	background-color: #ffd09e;
}

td[data-column-name="prcsPlanName"], 
td[data-column-name="prcsStartDate"], 
td[data-column-name="prcsEndDate"],
td[data-column-name="prcsPlanAmt"],
td[data-column-name="prcsPrio"]{
	cursor : pointer;
}

.btn-icon-text2 {
    margin: -5px;
    width : 70px;
    border-radius: 0;
    height: 33px;
    line-height: 20px;
}
.btn-info2 {
    color: black;
    background-color: white;
    border-color: #ccc;
    
}
#todayBtn {
	margin-left: 2px !important;
	border-radius: 5px 0 0 5px;
	border : 1px solid #ccc;
}
#todayBtn:hover{
	background-color : #f4f4f4;
	border : 1px solid #868e96;
	color: black;
}
#weekBtn:hover{
	background-color : #f4f4f4;
	border : 1px solid #868e96;
	color: black;
}
#monthBtn{
	border-radius: 0 5px 5px 0;
	border : 1px solid #ccc;
}
#monthBtn:hover{
	background-color : #f4f4f4;
	border : 1px solid #868e96;
	color: black;
}
#searchBtn{
	margin-left: 10px;
}

</style>

</head>
<body>
	<div class="black_bg"></div>
	<h1>생산 계획 관리</h1>
	<div class="col-lg-12 stretch-card">
		<div class="card">
			<div class="card-body">				
				<div class="table-responsive pt-3">
							
					<p>계획명</p>
					<input type="text" placeholder="검색어를 입력하세요" id ="searchPlanName" name="searchPlanName">
					<br>	   	
	            	
	            	<div id="btnContainer">
	            		<div style="width: 900px;">
							<p>계획일자</p>
	                 		<input id="startDate" type="date">&nbsp;&nbsp;-&nbsp;&nbsp;<input id="endDate" type="date">
	                 		
	                 		<button type="button" class="btn btn-info btn-icon-text btn-info2 btn-icon-text2" id="todayBtn">오늘</button>
							<button type="button" class="btn btn-info btn-icon-text btn-info2 btn-icon-text2" id="weekBtn">일주일</button>
							<button type="button" class="btn btn-info btn-icon-text btn-info2 btn-icon-text2" id="monthBtn">한달</button>
							<button type="button" class="btn btn-info btn-icon-text" id="searchBtn">
								<i class="fas fa-search"></i>검색
							</button>
							<button type="reset" class="btn btn-info btn-icon-text" id="resetBtn">초기화</button>
		            	</div>
		            	<div>
	            			<button id="orderModal" class="btn btn-info btn-icon-text">미계획 주문서 가져오기</button>
	            		</div>	
	            	</div>     	
	            	
            	</div>

				
				<div id="planContainer">
					<div id="leftGrid">
						<div id="leftGridHeader">
							<h2>생산 계획</h2>	
							<div>
								<button id="remove" class="btn btn-info btn-icon-text">삭제</button>
								<button id="save" class="btn btn-info btn-icon-text">저장</button>		            		
							</div>
						</div>
							            	
		           		<div id="planGrid"></div>					
					</div>
					<div id="rightGrid">
						<div id="rightGridHeader">
							<h2>상세 생산 계획</h2>			
						</div>		
	           			<div id="planDeGrid"></div>
					</div>
				</div>
				
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
	//오늘
	document.getElementById('todayBtn').addEventListener('click', todayInput);
	//일주일
	document.getElementById('weekBtn').addEventListener('click', weekInput);
	//한달
	document.getElementById('monthBtn').addEventListener('click', monthInput);
	
	//저장
	document.getElementById('save').addEventListener('click', saveServer);
	//삭제
	document.getElementById('remove').addEventListener('click', removeData);
	
	//오늘 버튼 클릭시 input태그에 오늘 날짜 입력
	function todayInput(){
		$('#startDate').val(getToday());
		$('#endDate').val(getToday());;
	}
	
	//일주일 버튼 클릭시 input태그에 일주일전~오늘 날짜 입력
	function weekInput(){
		$('#startDate').val(getWeek());
		$('#endDate').val(getToday());;
	}
	
	//한달 버튼 클릭시 input태그에 한달전~오늘 날짜 입력
	function monthInput(){
		$('#startDate').val(getMonth());
		$('#endDate').val(getToday());;
	}
	
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
				stopEdit();
				
				//삭제버튼 다시 생기게하기
				remove.style.display = 'inline-block';
				
				gridClick = 'Y';
			},
			error : function(reject){
			 	console.log(reject);
			}
		});
	}
	


	//저장 - 등록, 수정 가능
    function saveServer() {	
		
    	//생산계획 편집종료
 		let rowKey = planGrid.getFocusedCell().rowKey;
		let columnName = planGrid.getFocusedCell().columnName;
		planGrid.finishEditing(rowKey, columnName);
		
		//상세생산계획 편집종료
		let rowKeyDe = planDeGrid.getFocusedCell().rowKey;
		let columnNameDe = planDeGrid.getFocusedCell().columnName;
		planDeGrid.finishEditing(rowKeyDe, columnNameDe);

		
		//변경사항 없을 시 경고창
		if(!planGrid.isModified() && !planDeGrid.isModified()){
			swal("경고", "변경사항이 없습니다.", "warning");
			return false;
		}

    	let codeValue = planGrid.getValue(rowKey, 'prcsPlanCode');	
		if(codeValue == null){
			//insert
			planInsert();		
		} else{
			//update
			planUpdate();		
		}
		
	}	

	//등록
	function planInsert(){
		//저장버튼 눌렀을때 그리드에 데이터가 비어있는지 확인할 변수
		let flag = true; 

		//생산계획 데이터 가져오기
		let list = planGrid.getData();
		let object = list[0];	
		//빈 데이터 있는지 체크
		$.each(list, function(i, obj){
			for(let field in obj){
				//console.log(field+'-'+obj[field]);
				if(obj['prcsPlanName'] == null || obj['empCode'] == null || obj['prcsStartDate'] == null || obj['prcsEndDate'] == null){
					flag = false;
				}
			}
		})


		//상세생산계획 데이터 가져오기
		let deList = planDeGrid.getData();
		//빈 데이터 있는지 체크
		$.each(deList, function(i, objDe){
			for(let field in objDe){
				//console.log(field+'-'+objDe[field]);			
				if(objDe['prodCode'] == null || objDe['prcsRqAmt'] == null || objDe['prcsPlanAmt'] == null || objDe['ordCode'] == null){
					flag = false;
				}
			}					
		})		

		let planInsertList = { prcsPlanVO : object, insertList : deList };
		
		if(flag){		
			//주문수량과 생산계획량 비교 -> 생산계획량이 주문수량보다 적을시 경고창
			let list = planDeGrid.getData();
			let amtCk = true;
			$.each(list, function(i, obj){
				for(let field in obj){
					if(obj['prcsRqAmt'] > obj['prcsPlanAmt']){
						amtCk = false;
					}
				}
			})
			if(amtCk == false){
				swal("경고", "생산계획량이 주문수량보다 적습니다.", "warning");
				return false;
			} else{
				$.ajax({
					url : 'prcsPlanInsert',
					method : 'POST',
					data : JSON.stringify(planInsertList),
					contentType : 'application/json',
					async : false, 
					success : function(data){									
						searchPlanList();
						swal("성공", "등록이 완료되었습니다.", "success");
				
					},
					error : function(reject){
			 			console.log(reject);
			 		}		
				})
			}
		} else {
			swal("경고", "모든 값이 입력되지 않았습니다.", "warning");
		}
	}
	

	//수정
	function planUpdate(){		
		//저장버튼 눌렀을때 그리드에 데이터가 비어있는지 확인할 변수
		let flag = true; 
	
		let list = planGrid.getData();
		//빈 데이터 있는지 체크
		$.each(list, function(i, obj){
			for(let field in obj){
				//console.log(field+'-'+obj[field]);
				if(obj['prcsPlanName'] == null || obj['empCode'] == null || obj['prcsStartDate'] == null || obj['prcsEndDate'] == null){
					flag = false;
				}
			}
		})

		let deList = planDeGrid.getData();
		//빈 데이터 있는지 체크
		$.each(deList, function(i, objDe){
			for(let field in objDe){
				//console.log(field+'-'+objDe[field]);			
				if(objDe['prodCode'] == null || objDe['prcsRqAmt'] == null || objDe['prcsPlanAmt'] == null){
					flag = false;
				}
			}					
		})			
		
		let planUpdateList = { updateList: list, updateDeList: deList };		
		
		if(flag){
			//주문수량과 생산계획량 비교 -> 생산계획량이 주문수량보다 적을시 경고창
			let list = planDeGrid.getData();
			
			//지시수량이 올바르게 들어갔는지 확인할 변수
			let amtCk = true;
			$.each(list, function(i, obj){
				for(let field in obj){
					if(obj['prcsRqAmt'] > obj['prcsPlanAmt']){
						amtCk = false;
					}
				}
			})
			if(amtCk == false){
				swal("경고", "생산계획량이 주문수량보다 적습니다", "warning");
				return false;
			} 
			
			$.ajax({
				url : 'prcsPlanUpdate',
				method : 'POST',
				data : JSON.stringify(planUpdateList),
				contentType : 'application/json',
				success : function(data){	
					searchPlanList();
					swal("수정이 완료되었습니다.", "", "success");
			
				},
				error : function(reject){
		 			console.log(reject);
		 		}		
			})
		} else{
			swal("경고", "모든 값이 입력되지 않았습니다.", "warning");
		}
		
	
	}
	 

	//삭제
	function removeData(){

		swal({
			title: "정말 삭제하시겠습니까?",
			text: "",
			icon: "warning",
			buttons: true,
			dangerMode: true,
		})
		.then((message) => {
			if(message) {		
				//생산계획 -> delete (상세생산계획은 CASCADE로 삭제)
				
				//체크한 행들의 prcsPlanCode와 ordCode가 담긴 list 만들기
				let checkList = planGrid.getCheckedRows();
	
				let planCodeList = [];			
				$.each(checkList, function(i, obj){
					planCode = checkList[i]['prcsPlanCode'];
					planCodeList.push(planCode);
				})
				
				$.ajax({
					url : 'prcsPlanDelete',
					method : 'POST',
					data : JSON.stringify(planCodeList),
					contentType : 'application/json',
					success : function(data){	
						//체크된 행 부분 삭제
						planGrid.removeCheckedRows(false);
						//planDeGrid.clear();
						searchPlanList();
						swal(" 삭제가 완료되었습니다.", "", "success");
					},
					error : function(reject){
			 			console.log(reject);
			 		}		
				})	
			} else{
				swal("삭제가 취소되었습니다.", "", {icon: "warning"});
			}
		})
	}
	


	
	//생산계획 grid
    var planGrid = new tui.Grid({
        el: document.getElementById('planGrid'),
        scrollX: false,
        scrollY: false,
        minBodyHeight: 320,
        rowHeaders: ['rowNum', 'checkbox'],
       	pagination: true,
       	pageOptions: {
   			useClient: true,
   			perPage: 8,
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
          {
            header: '계획일자',
            name: 'prcsPlanDate'
          },
		  {
            header: '담당자코드',
            name: 'empCode',
            hidden: true
          },
          {
            header: '담당자',
            name: 'empName',
            editor: 'text',
            align: 'center'
          },
          {
			header: '생산지시여부',
            name: 'prcsDirYn',
            hidden: true
          },
          {
            header: '예상생산시작일',
            name: 'prcsStartDate',
            editor: {
  		      type: 'datePicker',
  		      options: {
  		    	  language: 'ko',
  		    	  selectableRanges: [[new Date(), new Date(2099,1,1)]]
  		      }
  		    },
  		  	className: 'yellow-background'
          },
          {
            header: '예상생산종료일',
            name: 'prcsEndDate',
            editor: {
  		      type: 'datePicker',
  		      options: {
  		    	  language: 'ko',
				  selectableRanges: [[new Date(), new Date(2099,1,1)]]
  		      }
  		    },
  		  	className: 'yellow-background'
          }
          
        ]
	});
	
	
	
	//상세생산계획 grid
	var planDeGrid = new tui.Grid({
		el: document.getElementById('planDeGrid'),
		scrollX: false,
		scrollY: false,
		minBodyHeight: 320,
		rowHeaders: ['rowNum'],
		pagination: true,
		pageOptions: {
			useClient: true,
			perPage: 8,
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
				header: '제품코드',
				name: 'prodCode',
				hidden:true
			},
			{
				header: '제품명',
				name: 'prodName'
			},
			{
				header: '주문수량',
				name: 'prcsRqAmt',
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
				header: '생산계획량',
				name: 'prcsPlanAmt',
				editor: 'text',
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
				header: '우선순위',
				name: 'prcsPrio',
				formatter: 'listItemText',
				editor: {
					type: 'select',
					options: {
						listItems: [
	                    	<c:forEach items="${prcsPrio}" var="p">
	                    	 {
	                             text: '${p.commdeName}',
	                             value: '${p.commdeCode}'
	                           }, 
	    					</c:forEach>
	                    ]
					}		
				},
				align: 'center'
			},
// 			{
// 				header: '지시수량',
// 				name: 'prcsDirAmt',
// 				hidden: true
// 			},
     		{
				header: '지시상태',
				name: 'prcsDirSts',
				hidden: true
			},
// 			{
// 				header: '생산량',
// 				name: 'prcsAmt',
// 				hidden: true
//      		}
		]
	});
	
	//생산계획 조회(오늘 날짜)
	$.ajax({
		url : 'searchPlanList',
		method : 'GET',
		data : { startDate : getToday(), endDate : getToday() },
		success : function(data){	
			//오늘 날짜 input태그에 입력시켜놓기
			todayInput();
			
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
			stopEdit();
			
			//삭제버튼 다시 생기게하기
			remove.style.display = 'inline-block';
			
			gridClick = 'Y';
		},
		error : function(reject){
		 	console.log(reject);
		}
	});
	
	

	//생산 계획 클릭시 해당 계획의 상세생산계획 조회
	planGrid.on('click', () => {
		
		//선택한 행 색깔 바꾸기
		let selectKey = planGrid.getFocusedCell().rowKey;
    	planGrid.addRowClassName(selectKey, 'selected-cell');
		//다른 행 선택시 기존에 클릭했던 행은 class제거
    	planGrid.on('focusChange', () => {
    		planGrid.removeRowClassName(selectKey, 'selected-cell');
	    })
	    
	    //이벤트 걸린 행에 prcsPlanCode가 없는 경우 등록 모드이므로 행 색깔 바꾸기X
	    let prcsPlanCode = planGrid.getValue(selectKey, 'prcsPlanCode');
	    if (prcsPlanCode == null) {
	    	planGrid.removeRowClassName(selectKey, 'selected-cell');  
		}
		
		//조건별 검색을 통한 조회일때 사용 (주문서 조회 적용시 -> 생산계획 그리드 클릭시 사용 안돼야함)
		if(gridClick == 'Y'){
	    	//클릭한 계획의 계획코드 가져오기
	    	let rowKey = planGrid.getFocusedCell().rowKey;
	    	let planCode = planGrid.getValue(rowKey, 'prcsPlanCode');
			let getRow = planGrid.getRow(rowKey);
	    	$.ajax({
				url : 'prcsPlanDeList',
				method : 'GET',
				data : { prcsPlanCode : planCode },
				success : function(data){
				
					planDeGrid.resetData(data);
					
					//지시완료는 수정, 삭제 불가
					if(getRow['prcsDirYn'] == '지시완료'){		
						$.each(planDeGrid.getData(), function(idx, obj){
							planDeGrid.disableRow(obj['rowKey']);
						});
					} else{
						//분할지시 한 경우, 상세 생산 계획에서 지시완료 일때 수정 불가
						$.each(data, function(i, obj){
							if(data[i]['prcsDirSts'] == '지시완료'){
								planDeGrid.disableRow(obj['rowKey']);
							}
						})
					}
	 		    },
				error : function(reject){
		 			console.log(reject);
		 		}	
			})
		}
  	});
	
	
	//지시완료는 수정, 삭제 불가
	function stopEdit(){
		$.each(planGrid.getData(), function(idx, obj){
			if(obj['prcsDirYn'] == '지시완료'){	
				planGrid.disableRow(obj['rowKey']);
			} 
			
		})
	}
	
	//이전 날짜 선택불가
    $('#startDate').on('change', function() {
		$('#endDate').attr('min', $('#startDate').val());
    });
	//이후날짜 선택불가
    $('#endDate').on('change', function() {
		$('#startDate').attr('max', $('#endDate').val());
	});
	
	
	
	//수정중일때 저장하지 않고 페이지 나가면 경고창 출력
	$(document).ready(function(){ 
	    window.onbeforeunload = function(){
	        if(orderGrid.isModified()){
	        	doExit();
	        }
	    };
	});
	
	function doExit(){
	    event.returnValue = '"저장되지 않은 데이터가 있습니다."';
	}
	
    </script>
    
	
</body>
</html>