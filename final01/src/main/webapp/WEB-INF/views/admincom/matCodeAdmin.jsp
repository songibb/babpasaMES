<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>생산 지시</title>


<!-- 반드시 순서 중요함 time-picker date-picker가 toastui-calendar.min.js -->
<script src="https://uicdn.toast.com/tui.time-picker/latest/tui-time-picker.js"></script>
<script src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
<script src="https://uicdn.toast.com/calendar/latest/toastui-calendar.min.js"></script>
<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
<script src="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.js"></script>

<link rel="stylesheet" href="https://uicdn.toast.com/tui.time-picker/latest/tui-time-picker.css" />
<link rel="stylesheet" href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />
<link rel="stylesheet" href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css" />
<link rel="stylesheet" href="https://uicdn.toast.com/calendar/latest/toastui-calendar.min.css" />
<link rel="stylesheet" href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css"/>

</head>
<body>
<div class="black_bg"></div>
	<h3>자재 관리</h3>
	<div class="col-lg-12 stretch-card">
		<div class="card">
			<div class="card-body">
				<div class="table-responsive pt-3">
					<div id="">		
	                  자재명 <input type="text"  id="matCodeInput">
	                   <button type="button" class="btn btn-info btn-icon-text" id="searchBtn">
	                     <i class="fas fa-search"></i>
	                     검색
	                  </button>
	                  <button type="button" class="btn btn-info btn-icon-text" id="searchResetBtn">
	                     초기화
	                  </button>
		          	</div>
		          </div>
		          <div style="display: flex; justify-content: right;">
	            	<button id="matSave" class="btn btn-info btn-icon-text" >저장</button>
	            	<button id="delete" class="btn btn-info btn-icon-text" >삭제</button>
	            	<button id="matAdd" class="btn btn-info btn-icon-text">행추가</button>
	            	</div>
	           		<div id="grid"></div>
				
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
            
    </div>
  </div>
	</div>
<script>
		//삭제버튼
		$('#delete').on("click",function(){
			//그리드 행 지움
			grid.removeCheckedRows(false);
			//마우스 커서 없앰
			grid.blur();
			});
		
		
		//저장버튼
		document.getElementById('matSave').addEventListener('click', matSave);
		//행추가
		document.getElementById('matAdd').addEventListener('click', addMatRow);
		
		function addMatRow(){
			grid.appendRow({},{ at: 0 });
		}
		
		function matSave(){
			grid.blur();
			let modifyGridInfo = grid.getModifiedRows();
			
			if(!grid.isModified()){
				swal("값이 모두 입력되지 않았습니다","success");
				return false;
			}
			
			let flag = true;
			
			if(grid.getModifiedRows().createdRows.length > 0){
				
				$.each(grid.getModifiedRows().createdRows, function(idx2, obj2){
					if(obj2['matName'] == '' ||obj2['matUnit'] == '' || obj2['matStd'] == '' || obj2['matSafe'] == ''){
						flag = false;
						return false;
					}
					
				})
			}
			
			if(grid.getModifiedRows().updatedRows.length > 0){
				
				$.each(grid.getModifiedRows().updatedRows, function(idx2, obj2){
					if(obj2['matName'] == "" ||obj2['matUnit'] =="" || obj2['matStd'] == "" || obj2['matSafe'] == ""){
						flag = false;
						return false;
					}
				})
			}
			
			if(flag){
				$.ajax({
					url : 'updateMatCode',
					method : 'POST',
					data : JSON.stringify(grid.getModifiedRows()),
					contentType : 'application/json',
					success : function(data){
						swal("성공", data+"건이 처리되었습니다","success");
					},
					error : function(reject){
						console.log(reject);
					}
				})
			}else{
				swal("값이 입력되지 않았습니다","fail");
			}
			
		}
			
			
			
		
		//자재 리스트 조회
		$.ajax({
			url : "ajaxMatCodeList",
			 method :"GET",
		       success : function(result){
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
		        minBodyHeight: 30,
		        rowHeaders: [{type: 'rowNum'},{type: 'checkbox'}],
				pageOptions: {
					useClient: true,
			        perPage: 10
			      },
		        columns: [
		        	  {
			 	 	        header: '자재코드',
			 	 	        name: 'matCode'
		 	 	      },
		 	 	      {
			 	 	        header: '자재명',
			 	 	        name: 'matName',
			 	 	    	editor : 'text'
			 	 	        
			 	 	  },
		 	 	      {
				 			header: '단위',
				 		 	name: 'matUnit',
				 		 	formatter: 'listItemText',
				            editor: {
				                type: 'select',
				                options: {
				                  listItems: [
				                	<c:forEach items="${unitList}" var="u">
				                	 {
				                         text: '${u.commdeCode }',
				                         value: '${u.commdeCode }'
				                       }, 
									</c:forEach>
				                  ]
				                }
				              }
				 	  },
				 	  
				 	 
				 	  {
		                    header: '규격',           
		                    name: 'matStd',
		                    editor : 'text'
		              },
		              {
			 	 	        header: '안전재고량',
			 	 	        name: 'matSafe',
			 	 	        editor : 'text'
			 	 	  }
		        ]
		      });
	
				    
		
</script>

</body>
</html>