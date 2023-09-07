<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<!-- 토스트 그리드 데이트피커 -->
<link rel="stylesheet" href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />
<script src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
<!-- 토스트 페이지 네이션 -->
<script type="text/javascript" src="https://uicdn.toast.com/tui.code-snippet/latest/tui-code-snippet.js"></script>
<link rel="stylesheet" href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css" />
<script src="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.js"></script>
<meta charset="UTF-8">
<title>자재 검수 페이지 </title>
<!-- 토스트 페이지 네이션 -->
<script type="text/javascript" src="https://uicdn.toast.com/tui.code-snippet/latest/tui-code-snippet.js"></script>
<link rel="stylesheet" href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css" />
<script src="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.js"></script>
<!-- 페이지 네이션 끝 -->
<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
<style>

   #matDeModal{
		margin-top : 120px;
		margin-bottom : 10px;
		float : right;
	}

	#customtemplateSearchAndButton p{
		width: 80px;
		display: inline-block;
		font-size: 20px;
	}
	
	#customtemplateSearchAndButton input[type="text"],
		select {
		  width: 230px;
		  padding: 6px;
		  margin-bottom: 15px;
		  border: 1px solid #ccc;
		  border-radius: 4px;
		}
		
	
	h1{
		margin-left: 15px;
	}

	h1, h2{
		font-weight: 800;
	}
	
	.yellow-background {
        background-color: rgb(255,253,235);
	}
	
	#save, #delete{
		float : right;
	}
	
	.my-styled-cell {background-color: rgb(255, 229, 229)}

</style>    
       
</head>
<body>
   <h1>자재 검수 관리</h1>
   <div class="col-lg-12 stretch-card">
       <div class="card">
           <div class="card-body">
               <div class="table-responsive pt-3">                                                                             
                   	</button>

                	<!--추가 누르면 검사 예정 자재 항목들 뜨고 그걸 기반으로 코드 가져와서 행에 추가되게 해야됨  -->
                  	<div id="customtemplateSearchAndButton">
        				<div style="display: flex; justify-content: space-between;">
            				<div style="flex: 1; margin-left: 10px; margin-top : 20px;">
                				<p>자재명</p>
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
		            <div>
            		
            		<button id="matDeModal" class="btn btn-info btn-icon-text">주문서조회</button>
                	
            		</div>
            		
				</div>
		            <div id="matgrid"></div>
            		
            		<button class="btn btn-info btn-icon-text" id="save">저장</button>
			</div>
		</div>
	</div> 
<div>
		<jsp:include page="../comFn/dateFormat.jsp"></jsp:include>
	</div>


	<script>
	
	//저장버튼
	document.getElementById('save').addEventListener('click', saveServer);
	
	//검수 목록 그리드
	var matgrid = new tui.Grid({
	        el: document.getElementById('matgrid'),
	        data: [
	        	<c:forEach items="${matChkList}" var="matChk" varStatus="status">
	           	{
	           		matTestCode : "${matChk.matTestCode}",
	           		matOdDeCd : "${matChk.matOdDeCd}",
	           		matCode : "${matChk.matCode}",
	           		matName : "${matChk.matName}",
	           		matAmt : "${matChk.matAmt}",
	           		matYamt : "${matChk.matYamt}",
	           		matNamt : "${matChk.matNamt}",
	           		empCode : "${matChk.empCode}",
	           		empName : "${matChk.empName}",
	           		matTestDate : `<fmt:formatDate value="${matChk.matTestDate}" pattern="yyyy-MM-dd"/>`,
	           		errCode : "${matChk.errCode}",
	           		errCodeName : "${matChk.errCodeName}"
	           			
	           	}<c:if test="${not status.last}">,</c:if>
	           </c:forEach>
		          ],
	        scrollX: false,
	        scrollY: false,
	        minBodyHeight: 300,
	        rowHeaders: [{type: 'rowNum'},{type: 'checkbox'}],
	        pagination: true,
			pageOptions: {
				useClient: true,
		        perPage: 10
		      },
	        columns: [
	        	  {
	 	 	        header: '자재검수코드',
	 	 	        name: 'matTestCode',
		            align: 'center'
	 	 	      },
	 	 	      {
		 	 	        header: '자재발주코드',
		 	 	        name: 'matOdDeCd',
			            align: 'center'
		 	 	        
		 	 	  },
		 	 	  {
			 	 		header: '자재명',
			 	 		name : 'matName'
		 	 	  },
	 	 	      {
			 			header: '전체자재량',
			 		 	name: 'matAmt',
			 		 	formatter(e) {
	                    	if (e['value'] != null){
	        	                val = e['value']
	        	                    .toString()
	        	                    .replace(/\B(?=(\d{3})+(?!\d))/g, ',');
	        	                return val;
	                        	}
	        	            }
			 	  },
			 	  {
	                    header: '합격량', 
	                    name: 'matYamt',
	                    editor: 'text',
			 		 	formatter(e) {
	                    	if (e['value'] != null){
	        	                val = e['value']
	        	                    .toString()
	        	                    .replace(/\B(?=(\d{3})+(?!\d))/g, ',');
	        	                return val;
	                        	}
	        	            }
	              },
	              {
	            	  	header: '불합격량',
			 		 	name: 'matNamt',
			 		 	formatter(e) {
	                    	if (e['value'] != null){
	        	                val = e['value']
	        	                    .toString()
	        	                    .replace(/\B(?=(\d{3})+(?!\d))/g, ',');
	        	                return val;
	                        	}
	        	            }
	              },
	              {
	            	  	header: '담당자',
			 		 	name: 'empCode',
			 		 	editor: 'text',
			 		 	hidden : true
	              },
	              {
		  				header: '담당자',
		  				name :'empName'
	  			  },
	              {
		 	 	        header: '검수일자',
		 	 	        name: 'matTestDate',
				 	  	className: 'yellow-background',
			            align: 'center'
		 	 	  },
		 	 	  {
		 	 	        header: '불량코드',
		 	 	        name: 'errCode',
		 	 	        editor:'text',
		 	 	        hidden: true
		 	 	  },
		 	 	 {
		 	 	        header: '불량명',
		 	 	        name: 'errCodeName',
		 	 	        editor:'text'
		 	 	  }
	        ]
	      });
	
	setDisabled();
	
	//불량수량, 반품 있는 셀 - 빨간색으로 변경
	matgrid.on('onGridMounted', function (e) {
	    let data = matgrid.getData();
	    
	    $.each(data, function (idx, obj) {
		    if (obj['matNamt'] != '0') {
		            let rowKey = obj['rowKey'];
		            matgrid.addRowClassName(rowKey,'my-styled-cell');
		        }
	   	})
	});

	matgrid.on('afterChange', (ev) => {
		
		let change = ev.changes[0];
		let rowData = matgrid.getRow(change.rowKey);
		let matNamt = rowData.matAmt - rowData.matYamt;
		
		if(change.columnName == 'matYamt' || change.columnName == 'matNamt'){
			if(rowData.matYamt != null && rowData.matNamt != null){
				matgrid.setValue(change.rowKey, 'matNamt', matNamt);
			}
		}
		});
	

	 //삭제버튼
	$('#delete').on("click",function(){
		//그리드에서 행 지움
		matgrid.removeCheckedRows(false);
		//마우스 커서 없앰
		swal("성공", "삭제되었습니다.", "success");
		matgrid.blur();
	});
	 
	//저장버튼
	document.getElementById('save').addEventListener('click', saveServer);
	
	//저장 함수
	function saveServer() {	
		matgrid.blur();
		let modifyGridInfo = matgrid.getModifiedRows();
		
		// 수정된게 없으면 바로 빠져나감
		
		if(!matgrid.isModified()){
			swal("", "변경사항이 없습니다", "warning");
			return false;
		}
		
		//flag가 true = 입력폼이나 수정폼에 빠뜨린 데이터가 없다
		var flag = true;
		//create, modify, delete 포함하는 전체 배열을 도는 each문			
			
		if(matgrid.getModifiedRows().createdRows.length > 0 ){
				
				$.each(matgrid.getModifiedRows().createdRows, function(idx2, obj2){
					if(obj2['matYamt'] == "" || obj2['errCodeName'] == "" ){
						flag = false;
						return false;
					}
				})
		}
		
		if(matgrid.getModifiedRows().updatedRows.length > 0 ){

				$.each(matgrid.getModifiedRows().updatedRows, function(idx2, obj2){
					if(obj2['matYamt'] == "" ||obj2['errCodeName'] == ""){
						flag = false;
						return false;
					}
				})
				
		}
		
		if(flag){
				$.ajax({
					url : 'matChkDirSave',
					method : 'POST',
					data : JSON.stringify(matgrid.getModifiedRows()),
					contentType : 'application/json',
					success : function(data){
						swal("성공", "등록이 완료되었습니다.", "success");
						
						//공통코드 조회 ajax
						$.ajax({
							url : 'ajaxMatQualList',
							method : 'GET',
							success : function(result){
								
							  $.each(result, function(i, objDe){
				 					let td = result[i]['matTestDate'];
				 					
				 					result[i]['matTestDate'] = getDate(td);

				 				}) 
								
								matgrid.resetData(result);

							     $.each(result, function (idx, obj) {

							        if (obj['matNamt'] != '0') {
							            let rowKey = obj['rowKey'];
							            matgrid.addRowClassName(rowKey, 'my-styled-cell');
							        }
							    }) 
							    	 
								setDisabled();
	
							},
							error : function(reject){
								console.log(reject);
							}
						});
						
						
					},
					error : function(reject){
						console.log(reject);
						swal("실패", "모든 값이 입력되지 않았습니다.", "warning");
					}
				})
		} else {
			swal("", "값이 입력되지 않았습니다", "warning");
		}
		
		

	}
	
	//사원코드 - 행 클릭 모달
    var Grid;
    matgrid.on('click', (ev) => {
   	let rowKey = matgrid.getFocusedCell().rowKey;
   	let columnName = matgrid.getFocusedCell().columnName;
   	let errRtStsName = matgrid.getValue(rowKey, 'errRtStsName');
   	
   	if(errRtStsName != null){
			   ev.stop();
			   return false;
	   	}
   	
   	if(columnName == "empCode"){
   		$(".modal").fadeIn();
   	       Grid = createProdGrid();
   	       
   	       Grid.on('click', () => {
   	       		let rowKey2 = Grid.getFocusedCell().rowKey;
   	        	let empCode = Grid.getValue(rowKey2, 'empCode');
   	        	let empName = Grid.getValue(rowKey2, 'empName');
   	        	
   	        	console.log(empCode);
   	        	console.log(empName);

   	        	matgrid.setValue(rowKey, 'empCode', empCode);
   	        	matgrid.setValue(rowKey, 'empName', empName);
   	    		//선택시 모달창 닫기
   	    		if(rowKey != null){
   	    			$(".modal").fadeOut();
   	        		Grid.destroy();
   	    		}

   	       });
   	}

 	});
	
	//모달창 닫기
	$("#close_btn").click(function(){
       $(".modal").fadeOut();
        
 		Grid.destroy();
    });
	
	
	//사원 목록모달 그리드
    function createProdGrid(){
       var prodGrid = new tui.Grid({
           el: document.getElementById('modal_label'),
          scrollX: false,
           scrollY: false,
           minBodyHeight: 30,
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
                   header: '사원번호',
                   name: 'empCode',
                 },                  
                 {
                   header: '사원명',
                   name: 'empName'
                 }
            ]
          
         });
       
       
       $.ajax({
		    url : 'empCodeList1',
		    method : 'GET',
		    success : function(data){
		    	prodGrid.resetData(data);
		    },
		    error : function(reject){
		        console.log(reject);
		    }	
		})		 
       return prodGrid;
    }
	
	
	
  //불량코드 - 행 클릭 모달
    var Grid;
    matgrid.on('click', (ev) => {
   	let rowKey = matgrid.getFocusedCell().rowKey;
   	let columnName = matgrid.getFocusedCell().columnName;
	let errRtStsName = matgrid.getValue(rowKey, 'errRtStsName');
   	
   	if(errRtStsName != null){
			   ev.stop();
			   return false;
	   	}
   	
   	if(columnName == "errCodeName"){
   		$(".modal").fadeIn();
   	       Grid = createProdGrid2();
   	       
   	       Grid.on('click', () => {
   	       		let rowKey2 = Grid.getFocusedCell().rowKey;
   	       	let commdeCode = Grid.getValue(rowKey2, 'commdeCode');
   	        	let commdeName = Grid.getValue(rowKey2, 'commdeName');

   	        	matgrid.setValue(rowKey, 'errCode', commdeCode);
   	        	matgrid.setValue(rowKey, 'errCodeName', commdeName);
   	    		//선택시 모달창 닫기
   	    		if(rowKey != null){
   	    			$(".modal").fadeOut();
   	        		Grid.destroy();
   	    		}

   	       });
   	}

 	});
	
	//모달창 닫기
	$("#close_btn").click(function(){
       $(".modal").fadeOut();
        
 		Grid.destroy();
    });
	
	
	//불량 목록모달 그리드
    function createProdGrid2(){
       var prodGrid = new tui.Grid({
           el: document.getElementById('modal_label'),
          scrollX: false,
           scrollY: false,
           minBodyHeight: 30,
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
                   header: '불량코드',
                   name: 'commdeCode',
                 },                  
                 {
                   header: '불량명',
                   name: 'commdeName'
                 }
            ]
          
         });
       
       
       $.ajax({
		    url : 'errCodeList',
		    method : 'GET',
		    success : function(data){
		    	prodGrid.resetData(data);
		    },
		    error : function(reject){
		        console.log(reject);
		    }	
		})		 
       return prodGrid;
    }
	
	
	//불량반품상태 - 행 클릭 모달
    var Grid;
    matgrid.on('click', (ev) => {
   	let rowKey = matgrid.getFocusedCell().rowKey;
   	let columnName = matgrid.getFocusedCell().columnName;
	let errRtStsName = matgrid.getValue(rowKey, 'errRtStsName');
   	
   	if(errRtStsName != null){
			   ev.stop();
			   return false;
	   	}
   	if(columnName == "errRtStsName"){
   		$(".modal").fadeIn();
   	       Grid = createProdGrid3();
   	       
   	       Grid.on('click', () => {
   	       		let rowKey2 = Grid.getFocusedCell().rowKey;
   	       	let commdeCode = Grid.getValue(rowKey2, 'commdeCode');
   	     	let commdeName = Grid.getValue(rowKey2, 'commdeName');

   	        	matgrid.setValue(rowKey, 'errRtSts', commdeCode);
   	        	matgrid.setValue(rowKey, 'errRtStsName', commdeName);
   	    		//선택시 모달창 닫기
   	    		if(rowKey != null){
   	    			$(".modal").fadeOut();
   	        		Grid.destroy();
   	    		}

   	       });
   	}

 	});
	
	//모달창 닫기
	$("#close_btn").click(function(){
       $(".modal").fadeOut();
        
 		Grid.destroy();
    });
	
	
	//불량 반품 상태 목록모달 그리드
    function createProdGrid3(){
       var prodGrid = new tui.Grid({
           el: document.getElementById('modal_label'),
          scrollX: false,
           scrollY: false,
           minBodyHeight: 30,
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
                   header: '자재반품코드',
                   name: 'commdeCode',
                 },                  
                 {
                   header: '반품상태',
                   name: 'commdeName'
                 }
            ]
          
         });
       
       
       $.ajax({
		    url : 'matReturnCode',
		    method : 'GET',
		    success : function(data){
		    	prodGrid.resetData(data);
		    },
		    error : function(reject){
		        console.log(reject);
		    }	
		})		 
       return prodGrid;
    }
	
  //비활성화
	function setDisabled(){
		$.each(matgrid.getData(), function(idx, obj){
			
			if(obj['matYamt'] != null){
				matgrid.disableRow(obj['rowKey']);

			}
		})
	}
  
	//검색
    $('#searchBtn').on('click', searchProdIn);
    function searchProdIn(e){
 	   let content = $('#matSearch').val();
 	   let search = { matName : content };
 	   $.ajax({
 		   url : 'searchMatChk',
 		   method : 'GET',
 		   data : search ,
 		   success : function(data){
 			   
			  $.each(data, function(i, objDe){
					let td = data[i]['matTestDate'];
					
					data[i]['matTestDate'] = getDate(td);

				})
 				
 			   matgrid.resetData(data);
				setDisabled();
 		   },
 		   error : function(reject){
 			   console.log(reject);
 		   }
 	   })
    }
    
    </script>
    
    <div>
		<jsp:include page="../comFn/dateFormat.jsp"></jsp:include>
		<jsp:include page="../comFn/matDeModal.jsp"></jsp:include>
	</div>
</body>
</html>