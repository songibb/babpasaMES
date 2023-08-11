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

</head>
<body>
	<div class="black_bg"></div>
	<h2>제품 공정 흐름도</h2>
	<div class="col-lg-12 stretch-card">
		<div class="card">
			<div class="card-body">
				<div class="table-responsive pt-3">
	           		<div id="grid"></div>
	           		<div>
	           			<span>제품명 : </span> 
	           			<input type="text" name="prodName" id="prodName" readonly>
	           		</div>
	           		<div id="grid2"></div>
				</div>
	   		</div>
		</div>
	</div> 

    
	<script>
	
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
        minBodyHeight: 30,
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
	
	
	//제품별공정 조회
    var grid2 = new tui.Grid({
        el: document.getElementById('grid2'),
        scrollX: false,
        scrollY: false,
        minBodyHeight: 30,
		rowHeaders: ['rowNum'],
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
        	name: 'prcsName'
          },
          {
            header: '공정순서',
            name: 'prcsSeq'
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
	

			

	</script>
</body>
</html>