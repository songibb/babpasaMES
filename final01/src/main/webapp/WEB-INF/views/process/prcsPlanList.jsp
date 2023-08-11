<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>생산 계획 조회</title>

<!-- 토스트 페이지 네이션 -->
<script type="text/javascript" src="https://uicdn.toast.com/tui.code-snippet/latest/tui-code-snippet.js"></script>
<link rel="stylesheet" href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css" />
<script src="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.js"></script>
<!-- 페이지 네이션 끝 -->
<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>

<style type="text/css">
#planContainer{
	display: flex;
	justify-content: space-between;
}
#planGrid{
    width: 800px;
}
#planDeGrid{
    width: 800px;
}

</style>

</head>
<body>
	<div class="black_bg"></div>
	<h2>생산 계획 조회</h2>
	<div class="col-lg-12 stretch-card">
		<div class="card">
			<div class="card-body">
				<div class="table-responsive pt-3">
					<button type="button" class="btn btn-info btn-icon-text excelDownload">
		                Excel <i class="bi bi-printer"></i>                                                                              
					</button>
					<form>
						<div id="customtemplateSearchAndButton">		
							<p>계획일자</p>
                  			<input id="startDate" type="date">&nbsp;&nbsp;-&nbsp;&nbsp;<input id="endDate" type="date">
							<br>
							
							<p>계획명</p>
							<input type="text" placeholder="검색어를 입력하세요" name="prcsSearch" value="">

							<button type="button" class="btn btn-info btn-icon-text" >
								<i class="fas fa-search"></i>검색
							</button>
							<button type="reset" class="btn btn-info btn-icon-text">초기화</button>
		            	</div>
	            	</form>
				</div>
				
				<div id="planContainer">
            		<div id="planGrid"></div>
           			<div id="planDeGrid"></div>
            	</div>
	   		</div>
		</div>
	</div> 
    
    
	<script>
	
	//생산계획 조회
    var planGrid = new tui.Grid({
        el: document.getElementById('planGrid'),
        data: [
	           <c:forEach items="${planList}" var="p" varStatus="status">
	           	{
	           		prcsPlanCode : "${p.prcsPlanCode}",
	           		prcsPlanName :"${p.prcsPlanName}",
	           		prcsPlanDate :"<fmt:formatDate value='${p.prcsPlanDate}' pattern='yyyy-MM-dd'/>",
	           		empCode :"${p.empCode}",
	           		prcsDirYn : "${p.prcsDirYn}",
	           		prcsStartDate : "<fmt:formatDate value='${p.prcsStartDate}' pattern='yyyy-MM-dd'/>",
	           		prcsEndDate : "<fmt:formatDate value='${p.prcsEndDate}' pattern='yyyy-MM-dd'/>"
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
            header: '계획코드',
            name: 'prcsPlanCode'
          },
          {
            header: '계획명',
            name: 'prcsPlanName'
          },
          {
            header: '계획일자',
            name: 'prcsPlanDate'
          },
          {
            header: '담당자',
            name: 'empCode'
          },
          {
            header: '생산지시여부',
            name: 'prcsDirYn'
          },
          {
            header: '예상생산시작일',
            name: 'prcsStartDate'
          },
          {
            header: '예상생산종료일',
            name: 'prcsEndDate'
          }
        ]
      })  

	
	//상세생산계획 조회
	var planDeGrid = new tui.Grid({
        el: document.getElementById('planDeGrid'),
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
            header: '상세계획코드',
            name: 'prcsPlanDeCode'
          },
          {
            header: '계획코드',
            name: 'prcsPlanCode'
          },
          {
            header: '제품코드',
            name: 'prodCode'
          },
          {
            header: '주문수량',
            name: 'ordTotalAmt'
          },
          {
            header: '상세계획량',
            name: 'prcsPlanAmt'
          },
          {
            header: '우선순위',
            name: 'prcsPrio'
          },
          {
            header: '지시수량',
            name: 'prcsDirAmt'
          },
          {
            header: '지시상태',
            name: 'prcsDirSts'
          }
          ,
          {
            header: '생산량',
            name: 'prcsAmt'
          }
        ]
      })  
	
	
	//생산 계획 클릭시 해당 계획의 상세생산계획 조회
    planGrid.on('click', () => {
    	//클릭한 계획의 계획코드 가져오기
    	let rowKey = planGrid.getFocusedCell().rowKey;
    	let planCode = planGrid.getValue(rowKey, 'prcsPlanCode');

    	$.ajax({
			url : 'prcsPlanDeList',
			method : 'GET',
			data : { prcsPlanCode : planCode },
			success : function(data){
				planDeGrid.resetData(data);
 		    },
			error : function(reject){
	 			console.log(reject);
	 		}	
		})
  	});
		
	</script>

</body>
</html>