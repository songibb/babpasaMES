<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>생산 관리</title>

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
	<h2>생산 관리</h2>
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
	           		<div id="dirGrid"></div>
	           		<div id="dirDeGrid"></div>
	           		<div id="ingGrid"></div>
				</div>
	   		</div>
		</div>
	</div> 
	
	
	<div>
		<jsp:include page="../modal/actModal.jsp"></jsp:include>
	</div> 
    
	<script>
	
	//생산지시 조회
    var dirGrid = new tui.Grid({
        el: document.getElementById('dirGrid'),
        data: [
	           <c:forEach items="${dirList}" var="d" varStatus="status">
	           	{
	           		prcsDirCode : "${d.prcsDirCode}",
	           		prcsPlanCode : "${d.prcsPlanCode}",
	           		prcsDirName : "${d.prcsDirName}",
	           		prcsDirDate : "<fmt:formatDate value='${d.prcsDirDate}' pattern='yyyy-MM-dd'/>",
	           		prcsDirSts : "${d.prcsDirSts}",
	           		empCode : "${d.empCode}"
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
            header: '지시코드',
            name: 'prcsDirCode'
          },
          {
            header: '계획코드',
            name: 'prcsPlanCode'
          },
          {
            header: '지시명',
            name: 'prcsDirName'
          },
          {
            header: '지시일자',
            name: 'prcsDirDate'
          },
          {
            header: '지시상태',
            name: 'prcsDirSts'
          },
          {
            header: '담당자',
            name: 'empCode'
          }
        ]
      })  

	
	//상세생산지시 조회
	var dirDeGrid = new tui.Grid({
        el: document.getElementById('dirDeGrid'),
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
            header: '상세지시코드',
            name: 'prcsDirDeCode'
          },
          {
            header: '제품코드',
            name: 'prodCode'
          },
          {
            header: '생산계획량',
            name: 'prcsPlanAmt'
          },
          {
            header: '지시수량',
            name: 'prcsDirAmt'
          },
          {
            header: '생산시작일자',
            name: 'prcsStartDeDate'
          },
          {
            header: '생산마감일자',
            name: 'prcsEndDeDate'
          },
          {
            header: '공정진행상태',
            name: 'prcsIngSts'
          },
          {
            header: '담당자',
            name: 'empCode'
          }
        ]
      })  
	
	
 	//진행 공정 조회
	var ingGrid = new tui.Grid({
        el: document.getElementById('ingGrid'),
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
        	//지울부분----------
          {
            header: '진행공정관리코드',
            name: 'prcsIngCode'
          },
          
          {
            header: '상세지시코드',
            name: 'prcsDirDeCode'
          },
          {
            header: '제품코드',
            name: 'prodCode'
          },
          //지울부분----------
          {
            header: '공정코드',
            name: 'prcsCode'
          },
          {
            header: '공정순서',
            name: 'prcsSeq'
          },
          {
            header: '투입량',
            name: 'inputAmt'
          },
          {
            header: '불량량',
            name: 'errAmt'
          },
          {
            header: '생산량',
            name: 'prcsAmt'
          },
          {
            header: '공정상태',
            name: 'prcsDirIngSts'
          },

        ]
      })  
	
	
	//생산지시 클릭시 해당 지시의 상세 생산지시 조회
    dirGrid.on('click', () => {
    	//클릭한 지시의 지시코드 가져오기
    	let rowKey = dirGrid.getFocusedCell().rowKey;
    	let dirCode = dirGrid.getValue(rowKey, 'prcsDirCode');

    	$.ajax({
			url : 'prcsDirDeList',
			method : 'GET',
			data : { prcsDirCode : dirCode },
			success : function(data){
				dirDeGrid.resetData(data);
 		    },
			error : function(reject){
	 			console.log(reject);
	 		}	
		})
  	});
	
	
  	//상세 생산지시 클릭시 해당 지시의 진행 공정 조회
    dirDeGrid.on('click', () => {
    	//클릭한 상세 지시의 상세지시코드, 제품코드 가져오기
    	let rowKey = dirDeGrid.getFocusedCell().rowKey;
    	let dirDeCode = dirDeGrid.getValue(rowKey, 'prcsDirDeCode');
    	let prodCode = dirDeGrid.getValue(rowKey, 'prodCode');
		//클릭한 상세 지시의 제품코드 가져오기
    	$.ajax({
			url : 'prcsIngList',
			method : 'GET',
			data : { prcsDirDeCode : dirDeCode, prodCode : prodCode },
			success : function(data){
				ingGrid.resetData(data);
 		    },
			error : function(reject){
	 			console.log(reject);
	 		}	
		})



  	});
    
    
    
	</script>
</body>
</html>