<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공통코드관리</title>
	<!-- 토스트 페이지 네이션 -->
    <script type="text/javascript" src="https://uicdn.toast.com/tui.code-snippet/latest/tui-code-snippet.js"></script>
    <link rel="stylesheet" href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css" />
    <script src="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.js"></script>
    <!-- 페이지 네이션 끝 -->
    <link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
    <script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>   
	<style>
	label {
	  display: block;
	  margin-bottom: 7px;
	  margin-top: 2px;
	  font-weight: bold;
	}
	
	input[type="text"],
	select {
	  width: 15%;
	  padding: 6px;
	  margin-bottom: 15px;
	  border: 1px solid #ccc;
	  border-radius: 4px;
	}
	input[type="date"],
	select {
	  width: 15%;
	  padding: 5px;
	  margin-bottom: 15px;
	  border: 1px solid #ccc;
	  border-radius: 4px;
	}
	
	select {
	  background-color: white; 
	}
	form p{
		width: 100px;
		display: inline-block;
		font-size: 20px;
	}
	h1{
		margin-left: 15px;
	}
	h1, h2{
		font-weight: 800;
	}
	h2{
		display : inline-block;
	}
	
	#matSave, #delete, #matAdd{
	
	float : right;
	}
	
	.selected-cell{
	   background-color: #ffd09e;
	}
	
	td[data-column-name="commdeUse"]{
		cursor : pointer;
	}

	</style>
</head>
<body>
	<div class="black_bg"></div>
	<h1>공통 코드 관리</h1>
	<div class="col-lg-12 stretch-card">
		<div class="card">
			<div class="card-body">
				<div class="table-responsive pt-3">
					<form>
						<p>공통코드명</p> 
						<input type="text" placeholder="검색어를 입력하세요" id="commNameSearch">
						<br>
						<p>공통코드</p> 
						<input type="text" placeholder="검색어를 입력하세요" id="commSearch" style="margin-bottom: 35px">
						<button type="button" class="btn btn-info btn-icon-text" id="searchBtn" >
							<i class="fas fa-search"></i>검색
						</button>
						<button type="reset" class="btn btn-info btn-icon-text">초기화</button>
		            </form>
		            
	            	<div>
	            		<h2 style="display : inline-block;">공통 코드 목록</h2>
		            	<button id="save" class="btn btn-info btn-icon-text" style="float : right;">저장</button>
		            	<button id="delete" class="btn btn-info btn-icon-text" style="float : right;">삭제</button> 
	            		<button id="commAdd" class="btn btn-info btn-icon-text" style="float : right;">추가</button>
	            		<input type="text" name="commCode" id="commCode" readonly="readonly" style="width: 5%; float : right; margin-top: 5px">
	            	</div>
	            </div>
	            <div id="container" style="display: flex; justify-content: center;">
		           		<div id="grid" style="width: 600px; margin-right: 50px"></div>
		           		<div id="grid2" style="width: 1000px;"></div>
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
	
	
 	$('#delete').on("click",function(){
		//그리드 행 지움
		grid2.removeCheckedRows(false);
		//마우스 커서 없앰
		grid2.blur();
	});
	
	
	
		//공통코드 조회 ajax
		$.ajax({
			url : 'ajaxCommCodeList',
			method : 'GET',
			success : function(result){
				 grid.resetData(result);
			},
			error : function(reject){
				console.log(reject);
			}
		});
		
		//공통코드 검색 조회
		$('#searchBtn').on('click', searchCommIn);
		function searchCommIn(e){
			let commName = $("#commNameSearch").val();
			let commCode = $('#commSearch').val();
			let search = {commCode : commCode, commName : commName};
			$.ajax({
				url: 'commCodeSearch',
				method : 'GET',
				data : search ,
				success : function(data){
					grid.resetData(data);
					$("#commCode").val("");
					grid2.clear();
					
				},
				error : function(reject){
					console.log(reject);
				}
			})
		}
		
			
		
		var grid = new tui.Grid({
			el: document.getElementById('grid'),
			scrollX: false,
			scrollY: false,
			 minBodyHeight: 400,
			 rowHeaders: ['rowNum'],
			pagination: true,
			pageOptions: {
				useClient: true,
				perPage: 10,
			},
			columns: [
				{
					header: '공통코드',
					name: 'commCode',
					align: 'center'
				},
				{
					header: '공통코드명',
					name: 'commName'
				},
				{
					header: '내용',
					name: 'commInfo'
				}	
			]
			
		})
		
		//상세공통코드 가져오기
		var grid2 = new tui.Grid({
			el: document.getElementById('grid2'),
			scrollX: false,
			scrollY: false,
			 minBodyHeight: 400,
			 rowHeaders: [{type: 'rowNum'},{type: 'checkbox'}],
			pagination: true,
			pageOptions: {
				useClient: true,
				perPage: 10,
			},
			columns: [
				{
					header: '공통상세코드넘버',
					name: 'commDeNo',
					align: 'center',
					hidden :true
				},
				{
					header: '공통상세코드',
					name: 'commdeCode',
					editor : 'text',
					 align: 'center'
				},
				{
					header: '공통코드',
					name: 'commCode',
					hidden : true
				},
				{
					header: '공통상세코드명',
					name: 'commdeName',
					editor : 'text'
				},
				{
					header: '내용',
					name: 'commdeInfo',
					editor : 'text'
				},
				{
					header: '사용여부',
					name: 'commdeUse',
					align: 'center',
					formatter: 'listItemText',
					editor: {
		                type: 'select',
		                options: {
		                  listItems: [
		                	<c:forEach items="${useList}" var="u">
		                	 {
		                         text: '${u.commdeName }',
		                         value: '${u.commdeCode }'
		                       }, 
							</c:forEach>
		                  ]
		                }
		              }
				}
			]
			
		})
		
		grid.on('click', () => {
			let rowKey = grid.getFocusedCell().rowKey;
	    	let commCode = grid.getValue(rowKey, 'commCode');
	    	
	    	$.ajax({
	    		url : 'ajaxCommDeCodeList',
				method : 'GET',
				data : { commCode : commCode },
				success : function(data){
	 				grid2.resetData(data);
	 		    },
				error : function(reject){
		 			console.log(reject);
		 		}
	    	})
	    	
	    	$("#commCode").val(commCode);
	    	
	    	let selectKey = grid.getFocusedCell().rowKey;
			grid.addRowClassName(selectKey, 'selected-cell');
			//다른 행 선택시 기존에 클릭했던 행은 class제거
			grid.on('focusChange', () => {
				grid.removeRowClassName(selectKey, 'selected-cell');
			})
		});
		
		
		
		
		
		
		//저장버튼
		document.getElementById('save').addEventListener('click', commSave);
		//행추가
		document.getElementById('commAdd').addEventListener('click', addCommRow);
		
		
		
		function addCommRow(){
			commCode = $("#commCode").val();
			
			if($('#commCode').val().length === 0){
				swal("경고","상세코드를 추가할 공통코드를 먼저 선택해주세요","warning");
			}else{
				grid2.appendRow( {'commCode' : commCode}, { at: 0 });
			}
			
		};
		
		
		
		
		
		function commSave(){
			grid2.blur();
			let modifyGridInfo = grid2.getModifiedRows();
			
			//변경사항없으면 빠져나감
			if(!grid2.isModified()){
				swal("경고","변경사항이 없습니다","warning");
				return false;
			}
			
			
			
			
			//입력 빠뜨린곳 없으면 true
			let flag = true;
			//중복된 상세코드 있는 것 체크
			let use = true;
			
			
			
			if(grid2.getModifiedRows().createdRows.length > 0 ){
							
							$.each(grid2.getModifiedRows().createdRows, function(idx2, obj2){
								if(obj2['commdeCode'] == null ||obj2['commdeName'] == null || obj2['commdeInfo'] == null || obj2['commdeUse'] == null){
									flag = false;
									return false;
								}
								
							})
							
							
					}
			
			
			if(grid2.getModifiedRows().updatedRows.length > 0 ){

				$.each(grid2.getModifiedRows().updatedRows, function(idx2, obj2){
					if(obj2['commdeCode'] == "" ||obj2['commdeName'] =="" || obj2['commdeInfo'] == "" || obj2['commdeUse'] == ""){
						flag = false;
						return false;
					}
				})
				
		}
			$.each(grid2.getColumnValues('commdeCode'), function(i, obj3){
				$.each(grid2.getColumnValues('commdeCode'), function(j, obj4){
					if(i!=j && obj3==obj4){
						use = false;
						return false;
					}
				})
			})
			
			if(flag && use){
				$.ajax({
					url : 'updateCommCode',
					method : 'POST',
					data : JSON.stringify(grid2.getModifiedRows()),
					contentType : 'application/json',
					success : function(data){
						swal("성공", "저장되었습니다","success");
						
				    	let commCode = $("#commCode").val();
				    	
				    	$.ajax({
				    		url : 'ajaxCommDeCodeList',
							method : 'GET',
							data : { commCode : commCode },
							success : function(data){
				 				grid2.resetData(data);
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
		}else if(!flag && use){
			swal('경고','모든값이 입력되지 않았습니다','warning');
		}else if(flag && !use){
			swal("경고","중복된 상세코드가 있습니다","warning");
		}else{
			swal('경고','모든값이 입력되지 않았습니다','warning');
		}

	}
			
		//수정중일때 페이지 나가면 경고창 출력
		$(document).ready(function(){ 
			
		    window.onbeforeunload = function(){
		    	grid2.blur();
		        if(grid2.isModified()){
		        	doExit();
		        }
		    };
		});
		
		function doExit(){
		    event.returnValue = '"페이지를 벗어 나시겠습니까?"';
		}
			
		
		
	</script>
</body>
</html>