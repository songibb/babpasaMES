<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자재 반품 목록</title>
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
	
	#customtemplateSearchAndButton p{
		width : 100px;
	}
</style>    
       
</head>
<body>
   <h1>자재 반품 목록</h1>
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
                				<br>
                				<p>업체명</p>
                				<input type="text" id="actCodeInput">
                				<i class="bi bi-search" id="actModal"></i>
                				<input type="text" class="blackcolorInputBox" id="actNameFix" readonly>
                				<br>
                				<p>반품요청일자</p>
                				<input id="startDate" type="date">&nbsp;&nbsp;-&nbsp;&nbsp;<input id="endDate" type="date">
                				<br>
                				<p>반품여부</p>
                				<label for="before"><input type="checkbox" id="before" value="R4">반품중</label>
                				<label for="ing"><input type="checkbox" id="ing" value="R5">반품완료</label>
                				<label for="after"><input type="checkbox" id="after" value="R6">반품실패</label>
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
		            <h2>자재 반품 목록</h2>
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

	<script>
   
		//모달 시작
		var Grid;
		$("#actModal").click(function(){
		       $(".modal").fadeIn();
		       preventScroll();
		       Grid = createActGrid();
		       $('.modal_title h3').text('거래처 목록');
		       Grid.on('dblclick', () => {
		        	let rowKey = Grid.getFocusedCell().rowKey;
		        	let actCode = Grid.getValue(rowKey, 'actCode');
		        	let actName = Grid.getValue(rowKey, 'actName');
		    		$("#actCodeInput").val(actCode);
		    		$("#actNameFix").val(actName);
		    		//모달창 닫기
		    		console.log(rowKey);
		    		if(rowKey != null){
		    			$(".modal").fadeOut();
		    			activeScroll();
		    			let inputContent = $('#modalSearch').val('');
		    			if(Grid != null && Grid.el != null){
		 	    			Grid.destroy();	
		 	    		}
		    		}
		
		    	});
		});
  
  
  
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
		  			if(Grid != null && Grid.el != null){
	 	    			Grid.destroy();	
	 	    		}
	
	     		}
	       	 })
	     });
  
		 $(".close_btn").click(function(){
		      	$(".modal").fadeOut();
		      	activeScroll();
		      	let inputContent = $('#modalSearch').val('');
		      	if(Grid != null && Grid.el != null){
 	    			Grid.destroy();	
 	    		}
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
		
		

		//검색
		$('#searchBtn').on('click', searchMatRt);
		function searchMatRt(e){
			   let mat = $('#matCodeInput').val();
			   let act = $('#actCodeInput').val();
			   let sd = $('#startDate').val();
			   let ed = $('#endDate').val();
			   
			   var checkboxList = [];
			   let checkedList = $('input[type="checkbox"]:checked');
			   $.each(checkedList, function(idx, obj){
				   checkboxList.push(obj.value);
			   })
				  
			   let search = { materialCode : mat , accountCode : act , startDate : sd , endDate : ed, checkList : checkboxList };
			   $.ajax({
				   url : 'getMatRtFilter',
				   method : 'GET',
				   data : search ,
				   success : function(data){
					   
					  for(let i of data){
							let date = new Date(i.matTestDate);
							let year = date.getFullYear();    //0000년 가져오기
							let month = date.getMonth() + 1;  //월은 0부터 시작하니 +1하기
							let day = date.getDate();        //일자 가져오기
					   		i.matTestDate = year + "-" + (("00"+month.toString()).slice(-2)) + "-" + (("00"+day.toString()).slice(-2));
							
							date = new Date(i.matRtDate);
							year = date.getFullYear();    //0000년 가져오기
							month = date.getMonth() + 1;  //월은 0부터 시작하니 +1하기
							day = date.getDate();        //일자 가져오기
					   		i.matRtDate = year + "-" + (("00"+month.toString()).slice(-2)) + "-" + (("00"+day.toString()).slice(-2));
					  }
					   grid.resetData(data);
				   },
				   error : function(reject){
					   console.log(reject);
				   }
			   });
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
	         grid.export('xlsx');
	      })
	   })

	
		   //전체조회 그리드
		   var grid = new tui.Grid({
			       el: document.getElementById('grid'),
			       data: [
			           <c:forEach items="${rtList}" var="mat">
			           	{
			           	matOdDeCd : "${mat.matOdDeCd}",
			           	matName :"${mat.matName}",
			           	matUnit : "${mat.matUnit}",
			           	matStd : "${mat.matStd}",
			           	actName :"${mat.actName}",
			           	matTestDate : `<fmt:formatDate value="${mat.matTestDate}" pattern="yyyy-MM-dd"/>`,
			           	errInfo : "${mat.errInfo}",
			           	matRtAmt :"${mat.matRtAmt}",
			           	empName : "${mat.empName}",
			           	matRtDate : `<fmt:formatDate value="${mat.matRtDate}" pattern="yyyy-MM-dd"/>`,
			           	matRtTotalAmt : "${mat.matRtTotalAmt}",
			           	matRtSts : "${mat.matRtSts}"
			           	},
			           </c:forEach>
			          ],
				   scrollX: false,
			       scrollY: false,
			       minBodyHeight: 400,
			       rowHeaders: ['rowNum'],
			       pagination: true,
			       pageOptions: {
			       //백엔드와 연동 없이 페이지 네이션 사용가능하게 만듦
			         useClient: true,
			         perPage: 10
			       },
			       columns: [
			 	      {
			 	        header: '발주상세코드',
			 	        name: 'matOdDeCd',
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
				 	    header: '불량내용',
				 	    name: 'errInfo'
				 	  },
				 	  {
				 	    header: '반품수량',
				 	    name: 'matRtAmt',
			 	       	formatter(e) { 
			 	        	val = e['value'].toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
			 	           	return val;
			 	        }
				 	  },
				 	  {
					 		header: '불량수량',
					 		name : 'matRtTotalAmt'
					 		
					 },
					  {
				 	    header: '검사일자',
				 	    name: 'matTestDate',
			 	  		className: 'yellow-background'
				 	  },
					  {
						header: '반품요청일',
						name: 'matRtDate',
		 	  		 	className: 'yellow-background'
					  },
					  {
						header: '반품상태',
						name: 'matRtSts',
						formatter: function (e) {
							if(e.value == 'R4'){
								return "반품중";
							} else if(e.value == 'R5'){
								return "반품완료";
							} else if(e.value == 'R6'){
								return "반품실패";
							}
		                }   
				      },
				 	  {
					 	header: '담당자',
					 	name: 'empName'
					  }
			 	    ]
			      
		});
		   
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