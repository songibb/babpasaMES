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
   #save, #delete, #dirAdd{
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
   <h1>자재 발주 관리</h1>
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
                	<button class="btn btn-info btn-icon-text" id="dirAdd">행추가</button>
                  	<div id="customtemplateSearchAndButton">
        				<div style="display: flex; justify-content: space-between;">
            				<div style="flex: 1;">
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
                				<p>발주일자</p>
                				<input id="startDate" type="date">&nbsp;&nbsp;-&nbsp;&nbsp;<input id="endDate" type="date">
                				<br>
                				<p>등록 거래처명</p>
                  				<input type="text" id="selectActCodeInput">
                    			<i class="bi bi-search" id="selectActModal"></i>
                  				<input type="text" class="blackcolorInputBox" id="selectActNameFix" readonly>
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
		            <h2>발주 목록</h2>
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
	
	//삭제버튼
	$('#delete').on("click",function(){
		//그리드에서 행 지움
		orderGrid.removeCheckedRows(false);
		//마우스 커서 없앰
		orderGrid.blur();
		});
	
	
	//저장버튼
	document.getElementById('save').addEventListener('click', saveServer);
	//행추가
	document.getElementById('dirAdd').addEventListener('click', addDirRow);

	

	//행추가 버튼 클릭시 상세생산지시 행 추가
	
	function addDirRow(){
		//등록 거래처명
		actName = $('#selectActNameFix').val();
		actCode = $('#selectActCodeInput').val();
		
		
		//등록 거래처가 없으면 행추가를 못함
		if($('#selectActNameFix').val().length === 0){
			alert('거래처를 먼저 등록해주세요.');
		} else {
			//거래처가 등록되어 있을 경우 행추가 허용
		    orderGrid.appendRow( {'actName' : actName, 'actCode' : actCode}, { at: 0 });	
			
		}
	}

	//발주 form
	var orderGrid = new tui.Grid({
	        el: document.getElementById('grid'),
	        data: [
	        	<c:forEach items="${matOrderList}" var="mat" varStatus="status">
	           	{
	           	matOdCd : "${mat.matOdCd}",
	           	matOdDeCd : "${mat.matOdDeCd}",
	           	matName :"${mat.matName}",
	           	matCode : "${mat.matCode}",
	           	matPrice :"${mat.matPrice}",
	           	matAmt :"${mat.matAmt}",
	           	matTotalPrice : "${mat.matPrice * mat.matAmt}",
	           	actName :"${mat.actName}",
	           	actCode : "${mat.actCode}",
	           	empName : "${mat.empName}",
	           	empCode : "${mat.empCode}",
	           	matOdRq : `<fmt:formatDate value="${mat.matOdRq}" pattern="yyyy-MM-dd"/>`,
	           	matOdAcp :`<fmt:formatDate value="${mat.matOdAcp}" pattern="yyyy-MM-dd"/>`
	           	}<c:if test="${not status.last}">,</c:if>
	           </c:forEach>
		          ],
	        scrollX: false,
	        scrollY: false,
	        minBodyHeight: 30,
	        rowHeaders: [{type: 'rowNum'},{type: 'checkbox'}],
			pageOptions: {
				useClient: true,
		        perPage: 10
		      },
	        columns: [
	        	  {
	 	 	        header: '발주코드',
	 	 	        name: 'matOdCd'
	 	 	      },
	 	 	      {
		 	 	        header: '발주상세코드',
		 	 	        name: 'matOdDeCd',
		 	 	        hidden : true
		 	 	        
		 	 	  },
	 	 	      {
			 			header: '자재명',
			 		 	name: 'matName',
			 	 	    editor : 'text'
			 	  },
			 	  {
	                    header: '자재코드',            // [필수] 컬럼 이름
	                    name: 'matCode',                 // [필수] 컬럼 매핑 이름 값
	                    hidden : true                // [선택] 숨김 여부
	              },
	              {
		 	 	        header: '단가(원)',
		 	 	        name: 'matPrice',
		 	 	        editor : 'text'
		 	 	  },
		 	 	  {
		 	 	        header: '발주량',
		 	 	        name: 'matAmt',
			 	 	    editor : 'text'
		 	 	  },
		 	 	  {
		 	 	        header: '총액',
		 	 	        name: 'matTotalPrice',
			 	 	    value : '${mat.matPrice * mat.matAmt}'
		 	 	  },
	        	  {
	 	 	        header: '거래처명',
	 	 	        name: 'actName'
	 	 	      },
	 	 	      {
	                header: '거래처코드',            // [필수] 컬럼 이름
	                name: 'actCode',                 // [필수] 컬럼 매핑 이름 값
	                hidden : true                // [선택] 숨김 여부
	              },
	 	 	      {
                    header: '담당자명',            // [필수] 컬럼 이름
                    name: 'empName'                 // [필수] 컬럼 매핑 이름 값                   // [선택] 숨김 여부
                  },
                  {
                    header: '담당자코드',            // [필수] 컬럼 이름
                    name: 'empCode',                 // [필수] 컬럼 매핑 이름 값
                    hidden : true                 // [선택] 숨김 여부
                  },
	 	 	      {
	 	 	        header: '발주일자',
	 	 	        name: 'matOdRq',
	 	 	      	editor: {
	 	  		      type: 'datePicker',
	 	  		      options: {
	 	  		    	  language: 'ko'
	 	  		      }
	 	  		    },
	 	  		 	className: 'yellow-background'
	 	 	        
	 	 	      },
	 	 	      {
		 	 	    header: '납기요청일',
		 	 	    name: 'matOdAcp',
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
	

	
	
	
	
	//저장 버튼 클릭시 실행 될 함수 -> insert 실행
	function saveServer() {	
		orderGrid.blur();
		let modifyGridInfo = orderGrid.getModifiedRows();
		console.log(modifyGridInfo);
		//flag가 true = 입력폼이나 수정폼에 빠뜨린 데이터가 없다
		var flag = true;
		//create, modify, delete 포함하는 전체 배열을 도는 each문
		var list = [];
		var list2 = [];
		var list3 = [];
		$.each(modifyGridInfo, function(idx, obj){
			
			//$.each를 돌 때 idx가 createdRows, updatedRows, deletedRows 3가지로 나눠짐 
			//obj.length != 0 -> 데이터가 있을 때만 코드를 실행시키겠다
			if(!flag){
				alert('값이 입력되지 않았습니다.');
				return;
			}
			else if(idx == 'createdRows' && obj.length != 0){
				
				$.each(obj, function(idx2, obj2){
					// console.log(obj2);  createdRows [{…}]
					
					if(obj2['actCode'] == '' ||obj2['matAmt'] =='' || obj2['matCode'] == '' || obj2['matOdAcp'] == '' || obj2['matPrice']=='' || obj2['matOdRq'] == ''){
						flag = false;
						return;
					}
					
					let customObj = {};
					customObj['empCode'] = "이슬";	//고치기
					customObj['actCode'] = obj2['actCode'];
					customObj['matAmt'] = obj2['matAmt'];
					customObj['matCode'] = obj2['matCode'];
					customObj['matOdAcp'] = obj2['matOdAcp'];
					customObj['matPrice'] = obj2['matPrice'];
					customObj['matOdRq'] = obj2['matOdRq'];
				 	list.push(customObj);
					
					
				})
			}else if(idx == 'updatedRows' && obj.length != 0){
				
				
				$.each(obj, function(idx2, obj2){
					if(obj2['matOdDeCd'] == '' ||obj2['actCode'] =='' ||obj2['matAmt'] == '' || obj2['matCode'] == '' || obj2['matOdAcp']=='' || obj2['matPrice'] == '' || obj2['matOdRq'] == ''){
						flag = false;
						return;
					}
					
						let customObj = {};
						customObj['matOdDeCd'] = obj2['matOdDeCd'];
						customObj['empCode'] = "이슬";	//고치기
						customObj['actCode'] = obj2['actCode'];
						customObj['matAmt'] = obj2['matAmt'];
						customObj['matCode'] = obj2['matCode'];
						customObj['matOdAcp'] = obj2['matOdAcp'];
						customObj['matPrice'] = obj2['matPrice'];
						customObj['matOdRq'] = obj2['matOdRq'];
			 			list2.push(customObj);

				})
				

			}else if(idx == 'deletedRows' && obj.length != 0){
				
				
				
				$.each(obj, function(idx2, obj2){
						
						let customObj = {};
						customObj['matOdDeCd'] = obj2['matOdDeCd'];
						customObj['matOdCd'] = obj2['matOdCd'];
						list3.push(customObj);
				})

			}
			
		})
		
		if(flag){
			
			if(list3.length != 0){
				$.ajax({
					url : 'matOrderDirDelete',
					method : 'POST',
					data : JSON.stringify(list3),
					contentType : 'application/json',
					success : function(data){
						console.log(data);
						selectAjax();
					},
					error : function(reject){
						console.log(reject);
					}
				});
			}
			if(list2.length != 0){
				$.ajax({
					url : 'matOrderDirUpdate',
					method : 'POST',
					data : JSON.stringify(list2),
					contentType : 'application/json',
					success : function(data){
						selectAjax();
					},
					error : function(reject){
						console.log(reject);
					}
				});
			}
			if(list.length != 0){
				$.ajax({
					url : 'matOrderDirInsert',
					method : 'POST',
					data : JSON.stringify(list),
					contentType : 'application/json',
					success : function(data){
						selectAjax();
					},
					error : function(reject){
						console.log(reject);
					}
				});
			}

		} else {
			return;
		}
	}
	
	//검색
	function selectAjax(){
		let mat = $('#matCodeInput').val();
		let act = $('#actCodeInput').val();
		let sd = $('#startDate').val();
		let ed = $('#endDate').val();
		   
		let search = { materialCode : mat , accountCode : act , startDate : sd , endDate : ed };
		$.ajax({
			url : 'getMatOrderFilter',
			method : 'GET',
			data : search,
			success : function(data2){
				
				$.each(data2, function(idx, obj){
					obj['matTotalPrice'] = obj['matPrice'] * obj['matAmt'];
					let date = new Date(obj['matOdRq']);
					let year = date.getFullYear();    //0000년 가져오기
					let month = date.getMonth() + 1;  //월은 0부터 시작하니 +1하기
					let day = date.getDate();        //일자 가져오기
					obj['matOdRq'] = year + "-" + (("00"+month.toString()).slice(-2)) + "-" + (("00"+day.toString()).slice(-2));
					
					date = new Date(obj['matOdAcp']);
					year = date.getFullYear();    //0000년 가져오기
					month = date.getMonth() + 1;  //월은 0부터 시작하니 +1하기
					day = date.getDate();        //일자 가져오기
					obj['matOdAcp'] = year + "-" + (("00"+month.toString()).slice(-2)) + "-" + (("00"+day.toString()).slice(-2));
					
					
				})
				orderGrid.resetData(data2);
			}
		})
	}
		
	function findColumns(){
		var rows = orderGrid.findRows({
			matOdCd : null
		});
		return rows;
	}
	
	//거래처명, 자재명, 담당자명 클릭하면 모달창 나온 후 선택할 수 있음. 선택 시 hidden cell에 데이터 넘어감
		var Grid;
		$("#actModal, #selectActModal").on('click', event =>{
			
		       $(".modal").fadeIn();
		       Grid = createActGrid();
		       
		       Grid.on('click', event2 => {
		        	let rowKey = Grid.getFocusedCell().rowKey;
		        	let actCode = Grid.getValue(rowKey, 'actCode');
		        	let actName = Grid.getValue(rowKey, 'actName');
		    		$(event.currentTarget).prev().val(actCode);
		    		$(event.currentTarget).next().val(actName);
		    		if(event.currentTarget.id == 'selectActModal'){
		    			var rows = findColumns();
		    			$.each(rows, function(idx, obj){
		    				obj.actCode = actCode;
		    				obj.actName = actName;
		    			})
		    		}
		    		
		    		
		    		//모달창 닫기
		    		if(rowKey != null){
		    			$(".modal").fadeOut();
		        		Grid.destroy();
		    		}

		    		});
		      	});
			
		     
		     
		   $("#matModal").click(function(){
		       $(".modal").fadeIn();
		       Grid = createMatGrid();
		       Grid.on('click', () => {
		       	let rowKey = Grid.getFocusedCell().rowKey;
		       	let matCode = Grid.getValue(rowKey, 'matCode');
		    	let matName = Grid.getValue(rowKey, 'matName');
				$("#matCodeInput").val(matCode);
				$("#matNameFix").val(matName);
		       
		   		$("#matCodeInput").val(matCode);
		   		//모달창 닫기
		   		if(rowKey != null){
					$(".modal").fadeOut();
		    		Grid.destroy();

		   		}
		     })
		     });
	
		
		orderGrid.on('dblclick', () => {
    	let rowKey = orderGrid.getFocusedCell().rowKey;
    	let columnName = orderGrid.getFocusedCell().columnName;
    	let value = orderGrid.getFocusedCell().value;
    	
    	if(columnName == 'matName'){
    		$(".modal").fadeIn();
 	       Grid = createMatGrid();
 	       
 	       Grid.on('click', () => {
 	       		let rowKey2 = Grid.getFocusedCell().rowKey;
 	        	let matCode = Grid.getValue(rowKey2, 'matCode');
 	        	let matName = Grid.getValue(rowKey2, 'matName');
 	        	orderGrid.finishEditing(rowKey, columnName);

 	    		if(matCode != null){
 	    			orderGrid.setValue(rowKey, 'matCode', matCode);
 	    		}
 	    		if(matName != null){
 	    			orderGrid.setValue(rowKey, 'matName', matName);
 	    		}
 	    		
 	    		
 	    		//선택시 모달창 닫기
 	    		if(matCode != null){
 	    			$(".modal").fadeOut();
 	        		Grid.destroy();
 	    		}

 	       });
    	} 
    	

  	});
	
	//모달창 닫기
	$(".close_btn").click(function(){
        $(".modal").fadeOut();
         
  		Grid.destroy();
     });
	
	//거래처 모달 그리드
     function createActGrid(){
  	   var actGrid = new tui.Grid({
  	       el: document.getElementById('modal_label'),
  	       data: [
  	    	   <c:forEach items="${actList}" var="a" varStatus="status">
  	          	{
  	          		actCode : "${a.actCode}",
  	          		actName :"${a.actName}",
  	          		actSts :"${a.actSts}",
  	          		actKind :"${a.actKind}"
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
  	               header: '거래처코드',
  	               name: 'actCode',
  	             },
  	             {
  	               header: '거래처명',
  	               name: 'actName'
  	             },
  	             {
  	               header: '거래상태',
  	               name: 'actSts'
  	             },
  	             {
  	               header: '거래처구분',
  	               name: 'actKind'
  	             }
  	 	    ]
  	      
  	     });
  	   
  	   return actGrid;
     }
	
   //자재 모달 그리드
     function createMatGrid(){
	   var matGrid = new tui.Grid({
	       el: document.getElementById('modal_label'),
	       data: [
	    	   <c:forEach items="${matList}" var="m" varStatus="status">
	          	{
	          		matCode : "${m.matCode}",
	          		matName :"${m.matName}",
	          		matStd :"${m.matStd}",
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
	               header: '자재코드',
	               name: 'matCode',
	             },
	             {
	               header: '자재명',
	               name: 'matName'
	             },
	             {
	               header: '규격',
	               name: 'matStd'
	             }
	 	    ]
	      
	     });
	   
	   return matGrid;
  }
   
   //이전 날짜 선택불가
     $( '#startDate' ).on( 'change', function() {
       $( '#endDate' ).attr( 'min',  $( '#startDate' ).val() );
     } );
    //이후날짜 선택불가
     $( '#endDate' ).on( 'change', function() {
          $( '#startDate' ).attr( 'max',  $( '#endDate' ).val() );
        } );
    
    
   //검색
     $('#searchBtn').on('click', searchMatIn);
    function searchMatIn(e){
 	   let mat = $('#matCodeInput').val();
 	   let act = $('#actCodeInput').val();
 	   let sd = $('#startDate').val();
 	   let ed = $('#endDate').val();	   
 		  
 	   let search = { materialCode : mat , accountCode : act , startDate : sd , endDate : ed };
 	   selectAjax();
    }
    
  //초기화
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
          orderGrid.export('xlsx');
       })
    })
	

    </script>
</body>
</html>