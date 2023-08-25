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
					<form>
						<div id="customtemplateSearchAndButton">		
							<p>지시일자</p>
							<input type="date" id="startDate" name="startDate" value="">&nbsp;&nbsp;-&nbsp;&nbsp;<input type="date" id="endDate" name="endDate" value="">		

							<button type="button" class="btn btn-info btn-icon-text" id="searchBtn">
								<i class="fas fa-search"></i>검색
							</button>
							<button type="reset" class="btn btn-info btn-icon-text">초기화</button>
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
		<jsp:include page="../comFn/dateFormat.jsp"></jsp:include>
	</div>
    
	<script>
	
	//검색
	document.getElementById('searchBtn').addEventListener('click', searchDirist);
	
	function searchDirist(){
		let searchObj = {};
		searchObj['startDate'] = $('#startDate').val();
		searchObj['endDate'] = $('#endDate').val();	   

		$.ajax({
			url : 'selectPrcsDirList',
			method : 'GET',
			data : searchObj,
			success : function(data){	
				//날짜 츨력 포맷 변경
				$.each(data, function(i, objDe){
					let pdd = data[i]['prcsDirDate'];
					data[i]['prcsDirDate'] = getDate(pdd);
				})
				dirGrid.resetData(data);
				dirDeGrid.clear();	
				},
				error : function(reject){
				 console.log(reject);
				}
		});
	};
	
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
            header: '담당자코드',
            name: 'empCode',
            hidden: true
          },
          {
            header: '담당자',
            name: 'empName'
          },
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
//           {
//             header: '생산마감일자',
//             name: 'prcsEndDeDate'
//           },
          {
            header: '공정진행상태',
            name: 'prcsIngSts'
          },
          {
            header: '담당자코드',
            name: 'empCode',
            hidden: true
          },
          {
            header: '담당자',
            name: 'empName'
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
            name: 'prodCode',
            hidden: true
          },
          {
            header: '제품명',
            name: 'prodName'
          },
          {
            header: '공정코드',
            name: 'prcsCode'
          },
          {
            header: '공정명',
            name: 'prcsName'
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
          }
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
				//날짜 츨력 포맷 변경
				$.each(data, function(i, objDe){
					let psdd = data[i]['prcsStartDeDate'];
					let pedd = data[i]['prcsEndDeDate'];
					data[i]['prcsStartDeDate'] = getDate(psdd);
					data[i]['prcsEndDeDate'] = getDate(pedd);
				})
				
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
  	
  	
  	//생산지시 -> 생산완료 update
	let dirList = dirGrid.getData();
	
	function updateDirPrcsStsAjax(){
		$.ajax({
			url : 'updateDirPrcsSts',
			method : 'POST',
			data : JSON.stringify(dirList),
			contentType : "application/json",
			success : function(data){
				//console.log(data);
			},
			error : function(reject){
	 			console.log(reject);
	 		}
		})
	}

	updateDirPrcsStsAjax();
   
 
    
	</script>
	
	<div>
		<jsp:include page="../comFn/prcsIngModal.jsp"></jsp:include>
	</div>
</body>
</html>