<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>완제품 품질 검사</title>
	<!-- 토스트 페이지 네이션 -->
    <script type="text/javascript" src="https://uicdn.toast.com/tui.code-snippet/latest/tui-code-snippet.js"></script>
    <link rel="stylesheet" href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css" />
    <script src="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.js"></script>
    <!-- 페이지 네이션 끝 -->
    <link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
    <script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
    
    <style>
      h1{
			margin-left: 15px;
		}
		h1, h2{
			font-weight: 800;
		}
		
		.selected-cell{background-color: #ffd09e;}
		
		#grid tbody td{
			cursor : pointer;
		}
		
		td[data-column-name="testResult"]{
			cursor : pointer;
		}
    </style>   
</head>
<body>
	<div class="black_bg"></div>
	<h1>완제품 품질 검사</h1>
	<div class="col-lg-12 stretch-card">
      <div class="card">
         <div class="card-body" style="padding-top: 50px;">
            <!-- <div class="table-responsive pt-3">
                  
                  
               </div> -->
               <div id="container" style="display: flex; justify-content: center;">
                       <div id="grid" style="width: 700px; margin-right: 20px"><h2>완제품 품질 검사 목록</h2></div>
                      <div>
                       <div style="display: flex; justify-content: space-between;">
                       <h2>상세 품질 검사 조회</h2>
                     <button id="save" class="btn btn-info btn-icon-text">저장</button>
                     </div>
                       <div id="grid2" style="width: 800px;"></div>
                       </div>
		
               </div>
         </div>
      </div> 
   </div>
	
		<div class="modal">
   
  <div class="modal_content" 
       title="클릭하면 창이 닫힙니다.">
          <div class="m_head">
            <div class="modal_title"><h3>목록</h3></div>
            <div class="close_btn" id="close_btn">X</div>
       </div>
       <div class="m_body">
            <div id="modal_label"></div>
       </div>
       <div class="m_footer">
            <div class="modal_btn cancle" id="close_btn">CANCLE</div>
            <div class="modal_btn save" id="save_btn">SAVE</div>
    </div>
  </div>
	</div>
	
	<script>
	//저장버튼
	document.getElementById('save').addEventListener('click', commSave);
	
		
		$.ajax({
			url : 'ajaxLastPrcsList',
			method : 'GET',
			success : function(result){
				console.log(result);
				 grid.resetData(result);
			},
			error : function(reject){
				console.log(reject);
			}
		});
					
		
		var grid = new tui.Grid({
			el: document.getElementById('grid'),
			scrollX: false,
			scrollY: false,
			 minBodyHeight: 200,
			 rowHeaders: ['rowNum'],
			pagination: true,
			pageOptions: {
				useClient: true,
				perPage: 10,
			},
			columns: [
				{
					header: '검사번호',
					name: 'testNum',
			        align: 'center'
				},
				{
					header: '공정진행코드',
					name: 'prcsIngCode',
			        align: 'center'
				},
				{
					header: '제품명',
					name: 'prodName',
			        align: 'left'
				},
				{
					header: '생산량',
					name: 'prcsAmt',
			        align: 'left'
				}
				
			]
			
		})
		

		//상세공통코드 가져오기
		var grid2 = new tui.Grid({
			el: document.getElementById('grid2'),
			scrollX: false,
			scrollY: false,
			 minBodyHeight: 200,
			 rowHeaders: [{type: 'rowNum'}],
			columns: [
				{
					header: '검사번호',
					name: 'testNum'
				},
				{
					header: '공정진행코드',
					name: 'prcsIngCode'
				},
				{
					header: '상세검사번호',
					name: 'testNumInfo'
				},
				{
					header: '검사코드',
					name: 'testCode',
					hidden: true
				},
				{
					header: '검사명',
					name: 'testName'
				},
				{
					header: '검사기준값',
					name: 'passValue'
				},
				{
					header: '검사값',
					name: 'testResult',
					editor: 'text'
				},
				{
					header: '적합여부',
					name :'passYn',
					hidden: true
				},
				{
					header: '적합여부',
					name :'passYn2'
				},
				
				{
					header: '담당자',
					name : 'empCode',
					editor: 'text',
					hidden: true
					
				},
				{
					header: '담당자',
					name :'empName'
				}
				
			]
			
		})
		
		
		 //자동 계산
	      grid2.on('afterChange', (ev) => {
	      
	      let change = ev.changes[0];
	      let rowData = grid2.getRow(change.rowKey);
	      
	      
	      
	      if(change.columnName == 'testResult'){
	         if(rowData.testResult != null && rowData.testResult != ""){
	            let passYn;
	            let passYn2;
	            if(rowData.testResult < rowData.passValue){
	               passYn = 'Y';
	               passYn2 = '합격';
	            } else if(rowData.testResult >= rowData.passValue){
	               passYn = 'N';
	               passYn2 = '불합격';
	            }
	            grid2.setValue(change.rowKey, 'passYn', passYn);
	            grid2.setValue(change.rowKey, 'passYn2', passYn2);
	         }
	      }
	      });
	      //끝
	      
		grid.on('click', () => {
			
			 let selectKey = grid.getFocusedCell().rowKey;
	    	  grid.addRowClassName(selectKey, 'selected-cell');
	    	  //다른 행 선택시 기존에 클릭했던 행은 class제거
	    	  grid.on('focusChange', () => {
	    		  grid.removeRowClassName(selectKey, 'selected-cell');
	    	  })
	    	  
			let rowKey = grid.getFocusedCell().rowKey;
	    	let testNum = grid.getValue(rowKey, 'testNum');
	    	console.log(testNum);
	    	$.ajax({
	    		url : 'ajaxOneChkList',
				method : 'GET',
				data : { testNum : testNum },
				success : function(data){
	 				grid2.resetData(data);
	 				grid2.setColumnValues('empCode', ${user.id});
	 				grid2.setColumnValues('empName', `${user.empName}`);
	 				
	 				
	 		    },
				error : function(reject){
		 			console.log(reject);
		 		}
	    	})
	    	
	    	$("#testNum").val(testNum);
		});
		
		
		function commSave(){
			grid2.blur();
			let modifyGridInfo = grid2.getModifiedRows();
			
			//변경사항없으면 빠져나감
			if(!grid2.isModified()){
				swal("변경사항이 없습니다","","warning");
				return false;
			}
			
			
		//입력 빠뜨린곳 없으면 true
		var flag = true;
		
		if(grid2.getModifiedRows().createdRows.length > 0 ){
					
					$.each(grid2.getModifiedRows().createdRows, function(idx2, obj2){
						if(obj2['passYn'] == null ||obj2['passYn2'] ==null ){
							flag = false;
							return false;
						}
					})
			}
     
		
		if(grid2.getModifiedRows().updatedRows.length > 0 ){

			$.each(grid2.getModifiedRows().updatedRows, function(idx2, obj2){
				if(obj2['passYn'] == null ||obj2['passYn2'] ==null ){
					flag = false;
					return false;
				}
			})		
		}
			
		let rowKey = grid.getFocusedCell().rowKey;
		let testNum = grid.getValue(rowKey, 'testNum');
		let prcsIngCode = grid.getValue(rowKey, 'prcsIngCode');
		let oneVO = {};
		oneVO['testNum'] = testNum;
		oneVO['prcsIngCode'] = prcsIngCode;
		
		let oneAllList = {
			oneList : grid2.getModifiedRows().updatedRows,
			oneChkVO : oneVO
				
		};
		
		console.log(oneAllList);
		console.log(grid2.getData());
		

		if(flag){
			$.ajax({
				url : 'updateOneChk',
				method : 'POST',
				data : JSON.stringify(oneAllList),
				contentType : 'application/json',
				success : function(data){
					swal("성공", data+"건이 처리되었습니다","success");
					
					$.ajax({
	                      url : 'ajaxLastPrcsList',
	                      method : 'GET',
	                      success : function(result){
	                         console.log(result);
	                          grid.resetData(result);
	                          grid2.resetData(result);
	                      },
	                      error : function(reject){
	                         console.log(reject);
	                      }
	                   });
					
				},
				error : function(reject){
					console.log(reject);
				}
			})
		} else {
			swal("실패", "모든 값이 입력되지 않았습니다.", "warning");
		}

	}
		
		//수정중일때 페이지 나가면 경고창 출력
	  	$(document).ready(function(){ 
	  	    window.onbeforeunload = function(){
	  	        if(grid2.isModified()){
	  	        	doExit();
	  	        }
	  	    };
	  	});
	  	
	  	function doExit(){
	  	    event.returnValue = "페이지를 벗어 나시겠습니까?";
	  	}	
		

	</script>
</body>
</html>