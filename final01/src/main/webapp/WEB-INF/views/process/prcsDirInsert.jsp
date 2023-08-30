<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>생산 지시</title>

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
#btnContainer{
	display: flex;
	justify-content: end;
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

#matContainer{
	display: flex;
	justify-content: space-between;
}

input[type="text"] {
  padding: 6px;
  margin-bottom: 15px;
  border: 1px solid #ccc;
  border-radius: 4px;
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
</style>    
    
</head>
<body>
	<div class="black_bg"></div>
	<h1>생산 지시</h1>
	<div class="col-lg-12 stretch-card">
		<div class="card">
			<div class="card-body">
				<div id="customtemplateSearchAndButton">		
					
		        </div>
	            <div>
	            	<div>          
	            		<div>  	
		            		<div id="btnContainer">
			            		<button id="planModal" class="btn btn-info btn-icon-text">생산 계획 가져오기</button>	  		
			            	</div>  
						</div>	
						
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
			           					<button id="deAdd" class="btn btn-info btn-icon-text">행추가</button>
		           						<button id="deRemove" class="btn btn-info btn-icon-text">행삭제</button>
		           						<button id="save" class="btn btn-info btn-icon-text">지시 등록</button>
		           					</div>
			      				</div>
			           			<div id="dirDeGrid"></div>
							</div>
						</div>
						
	           		</div>	  
	           		<hr>
	           		<div id="matContainer">
	           			<div class="leftGrid">
	           				<div class="leftGridHeader">
				            	<h2>공정별 자재 소모량</h2>
				            	<div>         					
		           					<input type="text" name="prodName" id="prodName" readonly>
		           				</div>	
							</div>
		           			<div id="bomGrid"></div>
	           			</div>
	           			<div class="rightGrid">
	           				<div class="rightGridHeader">
		           				<h2>자재별 LOT 재고</h2>
		           				<div>         					
		           					<input type="text" name="matName" id="matName" readonly>
		           				</div>	
		      				</div>
		           			<div id="matLotGrid"></div>
	           			</div>
           			</div>
	            </div>
				
				
	   		</div>
		</div>
	</div> 
	
	<div>	
		<jsp:include page="../comFn/dateFormat.jsp"></jsp:include>
		<jsp:include page="../comFn/planModal.jsp"></jsp:include>
	</div>
    
	<script>
	
	//저장
	document.getElementById('save').addEventListener('click', saveServer);
	//행추가
	document.getElementById('deAdd').addEventListener('click', addDeRow);
	//행삭제
	document.getElementById('deRemove').addEventListener('click', removeDeRow);
	


	//행추가 버튼 클릭시 체크된 상세생산지시와 같은 행 추가 (분할지시를 위해)
	function addDeRow(){
		let list = dirDeGrid.getCheckedRows();
		if(list.length == 0){
			swal("경고", "추가할 행을 선택해주세요.", "warning");	
		}
		dirDeGrid.appendRows(list);
	}
	
	//행삭제 버튼 클릭시 체크된 상세생산지시 행 삭제
	function removeDeRow(){
		dirDeGrid.removeCheckedRows(false);
	}
		
	//저장 버튼 클릭시 실행 될 함수 -> insert 실행
	function saveServer() {	
		
		//생산지시 편집종료
		let rowKey = dirGrid.getFocusedCell().rowKey;
		let columnName = dirGrid.getFocusedCell().columnName;		
		dirGrid.finishEditing(rowKey, columnName);
		
		//상세생산지시 편집종료
		let rowKeyDe = dirDeGrid.getFocusedCell().rowKey;
		let columnNameDe = dirDeGrid.getFocusedCell().columnName;
		dirDeGrid.finishEditing(rowKeyDe, columnNameDe);
		
		
		//저장버튼 눌렀을때 그리드에 데이터가 비어있는지 확인할 변수
		let flag = true; 

		//생산지시 데이터 가져오기
		let list = dirGrid.getData();
		let object = list[0];
		//빈 데이터 있는지 체크
		$.each(list, function(i, obj){
			for(let field in obj){
				//console.log(field+'-'+obj[field]);
				if(obj['prcsDirName'] == null || obj['empCode'] == null || obj['prcsStartDate'] == null){
					flag = false;
				}
			}
		})
		
		//상세생산지시 데이터 가져오기			
		let deList = dirDeGrid.getData();
		$.each(deList, function(i, objDe){
			for(let field in objDe){
				//console.log(field+'-'+objDe[field]);			
				if(objDe['prcsStartDeDate'] == null || objDe['prcsDirAmt'] == 0){
					flag = false;
				}
			}	
		})
		
		let dirInsertList = { prcsDirVO : object, insertList : deList };
		
		if(flag){
	
			//생산계획량과 지시수량 비교 -> 지시수량이 생산계획량보다 적을시 경고창
			let list = dirDeGrid.getData();
	
			//분할지시
			//상세지시코드 반복문 돌려서 상세계획코드만 codeList에 담기
			let codeList = [];
			$.each(list, function(i, obj){
				codeList.push(obj['prcsPlanDeCode']);
			})

			//상세계획코드별 중복되는 개수 구해서 result 객체에 담기
			let result = {}
			for(let code of codeList){
				if(result[code]) {
					//이미 존재하는 데이터는 여기
					result[code] = result[code] + 1;
				} else {
					//처음 들어오는 데이터는 여기
					result[code] = 0 + 1;
				}
			}
			
			//지시수량이 올바르게 들어갔는지 확인할 변수
			let amtCk = true;
			
			for(let idx in result){
				
				//result객체의 값이 1보다 크면 중복이라는 뜻
				if(result[idx] > 1){
					
					//해당 상세계획코드의 지시수량의 합 구하기
					let sumDirAmt = 0;
					let planAmt = 0;
		 			$.each(list, function(i, obj){
		 				if(list[i]['prcsPlanDeCode'] == idx){
		 					sumDirAmt = sumDirAmt + Number(list[i]['prcsDirAmt']);
		 					planAmt = list[i]['prcsPlanAmt'];
		 				}
		 			})	
		 			
					//해당 상세계획코드의 지시수량 모두 더한 값이 생산계획량보다 적으면 경고창
					if( sumDirAmt < planAmt){
						amtCk = false;
					}
		 			
				} else {
					//중복값이 없는 경우
					//지시수량이 생산계획량보다 적을시 경고창
					$.each(list, function(i, obj){
						if(list[i]['prcsPlanDeCode'] == idx){
							if(list[i]['prcsPlanAmt'] > list[i]['prcsDirAmt']){
								amtCk = false;
							}
						}
					})
				}
			}
			
			if(amtCk == false){
				swal("경고", "지시수량이 생산계획량보다 적습니다.", "warning");
				return false;
			} 
					
			$.ajax({
				url : 'prcsDirInsert',
				method : 'POST',
				data : JSON.stringify(dirInsertList),
				contentType : 'application/json',
				async : false, 
				success : function(data){									
					swal("성공", "등록이 완료되었습니다.", "success");
				},
				error : function(reject){
		 			console.log(reject);
		 		}		
			})


		} else {
			
			swal("경고", "모든 값이 입력되지 않았습니다.", "warning");
		}
	};

	
	//생산지시 grid
    var dirGrid = new tui.Grid({
        el: document.getElementById('dirGrid'),
        scrollX: false,
        scrollY: false,
        minBodyHeight: 200,	
        columns: [
//           {
//             header: '지시코드',
//             name: 'prcsDirCode'
//           },
          {
            header: '계획코드',
            name: 'prcsPlanCode',
            align: 'center'
          },
          {
            header: '지시명',
            name: 'prcsDirName',
            editor: 'text'
          },
          {
            header: '지시등록일자',
            name: 'prcsDirDate',
            align: 'center'
          },
          {
			header: '생산시작일자',
            name: 'prcsStartDate',
            editor: {
   		      type: 'datePicker',
   		      options: {
   		    	  language: 'ko',
   		    	  selectableRanges: [[new Date(), new Date(2099,1,1)]]
   		      }
   		    },
   		 	className: 'yellow-background',
   		 	align: 'center'
          },
//           {
//             header: '생산종료일자',
//             name: 'prcsEndDate'
//           },
//           {
//             header: '전체공정진행상태',
//             name: 'prcsDirSts'
//           },
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
          }
        ]
	});
	
	//상세생산지시 grid
	var dirDeGrid = new tui.Grid({
        el: document.getElementById('dirDeGrid'),
        scrollX: false,
        scrollY: false,
        minBodyHeight: 200,
		rowHeaders: ['checkbox'],
        columns: [
//           {
//             header: '상세지시코드',
//             name: 'prcsDirDeCode'
//           },
//           {
//             header: '지시코드',
//             name: 'prcsDirCode'
//           },
// 		  {
//             header: '상세계획코드',
//             name: 'prcsPlanDeCode',
//             hidden: false
//           },
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
            editor: 'text',
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
            editor: {
   		      type: 'datePicker',
   		      options: {
   		    	  language: 'ko',
   		    	  selectableRanges: [[new Date(), new Date(2099,1,1)]]
   		      }
   		    },
   		 	className: 'yellow-background',
   		 	align: 'center'
          },
//           {
//             header: '생산마감일자',
//             name: 'prcsEndDeDate'
//           },
//           {
//             header: '공정진행상태',
//             name: 'prcsIngSts'
//           },
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
        ]
      });
	
	//BOM grid
	var bomGrid = new tui.Grid({
        el: document.getElementById('bomGrid'),
        scrollX: false,
        scrollY: false,
        minBodyHeight: 200,
		rowHeaders: ['rowNum'],
		pagination: true,
		pageOptions: {
			useClient: true,
			perPage: 5
		},
        columns: [
       	  {
       	  	header: '투입공정',
            name: 'prcsName'
          },
    	  {
            header: '자재코드',
            name: 'mpCode',
            hidden: true
          },
          {
            header: '자재명',
            name: 'matName'
          },
          {
            header: '자재소모량',
            name: 'bomAmt',
            formatter(e) {
            	if (e['value'] != null){
	                val = e['value']
	                    .toString()
	                    .replace(/\B(?=(\d{3})+(?!\d))/g, ',');
	                return val;
            	}
            },
            align: 'right'
          }
          
//           {
//             header: '단위',
//             name: 'bomUnit'
//           }
        ]
      });
	
	//자재별 LOT grid
	var matLotGrid = new tui.Grid({
        el: document.getElementById('matLotGrid'),
        scrollX: false,
        scrollY: false,
        minBodyHeight: 200,
		rowHeaders: ['rowNum'],
        columns: [
          {
            header: '자재명',
            name: 'matName',
            hidden: true
          },
          {
            header: 'LOT번호',
            name: 'matLot',
            align: 'center'
          },
          {
       	  	header: '재고량',
            name: 'lotStock',
            formatter(e) {
            	if (e['value'] != null){
	                val = e['value']
	                    .toString()
	                    .replace(/\B(?=(\d{3})+(?!\d))/g, ',');
	                return val;
            	}
            },
            align: 'right'
          }

        ]
      });

	
	
	

	
	//상세 생산지시 클릭시 해당 제품의 BOM 조회 
	dirDeGrid.on('click', () => {
		
		//선택한 행 색깔 바꾸기
		let selectKey = dirDeGrid.getFocusedCell().rowKey;
		dirDeGrid.addRowClassName(selectKey, 'selected-cell');
		//다른 행 선택시 기존에 클릭했던 행은 class제거
    	dirDeGrid.on('focusChange', () => {
    		dirDeGrid.removeRowClassName(selectKey, 'selected-cell');
	    })
		
    	//클릭한 상세생산지시의 BOM 목록 가져오기
    	let rowKey = dirDeGrid.getFocusedCell().rowKey;
    	let prodCode = dirDeGrid.getValue(rowKey, 'prodCode');
    	let prodName = dirDeGrid.getValue(rowKey, 'prodName');
    	let dirAmt = dirDeGrid.getValue(rowKey, 'prcsDirAmt');
    	$('#prodName').val(prodName);
		
    	if(prodCode != null){
    		$.ajax({
    			url : 'bomList',
    			method : 'GET',
    			data : { prodCode : prodCode, prcsDirAmt : dirAmt },
    			success : function(data){
    				bomGrid.resetData(data);
     		    },
    			error : function(reject){
    	 			console.log(reject);
    	 		}	
    		})
    	}
    	

  	});
	
	//BOM 클릭시 해당 자재의 LOT 조회 
	bomGrid.on('click', () => {
		
		//선택한 행 색깔 바꾸기
		let selectKey = bomGrid.getFocusedCell().rowKey;
		bomGrid.addRowClassName(selectKey, 'selected-cell');
		//다른 행 선택시 기존에 클릭했던 행은 class제거
    	bomGrid.on('focusChange', () => {
    		bomGrid.removeRowClassName(selectKey, 'selected-cell');
	    })
		
		
    	//클릭한 BOM의 자재 LOT 가져오기
    	let rowKey = bomGrid.getFocusedCell().rowKey;
    	let matCode = bomGrid.getValue(rowKey, 'mpCode');
    	let matName = bomGrid.getValue(rowKey, 'matName');
    	$('#matName').val(matName);
    	console.log(matCode);
    	$.ajax({
			url : 'matLotStockList',  
			method : 'GET',
			data : { materialCode : matCode },
			success : function(data){
				matLotGrid.resetData(data);
 		    },
			error : function(reject){
	 			console.log(reject);
	 		}	
		})

  	});
	
	
	//생산지시 너무 비어보여서 페이지 호출할떄마다 행추가
	dirGrid.appendRow();
	dirDeGrid.appendRow();
	
	
    </script>
</body>
</html>