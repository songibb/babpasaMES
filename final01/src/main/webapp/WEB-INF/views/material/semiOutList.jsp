<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
    <title>반제품 출고 조회</title>
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
   <h1>반제품 출고 조회</h1>
   <div class="col-lg-12 stretch-card">
       <div class="card">
           <div class="card-body">
               <div class="table-responsive pt-3">
               		<button type="button" class="btn btn-info btn-icon-text excelDownload">
                      	 Excel
                      	<i class="bi bi-printer"></i>                                                                              
                   	</button>
                  	<div id="customtemplateSearchAndButton">
        				<div style="display: flex; justify-content: space-between;">
            				<div style="flex: 1;">
                				<p>반제품명</p>
				                <input type="text" id="prodCodeInput">
				                <i class="bi bi-search" id="prodModal"></i> <!-- 돋보기 아이콘 -->
				                <input type="text" class="blackcolorInputBox" id="prodNameFix" readonly>
				                <br>
				                <p>출고일자</p>
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
		            <h2>반제품 출고 목록</h2>
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
   
   //엑셀 다운로드
   const excelDownload = document.querySelector('.excelDownload');
   
   document.addEventListener('DOMContentLoaded', ()=>{
      excelDownload.addEventListener('click', function(e){
         grid.export('xlsx');
      })
   })

	
   //전체조회 그리드
   var grid = new tui.Grid({
	       el: document.getElementById('grid'),
	       data: [
	           <c:forEach items="${outList}" var="semi">
	           	{
	           	semiLot : "${semi.semiLot}",
	           	prodCode :"${semi.prodCode}",
	           	prodName :"${semi.prodName}",
	           	semiOutAmt :"${semi.semiOutAmt}",
	           	prcsListCode : "${semi.prcsListCode}",
	           	empName : "${semi.empName}",
	           	semiOutDate : `<fmt:formatDate value="${semi.semiOutDate}" pattern="yyyy-MM-dd"/>`,
	           	semiExd :`<fmt:formatDate value="${semi.semiExd}" pattern="yyyy-MM-dd"/>`
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
	 	        header: '반제품 LOT',
	 	        name: 'semiLot',
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
	 	        header: '출고량',
	 	        name: 'semiOutAmt'
	 	      },
	 	      {
	 	        header: '생산실적코드',
	 	        name: 'prcsListCode'
	 	      },
	 	      {
		 	    header: '담당자',
		 	    name: 'empName'
		 	  },
		 	  {
		 	    header: '출고일자',
		 	    name: 'semiOutDate',
	 	  		className: 'yellow-background'
		 	  },
		 	  {
			 	header: '유통기한',
			 	name: 'semiExd',
	 	  		className: 'yellow-background'
			  }
		 	 
	 	    ]
	      
	     });
   
   $('#searchBtn').on('click', searchSemiOut);
   function searchSemiOut(e){
	   let prod = $('#prodCodeInput').val();
	   let sd = $('#startDate').val();
	   let ed = $('#endDate').val();	   
		  
	   let search = { productCode : prod , startDate : sd , endDate : ed };
	   $.ajax({
		   url : 'getSemiOutFilter',
		   method : 'GET',
		   data : search ,
		   success : function(data){
			   
			  for(let i of data){
					let date = new Date(i.semiOutDate);
					let year = date.getFullYear();    //0000년 가져오기
					let month = date.getMonth() + 1;  //월은 0부터 시작하니 +1하기
					let day = date.getDate();        //일자 가져오기
			   		i.semiOutDate = year + "-" + (("00"+month.toString()).slice(-2)) + "-" + (("00"+day.toString()).slice(-2));
					
					date = new Date(i.semiExd);
					year = date.getFullYear();    //0000년 가져오기
					month = date.getMonth() + 1;  //월은 0부터 시작하니 +1하기
					day = date.getDate();        //일자 가져오기
			   		i.semiExd = year + "-" + (("00"+month.toString()).slice(-2)) + "-" + (("00"+day.toString()).slice(-2));
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