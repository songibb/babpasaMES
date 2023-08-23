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
	<h3>자재 조회</h3>
	<div class="col-lg-12 stretch-card">
		<div class="card">
			<div class="card-body">
				<div class="table-responsive pt-3">
					<div id="">		
	                  자재명 <input type="text"  id="matSearch">
	                   <button type="button" class="btn btn-info btn-icon-text" id="searchBtn">
	                     <i class="fas fa-search"></i>
	                     검색
	                  </button>
	                  <button type="button" class="btn btn-info btn-icon-text" id="searchResetBtn">
	                     초기화
	                  </button>
		          	</div>
		          </div>
	           		<div id="grid"></div>
				
	   		</div>
		</div>
	</div>
<script>
		
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
			
			let content = $('#matSearch').val();
			let search = {matName : content};
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
			 	 	        name: 'matName'
			 	 	        
			 	 	  },
		 	 	      {
				 			header: '단위',
				 		 	name: 'matUnit'
				 	  },
				 	  
				 	 
				 	  {
		                    header: '규격',           
		                    name: 'matStd'
		              },
		              {
			 	 	        header: '안전재고량',
			 	 	        name: 'matSafe'
			 	 	  }
		        ]
		   
		      });
	
				    
		
</script>

</body>
</html>