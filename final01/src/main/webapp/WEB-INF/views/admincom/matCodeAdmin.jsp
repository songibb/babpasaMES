<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자재 관리</title>


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
	  padding: 5px;
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
		width: 80px;
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

td[data-column-name="matCode"]{
		cursor : pointer;
	}

	
</style>
</head>
<body>
<div class="black_bg"></div>
	<h1>자재 관리</h1>
	<div class="col-lg-12 stretch-card">
		<div class="card">
			<div class="card-body">
				<div class="table-responsive pt-3">
					<form>		
						<p>자재명 </p>
						<input type="text"  id="matSearch">
						<br>
						<p> 단위 </p>
						<select id="unitSearch" name="unitSearch">
								<option value="">선택</option>
								<c:forEach items="${unitList}" var="u">
									<option value="${u.commdeCode }">${u.commdeCode }</option>
								</c:forEach>
						</select> 
						<br>
						<p>규격 </p>
						<input type="text"  id="stdSearch" name="stdSearch" style="margin-bottom: 35px">
						<button type="button" class="btn btn-info btn-icon-text" id="searchBtn" style="margin-top: 0">
	                     <i class="fas fa-search"></i>
	                     검색
						</button>
						<button type="reset" class="btn btn-info btn-icon-text" id="searchResetBtn" style="margin-top: 0">
	                     초기화
						</button>
		          	</form>
		          </div>
		          <div>
		        	 <div>
		            	<h2>자재 목록</h2>
		            	<button id="matSave" class="btn btn-info btn-icon-text" >저장</button>
		            	<button id="delete" class="btn btn-info btn-icon-text" >삭제</button>
		            	<button id="matAdd" class="btn btn-info btn-icon-text">행추가</button>
	            	</div>
	           		<div id="grid"></div>
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
				swal("경고","변경사항이 없습니다","warning");
				return false;
			}
			
			if(!grid.isModified()){
				swal("경고","모든 값이 입력되지 않았습니다","warning");
				return false;
			}
			
			let flag = true;
			
		
			
			if(grid.getModifiedRows().createdRows.length > 0){
				
				
				
				$.each(grid.getModifiedRows().createdRows, function(idx2, obj2){
					
					
					if(obj2['matName'] == null ||obj2['matUnit'] == null || obj2['matStd'] == null || obj2['matSafe'] == null){
						flag = false;
						return false;
					}
					if(isNaN(obj2['matSafe'])==true){
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
					if(isNaN(obj2['matSafe'])==true || obj2['matSafe']>999999999){
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
						let errCount = data.fail;
						console.log(errCount);
						let success = grid.getModifiedRows().deletedRows.length;
						console.log(success);
						let total = data.success;
						let message = success-errCount+total +"건 저장완료 \n" + errCount +"건 저장실패 \n (사용중인 자재는 삭제되지 않습니다)"
						swal("성공", message,"success");
						
						$('form')[0].reset();
						$.ajax({
							url : "ajaxMatCodeList",
							 method :"GET",
						       success : function(result){   
						           grid.resetData(result);
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
			}else{
				swal("경고","모든값이 입력되지 않았거나 정보 타입을 확인해 주세요","warning");
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
		})
		
		//자재명 검색 조회
		$('#searchBtn').on('click', searchMat);
		function searchMat(e){
			
			let matName = $('#matSearch').val();
			let matUnit = $('#unitSearch').val();
			let matStd = $('#stdSearch').val();
			let search = {matName : matName, matUnit : matUnit, matStd : matStd };
			$.ajax({
				url : "searchMatCodeList",
				 method :"GET",
				 data : search,
			       success : function(result){
			           grid.resetData(result);
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
		        rowHeaders: [{type: 'rowNum'},{type: 'checkbox'}],
				pageOptions: {
					useClient: true,
			        perPage: 10
			      },
		        columns: [
		        	  {
			 	 	        header: '자재코드',
			 	 	        name: 'matCode',
		 	 	            align: 'center',
			 	 	        sortable: true,
		 	 	            sortingType: 'asc'
		 	 	      },
		 	 	      {
			 	 	        header: '자재명',
			 	 	        name: 'matName',
			 	 	    	editor : 'text'
			 	 	        
			 	 	  },
		 	 	      {
				 			header: '단위',
				 		 	name: 'matUnit',
		 	 	            align: 'center',
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
		 	 	            align: 'right',
			 	 	        editor : 'text',
			 	 	      validation: {
			 	 	        dataType: 'number',
			 	 	        required: true
			 	 	      },
			 	 	    formatter(e) {
		                    	if (e['value'] != null){
		    	                val = e['value']
		    	                    .toString()
		    	                    .replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		    	                return val;
		                    	}
		    	            }
			 	 	  }
		        ]
		   
		      });
	
				    
		
</script>

</body>
</html>