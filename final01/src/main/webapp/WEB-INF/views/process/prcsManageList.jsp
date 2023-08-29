<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공정 관리</title>

<!-- 토스트 페이지 네이션 -->
<script type="text/javascript" src="https://uicdn.toast.com/tui.code-snippet/latest/tui-code-snippet.js"></script>
<link rel="stylesheet" href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css" />
<script src="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.js"></script>
<!-- 페이지 네이션 끝 -->
<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>

<style type="text/css">
form p{
	width: 180px;
	display: inline-block;
	font-size: 20px;
}
form select {
	width: 10%;
	padding: 6px;
	margin-bottom: 15px;
	border: 1px solid #ccc;
	border-radius: 4px;
}
form input[type="checkbox"] {
	width: 15%;
	padding: 6px;
	margin-bottom: 30px;
	border: 1px solid #ccc;
	border-radius: 4px;
}
h1{
	margin-left: 15px;
}
h1, h2{
	font-weight: 800;
}
h2{
	display: inline-block;
}
#gridHeader{
	display: flex;
	justify-content: space-between;
}


</style>
</head>
<body>
	<div class="black_bg"></div>
	<h1>공정 관리</h1>
	<div class="col-lg-12 stretch-card">
		<div class="card">
			<div class="card-body">
				<div class="table-responsive pt-3">
					<form>	
						<p>공정구분</p>
						<select id="searchPrcsType" name="searchPrcsType">
							<option value="">선택</option>
							<c:forEach items="${prcsTypeList}" var="p">
								<option value="${p.commdeCode}">${p.commdeName }</option>
							</c:forEach>
						</select>
						<br>	
						<p>반제품생산공정여부</p>
      					<label for="semiYes"><input type="checkbox" name="semiCk" id="semiYes">반제품유</label>
      					<label for="semiNo"><input type="checkbox" name="semiCk" id="semiNo">반제품무</label>
      					
      					<button type="button" class="btn btn-info btn-icon-text" id="searchBtn">
							<i class="fas fa-search"></i>검색
						</button>
						<button type="reset" class="btn btn-info btn-icon-text" id="resetBtn">초기화</button>
	            	</form>
	            </div>	
	            
	            <div id="gridHeader">
		            <h2>공정 목록</h2>
	            	<div>
		           		<button id="addBtn" class="btn btn-info btn-icon-text">추가</button>
		           		<button id="removeBtn" class="btn btn-info btn-icon-text">삭제</button>
		           		<button id="saveBtn" class="btn btn-info btn-icon-text">저장</button>
	           		</div>
           		</div>
           		
           		<div id="grid"></div>
				
	   		</div>
		</div>
	</div> 

	<script>
	
	//추가
	document.getElementById('addBtn').addEventListener('click', addRow);
	//삭제
	document.getElementById('removeBtn').addEventListener('click', removeRow);
	//저장
	document.getElementById('saveBtn').addEventListener('click', saveServer);
	
	//검색
	document.getElementById('searchBtn').addEventListener('click', searchPrcsManageList);
	
	//공정관리 조회
// 	function selectListAjax(){
// 		$.ajax({
// 	        url : "selectPrcsManageList",
// 	        method :"GET",
// 	        success : function(result){
// 	            grid.resetData(result);
// 	        },
// 	        error : function(reject){
// 	 			console.log(reject);
// 	 		}
// 		})
// 	}
	
// 	selectListAjax();
	
	//공정관리 조회 (검색)
	function searchPrcsManageList(){

		let manageObj = {};
		manageObj['semiYes'] = 1;
		manageObj['semiNo'] = 1;
		
		manageObj['searchPrcsType'] = $('#searchPrcsType').val();
		if($('#semiYes').is(':checked')){
 			manageObj['semiYes'] = 2;
		}
		if($('#semiNo').is(':checked')){
			manageObj['semiNo'] = 2;
		}
		if($('#semiYes').is(':checked') && $('#semiNo').is(':checked')){
			manageObj['semiYes'] = 1;
			manageObj['semiNo'] = 1;
		}
	
		
		$.ajax({
	        url : "selectPrcsManageList",
	        method :"GET",
	        data : manageObj,
	        success : function(result){
	            grid.resetData(result);
	        },
	        error : function(reject){
	 			console.log(reject);
	 		}
		})
		
	}
	

	function addRow(){	
		grid.appendRow({}, {at:0});
	};
	
	function removeRow(){
		grid.removeCheckedRows(false);
	}
	
	function saveServer(){
		grid.blur();
		let modifyGrid = grid.getModifiedRows();

		if(!grid.isModified()){
			swal("경고", "변경사항이 없습니다.", "warning");
			return false;
		}
		
		//빈 데이터가 있는지 확인할 변수
		let flag = true;
		
		//등록
		if(modifyGrid.createdRows.length > 0){
			$.each(modifyGrid.createdRows, function(idx, obj){
				if(obj['prcsType'] == '' || obj['prcsName'] == '' || obj['semiYn'] == ''){
					flag = false;
					return false;
				}
			})
		}
		
		//수정
		if(modifyGrid.updatedRows.length > 0){
			$.each(modifyGrid.updatedRows, function(idx, obj){
				if(obj['prcsType'] == '' || obj['prcsName'] == '' || obj['semiYn'] == ''){
					flag = false;
					return false;
				}
			})
		}
		
		console.log(modifyGrid);
		if(flag){
			$.ajax({
				url : 'updatePrcsManage',
				method : 'POST',
				data : JSON.stringify(modifyGrid),
				contentType : 'application/json',
				success : function(data){
					console.log(data);
					swal("성공", data +"건이 처리되었습니다.", "success");
					selectListAjax();
				},
				error : function(reject){		
					console.log(reject);
					swal("실패", "처리되지 않았습니다.", "error");
				}
			})
		} else {
			swal("경고", "모든 값이 입력되지 않았습니다.", "warning");
		}
	
	}
	


    var grid = new tui.Grid({
        el: document.getElementById('grid'),
        data: [
	           <c:forEach items="${prcsManageList}" var="p" varStatus="status">
	           	{
	           		prcsCode : "${p.prcsCode}",
	           		prcsType : "${p.prcsType}",
	           		prcsName : "${p.prcsName}",
	           		semiYn : "${p.semiYn}"
	           	} <c:if test="${not status.last}">,</c:if>
	           </c:forEach>
	    ] ,
        scrollX: false,
        scrollY: false,
        minBodyHeight: 30,
		rowHeaders: ['rowNum', 'checkbox'],
		pagination: true,
		pageOptions: {
			useClient: true,
			perPage: 10,
		},
        columns: [
          {
            header: '공정코드',
            name: 'prcsCode',
          },
          {
            header: '공정구분',
            name: 'prcsType',
            formatter: 'listItemText',
            editor: {
                type: 'select',
                options: {
                	listItems: [
                    	<c:forEach items="${prcsTypeList}" var="pt">
                    	 {
                             text: '${pt.commdeName}',
                             value: '${pt.commdeCode}'
                           }, 
    					</c:forEach>
                    ]
                }
            } 
          },
  
          {
            header: '공정이름',
            name: 'prcsName',
            editor: 'text'
          },
          {
            header: '반제품생산공정여부',
            name: 'semiYn',
            formatter: 'listItemText',
            editor: {
                type: 'select',
                options: {
                	listItems: [
                    	<c:forEach items="${semiYnList}" var="syn">
                    	 {
                             text: '${syn.commdeName}',
                             value: '${syn.commdeCode}'
                           }, 
    					</c:forEach>
                    ]
                }
            } 
          }		          
        ]
      })  


	</script>
</body>
</html>