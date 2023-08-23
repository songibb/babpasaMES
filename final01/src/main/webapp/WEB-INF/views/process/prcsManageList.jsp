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

</head>
<body>
	<div class="black_bg"></div>
	<h2>공정 관리</h2>
	<div class="col-lg-12 stretch-card">
		<div class="card">
			<div class="card-body">
				<div class="table-responsive pt-3">
					<form>
						<div id="customtemplateSearchAndButton">		
		            	</div>
	            	</form>
	            </div>	
	            
            	<div>
	           		<button id="addBtn" class="btn btn-info btn-icon-text">추가</button>
	           		<button id="saveBtn" class="btn btn-info btn-icon-text">저장</button>
	           		<button id="removeBtn" class="btn btn-info btn-icon-text">삭제</button>
           		</div>
           	
           		<div id="grid"></div>
				
	   		</div>
		</div>
	</div> 

	<script>
	
	//추가
	document.getElementById('addBtn').addEventListener('click', addRow);
	//저장
	document.getElementById('saveBtn').addEventListener('click', saveServer);
	//삭제
	document.getElementById('removeBtn').addEventListener('click', removeRow);
	
	
	//공정관리 조회
	function selectListAjax(){
		$.ajax({
	        url : "selectPrcsManageList",
	        method :"GET",
	        success : function(result){
	            grid.resetData(result);
	        },
	        error : function(reject){
	 			console.log(reject);
	 		}
		})
	}
	
	selectListAjax();
	
	
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
			swal("변경사항이 없습니다", "", "warning");
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
					swal("실패", "", "error");
				}
			})
		} else {
			swal("", "값이 입력되지 않았습니다", "warning");
		}
	
	}
	


    var grid = new tui.Grid({
        el: document.getElementById('grid'),
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