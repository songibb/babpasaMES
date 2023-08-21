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
	
	.m_body > input{
		border : 1px solid black;
	}
	
	
	.my-styled-cell {background-color: rgb(255, 229, 229)}
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
                  	<div id="customtemplateSearchAndButton">
        				<div style="display: flex; justify-content: space-between;">
            				<div style="flex: 1;">
                				<p>자재명</p>
                				<input type="text" id="matCodeInput">
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
       			<p>이름</p>
                <input type="text" id="modalSearch">
                <button type="button" class="btn btn-info btn-icon-text">검색</button>
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
		       preventScroll();
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
					activeScroll();
					let inputContent = $('#modalSearch').val('');
		    		Grid.destroy();
	
		   		}
		     })
		});
	
		$(".close_btn").click(function(){
		       	$(".modal").fadeOut();
		       	activeScroll();
		       	let inputContent = $('#modalSearch').val('');
				Grid.destroy();
		});
		
		//모달 검색
		$('#modalSearchBtn').on('click', function(e){
			let title = $('.modal_title h3').text();
			let inputContent = $('#modalSearch').val();
			
			if(title == '자재 목록'){
				let modalSearchData = {matName : inputContent}
				$.ajax({
					url : 'getMatModalSearch',
					method : 'GET',
					data : modalSearchData,
					success : function(data){
						
						Grid.resetData(data);
					},
					error : function(reject){
						console.log(reject);
					}
				})
			} else if(title == '거래처 목록'){
				let modalSearchData = {actName : inputContent}
				$.ajax({
					url : 'getActModalSearch',
					method : 'GET',
					data : modalSearchData,
					success : function(data){
						
						Grid.resetData(data);
					},
					error : function(reject){
						console.log(reject);
					}
				})
			}
		})
	
	

	
	
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
	 	 	      },
	 	 	      {
	 	 	        header: '규격',
	 	 	        name: 'matStd'
	 	 	      },
	 	 	      {
	 	 	        header: '현재고',
	 	 	        name: 'totalStock',
		 	       	formatter(e) { 
		 	        	val = e['value'].toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		 	           	return val;
		 	        }
	 	 	      },
	 	 	    
	 	 	      {
	 		 	    header: '안전재고',
	 		 	    name: 'matSafe',
		 	       	formatter(e) { 
		 	        	val = e['value'].toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		 	           	return val;
		 	        }
	 		 	  }
	        ]
	      });
	
		//안전재고량 > 현재고
		grid.on('onGridMounted', function(e){
			let data = grid.getData();
			
			$.each(data, function(idx, obj){
				
				if(Number(obj['totalStock']) < Number(obj['matSafe'])){
					let rowKey = obj['rowKey'];
					grid.addCellClassName(rowKey, 'totalStock', 'my-styled-cell');
				}
			})
		});
    
	
		//상세재고 조회
		var grid2;
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
	                name: 'lotStock',
		 	       	formatter(e) { 
		 	        	val = e['value'].toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		 	           	return val;
		 	        }
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
	
		
		
	    grid.on('dblclick', () => {
	    	
	    	
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
	
	
	
							i.matExd = year + "-" + (("00"+month.toString()).slice(-2)) + "-" + (("00"+day.toString()).slice(-2));
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
	    
		//스크롤 막기
	 	function preventScroll(){
		   $('html, body').css({'overflow': 'hidden', 'height': '100%'}); // 모달팝업 중 html,body의 scroll을 hidden시킴
			   $('#element').on('scroll touchmove mousewheel', function(event) { // 터치무브와 마우스휠 스크롤 방지
				   event.preventDefault();
				   event.stopPropagation();
				
				   return false;
		   });
	 	}

	 	//스크롤 활성화
	  	function activeScroll(){
	      	$('html, body').css({'overflow': 'visible', 'height': '100%'}); //scroll hidden 해제
	  		$('#element').off('scroll touchmove mousewheel'); // 터치무브 및 마우스휠 스크롤 가능
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