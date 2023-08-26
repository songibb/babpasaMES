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


</style>    
    
</head>
<body>
	<div class="black_bg"></div>
	<h2>생산 지시</h2>
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
			            		<button id="save" class="btn btn-info btn-icon-text">지시 등록</button>
			            	</div>  
						</div>	
						
						<div id="dirContainer">
							<div class="leftGrid">
								<div class="leftGridHeader">
					            	<span>생산 지시</span>	
								</div>
								<div id="dirGrid"></div>
							</div>
							
							<div class="rightGrid">
								<div class="rightGridHeader">
			           				<span>상세 생산 지시</span>
			           				<div>
		           						<button id="deAdd" class="btn btn-info btn-icon-text">행추가</button>
		           						<button id="deRemove" class="btn btn-info btn-icon-text">행삭제</button>
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
				            	<span>공정별 자재 소모량</span>
							</div>
		           			<div id="bomGrid"></div>
	           			</div>
	           			<div class="rightGrid">
	           				<div class="rightGridHeader">
		           				<span>자재별 LOT 재고</span>
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
	
	//생산계획조회 모달
// 	$("#planListModal").click(function(){
// 		$(".modal").fadeIn();
// 		Grid = createProdGrid();
// 		Grid.on('click', () => {
// 			let rowKey = Grid.getFocusedCell().rowKey;
// 	        let planCode = Grid.getValue(rowKey, 'planCode');
// // 	       	let prodName = Grid.getValue(rowKey, 'prodName');
// // 			$("#prodCodeInput").val(prodCode);
// // 			$("#prodNameFix").val(prodName);
			
// // 			$("#prodCodeInput").val(prodCode);
			
// 			//모달창 닫기
// 			if(rowKey != null){
// 				$(".modal").fadeOut();
// 				Grid.destroy();
// 			}
// 		});
// 	});
	
	
	//페이지 호출시 생산지시 등록하는 행 자동 생성
	window.onload = function addRow(){
		dirGrid.appendRow();
		dirDeGrid.appendRow();
	} 

	//행추가 버튼 클릭시 상세생산지시 행 추가
	function addDeRow(){
		dirDeGrid.appendRow();
	}
	
	//행삭제 버튼 클릭시 상세생산지시 행 삭제
	function removeDeRow(){
		dirDeGrid.removeCheckedRows(false);
	}
		
	//저장 버튼 클릭시 실행 될 함수 -> insert 실행
	function saveServer() {	
		
		//편집종료
		let rowKey = dirGrid.getFocusedCell().rowKey;
		let columnName = dirGrid.getFocusedCell().columnName;		
		dirGrid.finishEditing(rowKey, columnName);
		
		let rowKeyDe = dirDeGrid.getFocusedCell().rowKey;
		let columnNameDe = dirDeGrid.getFocusedCell().columnName;
		dirDeGrid.finishEditing(rowKeyDe, columnNameDe);
		
// 		console.log(dirDeGrid.isModified());
// 		console.log(dirDeGrid.getModifiedRows());
// 		if(!dirGrid.isModified() && !dirDeGrid.isModified()){
// 			swal("변경사항이 없습니다.", "", "warning");
// 			return false;
// 		}
		
		//생산계획량과 지시수량 비교 -> 생산계획량보다 지시수량이 적을시 경고창
		let amtCklist = dirDeGrid.getData();
		let amtCk = true;
		$.each(amtCklist, function(i, obj){
			for(let field in obj){
				if(obj['prcsPlanAmt'] > obj['prcsDirAmt']){
					amtCk = false;
				}
			}
		})
		if(amtCk == false){
			swal("경고", "주문수량보다 생산계획량이 적습니다.", "warning");
			return false;
		}
		

		let list = dirGrid.getData();
		let obj = list[0];

		$.ajax({
			url : 'prcsDirInsert',
			method : 'POST',
			data : JSON.stringify(obj),
			contentType : 'application/json',
			success : function(data){					
				//상세생산지시 insert
				let rowKey = dirDeGrid.getFocusedCell().rowKey;
				let columnName = dirDeGrid.getFocusedCell().columnName;
				//편집종료
				dirDeGrid.finishEditing(rowKey, columnName);
				
				let deList = dirDeGrid.getData();
				$.each(deList, function(i, objDe){
					deList[i]['prcsDirCode'] = data;
				})

				
				//분할지시
				//상세지시코드 for문돌려서 상세계획코드 구하기
				// 상세계획코드 개수가 1이상일때  
				// 해당 생산계획량 = 각각 지시수량 모두 더한 값 true이면
				// 아래 ajax 동작
				//if()

				$.ajax({
					url : 'prcsDirDeInsert',
					method : 'POST',
					data : JSON.stringify(deList),
					contentType : 'application/json',
					success : function(data){
						//등록 후 그리드 내용 지우고, 행추가
						dirGrid.clear();
						dirGrid.appendRow();
						dirDeGrid.clear();
						dirDeGrid.appendRow();
						
						swal("등록이 완료되었습니다.", "", "success");
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
            name: 'prcsPlanCode'
          },
          {
            header: '지시명',
            name: 'prcsDirName',
            editor: 'text'
          },
//           {
//             header: '지시등록일자',
//             name: 'prcsDirDate',
//           },
          {
			header: '생산시작일자',
            name: 'prcsStartDate',
            editor: {
   		      type: 'datePicker',
   		      options: {
   		    	  language: 'ko'
   		      }
   		    },
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
            editor: 'text'
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
            name: 'prcsPlanAmt'
          },
          {
            header: '지시수량',
            name: 'prcsDirAmt',
            editor: 'text'
          },
          {
            header: '생산시작일자',
            name: 'prcsStartDeDate',
            editor: {
   		      type: 'datePicker',
   		      options: {
   		    	  language: 'ko'
   		      }
   		    }
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
            editor: 'text'
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
            name: 'bomAmt'
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
//           {
//             header: '자재명',
//             name: 'matName'
//           },
          {
            header: 'LOT번호',
            name: 'matLot'
          },
          {
       	  	header: '재고량',
            name: 'lotStock'
          }

        ]
      });

	
	
	

	
	//상세 생산지시 클릭시 해당 제품의 BOM 조회 
	dirDeGrid.on('click', () => {
		
    	//클릭한 상세생산지시의 BOM 목록 가져오기
    	let rowKey = dirDeGrid.getFocusedCell().rowKey;
    	let prodCode = dirDeGrid.getValue(rowKey, 'prodCode');
    	let dirAmt = dirDeGrid.getValue(rowKey, 'prcsDirAmt');
		
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
		
    	//클릭한 BOM의 자재 LOT 가져오기
    	let rowKey = bomGrid.getFocusedCell().rowKey;
    	let matCode = bomGrid.getValue(rowKey, 'mpCode');
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
	
	

	
	
    </script>
</body>
</html>