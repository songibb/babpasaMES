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
	
	#grid{
		height: 700px;
		
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
                				<input type="text" id="matCodeInput">
                				<i class="bi bi-search" id="matModal"></i> <!-- 돋보기 아이콘 -->
                				<input type="text" class="blackcolorInputBox" id="matNameFix" readonly>
                				<br>
                				<p>업체명</p>
                				<input type="text" id="actCodeInput">
                				<i class="bi bi-search" id="actModal"></i>
                				<input type="text" class="blackcolorInputBox" id="actNameFix" readonly>
                				<br>
                				<p>발주일자</p>
                				<input id="startDate" type="date">&nbsp;&nbsp;-&nbsp;&nbsp;<input id="endDate" type="date">
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
                				<br>
                				<p>등록 업체명</p>
                  				<input type="text" id="selectActCodeInput">
                    			<i class="bi bi-search" id="selectActModal"></i>
                    		
                  				<input type="text" class="blackcolorInputBox" id="selectActNameFix" readonly>
                			
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
			swal("","업체를 먼저 등록해주세요.", "warning");
		} else {
			//거래처가 등록되어 있을 경우 행추가 허용
			let now = new Date();	// 현재 날짜 및 시간
			let year = now.getFullYear();
			let month = ('0' + (now.getMonth() + 1)).substr(-2);
			let day = ('0' + now.getDate()).substr(-2);
			let matOdRq = year + "-" + month + "-" + day;
		    orderGrid.appendRow( {'actName' : actName, 'actCode' : actCode, 'matOdRq' : matOdRq, 'empCode' : ${user.id}, 'empName' : `${user.empName}`}, { at: 0 });	
			
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
	           	matUnit : "${mat.matUnit}",
	           	matStd : "${mat.matStd}",
	           	matPrice :"${mat.matPrice}",
	           	matAmt :"${mat.matAmt}",
	           	matTotalPrice : "${mat.matPrice * mat.matAmt}",
	           	actName :"${mat.actName}",
	           	actCode : "${mat.actCode}",
	           	empName : "${mat.empName}",
	           	empCode : "${mat.empCode}",
	           	matTestYn : "${mat.matTestYn}",
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
	 	 	        name: 'matOdCd',
			 	 	width: 150
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
	            	  	header: '단위',
			 		 	name: 'matUnit' 
	              },
	              {
	            	  	header: '규격',
			 		 	name: 'matStd'
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
	 	 	        header: '업체명',
	 	 	        name: 'actName'
	 	 	      },
	 	 	      {
	                header: '업체코드',            // [필수] 컬럼 이름
	                name: 'actCode',                 // [필수] 컬럼 매핑 이름 값
	                hidden : true                // [선택] 숨김 여부
	              },
	 	 	      
	 	 	      {
	 	 	        header: '발주일자',
	 	 	        name: 'matOdRq',
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
			 	  },
			 	  {
			 		  header: '발주상세코드',
			 		  name: 'matOdDeCd',
			 		  hidden: true
			 	  },
			 	  {
	                    header: '담당자코드',            // [필수] 컬럼 이름
	                    name: 'empCode',
	                    hidden :true
	              },
	              {
	            	  header: '검수여부',
	            	  name: 'matTestYn',
	            	  formatter: function (e) {
	      					if(e.value == 'Y'){
	      						return "검수완료";
	      					} else if(e.value == 'N'){
	      						return "검수전";
	      					}
	                  }   
	      		      
	              },
	 	 	      {
	                    header: '담당자명',            // [필수] 컬럼 이름
	                    name: 'empName'             // [필수] 컬럼 매핑 이름 값                   // [선택] 숨김 여부
	              },
	        ]
	      });
	
	setDisabled();
   
	
	

	orderGrid.on('afterChange', (ev) => {
		
		let change = ev.changes[0];
		let rowData = orderGrid.getRow(change.rowKey);
		let totalPrice = rowData.matPrice * rowData.matAmt;
		
		if(change.columnName == 'matAmt' || change.columnName == 'matPrice'){
			if(rowData.matAmt != null && rowData.matPrice != null){
				orderGrid.setValue(change.rowKey, 'matTotalPrice', totalPrice);
			}
		}
		});
	
	
	
	
	function saveServer() {	
		orderGrid.blur();
		let modifyGridInfo = orderGrid.getModifiedRows();
		
		// 수정된게 없으면 바로 빠져나감
		
		if(!orderGrid.isModified()){
			swal("", "변경사항이 없습니다", "warning");
			return false;
		}
		
		//flag가 true = 입력폼이나 수정폼에 빠뜨린 데이터가 없다
		var flag = true;
		//create, modify, delete 포함하는 전체 배열을 도는 each문			
			
		if(orderGrid.getModifiedRows().createdRows.length > 0 ){
				
				$.each(orderGrid.getModifiedRows().createdRows, function(idx2, obj2){
					if(obj2['actCode'] == "" ||obj2['matAmt']  =="" || obj2['matCode'] == "" || obj2['matOdAcp'] == "" || obj2['matPrice']=="" || obj2['matOdRq'] == ""){
						flag = false;
						return false;
					}
				})
		}
		
		if(orderGrid.getModifiedRows().updatedRows.length > 0 ){
			$.each(orderGrid.getModifiedRows().updatedRows, function(idx2, obj2){
					if(obj2['matOdDeCd'] == "" ||obj2['actCode'] == "" ||obj2['matAmt'] == "" || obj2['matCode'] == "" || obj2['matOdAcp']== "" || obj2['matPrice'] == ""){
						flag = false;
						return false;
					}
				
			})
		}
				
		
		
		if(flag){
				$.ajax({
					url : 'matOrderDirSave',
					method : 'POST',
					data : JSON.stringify(orderGrid.getModifiedRows()),
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
	
	//검색
	function selectAjax(){
		let mat = $('#matCodeInput').val();
		let act = $('#actCodeInput').val();
		let sd = $('#startDate').val();
		let ed = $('#endDate').val();
		let comple = '1';
		let before = '1';
		   let beforeCheck = document.getElementById('before');
		   let compleCheck = document.getElementById('comple');
		   if(beforeCheck.checked && !compleCheck.checked){
			   comple = '2';
		   } else if(!beforeCheck.checked && compleCheck.checked){
			   before = '2';
		   }
			  
		   let search = { materialCode : mat , accountCode : act , startDate : sd , endDate : ed, before : before, comple : comple};
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
				setDisabled();
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
		       $('.modal_title h3').text('거래처 목록');
		       Grid.on('dblclick', event2 => {
		        	let rowKey = Grid.getFocusedCell().rowKey;
		        	if(rowKey != null){
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
		       $('.modal_title h3').text('자재 목록');
		       Grid.on('dblclick', () => {
		       	let rowKey = Grid.getFocusedCell().rowKey;
		       	if(rowKey != null){
		       		let matCode = Grid.getValue(rowKey, 'matCode');
			    	let matName = Grid.getValue(rowKey, 'matName');
					$("#matNameFix").val(matName);
			       
			   		$("#matCodeInput").val(matCode);
		       	}
		       	
		   		//모달창 닫기
		   		if(rowKey != null){
					$(".modal").fadeOut();
		    		Grid.destroy();

		   		}
		     })
		     });
	
		
		orderGrid.on('dblclick', ev => {
    	let rowKey = orderGrid.getFocusedCell().rowKey;
    	let columnName = orderGrid.getFocusedCell().columnName;
    	let value = orderGrid.getFocusedCell().value;
    	
    	
 	   	let matOdCd = orderGrid.getValue(rowKey, 'matOdCd');
 	   	let matTestYn = orderGrid.getValue(rowKey, 'matTestYn');
 	   	if(matOdCd != null){
 		   if(matTestYn == 'Y'){
 			   ev.stop();
 			   return false;
 		   }
 	   	}
    	
    	if(columnName == 'matName'){
    		$(".modal").fadeIn();
 	       Grid = createMatGrid();
 	      $('.modal_title h3').text('자재 목록');
 	       Grid.on('dblclick', () => {
 	       		let rowKey2 = Grid.getFocusedCell().rowKey;
 	       		if(rowKey2 != null){
	 	       		let matCode = Grid.getValue(rowKey2, 'matCode');
	 	        	let matName = Grid.getValue(rowKey2, 'matName');
	 	        	let matUnit = Grid.getValue(rowKey2, 'matUnit');
	 	        	let matStd = Grid.getValue(rowKey2, 'matStd');
	 	        	orderGrid.finishEditing(rowKey, columnName);
	
	 	    		if(matCode != null){
	 	    			orderGrid.setValue(rowKey, 'matCode', matCode);
	 	    		}
	 	    		if(matName != null){
	 	    			orderGrid.setValue(rowKey, 'matName', matName);
	 	    		}
	 	    		if(matUnit != null){
	 	    			orderGrid.setValue(rowKey, 'matUnit', matUnit);
	 	    		}
	 	    		if(matStd != null){
	 	    			orderGrid.setValue(rowKey, 'matStd', matStd);
	 	    		}
 	       		}
 	        	
 	    		
 	    		
 	    		//선택시 모달창 닫기
 	    		if(rowKey2 != null){
 	    			$(".modal").fadeOut();
 	        		Grid.destroy();
 	    		}

 	       });
    	} 
    	

  	});
		
	//비활성화
	function setDisabled(){
		$.each(orderGrid.getData(), function(idx, obj){
			
			if(obj['matOdCd'] != null && obj['matTestYn'] == 'Y'){
				orderGrid.disableRow(obj['rowKey']);
			}
		})
	}
	
		
	
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
	          		matUnit : "${m.matUnit}",
	          		matStd :"${m.matStd}"
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
		           header: '단위',
		           name: 'matUnit'
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