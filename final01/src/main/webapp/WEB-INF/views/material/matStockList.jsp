<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자재 재고 조회</title>
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
   <h1>자재 재고 조회</h1>
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
		            <h2>자재 전체 재고</h2>
		            <br>
		            <div id="grid"></div>
		            <h2>자재 LOT별 재고</h2>
		            <br>
		            <div id="grid2"></div>
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
	var Grid;
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
	
	//자재 재고 조회
    var grid = new tui.Grid({
        el: document.getElementById('grid'),
        data: [
        	<c:forEach items="${stockList}" var="stock">
           	{
           	matCode : "${stock.matCode}",
           	matName :"${stock.matName}",
           	matUnit : "${stock.matUnit}",
           	matStd :"${stock.matStd}",
           	totalStock :"${stock.totalStock}",
           	matSafe : "${stock.matSafe}"
           	},
           </c:forEach>
	          ],
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
 	 	        header: '자재코드',
 	 	        name: 'matCode'
 	 	      },
 	 	      {
 	 	        header: '자재명',
 	 	        name: 'matName'
 	 	      },
 	 	      {
 	 	    	header : '단위',
 	 	    	name : 'matUnit'
 	 	      }
 	 	      {
 	 	        header: '규격',
 	 	        name: 'matStd'
 	 	      },
 	 	      {
 	 	        header: '현재고',
 	 	        name: 'totalStock'
 	 	      },
 	 	      {
 		 	    header: '안전재고',
 		 	    name: 'matSafe'
 		 	  }
        ]
      })  

	
	//상세재고 조회
	function createGrid2(){
    	var grid2 = new tui.Grid({
            el: document.getElementById('grid2'),
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
                header: 'LOT 재고',
                name: 'lotStock'
              },
              {
                header: '유통기한',
                name: 'matExd',
	 	  		className: 'yellow-background'
              }
            ]
          });
    	
    	return grid2;
	}
	
	var grid2;
	//생산 계획 클릭시 해당 계획의 상세생산계획 조회
    grid.on('click', () => {
    	
    	
    	//클릭한 계획의 계획코드 가져오기
    	let rowKey = grid.getFocusedCell().rowKey;
    	let matCode = grid.getValue(rowKey, 'matCode');
		if(rowKey >= 0){
			
				if(grid2 != null){
					grid2.destroy();
				}
	    		
		}
			$.ajax({
				url : 'matLotStockList',
				method : 'GET',
				data : { materialCode : matCode },
				success : function(data){

					for(let i of data){
						let date = new Date(i.matExd);
						let year = date.getFullYear();    //0000년 가져오기
						let month = date.getMonth() + 1;  //월은 0부터 시작하니 +1하기
						let day = date.getDate();        //일자 가져오기



						i.matExd = year + "년 " + (("00"+month.toString()).slice(-2)) + "월 " + (("00"+day.toString()).slice(-2)) + "일";
					}
					
					
					grid2 = createGrid2();
	 				grid2.resetData(data);
	 		    },
				error : function(reject){
		 			console.log(reject);
		 		}	
		
    	
		})
  	
    })
	
  //엑셀 다운로드
    const excelDownload = document.querySelector('.excelDownload');
    
    document.addEventListener('DOMContentLoaded', ()=>{
       excelDownload.addEventListener('click', function(e){
          grid.export('xlsx');
       })
    });
    
    $('#searchBtn').on('click', searchMatStock);
    function searchMatStock(e){
 	   let mat = $('#matCodeInput').val();   
 		  
 	   let search = { materialCode : mat };
 	   $.ajax({
 		   url : 'getMatStockFilter',
 		   method : 'GET',
 		   data : search ,
 		   success : function(data){
 
 			   grid.resetData(data);
 			   if(grid2 != null){
					grid2.destroy();
					grid2 = createGrid2();
			   }
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
  
    
	</script>
</body>
</html>