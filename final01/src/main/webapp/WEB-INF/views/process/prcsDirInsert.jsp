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
#matContainer{
	display: flex;
	justify-content: space-between;
}
#bomGrid{
    width: 600px;
}
#matLotGrid{
    width: 600px;
}

</style>    
    
</head>
<body>
	<div class="black_bg"></div>
	<h2>생산 지시</h2>
	<div class="col-lg-12 stretch-card">
		<div class="card">
			<div class="card-body">
				<div class="table-responsive pt-3">
	            </div>
	            	
	            <div>	            	
	            	<div>
	            		<p>생산 지시</p>
	            		<button id="planModal" class="btn btn-info btn-icon-text">생산계획조회</button>
	            		<button id="save" class="btn btn-info btn-icon-text">저장</button>
	            		<div id="dirGrid"></div>
	            	</div>

	           		<div>
	           			<p>상세 생산 지시</p>
	           			<button id="deAdd" class="btn btn-info btn-icon-text">행추가</button>
	            		<button id="deRemove" class="btn btn-info btn-icon-text">행삭제</button>
	            		<div id="dirDeGrid"></div>
	           		</div>
	           		
	           		<div id="matContainer">
	           			<div>
	           				<p>공정 자재 소모량</p>
		           			<div id="bomGrid"></div>
	           			</div>
	           			<div>
	           				<p>자재별 LOT 재고</p>
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
	$("#planListModal").click(function(){
		$(".modal").fadeIn();
		Grid = createProdGrid();
		Grid.on('click', () => {
			let rowKey = Grid.getFocusedCell().rowKey;
	        let planCode = Grid.getValue(rowKey, 'planCode');
// 	       	let prodName = Grid.getValue(rowKey, 'prodName');
// 			$("#prodCodeInput").val(prodCode);
// 			$("#prodNameFix").val(prodName);
			
// 			$("#prodCodeInput").val(prodCode);
			
			//모달창 닫기
			if(rowKey != null){
				$(".modal").fadeOut();
				Grid.destroy();
			}
		});
	});
	
	
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
		let message = confirm("정말 삭제하시겠습니까?");
		if(message) {		
			dirDeGrid.removeCheckedRows(false);
		}
	}
		
	//저장 버튼 클릭시 실행 될 함수 -> insert 실행
	function saveServer() {	
		let modi1 = dirGrid.getModifiedRows();
		let modi2 = dirDeGrid.getModifiedRows();
		
		console.log(modi1);
		console.log(modi2);
		
		//생산지시 -> insert
		let rowKey = dirGrid.getFocusedCell().rowKey;
		let columnName = dirGrid.getFocusedCell().columnName;
		//편집종료
		dirGrid.finishEditing(rowKey, columnName);

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
	};



// 		$.ajax({
// 			url : 'prcsDirInsert',
// 			method : 'POST',
// 			data : JSON.stringify(obj),
// 			contentType : 'application/json',
// 			success : function(data){					
				
				
// 				//분할지시
// 				//상세지시코드 for문돌려서 상세계획코드 구하기
// 				// 상세계획코드 개수가 1이상일때  
// 				// 해당 생산계획량 = 각각 지시수량 모두 더한 값 true이면
// 				// 아래 ajax 동작
// 				//if()
// 			},
// 			error : function(reject){
// 	 			console.log(reject);
// 	 		}		
// 		})
			

		
// 		//상세생산지시 insert
// 		let deRowKey = dirDeGrid.getFocusedCell().rowKey;
// 		let deColumnName = dirDeGrid.getFocusedCell().columnName;
// 		//편집종료
// 		dirDeGrid.finishEditing(deRowKey, deColumnName);
		
// 		let deList = dirDeGrid.getData();

// 		$.ajax({
// 			url : 'prcsDirDeInsert',
// 			method : 'POST',
// 			data : JSON.stringify(deList),
// 			contentType : 'application/json',
// 			success : function(data){
// 				//등록 후 그리드 내용 지우고, 행추가
// 				dirGrid.clear();
// 				dirGrid.appendRow();
// 				dirDeGrid.clear();
// 				dirDeGrid.appendRow();
				
// 				alert('등록이 완료되었습니다.');
// 			},
// 			error : function(reject){
// 	 			console.log(reject);
// 	 		}
// 		})				
		
		
		
// 	};


	
	
	
	//생산지시 grid
    var dirGrid = new tui.Grid({
        el: document.getElementById('dirGrid'),
        scrollX: false,
        scrollY: false,
        minBodyHeight: 30,	
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
   		    }
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
            header: '담당자',
            name: 'empCode',
            editor: 'text'
          }
        ]
	});
	
	//상세생산지시 grid
	var dirDeGrid = new tui.Grid({
        el: document.getElementById('dirDeGrid'),
        scrollX: false,
        scrollY: false,
        minBodyHeight: 30,
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
		  {
            header: '상세계획코드',
            name: 'prcsPlanDeCode',
            hidden: false
          },
       	  {
            header: '제품코드',
            name: 'prodCode',
            hidden: false
          },
          {
            header: '제품명',
            name: 'prodName',
            editor: 'text'
          },
          {
            header: '생산계획량',
            name: 'prcsPlanAmt',
            editor: 'text'
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
            header: '담당자',
            name: 'empCode',
            editor: 'text'
          }
        ]
      });
	
	//BOM grid
	var bomGrid = new tui.Grid({
        el: document.getElementById('bomGrid'),
        scrollX: false,
        scrollY: false,
        minBodyHeight: 30,
		rowHeaders: ['rowNum'],
        columns: [
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
          },
          {
       	  	header: '투입공정',
            name: 'prcsName'
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
        minBodyHeight: 30,
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