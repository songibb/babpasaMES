<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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

<style type="text/css">
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
</style>

</head>
<body>
	<div class="black_bg"></div>
	<h2>생산 계획 관리</h2>
	<div class="col-lg-12 stretch-card">
		<div class="card">
			<div class="card-body">				
				<div style="display: flex; justify-content: space-between;">
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
	            	<div>
	            		<button id="orderModal" class="btn btn-info btn-icon-text">미계획 주문서 가져오기</button>
	            	</div>	
            	</div>

				
				<div id="planContainer">
					<div id="leftGrid">
						<div id="leftGridHeader">
							<span>생산 계획</span>	
							<div>
								<button id="remove" class="btn btn-info btn-icon-text">삭제</button>
								<button id="save" class="btn btn-info btn-icon-text">저장</button>		            		
							</div>
						</div>
							            	
		           		<div id="planGrid"></div>					
					</div>
					<div id="rightGrid">
						<div id="rightGridHeader">
							<span>상세 생산 계획</span>
							
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
	//저장
	document.getElementById('save').addEventListener('click', saveServer);
	//삭제
	document.getElementById('remove').addEventListener('click', removeData);
	
	
	
	//검색 -> 상세생산계획에 주문서 조회 적용 후에는 생산계획 그리드 클릭 적용안되게 할 변수
	//상세계획 클릭시 'Y' / 주문서조회 -> 상세계획 클릭시 'N'
	var gridClick = null;
	
	searchPlanList();
	
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

		if(!planGrid.isModified() && !planDeGrid.isModified()){
			swal("변경사항이 없습니다.", "", "warning");
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

		let list = planGrid.getData();
		let object = list[0];	
		//빈 데이터 있는지 체크
		$.each(list, function(i, obj){
			for(let field in obj){
				console.log(field+'-'+obj[field]);
				if(field != 'prcsPlanCode' && field != 'prcsDirYn' && obj[field] == null){
					flag = false;
				}
			}
		})


		let deList = planDeGrid.getData();
		//빈 데이터 있는지 체크
		$.each(deList, function(i, objDe){
			for(let field in objDe){
				console.log(field+'-'+objDe[field]);			
				if(objDe['prodCode'] == null || objDe['prcsRqAmt'] == null || objDe['prcsPlanAmt'] == null || objDe['ordCode'] == null){
					flag = false;
				}
			}					
		})		

		let planInsertList = { prcsPlanVO: object, insertList: deList };
		
		if(flag){			
			$.ajax({
				url : 'prcsPlanInsert',
				method : 'POST',
				data : JSON.stringify(planInsertList),
				contentType : 'application/json',
				async : false, 
				success : function(data){									
					searchPlanList();
					swal("등록이 완료되었습니다.", "", "success");
			
				},
				error : function(reject){
		 			console.log(reject);
		 		}		
			})
		} else {
			swal("모든 값이 입력되지 않았습니다.", "", "warning");
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
			swal("모든 값이 입력되지 않았습니다.", "", "warning");
		}
		
	
	}
	 

	//삭제
	function removeData(){
		let message = confirm("정말 삭제하시겠습니까?");
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
		} 
	}
	


	
	//페이지 호출시 생산계획 등록하는 행 자동 생성
// 	window.onload = function addRow(){
// 		planGrid.appendRow({'empCode' : ${user.id}, 'empName' : `${user.empName}`});
// 		planDeGrid.appendRow();
// 	} 

	//행추가 버튼 클릭시 상세생산계획 행 추가
// 	function addDeRow(){
// 		planDeGrid.appendRow();
// 	}
	
	//행삭제
// 	function removeRow(){
// 		let message = confirm("정말 삭제하시겠습니까?");
// 		if(message) {		
// 			planGrid.removeCheckedRows(false);
// 		}
// 	}
		
	
	
	
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
            header: '담당자코드',
            name: 'empCode',
            hidden: true
          },
          {
            header: '담당자',
            name: 'empName',
            editor: 'text'
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
				header: '제품코드',
				name: 'prodCode',
				hidden:true
			},
			{
				header: '제품명',
				name: 'prodName',
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
	

    </script>
    
	
</body>
</html>