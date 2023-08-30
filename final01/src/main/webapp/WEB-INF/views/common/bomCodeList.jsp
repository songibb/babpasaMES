<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BOM조회</title>
	<!-- 토스트 페이지 네이션 -->
    <script type="text/javascript" src="https://uicdn.toast.com/tui.code-snippet/latest/tui-code-snippet.js"></script>
    <link rel="stylesheet" href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css" />
    <script src="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.js"></script>
    <!-- 페이지 네이션 끝 -->
    <link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
    <script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>   
    <style>
    	.yellow-background {
        background-color: rgb(255,253,235);
		}
		
			input[type="text"],
	select {
	  width: 28%;
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
	<h1>BOM 조회</h1>
	<div class="col-lg-12 stretch-card">
		<div class="card">
			<div class="card-body">
				<div class="table-responsive pt-3">
					<form style="width: 800px">
								
							<p>제품명</p> 
							<input type="text" placeholder="검색어를 입력하세요" id="bomSearch" style="margin-bottom: 35px">
							<button type="button" class="btn btn-info btn-icon-text" id="searchBtn">
								<i class="fas fa-search"></i>검색
							</button>
							<button type="reset" class="btn btn-info btn-icon-text">초기화</button>
		            	
	            	</form>
	            	</div>
	            	<h2> BOM 목록 </h2>
	           		<div id="grid"></div>
	           		<h2> BOM 상세 목록 </h2>
	           		<div id="grid2"></div>
				
	   		</div>
		</div>
	</div> 

    
	<script>
	
	//제품명으로 BOM조회
	$('#searchBtn').on('click', searchProdIn);
   function searchProdIn(e){
	   let content = $('#bomSearch').val();
	   let search = { prodName : content };
	   $.ajax({
		   url : 'bomSearch',
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

   //bmo 조회
    var grid = new tui.Grid({
        el: document.getElementById('grid'),
        data: [
	           <c:forEach items="${bomList}" var="b" varStatus="status">
	           	{
	           		bomNo : "${b.bomNo}",
	           		prodCode :"${b.prodCode}",
	           		bomWdate :"<fmt:formatDate value='${b.bomWdate}' pattern='yyyy-MM-dd'/>",
	           		bomUdate :"<fmt:formatDate value='${b.bomUdate}' pattern='yyyy-MM-dd'/>",
	           		bomYn : "${b.bomYnName}",
	           		bomPrcsYn : "${b.bomPrcsYnName}",
	           		prodName : "${b.prodName}"
	           	} <c:if test="${not status.last}">,</c:if>
	           </c:forEach>
	          ],
        scrollX: false,
        scrollY: false,
        minBodyHeight: 120,
		rowHeaders: ['rowNum'],
		pagination: true,
		pageOptions: {
			useClient: true,
			perPage: 3,
		},
        columns: [
          {
            header: 'NO',
            name: 'bomNo',
            align: 'center',
            sortable: true,
	        sortingType: 'asc'
          },
          {
              header: '제품코드',
              name: 'prodCode',
              align: 'center'
            },
          {
              header: '제품명',
              name: 'prodName'
            },
          {
            header: '등록날짜',
            name: 'bomWdate',
            align: 'center',
            sortable: true,
	          sortingType: 'asc',
		    className: 'yellow-background'
          },
          {
            header: '수정날짜',
            name: 'bomUdate',
            align: 'center',
            sortable: true,
	          sortingType: 'asc',
		    className: 'yellow-background'
          },
          {
            header: '사용여부',
            name: 'bomYn',
            align: 'center'
          },
          {
            header: '공정사용여부',
            name: 'bomPrcsYn',
            align: 'center'
          }
        ]
      })  

    //bom상세조회
      //제품별 bno 클릭시 해당 계획의 상세BOM 조회

        var grid2 = new tui.Grid({
        el: document.getElementById('grid2'),
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
            header: 'NO',
            name: 'bomNo',
            align: 'center'
          },
          {
              header: 'BOM코드',
              name: 'bomCode',
              align: 'center'
            },
          {
                header: '공정명',
                name: 'prcsName',
            },
          {
            header: '자재/반제품구분',
            name: 'kindName',
            align: 'center'
          },
          {
            header: '자재/반제품명',
            name: 'mpName'
          },
          {
            header: '단위',
            name: 'bomUnit',
            align: 'center'
          },
          {
            header: '사용량',
            name: 'bomAmt',
            align: 'right',
            formatter(e) {
                val = e['value']
                    .toString()
                    .replace(/\B(?=(\d{3})+(?!\d))/g, ',');
                return val;
            }
          }
        ]
      })  
   
    grid.on('click', () => {
    	//클릭한 제품 BOM가져오기
    	let rowKey = grid.getFocusedCell().rowKey;
    	let bomNo = grid.getValue(rowKey, 'bomNo');

    	$.ajax({
			url : 'bomDecodeList',
			method : 'GET',
			data : { bomNo : bomNo },
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