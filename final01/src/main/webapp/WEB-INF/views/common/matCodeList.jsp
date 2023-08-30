<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자재 조회</title>


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
	
</style>
</head>
<body>
<div class="black_bg"></div>
	<h1>자재 조회</h1>
	<div class="col-lg-12 stretch-card">
		<div class="card">
			<div class="card-body">
				<div class="table-responsive pt-3">
					<form>		
	                  <p>자재명</p> 
	                  <input type="text"  id="matSearch">
	                  <br>
	                  <p>단위</p> 
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
		          	<h2>자재 목록</h2>
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
		        rowHeaders: ['rowNum'],
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
			 	 	        name: 'matName'
			 	 	        
			 	 	  },
		 	 	      {
				 			header: '단위',
				 		 	name: 'matUnit',
				 		 	align: 'center',
				 	  },
				 	  
				 	 
				 	  {
		                    header: '규격',           
		                    name: 'matStd'
		              },
		              {
			 	 	        header: '안전재고량',
			 	 	        name: 'matSafe',
			 	 	        align: 'right',
			 	 	      formatter(e) {
				                val = e['value']
				                    .toString()
				                    .replace(/\B(?=(\d{3})+(?!\d))/g, ',');
				                return val;
				            }
			 	 	  }
		        ]
		   
		      });
	
				    
		
</script>

</body>
</html>