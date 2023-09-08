<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>생산 관리</title>

<!-- 토스트 페이지 네이션 -->
<script type="text/javascript" src="https://uicdn.toast.com/tui.code-snippet/latest/tui-code-snippet.js"></script>
<link rel="stylesheet" href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css" />
<script src="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.js"></script>
<!-- 페이지 네이션 끝 -->
<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>

<style type="text/css">
#customtemplateSearchAndButton{
	margin-bottom: 30px;
}
#dirContainer{
	display: flex;
	justify-content: space-between;
}
.leftGrid{
    width: 700px;
    margin-right: 20px;
}
.leftGridHeader{
	height: 45px;
	display: flex;
	justify-content: space-between;
}
.rightGrid{
    width: 900px;
}
.rightGridHeader{
	height: 45px;
	display: flex;
	justify-content: space-between;
}

.yellow-background {
	background-color: rgb(255,253,235);
}

input[type="date"] {
  width: 15%;
  padding: 5px;
  margin-bottom: 35px;
  border: 1px solid #ccc;
  border-radius: 4px;
}

form p{
	width: 125px;
	display: inline-block;
	font-size: 20px;
}

h1{
	margin-left: 15px;
}
h1, h2{
	font-weight: 800;
}

.my-styled-cell{
	background-color: rgb(255, 229, 229);
}
</style>
</head>
<body>
	<div class="black_bg"></div>
	<h1>생산 관리</h1>
	<div class="col-lg-12 stretch-card">
		<div class="card">
			<div class="card-body">
				<div class="table-responsive pt-3">	
					<form>
						<p>생산시작일자</p>
						<input type="date" id="startDate" name="startDate" value="">&nbsp;&nbsp;-&nbsp;&nbsp;<input type="date" id="endDate" name="endDate" value="">		
						
						<button type="button" class="btn btn-info btn-icon-text" id="todayBtn">오늘</button>
						<button type="button" class="btn btn-info btn-icon-text" id="weekBtn">일주일</button>
						<button type="button" class="btn btn-info btn-icon-text" id="searchBtn">
							<i class="fas fa-search"></i>검색
						</button>
						<button type="reset" class="btn btn-info btn-icon-text">초기화</button>
	            	</form>
	            </div>
	            	
	            <div>
	           		<div id="dirContainer">
						<div class="leftGrid">
							<div class="leftGridHeader">
				            	<h2>생산 지시</h2>	
							</div>
							<div id="dirGrid"></div>
						</div>
						
						<div class="rightGrid">
							<div class="rightGridHeader">
		           				<h2>상세 생산 지시</h2>
		           				<div>
		           					<button id="reDir" class="btn btn-info btn-icon-text">재지시</button>
		           				</div>
		      				</div>
		           			<div id="dirDeGrid"></div>
						</div>
					</div>
	           		
	           		<div id="ingGrid"></div>
				</div>
	   		</div>
		</div>
	</div> 
	
	
	
	<div>
		<jsp:include page="../comFn/dateFormat.jsp"></jsp:include>
	</div>
    
	<script>
	
	//검색
	document.getElementById('searchBtn').addEventListener('click', searchDirist);
	//오늘
	document.getElementById('todayBtn').addEventListener('click', todayInput);
	//일주일
	document.getElementById('weekBtn').addEventListener('click', weekInput);
	
	//재지시
	document.getElementById('reDir').addEventListener('click', reDirInsert);
	
	
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
	
	//검색 
	function searchDirist(){
		let searchObj = {};
		searchObj['startDate'] = $('#startDate').val();
		searchObj['endDate'] = $('#endDate').val();	   

		$.ajax({
			url : 'selectPrcsDirList',
			method : 'GET',
			data : searchObj,
			success : function(data){	
				//날짜 츨력 포맷 변경
				$.each(data, function(i, objDe){
					let psd = data[i]['prcsStartDate'];
					data[i]['prcsStartDate'] = getDate(psd);
				})
				dirGrid.resetData(data);
				dirDeGrid.clear();	
				ingGrid.clear();
				},
			error : function(reject){
				console.log(reject);
			}
		});
	};
	
	//재지시 등록 (품질검사부적합시 사용)
	function reDirInsert(){


// 		//체크한 행들에서 품질검사부적합이 있는지 체크할 변수
// 		let nonPassCk = 0;		
// 		$.each(checkList, function(i, obj){
// 			//담당자는 재지시 버튼 누르는 사람으로 바뀌어야하므로 다시 지정
// 			checkList[i]['empCode'] = ${user.id};

// 			//품질검사부적합이 있을 때마다 1씩 증가
// 			if(checkList[i]['prcsIngSts'] == '품질검사부적합'){
// 				nonPassCk++;
// 			}

// 		})
		
		
		let getRowKey = dirDeGrid.getFocusedCell().rowKey;
		let getPrcsIngSts = dirDeGrid.getValue(getRowKey, 'prcsIngSts');
		let getreDirCk = dirDeGrid.getValue(getRowKey, 'reDirCk');
		
		//상세생산지시에서 품질검사부적합인지 판단
		if(getPrcsIngSts == '품질검사부적합'){
			
			if(getreDirCk == 'Y'){		
				//벌써 재지시를 내린 경우
				swal("경고", "이미 재지시 등록한 사항입니다.", "warning");
				
			} else{
				let getIngData = ingGrid.getData();
				$.each(getIngData, function(i, obj){
					
					if(obj['prcsDirIngSts'] == '품질검사부적합'){

						if(obj['semiYn'] == 'Y'){
							
							//반제품 품질검사부적합
							//var prcsCode = obj['prcsCode'];
							
							let dirDeObj = dirDeGrid.getRow(getRowKey);

							$.ajax({
								url : 'insertReDirDeSemi',
								method : 'POST',
								data : JSON.stringify(dirDeObj),
								contentType : 'application/json',
								success : function(data){
									console.log(data);
									swal("성공", "등록이 완료되었습니다.", "success");
									
									//클릭한 지시의 지시코드 가져오기
							    	let rowKey = dirGrid.getFocusedCell().rowKey;
							    	let dirCode = dirGrid.getValue(rowKey, 'prcsDirCode');
		
							    	$.ajax({
										url : 'prcsDirDeList',
										method : 'GET',
										data : { prcsDirCode : dirCode },
										success : function(data){
											//날짜 츨력 포맷 변경
											$.each(data, function(i, objDe){
												let psdd = data[i]['prcsStartDeDate'];
												let pedd = data[i]['prcsEndDeDate'];
												data[i]['prcsStartDeDate'] = getDate(psdd);
												data[i]['prcsEndDeDate'] = getDate(pedd);
											})
											
											dirDeGrid.resetData(data);
											
											//재지시 완료된 행은 사용불가
											//dirDeGrid.disableRow(dirDeObj['rowKey']);
											//공정완료된 반제품 회색처리
											//재지시 완료된 행들은 사용불가
											$.each(data, function(i, obj){
												if(data[i]['reDirCk'] == 'Y'){		
													dirDeGrid.disableRow(obj['rowKey']);
												}
											});	
											
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
							
						} else{
							//완제품 품질검사부적합
							//체크박스에 체크된 것 한번에 재지시하려고 list형태를 생각했으나, 반제품 품질검사부적합때문에 일단 선택한 행 하나씩 하는 걸로 변경
							let dirDeObj = dirDeGrid.getRow(getRowKey);
							let checkList = [];
							checkList.push(dirDeObj);
							$.ajax({
								url : 'insertReDirDe',
								method : 'POST',
								data : JSON.stringify(checkList),
								contentType : 'application/json',
								success : function(data){	
									swal("성공", "등록이 완료되었습니다.", "success");
									
									//클릭한 지시의 지시코드 가져오기
							    	let rowKey = dirGrid.getFocusedCell().rowKey;
							    	let dirCode = dirGrid.getValue(rowKey, 'prcsDirCode');
		
							    	$.ajax({
										url : 'prcsDirDeList',
										method : 'GET',
										data : { prcsDirCode : dirCode },
										success : function(data){
											//날짜 츨력 포맷 변경
											$.each(data, function(i, objDe){
												let psdd = data[i]['prcsStartDeDate'];
												let pedd = data[i]['prcsEndDeDate'];
												data[i]['prcsStartDeDate'] = getDate(psdd);
												data[i]['prcsEndDeDate'] = getDate(pedd);
											})
											
											dirDeGrid.resetData(data);
											
											//재지시 완료된 행들은 사용불가
											$.each(checkList, function(idx, obj){
												dirDeGrid.disableRow(obj['rowKey']);
											});
											
							 		    },
										error : function(reject){
								 			console.log(reject);
								 		}	
									})
								
								},
								error : function(reject){
									console.log(reject);
								}
							});
						}
					} 
				})

			}
			
			
		} else{
			//선택한 행이 품질검사부적합이 아닐 경우 경고창
			swal("경고", "재지시 등록 사항이 아닙니다.", "warning");
		}
		

// 		if(nonPassCk == 0){
// 			//체크한 리스트에 품질검사부적합이 없을시 경고창
// 			swal("경고", "재지시를 등록할 사항이 없습니다.", "warning");	
			
// 		} else if(nonPassCk != checkList.length){
// 			//체크한 리스트에 품질검사부적합이 없는 사항을 포함했을시 경고창
// 			swal("경고", "체크사항을 다시 확인해주세요", "warning");
			
// 		} else{
			//체크한 리스트의 각 진행공정관리 데이터에서 품질검사부적합이 반제품공정인지 아닌지 확인
			
// 			$.each()
				
// 				if(semiYn == 'Y'){
// 					//반제품 품질검사부적합
					
// 				} else{
// 					//완제품 품질검사부적합
// 					
					
// 				}
				
// 			}
			
// 		}

	}
	
	
	//생산지시 조회
    var dirGrid = new tui.Grid({
        el: document.getElementById('dirGrid'),
        data: [
	           <c:forEach items="${dirList}" var="d" varStatus="status">
	           	{
	           		prcsDirCode : "${d.prcsDirCode}",
	           		prcsPlanCode : "${d.prcsPlanCode}",
	           		prcsDirName : "${d.prcsDirName}",
	           		prcsStartDate : "<fmt:formatDate value='${d.prcsStartDate}' pattern='yyyy-MM-dd'/>",
	           		prcsDirSts : "${d.prcsDirSts}",
	           		empName : "${d.empName}"
	           	} <c:if test="${not status.last}">,</c:if>
	           </c:forEach>
	          ],
        scrollX: false,
        scrollY: false,
        minBodyHeight: 120,
		rowHeaders: ['rowNum'],
		pagination: true,
		pageOptions: {
			useClient: true,
			perPage: 3,
		},
		 
        columns: [
          {
            header: '지시코드',
            name: 'prcsDirCode',
            width: 'auto',
            align: 'center'
          },
          {
            header: '계획코드',
            name: 'prcsPlanCode',
            width: 'auto',
            align: 'center'
          },
          {
            header: '지시명',
            name: 'prcsDirName'
          },
          {
            header: '생산시작일자',
            name: 'prcsStartDate',
            className: 'yellow-background',
            align: 'center'
          },
          {
            header: '지시상태',
            name: 'prcsDirSts',
            align: 'center'
          },
          {
            header: '담당자코드',
            name: 'empCode',
            hidden: true
          },
          {
            header: '담당자',
            name: 'empName',
            align: 'center'
          },
        ]
      })  

	
	//상세생산지시 조회
	var dirDeGrid = new tui.Grid({
        el: document.getElementById('dirDeGrid'),
        scrollX: false,
        scrollY: false,
        minBodyHeight: 120,
		rowHeaders: ['rowNum'],
		pagination: true,
		pageOptions: {
			useClient: true,
			perPage: 3,
		},
        columns: [
          {
            header: '상세지시코드',
            name: 'prcsDirDeCode',
            width: 'auto',
            align: 'center'
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
            header: '생산계획량',
            name: 'prcsPlanAmt',
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
            header: '지시수량',
            name: 'prcsDirAmt',
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
            header: '생산시작일자',
            name: 'prcsStartDeDate',
            className: 'yellow-background',
            align: 'center'
          },
//           {
//             header: '생산마감일자',
//             name: 'prcsEndDeDate'
//           },
          {
            header: '공정진행상태',
            name: 'prcsIngSts',
            align: 'center'
          },
          {
            header: '담당자코드',
            name: 'empCode',
            hidden: true
          },
          {
            header: '담당자',
            name: 'empName',
            align: 'center'
          },
          {
            header: '재지시여부',
            name: 'reDirCk',
            hidden: true
          }
        ]
      })  
	
	
 	//진행 공정 조회
	var ingGrid = new tui.Grid({
        el: document.getElementById('ingGrid'),
        scrollX: false,
        scrollY: false,
        minBodyHeight: 280,
		rowHeaders: ['rowNum'],
		pagination: true,
		pageOptions: {
			useClient: true,
			perPage: 10
		},
        columns: [
          {
            header: '진행공정관리코드',
            name: 'prcsIngCode',
            align: 'center'
          },
          {
            header: '상세지시코드',
            name: 'prcsDirDeCode',
            hidden: true
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
            header: '공정순서',
            name: 'prcsSeq',
            align: 'center'
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
            header: '공정상태',
            name: 'prcsDirIngSts',
            align: 'center'
          },
          {
            header: '반제품공정유무',
            name: 'semiYn',
            hidden: true
          }
         
        ]
      })  
	
	
	//생산지시 클릭시 해당 지시의 상세 생산지시 조회
    dirGrid.on('click', () => {
    	
    	//선택한 행 색깔 바꾸기
		let selectKey = dirGrid.getFocusedCell().rowKey;
    	dirGrid.addRowClassName(selectKey, 'selected-cell');
		//다른 행 선택시 기존에 클릭했던 행은 class제거
    	dirGrid.on('focusChange', () => {
    		dirGrid.removeRowClassName(selectKey, 'selected-cell');
	    })
	    
    	//클릭한 지시의 지시코드 가져오기
    	let rowKey = dirGrid.getFocusedCell().rowKey;
    	let dirCode = dirGrid.getValue(rowKey, 'prcsDirCode');

    	$.ajax({
			url : 'prcsDirDeList',
			method : 'GET',
			data : { prcsDirCode : dirCode },
			success : function(data){
				//날짜 츨력 포맷 변경
				$.each(data, function(i, objDe){
					let psdd = data[i]['prcsStartDeDate'];
					let pedd = data[i]['prcsEndDeDate'];
					data[i]['prcsStartDeDate'] = getDate(psdd);
					data[i]['prcsEndDeDate'] = getDate(pedd);
				})
				
				dirDeGrid.resetData(data);
				
				let dirDeList = dirDeGrid.getData();
				
				//재지시 완료된 행들은 사용불가
				$.each(dirDeList, function(i, obj){
					if(dirDeList[i]['reDirCk'] == 'Y'){		
						dirDeGrid.disableRow(obj['rowKey']);
					}
				});	
				
 		    },
			error : function(reject){
	 			console.log(reject);
	 		}	
		})
  	});
	
	
  	//상세 생산지시 클릭시 해당 지시의 진행 공정 조회
    dirDeGrid.on('click', () => {
    	
    	//선택한 행 색깔 바꾸기
		let selectKey = dirDeGrid.getFocusedCell().rowKey;
		dirDeGrid.addRowClassName(selectKey, 'selected-cell');
		//다른 행 선택시 기존에 클릭했던 행은 class제거
    	dirDeGrid.on('focusChange', () => {
    		dirDeGrid.removeRowClassName(selectKey, 'selected-cell');
	    })
    	
    	//클릭한 상세 지시의 상세지시코드, 제품코드 가져오기
    	let rowKey = dirDeGrid.getFocusedCell().rowKey;
    	let dirDeCode = dirDeGrid.getValue(rowKey, 'prcsDirDeCode');
    	let prodCode = dirDeGrid.getValue(rowKey, 'prodCode');
    	
		//클릭한 상세 지시의 제품코드 가져오기
    	$.ajax({
			url : 'prcsIngList',
			method : 'GET',
			data : { prcsDirDeCode : dirDeCode, prodCode : prodCode },
			success : function(result){
				ingGrid.resetData(result);
				
				//품질검사 부적합시 row 빨간색으로 변경 
	   		    let noPass = ingGrid.getData();	            
	   		    $.each(noPass, function (idx, obj) {	   	
	   		        if (obj['prcsDirIngSts'] == '품질검사부적합') {
	   		            let rowKey = obj['rowKey'];
	   		        	ingGrid.addRowClassName(rowKey, 'my-styled-cell');
	   		        }
	   		    })

 		    },
			error : function(reject){
	 			console.log(reject);
	 		}	
		})
  	});
  	
  	
  	//생산지시 -> 생산완료 update
	let dirList = dirGrid.getData();
	
	function updateDirPrcsStsAjax(){
		$.ajax({
			url : 'updateDirPrcsSts',
			method : 'POST',
			data : JSON.stringify(dirList),
			contentType : "application/json",
			success : function(data){
				//console.log(data);
				searchDirist();
			},
			error : function(reject){
	 			console.log(reject);
	 		}
		})
	}

	updateDirPrcsStsAjax();
   
	//이전 날짜 선택불가
    $('#startDate').on('change', function() {
		$('#endDate').attr('min', $('#startDate').val());
    });
	//이후 날짜 선택불가
    $('#endDate').on('change', function() {
		$('#startDate').attr('max', $('#endDate').val());
	});
	
	
    
	</script>
	
	<div>
		<jsp:include page="../comFn/prcsIngModal.jsp"></jsp:include>
	</div>
</body>
</html>