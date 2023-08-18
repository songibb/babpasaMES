<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>반제품 입고 관리</title>
<!-- 토스트 페이지 네이션 -->
<script type="text/javascript" src="https://uicdn.toast.com/tui.code-snippet/latest/tui-code-snippet.js"></script>
<link rel="stylesheet" href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css" />
<script src="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.js"></script>
<!-- 페이지 네이션 끝 -->
<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
<style>
	#save, #delete{
		margin-top : 120px;
		float : right;
	}
	
	h1{
		font-weight : 700;
	}
	
	h2{
		clear : both;
		font-weight : 700;
	}
	
	.yellow-background {
        background-color: rgb(255,253,235);
	}
</style>    
       
</head>
<body>
   <h1>반제품 입고 관리</h1>
   <div class="col-lg-12 stretch-card">
       <div class="card">
           <div class="card-body">
               <div class="table-responsive pt-3">
               		<button type="button" class="btn btn-info btn-icon-text excelDownload">
                      	 Excel
                      	<i class="bi bi-printer"></i>                                                                              
                   	</button>
                   	<button class="btn btn-info btn-icon-text" id="save">저장</button>
                	<button class="btn btn-info btn-icon-text" id="delete">삭제</button>
                  	<div id="customtemplateSearchAndButton">
        				<div style="display: flex; justify-content: space-between;">
            				<div style="flex: 1;">
                				<p>반제품명</p>
				                <input type="text" id="prodCodeInput">
				                <i class="bi bi-search" id="prodModal"></i> <!-- 돋보기 아이콘 -->
				                <input type="text" class="blackcolorInputBox" id="prodNameFix" readonly>
				                <br>
				                <p>입고일자</p>
				                <input id="startDate" type="date">&nbsp;&nbsp;-&nbsp;&nbsp;<input id="endDate" type="date">
                				<button type="button" class="btn btn-info btn-icon-text" id="searchBtn">
                    				<i class="fas fa-search"></i>
                    					검색
                				</button>
                				<button type="button" class="btn btn-info btn-icon-text" id="searchResetBtn">
                    				초기화
                				</button>
            				</div>
        				</div>
	    			</div>
		            <h2>검사 완료된 반제품</h2>
		            <br>
		            <div id="grid2"></div>
		            <h2>반제품 입고 목록</h2>
		            <br>
		            <div id="grid"></div>
				</div>
			</div>
		</div>
	</div> 
	<div class="modal">
   		<div class="modal_content">
        	<div class="m_head">
            	<div class="modal_title"><h3>목록</h3></div>
            	<div class="close_btn" id="close_btn">X</div>
       		</div>
       		<div class="m_body">
            	<div id="modal_label"></div>
       		</div>
       		<div class="m_footer">
            	<div class="modal_btn cancle close_btn">CANCLE</div>
    		</div>
  		</div>
	</div>
	<script>
	
	//반제품 입고 목록
	var inGrid = new tui.Grid({
	       el: document.getElementById('grid'),
	       data: [
	           <c:forEach items="${inList}" var="semi">
	           	{
	           	semiLot : "${semi.semiLot}",
	           	prodCode :"${semi.prodCode}",
	           	prodName :"${semi.prodName}",
	           	semiInAmt :"${semi.semiInAmt}",
	           	empCode : "${semi.empCode}",
	           	empName : "${semi.empName}",
	           	semiInd : `<fmt:formatDate value="${semi.semiInd}" pattern="yyyy-MM-dd"/>`,
	           	semiExd : `<fmt:formatDate value="${semi.semiExd}" pattern="yyyy-MM-dd"/>`,
	            prcsListCode : "${semi.prcsListCode}"
	           	},
	           </c:forEach>
	          ],
		   scrollX: false,
	       scrollY: false,
	       minBodyHeight: 30,
	       rowHeaders: [{type: 'rowNum'},{type: 'checkbox'}],
	       pagination: true,
	       pageOptions: {
	       //백엔드와 연동 없이 페이지 네이션 사용가능하게 만듦
	         useClient: true,
	         perPage: 10
	       },
	       columns: [
	 	      {
	 	        header: '반제품 LOT',
	 	        name: 'semiLot'
	 	      },
	 	      {
	 	        header: '반제품코드',
	 	        name: 'prodCode'
	 	      },
	 	      {
	 	        header: '반제품명',
	 	        name: 'prodName'
	 	      },
	 	      {
			    header:'생산공정',
			    name: 'prcsListCode'
			  },
	 	      {
	 	        header: '입고량',
	 	        name: 'semiInAmt'
	 	      },
	 	      
	 	      {
	 	        header: '담당자명',
	 	        name: 'empName'
	 	      },
	 	      {
		 	    header: '담당자코드',
		 	    name: 'empCode',
		 	    hidden : true
		 	  },
	 	      {
		 	    header: '입고일자',
		 	    name: 'semiInd',
		 	    editor: {
	 	  		      type: 'datePicker',
	 	  		      options: {
	 	  		    	  language: 'ko'
	 	  		      }
	 	  		},
	 	  		className: 'yellow-background'
		 	  },
		 	  {
		 	    header: '유통기한',
		 	    name: 'semiExd',
		 	    editor: {
	 	  		      type: 'datePicker',
	 	  		      options: {
	 	  		    	  language: 'ko'
	 	  		      }
	 	  		},
	 	  		className: 'yellow-background'
		 	  }
	 	    ]
	      
	     });
	
	
	//test완료 목록 그리드
	   var testGrid = new tui.Grid({
		       el: document.getElementById('grid2'),
		       data: [
		           <c:forEach items="${testList}" var="test">
		           	{
		           	prcsListCode : "${test.prcsListCode}",
		           	prodCode : "${test.prodCode}",
		           	prodName : "${test.prodName}",
		           	testAmt : "${test.testAmt}",
		           	testDate : `<fmt:formatDate value="${test.testDate}" pattern="yyyy-MM-dd"/>`
		           	},
		           </c:forEach>
		          ],
			   scrollX: false,
		       scrollY: false,
		       minBodyHeight: 30,
		       rowHeaders: ['rowNum'],
		       pagination: true,
		       pageOptions: {
		       //백엔드와 연동 없이 페이지 네이션 사용가능하게 만듦
		         useClient: true,
		         perPage: 10
		       },
		       columns: [
		    	  {
		    		  header: '생산공정코드',
			 	      name: 'prcsListCode'
		    	  },
		    	  {
		    		  header: '반제품코드',
			 	      name: 'prodCode'
		    	  },
		 	      {
		 	          header: '반제품명',
		 	          name: 'prodName'
		 	      },
		 	      {
			 	        header: '생산량',
			 	        name: 'testAmt'
			 	  },
			 	  {
			 	        header: '검수일자',
			 	        name: 'testDate',
			 	        editor: {
			 	  		      type: 'datePicker',
			 	  		      options: {
			 	  		    	  language: 'ko'
			 	  		      }
			 	  		},
			 	  		className: 'yellow-background'
			 	  }
		 	    ]
		      
		     });
	
	 //삭제버튼
	$('#delete').on("click",function(){
		//그리드에서 행 지움
		inGrid.removeCheckedRows(false);
		//마우스 커서 없앰
		inGrid.blur();
	});
	
	//저장버튼
	document.getElementById('save').addEventListener('click', saveServer);
	
	//저장 함수
	function saveServer() {	
		inGrid.blur();
		let modifyGridInfo = inGrid.getModifiedRows();
		
		// 수정된게 없으면 바로 빠져나감
		
		if(!inGrid.isModified()){
			swal("", "변경사항이 없습니다", "warning");
			return false;
		}
		
		//flag가 true = 입력폼이나 수정폼에 빠뜨린 데이터가 없다
		var flag = true;
		//create, modify, delete 포함하는 전체 배열을 도는 each문			
			
		if(inGrid.getModifiedRows().createdRows.length > 0 ){
				
				$.each(inGrid.getModifiedRows().createdRows, function(idx2, obj2){
					if(obj2['prodCode'] == "" ||obj2['semiInAmt'] == "" || obj2['semiExd'] == "" || obj2['semiInd'] == "" || obj2['prcsListCode']== ""){
						flag = false;
						return false;
					}
				})
		}
		
		if(inGrid.getModifiedRows().updatedRows.length > 0 ){

				$.each(inGrid.getModifiedRows().updatedRows, function(idx2, obj2){
					if(obj2['semiInd'] == "" || obj2['semiExd'] == ""){
						flag = false;
						return false;
					}
				})
				
		}
		
		if(flag){
				$.ajax({
					url : 'semiInDirSave',
					method : 'POST',
					data : JSON.stringify(inGrid.getModifiedRows()),
					contentType : 'application/json',
					success : function(data){
						swal("성공", data +"건이 처리되었습니다.", "success");
						selectAjax();
					},
					error : function(reject){
						console.log(reject);
						swal("실패", "", "error");
					}
				})
		} else {
			swal("", "값이 입력되지 않았습니다", "warning");
		}

	}
	
	//검색 또는 DML 후 다시 LIST 불러오는 함수
	function selectAjax(){
		let mat = $('#matCodeInput').val();
		let act = $('#actCodeInput').val();
		let sd = $('#startDate').val();
		let ed = $('#endDate').val();
		   
		let search = { materialCode : mat , accountCode : act , startDate : sd , endDate : ed };
		$.ajax({
			url : 'getSemiInFilter',
			method : 'GET',
			data : search,
			success : function(data2){
				
				$.each(data2, function(idx, obj){
					
					let date = new Date(obj['semiInd']);
					let year = date.getFullYear();    //0000년 가져오기
					let month = date.getMonth() + 1;  //월은 0부터 시작하니 +1하기
					let day = date.getDate();        //일자 가져오기
					obj['semiInd'] = year + "-" + (("00"+month.toString()).slice(-2)) + "-" + (("00"+day.toString()).slice(-2));
					
					date = new Date(obj['semiExd']);
					year = date.getFullYear();    //0000년 가져오기
					month = date.getMonth() + 1;  //월은 0부터 시작하니 +1하기
					day = date.getDate();        //일자 가져오기
					obj['semiExd'] = year + "-" + (("00"+month.toString()).slice(-2)) + "-" + (("00"+day.toString()).slice(-2));
					
					
				})
				inGrid.resetData(data2);
			}
		})
	}
	
	//insert 후에는 1번 그리드도 내용이 업데이트 되어야 함
	function resetTestList(){
		$.ajax({
			url : 'getSemiTestFinish',
			method : 'GET',
			data : search,
			success : function(data2){
				
				$.each(data2, function(idx, obj){
					
					let date = new Date(obj['testDate']);
					let year = date.getFullYear();    //0000년 가져오기
					let month = date.getMonth() + 1;  //월은 0부터 시작하니 +1하기
					let day = date.getDate();        //일자 가져오기
					obj['testDate'] = year + "-" + (("00"+month.toString()).slice(-2)) + "-" + (("00"+day.toString()).slice(-2));
	
				})
				testGrid.resetData(data2);
			}
		})
	}
	
	//모달 시작
	   var Grid;
	     $("#prodModal").click(function(){
	       $(".modal").fadeIn();
	       Grid = createProdGrid();
	       $('.modal_title h3').text('반제품 목록');
	       Grid.on('dblclick', () => {
	        	let rowKey = Grid.getFocusedCell().rowKey;
	        	let prodCode = Grid.getValue(rowKey, 'prodCode');
	        	let prodName = Grid.getValue(rowKey, 'prodName');
	    		$("#prodCodeInput").val(prodCode);
	    		$("#prodNameFix").val(prodName);
	    		//모달창 닫기
	    		console.log(rowKey);
	    		if(rowKey != null){
	    			$(".modal").fadeOut();
	        		Grid.destroy();
	    		}

	    		});
	      	});
	     
	     $(".close_btn").click(function(){
	         $(".modal").fadeOut();
	         
	  		Grid.destroy();
	       });
	     
	   //반제품 모달 그리드
	     function createProdGrid(){
	  	   var prodGrid = new tui.Grid({
	  	       el: document.getElementById('modal_label'),
	  	       data: [
	  	    	   <c:forEach items="${prodList}" var="p" varStatus="status">
	  	          	{
	  	          		prodCode : "${p.prodCode}",
	  	          		prodName :"${p.prodName}"
	  	          	} <c:if test="${not status.last}">,</c:if>
	  	          </c:forEach>
	  	          ],
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
	  	               header: '반제품코드',
	  	               name: 'prodCode',
	  	             },
	  	             {
	  	               header: '반제품명',
	  	               name: 'prodName'
	  	             }
	  	 	    ]
	  	      
	  	     });
	  	   
	  	   return prodGrid;
	     }
	   //모달 끝
	
	
	
	//검색버튼
	//검색
    $('#searchBtn').on('click', searchSemiIn);
   function searchSemiIn(e){
	   let prod = $('#prodCodeInput').val();
	   let sd = $('#startDate').val();
	   let ed = $('#endDate').val();	   
		  
	   let search = { productCode : prod , startDate : sd , endDate : ed };
	   $.ajax({
		   url : 'getSemiInFilter',
		   method : 'GET',
		   data : search ,
		   success : function(data){
			   
			  for(let i of data){
					let date = new Date(i.semiInd);
					let year = date.getFullYear();    //0000년 가져오기
					let month = date.getMonth() + 1;  //월은 0부터 시작하니 +1하기
					let day = date.getDate();        //일자 가져오기
			   		i.semiInd = year + "-" + (("00"+month.toString()).slice(-2)) + "-" + (("00"+day.toString()).slice(-2));
					
					date = new Date(i.semiExd);
					year = date.getFullYear();    //0000년 가져오기
					month = date.getMonth() + 1;  //월은 0부터 시작하니 +1하기
					day = date.getDate();        //일자 가져오기
			   		i.semiExd = year + "-" + (("00"+month.toString()).slice(-2)) + "-" + (("00"+day.toString()).slice(-2));
			  }
			   inGrid.resetData(data);
		   },
		   error : function(reject){
			   console.log(reject);
		   }
	   });
   }
    
    //검색 옆 초기화버튼
    $('#searchResetBtn').on('click', resetInput);
    function resetInput(e){
 	   $('input').each(function(idx, obj){
 		   obj.value = '';
 	   })
    }
    
    
    
  	//엑셀 다운로드
    const excelDownload = document.querySelector('.excelDownload');
    document.addEventListener('DOMContentLoaded', ()=>{
       excelDownload.addEventListener('click', function(e){
          inGrid.export('xlsx');
       })
    })
	
	//상단 그리드 셀 클릭시 하단 그리드로 데이터 넘어가는 이벤트
	testGrid.on('dblclick', () => {
    	let rowKey = testGrid.getFocusedCell().rowKey;
    	//let columnName = orderGrid.getFocusedCell().columnName;
    	//let value = orderGrid.getFocusedCell().value;	
    	
    	let prcsListCode = testGrid.getValue(rowKey, 'prcsListCode');
    	let prodCode = testGrid.getValue(rowKey, 'prodCode');
    	let prodName = testGrid.getValue(rowKey, 'prodName');
    	let testAmt = testGrid.getValue(rowKey, 'testAmt');
    	
		
    	
    	
    	testGrid.removeRow(rowKey);
    	
    	testGrid.blur();
    	inGrid.appendRow({'prcsListCode' : prcsListCode,
    					   'prodCode' : prodCode,
    					   'prodName' : prodName,
    					   'semiInAmt' : testAmt,
    					   'empCode' : ${user.id},
    					   'empName' : `${user.empName}`},
    					   { at: 0 }
    	);
	
  	});
    
    //이전 날짜 선택불가
    $( '#startDate' ).on( 'change', function() {
      $( '#endDate' ).attr( 'min',  $( '#startDate' ).val() );
    } );
   //이후날짜 선택불가
    $( '#endDate' ).on( 'change', function() {
         $( '#startDate' ).attr( 'max',  $( '#endDate' ).val() );
       } );
    </script>
</body>
</html>