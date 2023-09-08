<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품 조회</title>
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
	<h1>제품 조회</h1>

		<div>
			<div class="col-lg-12 stretch-card" >
				<div class="card">
					<div class="card-body">
						<div class="table-responsive pt-3">
							<form>
								<div>		
									<p>제품명</p>
									<input type="text" placeholder="검색어를 입력하세요" id="prodSearch" >
									<br>
									<p>제품구분</p>
									<select id="prodTypeList" name="prodKind" style="margin-bottom: 35px">
											<option value="">선택</option>
											<c:forEach items="${prodTypeList}" var="p">
												<option value="${p.commdeCode }">${p.commdeName }</option>
											</c:forEach>
									</select>
									
									<button type="button" class="btn btn-info btn-icon-text" id="searchBtn">
										<i class="fas fa-search"></i>검색
									</button>
									
									<button type="reset" class="btn btn-info btn-icon-text">초기화</button>
				            	</div>
			            	</form>
			            	<h2>제품 목록</h2>
			           		<div id="grid"></div>
						</div>
			   		</div>
				</div>
			</div> 
		</div>
			


    
	<script>
	
	//전체조회 ajax
	   let prodName = $('#prodSearch').val();
	   let prodKind = $('#prodTypeList').val();
	   let search = { prodName : prodName, prodKind:prodKind };
	$.ajax({
		   url : "ajaxProdCodeList",
	       method :"GET",
	       success : function(result){
	           grid.resetData(result);
	       },
	       error : function(reject){
				console.log(reject);
			}
	});
	
	//제품검색조회
	$('#searchBtn').on('click', searchProdIn);
function searchProdIn(e){
	   let prodName = $('#prodSearch').val();
	   let prodKind = $('#prodTypeList').val();
	   let search = { prodName : prodName, prodKind:prodKind };
	   $.ajax({
		   url : 'getProdCodeFilter',
		   method : 'GET',
		   data : search ,
		   success : function(data){
			   grid.resetData(data);
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
         header: '제품코드',
         name: 'prodCode',
         align: 'center',
         sortable: true,
         sortingType: 'asc'
       },
       {
         header: '제품명',
         name: 'prodName'
       },
       {
         header: '반/완제품구분',
         name: 'prodKind',
         hidden:true
       },
       {
         header: '반/완제품구분',
         name: 'kindName',
         align: 'center'
         },
       {
         header: '단위',
         name: 'prodUnit'
       },
       {
         header: '규격',
         name: 'prodStd'
       },
       {
           header: '유통기한(일)',
           name: 'prodExdate',
           align: 'right'
           }
     ]
   });
 
   
	
	</script>
</body>
</html>