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
    
</head>
<body>
	<div class="black_bg"></div>
	<h2>생산 지시</h2>
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
	            	<button id="planModal">생산계획조회</button>
	            	
	           		<div id="dirGrid"></div>
	           		<div id="dirDeGrid"></div>
	           		<div id="matGrid"></div>
				</div>
	   		</div>
		</div>
	</div> 
	
	<div class="modal">
		<div class="modal_content" title="클릭하면 창이 닫힙니다.">
			<div class="m_head">
				<div class="modal_title"><h3>생산계획</h3></div>
				<div class="close_btn" id="close_btn">X</div>
			</div>
			<div class="m_body">
				<div id="modal_label"></div>
			</div>
<!-- 			<div class="m_footer"> -->
<!-- 				<div class="modal_btn save" id="save_btn">SAVE</div> -->
<!-- 			</div> -->
		</div>
	</div>
    
	<script>
	
	document.getElementById('save').addEventListener('click', saveServer);
	document.getElementById('deAdd').addEventListener('click', addDeRow);
	
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
		
	//저장 버튼 클릭시 실행 될 함수 -> insert 실행
	function saveServer() {	

		//생산지시 -> insert
		let rowKey = dirGrid.getFocusedCell().rowKey;
		let columnName = dirGrid.getFocusedCell().columnName;
		//편집종료
		dirGrid.finishEditing(rowKey, columnName);

		let list = dirGrid.getData();
		let obj = list[0];

// 		let obj = {};

// 		obj['prcsPlanCode'] = dirGrid.getValue(rowKey, 'prcsPlanCode');
// 		obj['prcsDirName'] = dirGrid.getValue(rowKey, 'prcsDirName');
// 		obj['prcsStartDate'] = dirGrid.getValue(rowKey, 'prcsStartDate');

// 		//담당자 세션으로 가져와서 객체에 담기
// 		obj['empCode'] = dirGrid.getValue(rowKey, 'empCode');


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
				console.log(deList);

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
        minBodyHeight: 30,
		rowHeaders: ['rowNum'],		
        columns: [
          {
            header: '지시코드',
            name: 'prcsDirCode'
          },
          {
            header: '계획코드',
            name: 'prcsPlanCode',
            editor: 'text'
          },
          {
            header: '지시명',
            name: 'prcsDirName',
            editor: 'text'
          },
          //지울부분
          {
            header: '지시등록일자',
            name: 'prcsDirDate',
          },
          {
			header: '생산시작일자',
            name: 'prcsStartDate',
            editor: 'text'
          },
          //지울부분
          {
            header: '생산종료일자',
            name: 'prcsEndDate'
          },
        	//지울부분
          {
            header: '전체공정진행상태',
            name: 'prcsDirSts'
          },
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
		rowHeaders: ['rowNum'],
        columns: [
          {
            header: '상세지시코드',
            name: 'prcsDirDeCode'
          },
          {
            header: '지시코드',
            name: 'prcsDirCode'
          },
          {
            header: '제품코드',
            name: 'prodCode',
            editor: 'text'
          },
          {
            header: '생산계획량',
            name: 'prcsPlanAmt',
            editor: 'text'
          },
          {
            header: '생산시작일자',
            name: 'prcsStartDeDate',
            editor: 'text'
          },
          {
            header: '생산마감일자',
            name: 'prcsEndDeDate'
          },
          {
            header: '공정진행상태',
            name: 'prcsIngSts'
          },
          {
            header: '담당자',
            name: 'empCode',
            editor: 'text'
          }
        ]
      });
	

	
    </script>
</body>
</html>