<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자재 입고 관리</title>

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
/*grid 날짜 컬럼색*/
.yellow-background {
        background-color: rgb(255,253,235);
}
</style>    
       
</head>
<body>
   <h1>자재 입고 관리</h1>
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
		        	<h2>검수 완료된 발주 목록</h2>
		        	<br>
		            <div id="grid2"></div>
		            <h2>입고 목록</h2>
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
	
	//자재 입고 목록
	var inGrid = new tui.Grid({
	        el: document.getElementById('grid'),
	        data : [
	        	<c:forEach items="${inList}" var="mat">
	           	{
	           	matLot : "${mat.matLot}",
	           	matCode : "${mat.matCode}",
	           	matName : "${mat.matName}",
	           	matUnit : "${mat.matUnit}",
	           	matStd : "${mat.matStd}",
	           	actName :"${mat.actName}",
	           	actCode :"${mat.actCode}",
	           	matInAmt : "${mat.matInAmt}",
	           	matTestCode :"${mat.matTestCode}",
	           	matInd : `<fmt:formatDate value="${mat.matInd}" pattern="yyyy-MM-dd"/>`,
	           	empCode : "${mat.empCode}",
	           	empName :"${mat.empName}",
	           	matExd : `<fmt:formatDate value="${mat.matExd}" pattern="yyyy-MM-dd"/>`
	           	},
	           </c:forEach>
	        ],
	        scrollX: false,
	        scrollY: false,
	        minBodyHeight: 30,
	        rowHeaders: [{type: 'rowNum'},{type: 'checkbox'}],
	        pagination: true,
			pageOptions: {
				useClient: true,
		        perPage: 10
		      },
	        columns: [
	        	 {
	 	 	        header: '자재 LOT',
	 	 	        name: 'matLot'
	 	 	      },
	 	 	      {
	 	 	        header: '자재코드',
	 	 	        name: 'matCode'
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
	 	          },
	 	 	      {
	 	 	        header: '업체명',
	 	 	        name: 'actName'
	 	 	      },
	 	 	      {
                      header: '업체코드',            // [필수] 컬럼 이름
                      name: 'actCode',                 // [필수] 컬럼 매핑 이름 값
                      hidden: true,                   // [선택] 숨김 여부
                  },
	 	 	      {
	 	 	        header: '입고량',
	 	 	        name: 'matInAmt'
	 	 	      },
	 	 	      {
		 	 	    header: '자재검수코드',
		 	 	    name: 'matTestCode'
		 	 	  },
	 	 	      {
	 		 	    header: '담당자',
	 		 	    name: 'empName'
	 		 	  },
	 		 	  {
                      header: '담당자코드',            // [필수] 컬럼 이름
                      name: 'empCode',                 // [필수] 컬럼 매핑 이름 값
                      hidden: true,                   // [선택] 숨김 여부
                  },
	 		 	  {
	 		 	    header: '입고일자',
	 		 	    name: 'matInd',
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
	 			 	name: 'matExd',
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
		           	matTestCode : "${test.matTestCode}",
		           	matOdDeCd : "${test.matOdDeCd}",
		           	matInputAmt : "${test.matInputAmt}",
		           	matCode : "${test.matCode}",
		           	matName : "${test.matName}",
		           	matUnit : "${test.matUnit}",
		           	matStd : "${test.matStd}",
		           	matYamt : "${test.matYamt}",
		           	matNamt : "${test.matNamt}",
		           	actName : "${test.actName}",
		           	actCode : "${test.actCode}",
		           	errCode : "${test.errCode}",
		           	errInfo : "${test.errInfo}",
		           	matTestDate : `<fmt:formatDate value="${test.matTestDate}" pattern="yyyy-MM-dd"/>`
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
		    		  header: '자재검수코드',
			 	      name: 'matTestCode',
			 	      hidden : true
		    	  },
		    	  {
		    		  header: '자재발주상세코드',
			 	      name: 'matOdDeCd'
		    	  },
		 	      {
		 	        header: '발주량',
		 	        name: 'matInputAmt'
		 	      },
		 	      {
			 	        header: '자재코드',
			 	        name: 'matCode',
			 			hidden : true
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
	              },
			 	  {
			 	        header: '업체코드',
			 	        name: 'actCode',
			 	        hidden : true
			 	  },
			 	  {
			 	        header: '업체명',
			 	        name: 'actName'
			 	  },
		 	      {
		 	        header: '합격량',
		 	        name: 'matYamt'
		 	      },
		 	      {
		 	        header: '불합격량',
		 	        name: 'matNamt'
		 	      },
		 	      {
		 	    	  header : '불량코드',
		 	    	  name : 'errCode',
		 	    	  hidden : true
		 	      },
		 	      {
		 	        header: '불량내용',
		 	        name : 'errInfo'
		 	      },
		 	      {
			 	    header: '검수일자',
			 	    name: 'matTestDate',
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
			alert("변경사항이 없습니다.");
			return false;
		}
		
		//flag가 true = 입력폼이나 수정폼에 빠뜨린 데이터가 없다
		var flag = true;
		//create, modify, delete 포함하는 전체 배열을 도는 each문			
			
		if(inGrid.getModifiedRows().createdRows.length > 0 ){
				
				$.each(inGrid.getModifiedRows().createdRows, function(idx2, obj2){
					if(obj2['matCode'] == "" ||obj2['matInAmt'] =="" || obj2['matExd'] == "" || obj2['matInd'] == "" || obj2['matTestCode']=="" || obj2['actCode'] == ""){
						flag = false;
						return false;
					}
				})
		}
		
		if(inGrid.getModifiedRows().updatedRows.length > 0 ){

				$.each(inGrid.getModifiedRows().updatedRows, function(idx2, obj2){
					if(obj2['matLot'] == "" ||obj2['matInd'] == "" ||obj2['matExd'] == ""){
						flag = false;
						return false;
					}
				})
				
		}
		
		if(flag){
				$.ajax({
					url : 'matInDirSave',
					method : 'POST',
					data : JSON.stringify(inGrid.getModifiedRows()),
					contentType : 'application/json',
					success : function(data){
						swal("성공", data +"건이 처리되었습니다.", "success");
					},
					error : function(reject){
						console.log(reject);
						swal("실패", "", "error");
					}
				})
		} else {
			alert("값이 입력되지 않았습니다.");
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
			url : 'getMatInFilter',
			method : 'GET',
			data : search,
			success : function(data2){
				
				$.each(data2, function(idx, obj){
					
					let date = new Date(obj['matInd']);
					let year = date.getFullYear();    //0000년 가져오기
					let month = date.getMonth() + 1;  //월은 0부터 시작하니 +1하기
					let day = date.getDate();        //일자 가져오기
					obj['matInd'] = year + "-" + (("00"+month.toString()).slice(-2)) + "-" + (("00"+day.toString()).slice(-2));
					
					date = new Date(obj['matExd']);
					year = date.getFullYear();    //0000년 가져오기
					month = date.getMonth() + 1;  //월은 0부터 시작하니 +1하기
					day = date.getDate();        //일자 가져오기
					obj['matExd'] = year + "-" + (("00"+month.toString()).slice(-2)) + "-" + (("00"+day.toString()).slice(-2));
					
					
				})
				inGrid.resetData(data2);
			}
		})
	}
	
	//insert 후에는 1번 그리드도 내용이 업데이트 되어야 함
	function resetTestList(){
		$.ajax({
			url : 'getMatTestInFilter',
			method : 'GET',
			data : search,
			success : function(data2){
				
				$.each(data2, function(idx, obj){
					
					let date = new Date(obj['matTestDate']);
					let year = date.getFullYear();    //0000년 가져오기
					let month = date.getMonth() + 1;  //월은 0부터 시작하니 +1하기
					let day = date.getDate();        //일자 가져오기
					obj['matTestDate'] = year + "-" + (("00"+month.toString()).slice(-2)) + "-" + (("00"+day.toString()).slice(-2));
	
				})
				testGrid.resetData(data2);
			}
		})
	}
	
	//거래처 검색 모달창
	var Grid;
	$("#actModal").on('click', event =>{
			
		$(".modal").fadeIn();
		Grid = createActGrid();
		
		$('.modal_title h3').text('거래처 목록');
		
		Grid.on('dblclick', event2 => {
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
		    //선택시 모달창 닫기
		    if(rowKey != null){
		    	$(".modal").fadeOut();
		        Grid.destroy();
		    }

		});
	});
	
	//거래처 모달창 내용 그리드
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
	
	//자재 검색 모달창
	$("#matModal").click(function(){
		$(".modal").fadeIn();
		Grid = createMatGrid();
		$('.modal_title h3').text('자재 목록');
		Grid.on('dblclick', () => {
			let rowKey = Grid.getFocusedCell().rowKey;
		    let matCode = Grid.getValue(rowKey, 'matCode');
		    let matName = Grid.getValue(rowKey, 'matName');
			$("#matCodeInput").val(matCode);
			$("#matNameFix").val(matName);
		       
		   	$("#matCodeInput").val(matCode);
		   	//선택시 모달창 닫기
		   	if(rowKey != null){
				$(".modal").fadeOut();
		    	Grid.destroy();
		   	}
		});
	});
	
	//자재 모달창 내용 그리드
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
	
	//모달창 닫기버튼
	$(".close_btn").click(function(){
    	$(".modal").fadeOut();
         
  		Grid.destroy();
  	});
	
	//검색버튼
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
    	
    	let matCode = testGrid.getValue(rowKey, 'matCode');
    	let matName = testGrid.getValue(rowKey, 'matName');
    	let matYamt = testGrid.getValue(rowKey, 'matYamt');
    	let actName = testGrid.getValue(rowKey, 'actName');
    	let actCode = testGrid.getValue(rowKey, 'actCode');
    	let matUnit = testGrid.getValue(rowKey, 'matUnit');
     	let matStd = testGrid.getValue(rowKey, 'matStd');
    	let matTestCode = testGrid.getValue(rowKey, 'matTestCode');
		
    	
    	
    	testGrid.removeRow(rowKey);
    	
    	testGrid.blur();
    	inGrid.appendRow({'matTestCode' : matTestCode,
    					   'matCode' : matCode,
    					   'matName' : matName,
    					   'actName' : actName,
    					   'actCode' : actCode,
    					   'matInAmt' : matYamt,
    					   'matUnit' : matUnit,
    					   'matStd' : matStd},
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