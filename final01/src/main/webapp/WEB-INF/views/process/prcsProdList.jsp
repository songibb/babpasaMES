<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품 공정 흐름도</title>

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

#prodContainer{
	display: flex;
	justify-content: center;
}
#leftGrid{
    width: 600px;
    margin-right: 20px;
}
#leftGridHeader{
	height: 45px;
}
#rightGrid{
    width: 1000px;
}
#rightGridHeader{
	height: 45px;
	display: flex;
	justify-content: space-between;
}
#rightGridHeader div:first-child{
	margin-top: 10px;
}
#rightGridHeader p{
	width: 80px;
	display: inline-block;
	font-size: 20px;
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
</style>
</head>
<body>
	<div class="black_bg"></div>
	<h1>제품 공정 흐름도</h1>
	<div class="col-lg-12 stretch-card">
		<div class="card">
			<div class="card-body">
				<div class="table-responsive pt-3">
				</div>
				<div id="prodContainer">
					<div id="leftGrid">
						<div id="leftGridHeader">
							<h2>제품 목록</h2>
						</div>
	           			<div id="grid"></div>
	           		</div>
	           		<div id="rightGrid">
	           			<div id="rightGridHeader">
	           				<div>
	           					<p>제품명 : </p> 
		           				<input type="text" name="prodName" id="prodName" readonly>
		           			</div>	
		           			<div>
		           				<button id="addBtn" class="btn btn-info btn-icon-text">추가</button>
								<button id="removeBtn" class="btn btn-info btn-icon-text">삭제</button>
								<button id="saveBtn" class="btn btn-info btn-icon-text">저장</button>		            		
							</div>
	           			</div>
	           			<div id="grid2"></div>
	           		</div>
				</div>
	   		</div>
		</div>
	</div> 

	<div class="modal">
		<div class="modal_content" title="클릭하면 창이 닫힙니다.">
			<div class="m_head">
				<div class="modal_title"><h3>목록</h3></div>
				<div class="close_btn" id="close_btn">X</div>
			</div>
			<div class="m_body">
				<div id="modal_label"></div>
			</div>
<!-- 			<div class="m_footer"> -->
<!-- 				<div class="modal_btn save" id="save_btn">선택</div> -->
<!-- 			</div> -->
		</div>
	</div>
    
	<script>
	//추가
	document.getElementById('addBtn').addEventListener('click', addRow);
	//삭제
	document.getElementById('removeBtn').addEventListener('click', removeRow);
	//저장
	document.getElementById('saveBtn').addEventListener('click', saveServer);
	
	
	function addRow(){	
		grid2.appendRow();
	};
	
	function removeRow(){
		grid2.removeCheckedRows(false);
	}
	

	//제품 조회
	var grid = new tui.Grid({
        el: document.getElementById('grid'),
        data: [
	           <c:forEach items="${prodList}" var="p" varStatus="status">
	           	{
	           		prodCode : "${p.prodCode}",
	           		prodName : "${p.prodName}"
	           	} <c:if test="${not status.last}">,</c:if>
	           </c:forEach>
	    ],
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
            header: '제품코드',
            name: 'prodCode'
          },
          {
            header: '제품명',
            name: 'prodName'
          }
        ]
    })  
	
	function saveServer(){
		grid2.blur();
		let modifyGrid = grid2.getModifiedRows();

		if(!grid2.isModified()){
			swal("변경사항이 없습니다.", "", "warning");
			return false;
		}
		
		//빈 데이터가 있는지 확인할 변수
		let flag = true;
		
		//등록
		if(modifyGrid.createdRows.length > 0){
			$.each(modifyGrid.createdRows, function(idx, obj){
				if(obj['prcsCode'] == '' || obj['prcsName'] == '' || obj['prcsSeq'] == ''){
					flag = false;
					return false;
				}
			})
		}
		
		//수정
		if(modifyGrid.updatedRows.length > 0){
			$.each(modifyGrid.updatedRows, function(idx, obj){
				if(obj['prcsCode'] == '' || obj['prcsName'] == '' || obj['prcsSeq'] == ''){
					flag = false;
					return false;
				}
			})
		}
		
		let prRowKey = grid.getFocusedCell().rowKey;
		let prodCode = grid.getValue(prRowKey, 'prodCode');
		modifyGrid['prodCode'] = prodCode;
		
		
		let modiList = { prodCode : prodCode , gridVO : modifyGrid }
		console.log(modiList);
		if(flag){
			$.ajax({
				url : 'updatePrcsProd',
				method : 'POST',
				data : JSON.stringify(modiList),
				contentType : 'application/json',
				success : function(data){
					console.log(data);
					swal("성공", data +"건이 처리되었습니다.", "success");
					selectListAjax();
				},
				error : function(reject){		
					console.log(reject);
					swal("실패", "", "error");
				}
			})
		} else {
			swal("", "모든 값이 입력되지 않았습니다.", "warning");
		}
	
	}
	
	
	//제품별공정 조회
    var grid2 = new tui.Grid({
        el: document.getElementById('grid2'),
        scrollX: false,
        scrollY: false,
        minBodyHeight: 400,
		rowHeaders: ['rowNum', 'checkbox'],
		pagination: true,
		pageOptions: {
			useClient: true,
			perPage: 10,
		},
        columns: [
          {
            header: '공정코드',
            name: 'prcsCode'
          },
          {
        	header: '공정이름',
        	name: 'prcsName',
        	editor: 'text'
          },
          {
            header: '공정순서',
            name: 'prcsSeq',
            editor: 'text'
          }		          
        ]
    })  
    
	//제품 클릭시 해당 제품의 공정목록 조회
	grid.on('click', () => {
    	//클릭한 제품의 제품코드 가져오기
    	let rowKey = grid.getFocusedCell().rowKey;
    	let prodCode = grid.getValue(rowKey, 'prodCode');
    	let prodName = grid.getValue(rowKey, 'prodName');
    	$('#prodName').val(prodName);
    	
    	$.ajax({
			url : 'selectPrcsProdList',
			method : 'GET',
			data : { prodCode : prodCode },
			success : function(data){
 				grid2.resetData(data);
 		    },
			error : function(reject){
	 			console.log(reject);
	 		}	
		})
  	});
	
	//공정이름 더블클릭시 공정 모달
	grid2.on('dblclick' ,() => {
		
		let rowKey = grid2.getFocusedCell().rowKey;
    	let columnName = grid2.getFocusedCell().columnName;
    	let value = grid2.getFocusedCell().value; 
    	let no = grid2.getValue(rowKey,'bomNo');
    	if(columnName == 'prcsName' && no ==null){
    		$(".modal").fadeIn();
  	       Grid = createPrcsGrid();
  	       
  	       Grid.on('dblclick', () => {
  	    	 let rowKey2 = Grid.getFocusedCell().rowKey;
  	    	 if(rowKey2 != null){
  	    		let prcsCode = Grid.getValue(rowKey2, 'prcsCode');
 	        	let prcsName = Grid.getValue(rowKey2, 'prcsName');
 	        	grid2.finishEditing(rowKey, columnName);
 	        	
 	        	if(prcsCode != null){
 	        		grid2.setValue(rowKey, 'prcsCode', prcsCode);
 	        	}
 	         	if(prcsName != null){
 	         		grid2.setValue(rowKey, 'prcsName', prcsName);
 	        	} 
  	    	 }
  	    	 
  	    	 if(rowKey2 != null){
  	    		$(".modal").fadeOut();
	        		Grid.destroy();
  	    	 }
  	    	 
  	    	 
  	       });
    	}
	})
	
   	function createPrcsGrid(){
   		
   		var prcsGrid = new tui.Grid({
   			el: document.getElementById('modal_label'),
			scrollX: false,
			scrollY: false,
			minBodyHeight: 30,
			rowHeaders: ['rowNum'],
			selectionUnit: 'row',
			pagination: true,
			pageOptions: {
			//백엔드와 연동 없이 페이지 네이션 사용가능하게 만듦
			  useClient: true,
			  perPage: 10
			},
			columns: [
			   {
			        header: '공정코드',
			        name: 'prcsCode',
			      },
			      {
			        header: '공정구분',
			        name: 'prcsType',
			   },
			      {
			        header: '공정이름',
			        name: 'prcsName'
			      },
			      {
			     header: '반제품공정구분',
			     name: 'semiYn'
			   }
			]
		});
   		
   		$.ajax({
		    url : 'selectPrcsManageList',
		    method : 'GET',
		    success : function(data){
		    	prcsGrid.resetData(data);
		    },
		    error : function(reject){
		        console.log(reject);
		    }	
		})
   		
   		return prcsGrid;
   	}
	
	$("#close_btn").click(function(){
	    $(".modal").fadeOut();
	  	Grid.destroy();
	});

	</script>
</body>
</html>