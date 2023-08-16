<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<title>자재 입고 목록</title>
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
   <h1>자재 입고 조회</h1>
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

   
   //모달 시작
  
	 var Grid;
     $("#actModal").click(function(){
       $(".modal").fadeIn();
       Grid = createActGrid();
       
       Grid.on('click', () => {
        	let rowKey = Grid.getFocusedCell().rowKey;
        	let actCode = Grid.getValue(rowKey, 'actCode');
        	let actName = Grid.getValue(rowKey, 'actName');
    		$("#actCodeInput").val(actCode);
    		$("#actNameFix").val(actName);
    		//모달창 닫기
    		console.log(rowKey);
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
     
     $(".close_btn").click(function(){
       $(".modal").fadeOut();
       
		Grid.destroy();
     });
     
     
     
  
   //모달 끝
   
   //엑셀 다운로드
   const excelDownload = document.querySelector('.excelDownload');
   
   document.addEventListener('DOMContentLoaded', ()=>{
      excelDownload.addEventListener('click', function(e){
         grid.export('xlsx');
      })
   })
   
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
   
   

	
   //전체조회 그리드
   var grid = new tui.Grid({
	       el: document.getElementById('grid'),
	       data: [
	           <c:forEach items="${inList}" var="mat">
	           	{
	           	matLot : "${mat.matLot}",
	           	matCode :"${mat.matCode}",
	           	matName :"${mat.matName}",
	           	actName :"${mat.actName}",
	           	matInAmt : "${mat.matInAmt}",
	           	empName : "${mat.empName}",
	           	matInd : `<fmt:formatDate value="${mat.matInd}" pattern="yyyy년 MM월 dd일"/>`,
	           	matExd : `<fmt:formatDate value="${mat.matExd}" pattern="yyyy년 MM월 dd일"/>`
	           	},
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
	 	        header: '자재 LOT',
	 	        name: 'matLot',
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
	 	        header: '업체명',
	 	        name: 'actName'
	 	      },
	 	      {
	 	        header: '입고량',
	 	        name: 'matInAmt'
	 	      },
	 	      {
		 	    header: '담당자',
		 	    name: 'empName'
		 	  },
		 	  {
		 	    header: '입고일자',
		 	    name: 'matInd',
 	  		 	className: 'yellow-background'
		 	  },
		 	  {
			 	header: '유통기한',
			 	name: 'matExd',
 	  		 	className: 'yellow-background'
			  }
	 	    ]
	      
	     });
   
 
   $('#searchBtn').on('click', searchMatIn);
   function searchMatIn(e){
	   let mat = $('#matCodeInput').val();
	   let act = $('#actCodeInput').val();
	   let sd = $('#startDate').val();
	   let ed = $('#endDate').val();	   
		  
	   let search = { materialCode : mat , accountCode : act , startDate : sd , endDate : ed };
	   $.ajax({
		   url : 'getMatInFilter',
		   method : 'GET',
		   data : search ,
		   success : function(data){
			   
			  for(let i of data){
					let date = new Date(i.matInd);
					let year = date.getFullYear();    //0000년 가져오기
					let month = date.getMonth() + 1;  //월은 0부터 시작하니 +1하기
					let day = date.getDate();        //일자 가져오기
			   		i.matInd = year + "년 " + (("00"+month.toString()).slice(-2)) + "월 " + (("00"+day.toString()).slice(-2)) + "일";
					
					date = new Date(i.matExd);
					year = date.getFullYear();    //0000년 가져오기
					month = date.getMonth() + 1;  //월은 0부터 시작하니 +1하기
					day = date.getDate();        //일자 가져오기
			   		i.matExd = year + "년 " + (("00"+month.toString()).slice(-2)) + "월 " + (("00"+day.toString()).slice(-2)) + "일";
			  }
			   grid.resetData(data);
		   },
		   error : function(reject){
			   console.log(reject);
		   }
	   });
   }
   
   //초기화 버튼
   $('#searchResetBtn').on('click', resetInput);
   function resetInput(e){
	   $('input').each(function(idx, obj){
		   obj.value = '';
	   })
   }
 
   

   
   
  
     
   
   
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