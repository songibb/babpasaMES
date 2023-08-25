<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품조회</title>
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
	  margin-bottom: 10px;
	  margin-top: 3px;
	  font-weight: bold;
	}
	
	input[type="text"],
	select {
	  width: 100%;
	  padding: 10px;
	  margin-bottom: 10px;
	  border: 1px solid #ccc;
	  border-radius: 4px;
	}
	
	select {
	  background-color: white; 
	}
	
</style>
</head>
<body>
	<div class="black_bg"></div>
	<h3>제품조회</h3>

		<div>
			<div class="col-lg-12 stretch-card" >
				<div class="card">
					<div class="card-body">
						<div class="table-responsive pt-3">
							<form>
								<div>		
									제품명 <input type="text" placeholder="검색어를 입력하세요" id="prodSearch" style="width: 20%">
									<br>
									제품구분
									<select id="prodTypeList" name="prodKind" style="width: 20%">
											<option value="">선택</option>
											<c:forEach items="${prodTypeList}" var="p">
												<option value="${p.commdeCode }">${p.commdeName }</option>
											</c:forEach>
									</select>
									<button type="button" class="btn btn-info btn-icon-text" id="searchBtn">
										<i class="fas fa-search"></i>검색
									</button>
									
									<button type="reset" class="btn btn-info btn-icon-text">초기화</button>
										<button type="button" class="btn btn-info btn-icon-text" id="deleteProd">삭제</button>
				            	</div>
			            	</form>
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
     minBodyHeight: 30,
		rowHeaders: [{type:'rowNum'},{type: 'checkbox'}],
		pagination: true,
		pageOptions: {
			useClient: true,
			perPage: 10,
		},
     columns: [
       {
         header: '제품코드',
         name: 'prodCode',
         filter: 'text'
       },
       {
         header: '제품명',
         name: 'prodName',
         filter: 'text'
       },
       {
         header: '반/완제품구분',
         name: 'prodKind',
         filter: 'select',
         hidden:true
       },
       {
         header: '반/완제품구분',
         name: 'kindName',
         filter: 'select'
         },
       {
         header: '단위',
         name: 'prodUnit'
       },
       {
         header: '규격',
         name: 'prodStd'
       }
     ]
   });
 
   
	
	</script>
</body>
</html>