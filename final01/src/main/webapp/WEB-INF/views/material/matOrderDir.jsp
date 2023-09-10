<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자재 발주 관리</title>
<!-- 토스트 페이지 네이션 -->
<script type="text/javascript" src="https://uicdn.toast.com/tui.code-snippet/latest/tui-code-snippet.js"></script>
<link rel="stylesheet" href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css" />
<script src="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.js"></script>
<!-- 페이지 네이션 끝 -->
<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
<style>
  

	#newPrcsPlanView, #save, #delete, #dirAdd, .excelDownload{
		margin-top : 0px;
		float : right;
	}
	

	h1{
		margin-left: 15px;
	}
	
	h1, h2{
		font-weight: 800;
	}
	
	h2{
		clear: both;
		display : inline-block;
	}
	
	#matBuyActInputHidden, #matBuyActInput ,#searchP input[type="text"] {
	  width: 15%;
	  padding: 6px;
	  margin-bottom: 15px;
	  border: 1px solid #ccc;
	  border-radius: 4px;
	}
	#searchP input[type="date"] {
	  width: 15%;
	  padding: 5px;
	  margin-bottom: 15px;
	  border: 1px solid #ccc;
	  border-radius: 4px;
	}
	
	#searchP input[type="checkbox"]{
		margin-bottom: 40px;
	}
	
	#searchP label[for="comple"]{
		margin-right : 20px;
	}
	
	#searchP p{
		width: 80px;
		display: inline-block;
		font-size: 20px;
	}
	
	/*grid 날짜 컬럼색*/
	.yellow-background {
	        background-color: rgb(255,253,235);
	}
	
	
	#grid {
		height : 600px;
	}
	
	.modal_content{
	  /*모달창 크기 조절*/
	  width:600px; height:700px;
	  background:#fff; border-radius:10px;
	  /*모달창 위치 조절*/
	  position:relative; top:33%; left:45%;
	  margin-top:-100px; margin-left:-200px;
	  text-align:center;
	  box-sizing:border-box;
	  line-height:23px;
	}
	
	.m_body > p{
		display : inline-block;
	}
	

	#customtemplateSearchAndButton p{
		width : 100px;
	}
	.yellow-background {
        background-color: rgb(255,253,235);
	}
	
	#grid{
		height: 700px;
		
	}
	
	#gridInsertAct{
		margin-left : 400px;
		display : inline-block;
	}
	
	.modal_content{
	  /*모달창 크기 조절*/
	  width:600px; height:700px;
	  background:#fff; border-radius:10px;
	  /*모달창 위치 조절*/
	  position:relative; top:28%; left:45%;
	  margin-top:-100px; margin-left:-200px;
	  text-align:center;
	  box-sizing:border-box;
	  line-height:23px;
	}
	
	.m_body > p{
		display : inline-block;
	}
	
	.m_body > input{
		border : 1px solid black;
	}

	
	#customtemplateSearchAndButton p{
		width : 100px;
	}
	
	#selectActCodeInput{
		margin-bottom : 35px;
	}
	
	#matNameFix, #actNameFix, #selectActNameFix {
		background-color : #868e96;
		border-color: #868e96;
	}
	
	#matModal, #selectActModal{
		cursor : pointer;
	}
	
	#modalSearch{
		width: 30%;
	  	padding: 6px;
	  	margin-bottom: 15px;
	  	border: 1px solid #ccc;
	  	border-radius: 4px;	
	}
	
	.selected-cell{
   		background-color: #ffd09e;
	}
	
	#insertActInputBox{
		display : inline-block;
		margin-left : 400px;
	}
	
	#searchGrid3Input, #searchGrid2Input{
		width: 15%;
	  padding: 5px;
	  margin-bottom: 15px;
	  border: 1px solid #ccc;
	  border-radius: 4px;
	}
	
	#searchGrid2, #searchGrid3{
		display : inline-block;
		margin-left : 130px;
	}
	
	#matActGridTitle{
		margin-bottom : 17px;
	}
/*모달끝*/
	.my-styled-cell {background-color: rgb(255, 229, 229);}
	
	.my-styled-green-cell {background-color: #cff0cc;}
	
	.my-styled-yellow-cell {background-color: #fdfd96;}
	
	td[data-column-name="matPrice"], td[data-column-name="matAmt"], td[data-column-name="matOdAcp"]{
		cursor : pointer;
	}
	
	#lowerMat{
		display : inline-block;
		margin-left : 20px;
	}
	
	.btn-icon-text2 {
	    margin: -5px;
	    width : 70px;
	    border-radius: 0;
	    height: 33px;
	    line-height: 20px;
	}

	.btn-info2 {
	    color: black;
	    background-color: white;
	    border-color: #ccc;
	    
	}

	#todayBtn {
		margin-left: 2px !important;
		border-radius: 5px 0 0 5px;
		border : 1px solid #ccc;
	}
	#todayBtn:hover{
		background-color : #f4f4f4;
		border : 1px solid #868e96;
		color: black;
	}
	#resetBtn:hover{
		background-color : #f4f4f4;
		border : 1px solid #868e96;
		color: black;
	}
	#weekBtn:hover, #monthBtn:hover{
	    background-color : #f4f4f4;
	    border : 1px solid #868e96;
	    color: black;
	}
	
	#monthBtn{
			border-radius: 0 5px 5px 0;
			border : 1px solid #ccc;
	}
</style>    
       
</head>
<body>
   <h1>자재 발주 관리</h1>
   <div class="col-lg-12 stretch-card">
       <div class="card">
           <div class="card-body">
               <div class="table-responsive pt-3">
        				<div id="searchP" style="display: flex; justify-content: space-between;">
            				<div style="flex: 1;">
                				<p>자재명</p>
                				<input type="text" id="matCodeInput" placeholder="검색어를 선택하세요" readonly>
                				<i class="bi bi-search" id="matModal"></i> <!-- 돋보기 아이콘 -->
                				<input type="text" class="blackcolorInputBox" id="matNameFix" readonly>
                				<br>
                				<p>거래처</p>
                				<input type="text" id="actCodeInput" placeholder="검색어를 선택하세요" readonly>
                				<i class="bi bi-search" id="actModal"></i>
                				<input type="text" class="blackcolorInputBox" id="actNameFix" readonly>
                				<br>
                				<p>발주일자</p>
                				<input id="startDate" type="date">&nbsp;&nbsp;-&nbsp;&nbsp;<input id="endDate" type="date">
                				<button type="button" class="btn btn btn-info btn-icon-text btn-info2 btn-icon-text2" id="todayBtn">오늘</button>
								<button type="button" class="btn btn btn-info btn-icon-text btn-info2 btn-icon-text2" id="weekBtn">일주일</button>								
								<button type="reset" class="btn btn btn-info btn-icon-text btn-info2 btn-icon-text2" id="monthBtn">한달</button>
                				<br>
                				<p>검수상태</p>
                				<label for="before"><input type="checkbox" id="before" value="before">검수전</label>
                				<label for="comple"><input type="checkbox" id="comple" value="comple">검수완료</label>
                				<button type="button" class="btn btn-info btn-icon-text" id="searchBtn">
                    				<i class="fas fa-search"></i>
                    					검색
                				</button>
                				<button type="button" class="btn btn-info btn-icon-text" id="searchResetBtn">
                    				초기화
                				</button>
            				</div>
        				</div>
		            <div id="container" style="display: flex;">
		           		<div style="flex: 1;"><h2>현재 자재 재고</h2><label for="lowerMat"><input type="checkbox" id="lowerMat" value="N">부족한 자재만 조회</label><p id="searchGrid2">자재명</p> <input type="text" id="searchGrid2Input">
		           		<button type="button" class="btn btn-info btn-icon-text" id="searchBtn2">
                    				<i class="fas fa-search"></i>
                    					검색
                				</button>
			            <br>
			            <div id="grid2" style="width: 730px;"></div></div>
		           		<div style="flex: 1;"><h2 id="matActGridTitle">거래처 목록</h2><input type="hidden" id="searchGrid3Input">
		           		
                    				
			            <br>
			            <div id="grid3" style="width: 730px; margin-right: 20px"></div></div>
	   				</div>
		            	
		            
		            </div>
		            
		            
		            <div id="grid">
		            <h2>발주 목록</h2>	<p id="insertActInputBox">등록 거래처</p> <input type="text" id="matBuyActInput" readOnly><input type="hidden" id="matBuyActInputHidden">
		            <button type="button" class="btn btn-info btn-icon-text excelDownload">
                      	 Excel
                      	<i class="bi bi-printer"></i>                                                                              
                   	</button>
                   	<button class="btn btn-info btn-icon-text" id="save">저장</button>
                	<button class="btn btn-info btn-icon-text" id="delete">삭제</button></div>
				</div>
			</div>
		</div>
	
	<div class="modal" id="modal">
   		<div class="modal_content">
        	<div class="m_head">
            	<div class="modal_title"><h3>목록</h3></div>
            	<div class="close_btn" id="close_btn">X</div>
       		</div>
       		<div class="m_body">
       			<p>이름</p>
                <input type="text" id="modalSearch">
                <button type="button" class="btn btn-info btn-icon-text" id="modalSearchBtn">검색</button>
            	<div id="modal_label"></div>
       		</div>
       		<div class="m_footer">
            	<div class="modal_btn cancle close_btn">CANCLE</div>
    		</div>
  		</div>
	</div>
	<div>
		<jsp:include page="../comFn/dateFormat.jsp"></jsp:include>
	</div>


	<script>
	
	//오늘
	document.getElementById('todayBtn').addEventListener('click', todayBtn);
	//일주일
	document.getElementById('weekBtn').addEventListener('click', weekBtn);
	//한달
	document.getElementById('monthBtn').addEventListener('click', monthInput);

	//오늘 버튼 클릭시
	function todayBtn(){
		$('#startDate').val(getToday());
		$('#endDate').val(getToday());;
	}
	
	//일주일 버튼 클릭시
	function weekBtn(){
		$('#startDate').val(getWeek());
		$('#endDate').val(getToday());;
	}
	
	function monthInput(){
		$('#startDate').val(getMonth());
		$('#endDate').val(getToday());;
	}
		var upGridData = [];
		
		<c:forEach items="${stockList}" var="stock" varStatus="status">
			upGridData.push(
		        {
		        	matCode: "${stock.matCode}",
		            matName: "${stock.matName}",
		            matUnit: "${stock.matUnit}",
		            matStd: "${stock.matStd}",
		            totalStock: "${stock.totalStock}",
		            matSafe: "${stock.matSafe}",
		            willUseAmt: "${stock.willUseAmt}",
		            willOdAmt : "${stock.willOdAmt}"
		        }
		    );
		</c:forEach>
	
	
		//그리드2 생성
		var planGrid = new tui.Grid({
		    el: document.getElementById('grid2'),
		    data: upGridData,
		    scrollX: false,
		    scrollY: false,
		    minBodyHeight: 160,
		    rowHeaders: [
		        {
		            type: 'rowNum'
		        }
		    ],
		    pageOptions: {
		        useClient: true,
		        perPage: 4
		    },
		    columns: [
		    	{
		            header: '자재코드',
		            name: 'matCode',
		            align: 'center',
		            filter: {
		                type: 'select',
		                showApplyBtn: true,
		                showClearBtn: true,
		                operator: 'OR'
		             },
		            hidden: true
		        }, {
		            header: '자재명',
		            name: 'matName',
		            align: 'left',
		            filter: {
		                type: 'text',
		                showApplyBtn: true,
		                showClearBtn: true,
		                operator: 'OR'
		             }
		            
		        }, {
		            header: '단위',
		            name: 'matUnit',
		            align: 'left'
		        }, {
		            header: '규격',
		            name: 'matStd',
		            align: 'left'
		        }, {
		            header: '현재고',
		            name: 'totalStock',
		            formatter(e) {
		                val = e['value']
		                    .toString()
		                    .replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		                return val;
		            },
		            align: 'right'
		        }, {
		            header: '안전재고',
		            name: 'matSafe',
		            formatter(e) {
		                val = e['value']
		                    .toString()
		                    .replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		                return val;
		            },
		            align: 'right'
		        }, {
		        	header: '일주일 내 소모예정량',
		            name: 'willUseAmt',
		            formatter(e) {
		                val = e['value']
		                    .toString()
		                    .replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		                return val;
		            },
		            width : 130,
		            align: 'right'
		        }, {
		        	header: '입고예정량',
		            name: 'willOdAmt',
		            formatter(e) {
		                val = e['value']
		                    .toString()
		                    .replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		                return val;
		            },
		            align: 'right'
		        }
		    ]
		});
		
		$('#searchBtn2').on('click', function(e){
			
			let materialName = $('#searchGrid2Input').val();
			$.ajax({
				url :'getResetPlanGridData',
				method : 'GET',
				data : { materialName : materialName },
				success : function(result){
					
					planGrid.resetData(result);
					
					$.each(result, function(idx, obj){
						if (Number(obj['totalStock']) + Number(obj['willOdAmt']) < Number(obj['matSafe']) + Number(obj['willUseAmt'])) {
				            let rowKey = obj['rowKey'];
				            planGrid.addCellClassName(rowKey, 'totalStock', 'my-styled-cell');
				        }
					})
					
				let actName = $('#matBuyActInput').val();
				let actCode = $('#matBuyActInputHidden').val();
					
					
				$.ajax({
	            	url : 'getLeastActListSearch',
	        		method : 'GET',
	        		data : { actCode : actCode },
	        		async : false,
	        		success : function(actResult){
	        			
	        			
	        			let data = planGrid.getData();
	        			$.each(data, function(idx, obj){
	        				$.each(actResult, function(idx2, obj2){
	        					 
	        					if(obj['matCode'] == obj2['matCode']){
	        						planGrid.addCellClassName(obj.rowKey, 'matName', 'my-styled-yellow-cell');
	        						return false;
	        					} else {
	        						planGrid.removeCellClassName(obj.rowKey, 'matName', 'my-styled-yellow-cell');
	        					}
	        					
	        					
	        				})
	        			})
	        			 
	        			if(actResult.length == 0){
	        				$.each(data, function(idx, obj){
	        					planGrid.removeCellClassName(obj.rowKey, 'matName', 'my-styled-yellow-cell');
	        					planGrid.removeCellClassName(obj.rowKey, 'matName', 'my-styled-green-cell');
	        				})
	        			}
	        			
	        			
	        			
	        			
	        		},
	        		error : function(actReject){
	        			console.log(actReject);
	        		}
	            })
            
            
	            $.ajax({
	            	url : 'getMaxActList',
	        		method : 'GET',
	        		data : { actCode : actCode },
	        		async : false,
	        		success : function(actResult){
	        			let data = planGrid.getData();
	        			
	        			 $.each(data, function(idx, obj){
	        				 $.each(actResult, function(idx2, obj2){
	        					 if(obj['matCode'] == obj2['matCode']){
	        						 
	        						 planGrid.removeCellClassName(obj.rowKey, 'matName', 'my-styled-yellow-cell');
	        						 planGrid.addCellClassName(obj.rowKey, 'matName', 'my-styled-green-cell');
	        						 
	        						 return false;
	        					 } else {
	        						 
	        						 planGrid.removeCellClassName(obj.rowKey, 'matName', 'my-styled-green-cell');
	        					 }
	        				 })
	        			 })
	        			 
	        			  if(actResult.length == 0){
	        				 $.each(data, function(idx, obj){
	        					 planGrid.removeCellClassName(obj.rowKey, 'matName', 'my-styled-yellow-cell');
	        					 planGrid.removeCellClassName(obj.rowKey, 'matName', 'my-styled-green-cell');
	        				 })
	        			 }
	        		},
	        		error : function(actReject){
	        			console.log(actReject);
	        		}
	            })
					},
					error : function(reject){
						console.log(reject);
					}
				})
			})
		
		
		
		planGrid.on('dblclick', () => {
		    let rowKey = planGrid
		        .getFocusedCell()
		        .rowKey;
	
		    if (rowKey != null && rowKey >= 0) {
		        let matCode = planGrid.getValue(rowKey, 'matCode');
		        let matName = planGrid.getValue(rowKey, 'matName');
		        let matStd = planGrid.getValue(rowKey, 'matStd');
		        let matUnit = planGrid.getValue(rowKey, 'matUnit');
		        let totalStock = planGrid.getValue(rowKey, 'totalStock');
		        let matSafe = planGrid.getValue(rowKey, 'matSafe');
		        let willUseAmt = planGrid.getValue(rowKey, 'willUseAmt');
		        let actName = $('#matBuyActInput').val();
	           	
		        let actCode = $('#matBuyActInputHidden').val();
		        
		        let matAmt = Number(willUseAmt) + Number(matSafe) - Number(totalStock);
		        if(matAmt < 0){
		        	matAmt = 0;
		        }
		      	
		        //마우스 커서 없앰
		        planGrid.blur();
	
		        let now = new Date(); // 현재 날짜 및 시간
		        let year = now.getFullYear();
		        let month = ('0' + (
		            now.getMonth() + 1
		        )).substr(-2);
		        let day = ('0' + now.getDate()).substr(-2);
		        let matOdRq = year + "-" + month + "-" + day;
				
		        var matPrice = 0;
		        if($('#matBuyActInputHidden').val() != null && $('#matBuyActInputHidden').val() != ""){
		        	let actCode = $('#matBuyActInputHidden').val();
		        	$.ajax({
		        		url : 'getActMatPrice',
		        		method : 'GET',
		        		data : { matCode : matCode, actCode : actCode },
		        		async : false,
		        		success : function(result){
		        			matPrice = result.matPrice;
		        		},
		        		error : function(reject){
		        			console.log(reject);
		        		}
		        	})
		        }
		       
		        let totalPrice = Number(matPrice) * Number(matAmt);
		        
		        let isExist = false;
		        
		        $.each(orderGrid.getModifiedRows().createdRows, function(idx,obj){
	        		if(obj['matCode'] == matCode){
	        			swal("경고", "이미 발주 등록한 자재입니다", "warning");
	        			isExist = true;
	        			return false;
	        		}
	        	})
	        	
	        	if(!isExist){
	        		if(orderGrid.getModifiedRows().createdRows.length > 0){
			        	orderGrid.appendRow({
			        		'matOdRq': matOdRq,
				            'matCode': matCode,
				            'matName': matName,
				            'matStd': matStd,
				            'matUnit': matUnit,
				            'matAmt': matAmt,
				            'empCode': `${user.id}`,
				            'empName': `${user.empName}`,
				            'actCode': orderGrid.getModifiedRows().createdRows[0].actCode,
			                'actName': orderGrid.getModifiedRows().createdRows[0].actName,
			                'matPrice': matPrice,
			                'matTotalPrice' : totalPrice
			            }, {at: 0});
			        }else {
			        	orderGrid.appendRow({
				            'matOdRq': matOdRq,
				            'matCode': matCode,
				            'matName': matName,
				            'matStd': matStd,
				            'matUnit': matUnit,
				            'matAmt': matAmt,
				            'empCode': `${user.id}`,
				            'empName': `${user.empName}`,
				            'matPrice' : matPrice,
				            'actName' : actName,
				            'actCode' : actCode,
				            'matTotalPrice' : totalPrice
				        }, {at: 0});
			        }
	        	}
		        
		    }
		});
		
		planGrid.on('onGridMounted', function (e) {
		    let data = planGrid.getData();
	
		    $.each(data, function (idx, obj) {
	
		        if (Number(obj['totalStock']) + Number(obj['willOdAmt']) < Number(obj['matSafe']) + Number(obj['willUseAmt'])) {
		            let rowKey = obj['rowKey'];
		            planGrid.addCellClassName(rowKey, 'totalStock', 'my-styled-cell');
		        }
		    })
		});
		
		//거래처 그리드
		var matActGrid = new tui.Grid({
		    el: document.getElementById('grid3'),
		    scrollX: false,
		    scrollY: false,
		    minBodyHeight: 160,
		    rowHeaders: ['rowNum'],
		    pagination: true,
		    pageOptions: {
		        //백엔드와 연동 없이 페이지 네이션 사용가능하게 만듦
		        useClient: true,
		        perPage: 4
		    },
		    columns: [
		        {
		        	header:'거래처코드',
		        	name:'actCode'
		        },
		        {
		        	header:'거래처명',
		        	name:'actName',
		            filter: {
		                type: 'text',
		                showApplyBtn: true,
		                showClearBtn: true
		             }
		        },
		        {
		        	header:'거래횟수',
		        	name:'actCount'
		        },
		        {
		        	header:'최근단가',
		        	name:'matPrice',
		        	formatter(e) {
		        		if(e['value'] != null){
		        			val = e['value']
		                    .toString()
		                    .replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		                return val + "원";
		        		}
		                
	            	}
		        }
		    ]
	
		});
		
		planGrid.on('click', event => {
			let rowKey = event.rowKey;
			let matCode = planGrid.getValue(rowKey, 'matCode');
			
			if(rowKey != null && rowKey >= 0){
				$.ajax({
			        url: 'getMatBuyAct',
			        method: 'GET',
			        data : { matCode : matCode },
			        success: function(result) {
			        	matActGrid.resetData(result);
			        },
			        error : function(reject){
			        	console.log(reject);
			        }
				})
			}
			
		});
		
		matActGrid.on('dblclick', () => {
        	let rowKey = matActGrid
            						.getFocusedCell()
            						.rowKey;
        
     		
            let actCode = matActGrid.getValue(rowKey, 'actCode');
            
            let actName = matActGrid.getValue(rowKey, 'actName');
            
            
            $.ajax({
            	url : 'getLeastActListSearch',
        		method : 'GET',
        		data : { actCode : actCode },
        		async : false,
        		success : function(result){
        			
        			
        			let data = planGrid.getData();
        			$.each(data, function(idx, obj){
        				$.each(result, function(idx2, obj2){
        					 
        					if(obj['matCode'] == obj2['matCode']){
        						planGrid.addCellClassName(obj.rowKey, 'matName', 'my-styled-yellow-cell');
        						return false;
        					} else {
        						planGrid.removeCellClassName(obj.rowKey, 'matName', 'my-styled-yellow-cell');
        					}
        					
        					
        				})
        			})
        			 
        			if(result.length == 0){
        				$.each(data, function(idx, obj){
        					planGrid.removeCellClassName(obj.rowKey, 'matName', 'my-styled-yellow-cell');
        					planGrid.removeCellClassName(obj.rowKey, 'matName', 'my-styled-green-cell');
        				})
        			}
        			
        				let filterData = [];
            			$.each(result, function(idx, obj){
            				console.log(result);
            				console.log(obj);
            				filterData.push({code:'eq', value:obj.matName});
            			})
            			console.log(filterData);
            			filterPlanGrid(filterData);
        			
        			
        			
        		},
        		error : function(reject){
        			console.log(reject);
        		}
            })
            
            
            $.ajax({
            	url : 'getMaxActList',
        		method : 'GET',
        		data : { actCode : actCode },
        		async : false,
        		success : function(result){
        			let data = planGrid.getData();
        			
        			 $.each(data, function(idx, obj){
        				 $.each(result, function(idx2, obj2){
        					 if(obj['matCode'] == obj2['matCode']){
        						 
        						 planGrid.removeCellClassName(obj.rowKey, 'matName', 'my-styled-yellow-cell');
        						 planGrid.addCellClassName(obj.rowKey, 'matName', 'my-styled-green-cell');
        						 
        						 return false;
        					 } else {
        						 
        						 planGrid.removeCellClassName(obj.rowKey, 'matName', 'my-styled-green-cell');
        					 }
        				 })
        			 })
        			 
        			  if(result.length == 0){
        				 $.each(data, function(idx, obj){
        					 planGrid.removeCellClassName(obj.rowKey, 'matName', 'my-styled-yellow-cell');
        					 planGrid.removeCellClassName(obj.rowKey, 'matName', 'my-styled-green-cell');
        				 })
        			 }
        		},
        		error : function(reject){
        			console.log(reject);
        		}
            })
                
            $('#matBuyActInput').val(actName);
           	$('#matBuyActInputHidden').val(actCode);
            let beforeAct = orderGrid.getModifiedRows().createdRows;
            for(data of beforeAct){
            	
            	var matPrice = 0;
		        var matCode = orderGrid.getValue(data.rowKey, 'matCode', matCode);
		        	
		        	$.ajax({
		        		url : 'getActMatPrice',
		        		method : 'GET',
		        		data : { matCode : matCode, actCode : actCode },
		        		async : false,
		        		success : function(result){
		        			
		        			
		        			matPrice = result.matPrice;
		        		},
		        		error : function(reject){
		        			console.log(reject);
		        		}
		        	})
		        
		        orderGrid.setValue(data.rowKey, 'matPrice', matPrice);
	        	orderGrid.setValue(data.rowKey, 'actCode', actCode);
	            orderGrid.setValue(data.rowKey, 'actName', actName);
            }

    	});
		
		function filterPlanGrid(data){
			planGrid.filter('matName', data);
		}
		

		//삭제버튼
		$('#delete').on("click", function () {
		    //그리드에서 행 지움
		    orderGrid.removeCheckedRows(false);
		    //마우스 커서 없앰
		    orderGrid.blur();
		});
	
		//저장버튼
		document
		    .getElementById('save')
		    .addEventListener('click', saveServer);
	
		
	
		//발주 form
		var orderGrid = new tui.Grid({
		    el: document.getElementById('grid'),
		    data: [<c:forEach items="${matOrderList}" var="mat" varStatus="status">
		        {
		            matOdCd: "${mat.matOdCd}",
		            matOdDeCd: "${mat.matOdDeCd}",
		            matName: "${mat.matName}",
		            matCode: "${mat.matCode}",
		            matUnit: "${mat.matUnit}",
		            matStd: "${mat.matStd}",
		            matPrice: "${mat.matPrice}",
		            matAmt: "${mat.matAmt}",
		            matTotalPrice: "${mat.matPrice * mat.matAmt}",
		            actName: "${mat.actName}",
		            actCode: "${mat.actCode}",
		            empName: "${mat.empName}",
		            empCode: "${mat.empCode}",
		            matTestYn: "${mat.matTestYn}",
		            matOdRq: `<fmt:formatDate value="${mat.matOdRq}" pattern="yyyy-MM-dd"/>`,
		            matOdAcp: `<fmt:formatDate value="${mat.matOdAcp}" pattern="yyyy-MM-dd"/>`
		        }
		        <c:if test="${not status.last}">,</c:if>
		    </c:forEach>
		        ],
		    scrollX: false,
		    scrollY: false,
		    minBodyHeight: 400,
		    rowHeaders: [
		        {
		            type: 'rowNum'
		        }, {
		            type: 'checkbox'
		        }
		    ],
		    pageOptions: {
		        useClient: true,
		        perPage: 10
		    },
		    columns: [
		        {
		            header: '발주코드',
		            name: 'matOdCd',
		            width: 150,
		            sortable: true,
		            sortingType: 'asc',
		            align: 'center'
		        },
		        {
		            header: '발주일자',
		            name: 'matOdRq',
		            className: 'yellow-background',
		            align: 'center'
		        },
		        {
		            header: '업체코드', // [필수] 컬럼 이름
		            name: 'actCode',// [선택] 숨김 여부
		            editor : 'text',
		            align: 'center',
		            hidden: true
		        },
		        {
		            header: '거래처',
		            name: 'actName',
		            align: 'left'
		            
		        }, {
		            header: '자재명',
		            name: 'matName',
		            align: 'left'
		        }, {
		            header: '자재코드', // [필수] 컬럼 이름
		            name: 'matCode', // [선택] 숨김 여부
		            hidden: true
		        }, {
		            header: '단위',
		            name: 'matUnit',
		            align: 'left'
		        }, {
		            header: '규격',
		            name: 'matStd',
		            align: 'left'
		        }, {
		            header: '단가(원)',
		            name: 'matPrice',
		            editor: 'text',
		            formatter(e) {
		                if (e['value'] != null) {
		                    val = e['value']
		                        .toString()
		                        .replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		                    return val + "원";
		                }
		            },
		            width: 120,
		            validation: {
		                dataType: 'number',
		                required: true
		            },
		            align: 'right'
		        }, {
		            header: '발주량',
		            name: 'matAmt',
		            editor: 'text',
		            formatter(e) {
		                if (e['value'] != null) {
		                    val = e['value']
		                        .toString()
		                        .replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		                    return val;
		                }
		            },
		            validation: {
		                dataType: 'number',
		                required: true
		            },
		            align: 'right'
		        }, {
		            header: '총액',
		            name: 'matTotalPrice',
		            value: '${mat.matPrice * mat.matAmt}',
		            formatter(e) {
		                if (e['value'] != null) {
		                    val = e['value']
		                        .toString()
		                        .replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		                    return val + "원";
		                }
		            },
		            width: 120,
		            align: 'right'
		        },    {
		            header: '납기요청일',
		            name: 'matOdAcp',
		            editor: {
		                type: 'datePicker',
		                options: {
		                    language: 'ko'
		                }
		            },
		            className: 'yellow-background',
		            align: 'center'
		        }, {
		            header: '발주상세코드',
		            name: 'matOdDeCd',
		            hidden: true
		        }, {
		            header: '담당자코드', // [필수] 컬럼 이름
		            name: 'empCode',
		            hidden: true
		        }, {
		            header: '검수여부',
		            name: 'matTestYn',
		            formatter: function (e) {
		                if (e.value == 'Y') {
		                    return "검수완료";
		                } else if (e.value == 'N') {
		                    return "검수전";
		                }
		            },
		            align: 'left'
	
		        }, {
		            header: '담당자', // [필수] 컬럼 이름
		            name: 'empName',
		            align: 'center' // [필수] 컬럼 매핑 이름 값                    [선택] 숨김 여부
		        }
		    ]
		});
	
		setDisabled();
	
		orderGrid.on('afterChange', ev => {
			
		    let change = ev.changes[0];
		    let rowData = orderGrid.getRow(change.rowKey);
		    let totalPrice = rowData.matPrice * rowData.matAmt;
	
		    if (change.columnName == 'matAmt' || change.columnName == 'matPrice') {
		        if (rowData.matAmt != null && rowData.matPrice != null) {
		            orderGrid.setValue(change.rowKey, 'matTotalPrice', totalPrice);
		        }
		    }
		});
	
		function saveServer() {
		    orderGrid.blur();
		    let modifyGridInfo = orderGrid.getModifiedRows();
	
		    // 수정된게 없으면 바로 빠져나감
	
		    if (!orderGrid.isModified()) {
		        swal("경고", "변경사항이 없습니다", "warning");
		        return false;
		    }
	
		    //flag가 true = 입력폼이나 수정폼에 빠뜨린 데이터가 없다
		    var flag = true;
		    //create, modify, delete 포함하는 전체 배열을 도는 each문
	
		    if (orderGrid.getModifiedRows().createdRows.length > 0) {
	
		        $.each(orderGrid.getModifiedRows().createdRows, function (idx2, obj2) {
		            if (obj2['actCode'] == "" || obj2['actCode'] == null || obj2['matAmt'] == "" || obj2['matAmt'] == null || obj2['matCode'] == "" || obj2['matCode'] == null || obj2['matOdAcp'] == null || obj2['matOdAcp'] == "" || obj2['matPrice'] == "" || Number(obj2['matPrice']) == 0 ||obj2['matPrice'] == null || obj2['matOdRq'] == null || obj2['matOdRq'] == "") {
		                flag = false;
		                return false;
		            }
		        })
		    }
	
		    if (orderGrid.getModifiedRows().updatedRows.length > 0) {
		        $.each(orderGrid.getModifiedRows().updatedRows, function (idx2, obj2) {
		            if (obj2['matOdDeCd'] == "" || obj2['matOdDeCd'] == null || obj2['actCode'] == "" || obj2['actCode'] == null || obj2['matAmt'] == "" || obj2['matAmt'] == null || obj2['matCode'] == "" || obj2['matCode'] == null || obj2['matOdAcp'] == null || obj2['matOdAcp'] == "" || obj2['matPrice'] == "" || obj2['matPrice'] == null) {
		                flag = false;
		                return false;
		            }
	
		        })
		    }
	
		    if (flag) {
		        $.ajax({
		            url: 'matOrderDirSave',
		            method: 'POST',
		            data: JSON.stringify(orderGrid.getModifiedRows()),
		            contentType: 'application/json',
		            success: function (data) {
		                swal("성공", data + "건이 처리되었습니다.", "success");
		                selectAjax();
		                resetPlanGrid();
		                matActGrid.clear();
		                $('#matBuyActInput').val("");
				        $('#matBuyActInputHidden').val("");
		            },
		            error: function (reject) {
		                
		                swal("실패", "", "error");
		            }
		        })
		    } else {
		        swal("경고", "값이 입력되지 않았습니다", "warning");
		    }
	
		}
		//두번째 그리드 데이터 리셋
		function resetPlanGrid(){
			$.ajax({
		        url: 'getResetPlanGridData',
		        method: 'GET',
		        success: function(result) {
		        	
		        	$.each(result, function (idx, obj) {
		        		
		        		planGrid.resetData(result);
				        if (Number(obj['totalStock']) + Number(obj['willOdAmt']) < Number(obj['matSafe']) + Number(obj['willUseAmt'])) {
				            let rowKey = obj['rowKey'];
				            planGrid.addCellClassName(rowKey, 'totalStock', 'my-styled-cell');
				        }
				    })
		        },
		        error : function(reject){
		        	console.log(reject);
		        }
			})
		        
		}
		
		
	
		//검색
		function selectAjax() {
		    let mat = $('#matCodeInput').val();
		    let act = $('#actCodeInput').val();
		    let sd = $('#startDate').val();
		    let ed = $('#endDate').val();
		    let comple = '1';
		    let before = '1';
		    let beforeCheck = document.getElementById('before');
		    let compleCheck = document.getElementById('comple');
		    if (beforeCheck.checked && !compleCheck.checked) {
		        comple = '2';
		    } else if (!beforeCheck.checked && compleCheck.checked) {
		        before = '2';
		    }
	
		    let search = {
		        materialCode: mat,
		        accountCode: act,
		        startDate: sd,
		        endDate: ed,
		        before: before,
		        comple: comple
		    };
		    $.ajax({
		        url: 'getMatOrderFilter',
		        method: 'GET',
		        data: search,
		        success: function (data2) {
	
		            $.each(data2, function (idx, obj) {
		                obj['matTotalPrice'] = obj['matPrice'] * obj['matAmt'];
		                let date = new Date(obj['matOdRq']);
		                let year = date.getFullYear(); //0000년 가져오기
		                let month = date.getMonth() + 1; //월은 0부터 시작하니 +1하기
		                let day = date.getDate(); //일자 가져오기
		                obj['matOdRq'] = year + "-" + (
		                    ("00" + month.toString()).slice(-2)
		                ) + "-" + (
		                    ("00" + day.toString()).slice(-2)
		                );
	
		                date = new Date(obj['matOdAcp']);
		                year = date.getFullYear(); //0000년 가져오기
		                month = date.getMonth() + 1; //월은 0부터 시작하니 +1하기
		                day = date.getDate(); //일자 가져오기
		                obj['matOdAcp'] = year + "-" + (
		                    ("00" + month.toString()).slice(-2)
		                ) + "-" + (
		                    ("00" + day.toString()).slice(-2)
		                );
	
		            })
		            orderGrid.resetData(data2);
		            resetPlanGrid();
		            matActGrid.clear();
		            setDisabled();
		        }
		    })
		}
	
		function findColumns() {
		    var rows = orderGrid.findRows({matOdCd: null});
		    return rows;
		}
	
		//거래처명, 자재명, 담당자명 클릭하면 모달창 나온 후 선택할 수 있음. 선택 시 hidden cell에 데이터 넘어감
		var Grid;
		$("#actModal, #selectActModal").on('click', event => {
	
		    $("#modal").fadeIn();
		    preventScroll();
		    Grid = createActGrid();
		    $('.modal_title h3').text('거래처 목록');
		    Grid.on('dblclick', event2 => {
		        let rowKey = Grid
		            .getFocusedCell()
		            .rowKey;
		        if (rowKey != null) {
		            let actCode = Grid.getValue(rowKey, 'actCode');
		            let actName = Grid.getValue(rowKey, 'actName');
		            $(event.currentTarget)
		                .prev()
		                .val(actCode);
		            $(event.currentTarget)
		                .next()
		                .val(actName);
		            if (event.currentTarget.id == 'selectActModal') {
		                var rows = findColumns();
		                $.each(rows, function (idx, obj) {
		                    obj.actCode = actCode;
		                    obj.actName = actName;
		                })
		            }
		        }
	
		        //모달창 닫기
		        if (rowKey != null) {
		            $("#modal").fadeOut();
		            activeScroll();
		            let inputContent = $('#modalSearch').val('');
		            if (Grid != null && Grid.el != null) {
		                Grid.destroy();
		            }
		        }
	
		    })
		});
	
		$("#matModal").click(function () {
		    $("#modal").fadeIn();
		    preventScroll();
		    Grid = createMatGrid();
		    $('.modal_title h3').text('자재 목록');
		    Grid.on('dblclick', () => {
		        let rowKey = Grid
		            .getFocusedCell()
		            .rowKey;
		        if (rowKey != null) {
		            let matCode = Grid.getValue(rowKey, 'matCode');
		            let matName = Grid.getValue(rowKey, 'matName');
		            $("#matNameFix").val(matName);
	
		            $("#matCodeInput").val(matCode);
		        }
	
		        //모달창 닫기
		        if (rowKey != null) {
		            $("#modal").fadeOut();
		            activeScroll();
		            let inputContent = $('#modalSearch').val('');
		            if (Grid != null && Grid.el != null) {
		                Grid.destroy();
		            }
	
		        }
		    })
		});
	
		orderGrid.on('dblclick', ev => {
		    let rowKey = orderGrid
		        .getFocusedCell()
		        .rowKey;
		    let columnName = orderGrid
		        .getFocusedCell()
		        .columnName;
		    let value = orderGrid
		        .getFocusedCell()
		        .value;
	
		    let matOdCd = orderGrid.getValue(rowKey, 'matOdCd');
		    let matTestYn = orderGrid.getValue(rowKey, 'matTestYn');
		    if (matOdCd != null) {
		        if (matTestYn == 'Y') {
		            ev.stop();
		            return false;
		        }
		    }
	
		 
	
		});
		
		orderGrid.on('click', ()=>{
		    //선택한 행 색깔 바꾸기
		    	  let selectKey = orderGrid.getFocusedCell().rowKey;
		    	  orderGrid.addRowClassName(selectKey, 'selected-cell');
		    	  //다른 행 선택시 기존에 클릭했던 행은 class제거
		    	  orderGrid.on('focusChange', () => {
		    		  orderGrid.removeRowClassName(selectKey, 'selected-cell');
		    	  })
		})
		
		planGrid.on('click', ()=>{
		    //선택한 행 색깔 바꾸기
		    	  let selectKey = planGrid.getFocusedCell().rowKey;
		    	  planGrid.addRowClassName(selectKey, 'selected-cell');
		    	  //다른 행 선택시 기존에 클릭했던 행은 class제거
		    	  planGrid.on('focusChange', () => {
		    		  planGrid.removeRowClassName(selectKey, 'selected-cell');
		    	  })
		})
		
		matActGrid.on('click', ()=>{
		    //선택한 행 색깔 바꾸기
		    	  let selectKey = matActGrid.getFocusedCell().rowKey;
		    	  matActGrid.addRowClassName(selectKey, 'selected-cell');
		    	  //다른 행 선택시 기존에 클릭했던 행은 class제거
		    	  matActGrid.on('focusChange', () => {
		    		  matActGrid.removeRowClassName(selectKey, 'selected-cell');
		    	  })
		})
	
		//모달 검색
		$('#modalSearchBtn').on('click', function (e) {
		    let title = $('.modal_title h3').text();
		    let inputContent = $('#modalSearch').val();
	
		    if (title == '자재 목록') {
		        let modalSearchData = {
		            matName: inputContent
		        }
		        $.ajax({
		            url: 'getMatModalSearch',
		            method: 'GET',
		            data: modalSearchData,
		            success: function (data) {
		                Grid.resetData(data);
		            },
		            error: function (reject) {
		                console.log(reject);
		            }
		        })
		    } else if (title == '거래처 목록') {
		        let modalSearchData = {
		            actName: inputContent
		        }
		        $.ajax({
		            url: 'getActMatModalSearch',
		            method: 'GET',
		            data: modalSearchData,
		            success: function (data) {
		                Grid.resetData(data);
		            },
		            error: function (reject) {
		                console.log(reject);
		            }
		        })
		    }
		})
	
		//비활성화
		function setDisabled() {
		    $.each(orderGrid.getData(), function (idx, obj) {
	
		        if (obj['matOdCd'] != null && obj['matTestYn'] == 'Y') {
		            orderGrid.disableRow(obj['rowKey']);
		        }
		    })
		}
	
		//모달창 닫기
		$(".close_btn").click(function () {
		    $("#modal").fadeOut();
		    activeScroll();
		    let inputContent = $('#modalSearch').val('');
		    if (Grid != null && Grid.el != null) {
		        Grid.destroy();
		    }
		});
	
		//거래처 모달 그리드
		function createActGrid() {
		    var actGrid = new tui.Grid({
		        el: document.getElementById('modal_label'),
		        data: [<c:forEach items="${actList}" var="a" varStatus="status">
		            {
		                actCode: "${a.actCode}",
		                actName: "${a.actName}",
		                actSts: "${a.actSts}",
		                actKind: "${a.actKind}"
		            }
		            <c:if test="${not status.last}">,</c:if>
		        </c:forEach>
		            ],
		        scrollX: false,
		        scrollY: false,
		        minBodyHeight: 400,
		        rowHeaders: ['rowNum'],
		        selectionUnit: 'row',
		        pagination: true,
		        pageOptions: {
		            //백엔드와 연동 없이 페이지 네이션 사용가능하게 만듦
		            useClient: true,
		            perPage: 10
		        },
		        columns: [
		            {
		                header: '거래처코드',
		                name: 'actCode',
			            align: 'center'
		            }, {
		                header: '거래처명',
		                name: 'actName',
			            align: 'left'
		            }, {
		                header: '거래상태',
		                name: 'actSts',
			            align: 'center'
		            }, {
		                header: '거래처구분',
		                name: 'actKind',
			            align: 'center'
		            }
		        ]
	
		    });
	
		    return actGrid;
		}
	
		//자재 모달 그리드
		function createMatGrid() {
		    var matGrid = new tui.Grid({
		        el: document.getElementById('modal_label'),
		        data: [<c:forEach items="${matList}" var="m" varStatus="status">
		            {
		                matCode: "${m.matCode}",
		                matName: "${m.matName}",
		                matUnit: "${m.matUnit}",
		                matStd: "${m.matStd}"
		            }
		            <c:if test="${not status.last}">,</c:if>
		        </c:forEach>
		            ],
		        scrollX: false,
		        scrollY: false,
		        minBodyHeight: 400,
		        rowHeaders: ['rowNum'],
		        selectionUnit: 'row',
		        pagination: true,
		        pageOptions: {
		            //백엔드와 연동 없이 페이지 네이션 사용가능하게 만듦
		            useClient: true,
		            perPage: 10
		        },
		        columns: [
		            {
		                header: '자재코드',
		                name: 'matCode'
		            }, {
		                header: '자재명',
		                name: 'matName'
		            }, {
		                header: '단위',
		                name: 'matUnit'
		            }, {
		                header: '규격',
		                name: 'matStd'
		            }
		        ]
		    });
	
		    return matGrid;
		}
	
		//이전 날짜 선택불가
		$('#startDate').on('change', function () {
		    $('#endDate').attr('min', $('#startDate').val());
		});
		//이후날짜 선택불가
		$('#endDate').on('change', function () {
		    $('#startDate').attr('max', $('#endDate').val());
		});
	
		//검색
		$('#searchBtn').on('click', searchMatIn);
		function searchMatIn(e) {
		    let mat = $('#matCodeInput').val();
		    let act = $('#actCodeInput').val();
		    let sd = $('#startDate').val();
		    let ed = $('#endDate').val();
	
		    let search = {
		        materialCode: mat,
		        accountCode: act,
		        startDate: sd,
		        endDate: ed
		    };
		    selectAjax();
		}
	
		//초기화
		$('#searchResetBtn').on('click', resetInput);
		function resetInput(e) {
		    $('#searchP input').each(function (idx, obj) {
		        obj.value = '';
		        obj.checked = false;
		    })
		}
	
		//스크롤 막기
		function preventScroll() {
		    $('html, body').css({'overflow': 'hidden', 'height': '100%'}); // 모달팝업 중 html,body의 scroll을 hidden시킴
		    $('#element').on(
		        'scroll touchmove mousewheel',
		        function (event) { // 터치무브와 마우스휠 스크롤 방지
		            event.preventDefault();
		            event.stopPropagation();
	
		            return false;
		        }
		    );
		}
	
		//스크롤 활성화
		function activeScroll() {
		    $('html, body').css({'overflow': 'visible', 'height': '100%'}); //scroll hidden 해제
		    $('#element').off('scroll touchmove mousewheel'); // 터치무브 및 마우스휠 스크롤 가능
		}
	
		//엑셀 다운로드
		const excelDownload = document.querySelector('.excelDownload');
	
		document.addEventListener('DOMContentLoaded', () => {
		    excelDownload.addEventListener('click', function (e) {
		        orderGrid.export('xlsx');
		    })
		})
		
		
		var filterUpGridData = [];
		$.each(upGridData, function(idx, obj){
				if (Number(obj['totalStock']) + Number(obj['willOdAmt']) < Number(obj['matSafe']) + Number(obj['willUseAmt'])) {
			    	filterUpGridData.push(obj);
			    }
		})
		
		
		
		//부족 자재 체크박스
		$('#lowerMat').on('click', function(event){
			let value = $('#lowerMat').val();
			if(value == 'N'){
				$('#lowerMat').val('Y');

				planGrid.resetData(filterUpGridData);
			} else{
				$('#lowerMat').val('N');
				planGrid.resetData(upGridData);
			}
		})
		
		
		//수정중일때 페이지 나가면 경고창 출력
		$(document).ready(function(){ 
		    window.onbeforeunload = function(){
		        if(orderGrid.isModified()){
		        	doExit();
		        }
		    };
		});
		
		function doExit(){
		    event.returnValue = '"페이지를 벗어 나시겠습니까?"';
		}
		
		document.getElementById('startDate').value = new Date().toISOString().substring(0, 10);
		document.getElementById('endDate').value = new Date().toISOString().substring(0, 10);
		
    </script>
</body>
</html>