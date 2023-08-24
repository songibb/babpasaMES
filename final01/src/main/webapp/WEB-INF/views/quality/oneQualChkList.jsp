<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>완제품 품질 검사</title>
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
	<h2>완제품 품질 검사 조회</h2>
	<div class="col-lg-12 stretch-card">
		<div class="card">
			<div class="card-body">
				<div class="table-responsive pt-3">

	          
	            <div id="container" style="display: flex; justify-content: center;">
		           		<div id="grid" style="width: 600px; margin-right: 50px"></div>
		           		<div id="grid2" style="width: 1000px;"></div>
	   			</div>
			</div>
		</div> 
	</div>
  </div>	
	<div>
		<jsp:include page="../comFn/dateFormat.jsp"></jsp:include>
	</div>
	<script>
	
		//공통코드 조회 ajax
		$.ajax({
			url : 'ajaxAllLastPrcsList',
			method : 'GET',
			success : function(result){
				
			$.each(result, function(i, objDe){
				let td = result[i]['testDate'];
				result[i]['testDate'] = getDate(td);

			})
				 grid.resetData(result);
			},
			error : function(reject){
				console.log(reject);
			}
		});
					
		
		var grid = new tui.Grid({
			el: document.getElementById('grid'),
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
	               header: '검사번호',
	               name: 'testNum'
	            },
	            {
	               header: '공정상세코드',
	               name: 'prcsIngCode'
	            },
	            {
	               header: '공정코드',
	               name: 'prcsCode'
	            },
	            {
	               header: '생산량',
	               name: 'prcsAmt'
	            },
	            {
	               header: '합격량',
	               name: 'passAmt'
	            },
	            {
	               header: '불합격량',
	               name: 'nonPassAmt'
	            },
	            {
	               header : '검사날짜',
	               name :'testDate'
	            }
				
			]
			
		})
		

		//상세공통코드 가져오기
		var grid2 = new tui.Grid({
			el: document.getElementById('grid2'),
			scrollX: false,
			scrollY: false,
			 minBodyHeight: 30,
			 rowHeaders: [{type: 'rowNum'}],
			pagination: true,
			pageOptions: {
				useClient: true,
				perPage: 10,
			},
			columns: [
				{
					header: '검사번호',
					name: 'testNum'
				},
				{
					header: '공정진행코드',
					name: 'prcsIngCode'
				},
				{
					header: '상세검사번호',
					name: 'testNumInfo'
				},
				{
					header: '검사코드',
					name: 'testCode',
					hidden: true
				},
				{
					header: '검사명',
					name: 'testName'
				},
				{
					header: '검사기준값',
					name: 'passValue'
				},
				{
					header: '검사값',
					name: 'testResult'
				},
				{
					header: '적합여부',
					name :'passYn'
				},
				{
					header: '담당자',
					name : 'empCode'
					
				}
			]
			
		})
		
		
	 //자동 계산
      grid2.on('afterChange', (ev) => {
      
      let change = ev.changes[0];
      let rowData = grid2.getRow(change.rowKey);
      
      
      
      if(change.columnName == 'testResult'){
         if(rowData.testResult != null && rowData.testResult != ""){
            let passYn;
            if(rowData.testResult < rowData.passValue){
               passYn = 'Y';
            } else if(rowData.testResult >= rowData.passValue){
               passYn = 'N';
            }
            grid2.setValue(change.rowKey, 'passYn', passYn);
         }
      }
      });
      //끝
	      
	grid.on('click', () => {
		let rowKey = grid.getFocusedCell().rowKey;
    	let testNum = grid.getValue(rowKey, 'testNum');
    	console.log(testNum);
    	$.ajax({
    		url : 'ajaxOneChkList',
			method : 'GET',
			data : { testNum : testNum },
			success : function(data){
 				grid2.resetData(data);
 		    },
			error : function(reject){
	 			console.log(reject);
	 		}
    	})
    	
    	$("#testNum").val(testNum);
	});
			
	</script>
</body>
</html>