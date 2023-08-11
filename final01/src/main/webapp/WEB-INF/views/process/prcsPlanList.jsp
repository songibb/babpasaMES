<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>생산 계획 관리</title>

<!-- 토스트 페이지 네이션 -->
<script type="text/javascript" src="https://uicdn.toast.com/tui.code-snippet/latest/tui-code-snippet.js"></script>
<link rel="stylesheet" href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css" />
<script src="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.js"></script>
<!-- 페이지 네이션 끝 -->
<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
        


</style>    
</head>
<body>
	<div class="black_bg"></div>
	<h2>생산 계획 관리</h2>
	<div class="col-lg-12 stretch-card">
		<div class="card">
			<div class="card-body">
				<div class="table-responsive pt-3">
					<button type="button" class="btn btn-info btn-icon-text excelDownload">
		                Excel <i class="bi bi-printer"></i>                                                                              
					</button>
					<form>
						<div id="customtemplateSearchAndButton">		
							<p>검색</p>
							<input type="text" placeholder="검색어를 입력하세요" name="prcsSearch" value="">
							
							<br>
							<p>자재명</p>
			                  <input type="text" placeholder="검색어를 입력하세요" id="matCodeInput">
			                  <i class="bi bi-search" id="matModal"></i> <!-- 돋보기 아이콘 -->
			                  <input type="text" class="blackcolorInputBox" id="matNameFix" readonly>
			                <br>
							<p>업체명</p>
			                  <input type="text" placeholder="검색어를 입력하세요" id="actCodeInput">
			                    <i class="bi bi-search" id="actModal"></i>
			                  <input type="text" class="blackcolorInputBox" id="actNameFix" readonly>
			                <br>
							
							
							<button type="button" class="btn btn-info btn-icon-text" >
								<i class="fas fa-search"></i>검색
							</button>
							<button type="button" class="btn btn-info btn-icon-text">초기화</button>
		            	</div>
	            	</form>
	           		<div id="grid"></div>
	           		<div id="grid2"></div>
				</div>
	   		</div>
		</div>
	</div> 


	<div class="modal">
   
  <div class="modal_content" 
       title="클릭하면 창이 닫힙니다.">
          <div class="m_head">
            <div class="modal_title"><h3>거래처 목록</h3></div>
            <div class="close_btn" id="close_btn">X</div>
       </div>
       <div class="m_body">
            <div id="modal_label"></div>
       </div>
       <div class="m_footer">
            <div class="modal_btn cancle" id="close_btn">CANCLE</div>
            <div class="modal_btn save" id="save_btn">SAVE</div>
    </div>
  </div>
</div>
    
	<script>
	
	
	//생산계획 조회
    var grid = new tui.Grid({
        el: document.getElementById('grid'),
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
			perPage: 10,
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
    grid.on('click', () => {
    	//클릭한 계획의 계획코드 가져오기
    	let rowKey = grid.getFocusedCell().rowKey;
    	let planCode = grid.getValue(rowKey, 'prcsPlanCode');

    	$.ajax({
			url : 'prcsPlanDeList',
			method : 'GET',
			data : { prcsPlanCode : planCode },
			success : function(data){
 				grid2.resetData(data);
 		    },
			error : function(reject){
	 			console.log(reject);
	 		}	
		})
  	});
	
    	
	</script>
	
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/actModal.js">
		var Grid;
	</script>
	
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/matModal.js">
		var Grid;
	</script>
</body>
</html>