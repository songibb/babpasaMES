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
    
    <style>
	    h1{
			margin-left: 15px;
		}
		
		h1, h2{
			font-weight: 800;
		}
		
		#customtemplateSearchAndButton input[type="text"],
		select {
		  width: 230px;
		  padding: 6px;
		  margin-bottom: 15px;
		  border: 1px solid #ccc;
		  border-radius: 4px;
		}
		
		#customtemplateSearchAndButton p{
		width: 90px;
		display: inline-block;
		font-size: 20px;
	}

	
	.yellow-background {
        background-color: rgb(255,253,235);
	}
	
	.my-styled-cell {background-color: rgb(255, 229, 229)}
	</style> 
</head>
<body>
	<div class="black_bg"></div>
	<h1>완제품 품질 조회</h1>
	<div class="col-lg-12 stretch-card">
		<div class="card">
			<div class="card-body">
				<div class="table-responsive pt-3" >
                  	<div id="customtemplateSearchAndButton">
        				<div style="display: flex; justify-content: space-between;">
            				<div style="flex: 1; margin-left: 10px; margin-top : 20px;">
                				<p>검사번호</p>
	  							<input type="text" placeholder="검색어를 입력하세요" id="matSearch">
								<button type="button" class="btn btn-info btn-icon-text" id="searchBtn">
									<i class="fas fa-search"></i>검색
								</button>
								<button type="button" class="btn btn-info btn-icon-text" id="searchResetBtn">
                    				초기화
                				</button>
                				<br>
            				</div>
        				</div>
	    			</div>
	    			</div> 
		            <div>
	            <div id="container" style="display: flex; justify-content: center;">
		           		<div id="grid" style="width: 700px; margin-right: 50px"><h2>완제품 품질 검사 목록</h2></div>
		           		<div id="grid2" style="width: 800px;"><h2>완제품 품질 검사 목록</h2></div>
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
			
			//안전재고량 > 현재고
 		    let data = grid.getData();
          
 		    $.each(data, function (idx, obj) {
 	
 		        if (obj['nonPassAmt'] != '0') {
 		            let rowKey = obj['rowKey'];
 		           grid.addRowClassName(rowKey,'my-styled-cell');
 		        }
 		    })
 		    
			},
			error : function(reject){
				console.log(reject);
			}
		});
					
		
		var grid = new tui.Grid({
			el: document.getElementById('grid'),
			scrollX: false,
			scrollY: false,
			 minBodyHeight: 200,
			 rowHeaders: ['rowNum'],
			pagination: true,
			pageOptions: {
				useClient: true,
				perPage: 10,
			},
			columns: [
			 	{
	               header: '검사번호',
	               name: 'testNum',
	               width: 'auto'
	            },
	            {
	               header: '공정상세코드',
	               name: 'prcsIngCode',
	               width: 'auto'
	            },
	            {
	               header: '공정코드',
	               name: 'prcsCode',
	               width: 'auto'
	            },
	            {
	               header: '생산량',
	               name: 'prcsAmt',
	               formatter(e) {
		                val = e['value']
	                    .toString()
	                    .replace(/\B(?=(\d{3})+(?!\d))/g, ',');
	                return val;
	            	}
	            },
	            {
	               header: '합격량',
	               name: 'passAmt',
	               formatter(e) {
		                val = e['value']
	                    .toString()
	                    .replace(/\B(?=(\d{3})+(?!\d))/g, ',');
	                return val;
	            	}
	            },
	            {
	               header: '불합격량',
	               name: 'nonPassAmt',
	               formatter(e) {
		                val = e['value']
	                    .toString()
	                    .replace(/\B(?=(\d{3})+(?!\d))/g, ',');
	                return val;
	            	}
	            },
	            {
	               header : '검사날짜',
	               name :'testDate',
			 	   className: 'yellow-background'
	            }
				
			]
			
		})
		

		//상세공통코드 가져오기
		var grid2 = new tui.Grid({
			el: document.getElementById('grid2'),
			scrollX: false,
			scrollY: false,
			 minBodyHeight: 200,
			 rowHeaders: [{type: 'rowNum'}],
			pagination: true,
			pageOptions: {
				useClient: true,
				perPage: 10,
			},
			columns: [
				{
					header: '검사번호',
					name: 'testNum',
		            width: 'auto'
				},
				{
					header: '공정진행코드',
					name: 'prcsIngCode',
		            width: 'auto'
				},
				{
					header: '상세검사번호',
					name: 'testNumInfo',
		            width: 'auto'
				},
				{
					header: '검사코드',
					name: 'testCode',
					hidden: true,
		            width: 'auto'
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
					name :'passYn2'
				},
				{
					header: '담당자',
					name : 'empName'
					
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
			success : function(result){
 				grid2.resetData(result);
 				
			//안전재고량 > 현재고
   		    let data = grid2.getData();
            
   		    $.each(data, function (idx, obj) {
   	
   		        if (Number(obj['passValue']) < Number(obj['testResult'])) {
   		            let rowKey = obj['rowKey'];
   		            grid2.addCellClassName(rowKey, 'passYn2', 'my-styled-cell');
   		        }
   		    })
 				
 				
 		    },
			error : function(reject){
	 			console.log(reject);
	 		}
    	})
    	
    	$("#testNum").val(testNum);
	});
      
      
	//검색
    $('#searchBtn').on('click', searchProdIn);
    function searchProdIn(e){
 	   let content = $('#matSearch').val();
 	   let search = { testNum : content };
 	   $.ajax({
 		   url : 'searchOneChk',
 		   method : 'GET',
 		   data : search ,
 		   success : function(data){
 			   
			  $.each(data, function(i, objDe){
					let td = data[i]['testDate'];
					
					data[i]['testDate'] = getDate(td);
				})		
 			   grid.resetData(data);
				setDisabled();
 		   },
 		   error : function(reject){
 			   console.log(reject);
 		   }
 	   })
    }
	</script>
</body>
</html>