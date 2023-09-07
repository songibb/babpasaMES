<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사원 조회</title>
<!-- 토스트 페이지 네이션 -->
<script type="text/javascript"
	src="https://uicdn.toast.com/tui.code-snippet/latest/tui-code-snippet.js"></script>
<link rel="stylesheet"
	href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css" />
<script
	src="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.js"></script>
<!-- 페이지 네이션 끝 -->
<link rel="stylesheet"
	href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@700&family=Noto+Sans+KR&display=swap"
	rel="stylesheet">
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
	
	
	.yellow-background {
        background-color: rgb(255,253,235);
	}
	
</style>
</head>
<body>
<div class="black_bg"></div>
   <h1>사원 조회</h1>
   <div class="col-lg-12 stretch-card">
       <div class="card">
           <div class="card-body">
               <div class="table-responsive pt-3">
                   <form action="" method="get" name="formInfo">
                   		<p>사원명</p>
						<input type="text" placeholder="검색어를 입력하세요" id="empSearch">
						<br>	
                  		<p>부서명</p>
                  		 	<select id="inputDeptSearch" name="deptCode">
								<option value="">선택</option>
								<c:forEach items="${inputDeptList}" var="d">
									<option value="${d.commdeCode }">${d.commdeName }</option>
								</c:forEach>
							</select>
						<br>
						<p>재직구분</p>
                 			<select id="selectEmpIngSearch" name="selectEmpIngSearch">
							<option value="">선택</option>
							<option value="재직">재직자</option>
							<option value="퇴사">퇴사자</option>
						</select>
						<br>
						<p>입사일자</p>
						<input id="startDate" type="date">&nbsp;&nbsp;-&nbsp;&nbsp;<input id="endDate" type="date" style="margin-bottom: 35px">
						<button type="button" class="btn btn-info btn-icon-text" id="searchBtn" style="margin-top: 0">
						<i class="fas fa-search"></i>검색
						</button>
						<button type="reset" class="btn btn-info btn-icon-text" style="margin-top: 0">초기화</button>
               	</form>
               	<h2>사원 목록</h2>
               <div id="grid"></div>
                </div>
         </div>
      </div>
   </div> 
    <div>
		<jsp:include page="../comFn/dateFormat.jsp"></jsp:include>
	</div>
<script>
	//이전 날짜 선택불가
	$('#startDate').on('change', function () {
	    $('#endDate').attr('min', $('#startDate').val());
	});
	//이후날짜 선택불가
	$('#endDate').on('change', function () {
	    $('#startDate').attr('max', $('#endDate').val());
	});

//사원명/부서명/입사일자검색조회
	$('#searchBtn').on('click', searchEmpIn);
	function searchEmpIn(e){
		let inputDeptList = $('#inputDeptSearch').val();
		   let empName = $('#empSearch').val();
		   let startDate = $('#startDate').val();
		   let endDate = $('#endDate').val();
		   let selectEmpIngSearch = $('#selectEmpIngSearch').val();
		   let search = { inputDeptList : inputDeptList, empName : empName, startDate : startDate, endDate : endDate, selectEmpIngSearch :selectEmpIngSearch };
		   $.ajax({
			   url : 'ajaxEmpList',
			   method : 'GET',
			   data : search,
			   success : function(data){
				   $.each(data, function(i, objDe){
						let empDate = data[i]['empDate'];
						data[i]['empDate'] = getDate(empDate);
						
						let empLeaveDate = data[i]['empLeaveDate'];
						if(empLeaveDate==null){
							data[i]['empLeaveDate'] = "-";
						}else{
						data[i]['empLeaveDate'] = getDate(empLeaveDate);
						}
						  
						})
				   grid.resetData(data);
				   stopEdit();
				   
				   
				 
			   },
			   error : function(reject){
				   console.log(reject);
			   }
		   })
	}
	//ajax 전체조회
let inputDeptList = $('#inputDeptSearch').val();
		   let empName = $('#empSearch').val();
		   let startDate = $('#startDate').val();
		   let endDate = $('#endDate').val();
		   let selectEmpIngSearch = $('#selectEmpIngSearch').val();
		   let search = { inputDeptList : inputDeptList, empName : empName, startDate : startDate, endDate : endDate, selectEmpIngSearch :selectEmpIngSearch };
	   $.ajax({
		   url : 'ajaxEmpList',
		   method : 'GET',
		   data : search,
		   success : function(data){
			   $.each(data, function(i, objDe){
					let empDate = data[i]['empDate'];
					data[i]['empDate'] = getDate(empDate);
					
					let empLeaveDate = data[i]['empLeaveDate'];
					if(empLeaveDate==null){
						data[i]['empLeaveDate'] = "-";
					}else{
					data[i]['empLeaveDate'] = getDate(empLeaveDate);
					}
					})
			   grid.resetData(data);
			   stopEdit();
		   },
		   error : function(reject){
			   console.log(reject);
		   }
	   })
	   
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
	           header: '사원번호',
	           name: 'empCode',
	           align: 'center'
	         },
	         {
	           header: '사원명',
	           name: 'empName',
	           align: 'center'
	         },
	         {
	           header: '입사일',
	           name: 'empDate',
	           align: 'center',
	           sortable: true,
	           sortingType: 'asc',
	           className: 'yellow-background'
	         },
	         {
	           header: '퇴사일',
	           name: 'empLeaveDate',
	           align: 'center',
	           sortable: true,
	           sortingType: 'asc',
	           className: 'yellow-background'
		         },
	         {
	           header: '권한',
	           name: 'empRole',
	           align: 'center',
	           hidden: true
		      },
	         {
	           header: '직급정보',
	           name: 'empRoleName',
	           align: 'center'
	         },
	         {
	           header: '부서명',
	           name: 'deptCode',
	           hidden: true
	         },
	         {
	           header: '부서명',
	           name: 'deptcodeName',
	           align: 'center'
	         },
	         {
	           header: '연락처',
	           name: 'empTel',
	           align: 'center'
	         }
	       ]
	      
	     });
	
	
	   function stopEdit(){
			$.each(grid.getData(), function(idx, obj){
				
				if(obj['empLeaveDate'] != '-'){
					grid.disableRow(obj['rowKey']);
				}
			})
		}

</script>
</body>
</html>