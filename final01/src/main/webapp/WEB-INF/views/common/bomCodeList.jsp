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
</head>
<body>
	<div class="black_bg"></div>
	<h3>BOM조회</h3>
	<div class="col-lg-12 stretch-card">
		<div class="card">
			<div class="card-body">
				<div class="table-responsive pt-3">
					<button type="button" class="btn btn-info btn-icon-text excelDownload">
		                Excel <i class="bi bi-printer"></i>                                                                              
					</button>
					<form>
						<div id="customtemplateSearchAndButton">		
							<p>제품명</p>
							<input type="text" placeholder="검색어를 입력하세요" id="bomSearch" ">
							<button type="button" class="btn btn-info btn-icon-text" id="searchBtn">
								<i class="fas fa-search"></i>검색
							</button>
							<button type="reset" class="btn btn-info btn-icon-text">초기화</button>
		            	</div>
	            	</form>
	            	</div>
	            	<p3> bom조회 </p3>
	           		<div id="grid"></div>
	           		<p3> bom상세조회 </p3>
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
	           		bomYn : "${b.bomYn}",
	           		bomPrcsYn : "${b.bomPrcsYn}",
	           		prodName : "${b.prodName}"
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
			perPage: 5,
		},
        columns: [
          {
            header: 'NO',
            name: 'bomNo',
            filter: 'text'
          },
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
            header: '등록날짜',
            name: 'bomWdate',
          },
          {
            header: '수정날짜',
            name: 'bomUdate'
          },
          {
            header: '사용여부',
            name: 'bomYn'
          },
          {
            header: '공정사용여부',
            name: 'bomPrcsYn'
          }
        ]
      })  

    //bom상세조회
      //제품별 bno 클릭시 해당 계획의 상세BOM 조회

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
            header: 'NO',
            name: 'bomNo',
          },
          {
              header: 'BOM코드',
              name: 'bomCode',
            },
          {
                header: '공정코드',
                name: 'prcsCode',
            },
          {
            header: '자재/반제품구분',
            name: 'mpKind',
          },
          {
            header: '자재/반제품코드',
            name: 'mpCode'
          },
          {
            header: '단위',
            name: 'bomUnit'
          },
          {
            header: '사용량',
            name: 'bomAmt'
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