<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
    <title>Home</title>
    <!-- 토스트 페이지 네이션 -->
    <script type="text/javascript" src="https://uicdn.toast.com/tui.code-snippet/latest/tui-code-snippet.js"></script>
    <link rel="stylesheet" href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css" />
    <script src="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.js"></script>
    <!-- 페이지 네이션 끝 -->
    <link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
    <script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@700&family=Noto+Sans+KR&display=swap" rel="stylesheet">
<style>
   body {
      font-family: 'Nanum Gothic', sans-serif;
      font-family: 'Noto Sans KR', sans-serif;
    }
    .search-container {
      display: flex;
      align-items: center;
      background-color: #fff;
      border-radius: 8px;
      padding: 5px 10px;
      margin-bottom: 10px;
    }

    .search-icon {
      margin-right: 10px;
      color: #888;
    }

    .search-input {
      border: none;
      outline: none;
      font-size: 16px;
      width: 100%;
      padding: 5px;
    }
    .col-lg-12 stretch-card{
       margin-top : 30px;
    }
    
    #customtemplateSearchAndButton{
       margin-bottom : 80px;
       float : left;   
    }
    
    #customtemplateSearchAndButton input, #modalTitle input{
       border : 1px solid black; 
       display : inline-block;
    }
    
    #customtemplateSearchAndButton p, #modalTitle p{
       display : inline-block;
       padding-bottom: 10px;
       padding-right : 10px;
    }
    
    #customtemplateSearchAndButton .blackcolorInputBox{
       background-color : #868e96;
    }
    
    .btn-icon-text{
       margin : 5px;
       padding : 7px;
       border-radius : 9px;
       height : 33px;
    }
    
    .excelDownload{
       margin-top : 120px;
       float : right;
    }
    
  
   /*모달시작*/
   #actModal{ 
     cursor:pointer;
   }
   
   .modal{ 
     position:absolute; width:100%; height:100%; background: rgba(0,0,0,0.8); top:0; left:0; display:none;
   }
   
   .modal_content{
     /*모달창 크기 조절*/
     width:600px; height:600px;
     background:#fff; border-radius:10px;
     /*모달창 위치 조절*/
     position:relative; top:33%; left:45%;
     margin-top:-100px; margin-left:-200px;
     text-align:center;
     box-sizing:border-box;
     line-height:23px; cursor:pointer;
   }
   
   .m_head{
        height: 10%;
        margin : 0;
        /*제목 높낮이 조절*/
        padding: 17px;
        display: flex;
        justify-content: space-between;
        background-color:rgb(232, 143, 33);
        border-top-left-radius: 10px;
        border-top-right-radius: 10px;
      }
      
      .close_btn{
        font-size: 20px;
        color: black;
        font-weight: 900;
        cursor: pointer;
      }
      
      .modal_btn{
        width: 80px;
        height: 30px;
        border-radius: 5px;
        text-align: center;
        font-size: 14px;
        font-weight: bolder;
        padding-top: 5px;
        margin-left: 5px;
        font-family: sans-serif;
      }
      .m_head{
        height: 10%;
        padding: 20px;
        display: flex;
        justify-content: space-between;
        border-top-left-radius: 10px;
        border-top-right-radius: 10px;
        font-family: sans-serif;
      }
      
      .m_body{
        height: 80%;
        padding: 20px;
      }
      
      .m_footer{
        height: 10%;
        padding: 15px;
        border-bottom-left-radius: 10px;
        border-bottom-right-radius: 10px;
        display: flex;
        justify-content: end;
      }
      .cancle{
        background-color: black;
        color: white;
      }
      .save{
        background-color: black;
        color: white;
      }
   /*모달끝*/
   
   /*날짜 input 크기*/
   input[type="date"]{
      width : 221px;
   }

</style>
</head>
<body>
   <div class="black_bg"></div>
   <h1>발주 목록 조회</h1>
   <div class="col-lg-12 stretch-card">
       <div class="card">
           <div class="card-body">
               <div class="table-responsive pt-3">
                   <button type="button" class="btn btn-info btn-icon-text excelDownload">
                       Excel
                      <i class="bi bi-printer"></i>                                                                              
                   </button>
                  <div id="customtemplateSearchAndButton">
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
                  <button type="button" class="btn btn-info btn-icon-text" id="searchBtn">
                     <i class="fas fa-search"></i>
                     검색
                  </button>
                  <button type="button" class="btn btn-info btn-icon-text" id="searchResetBtn">
                     초기화
                  </button>
               </div>
               <div id="grid"></div>
                </div>
         </div>
      </div>
   </div> 
   

<div class="modal">
   
  <div class="modal_content" 
       title="클릭하면 창이 닫힙니다.">
          <div class="m_head">
            <div class="modal_title"><h3>거래처 목록</h3></div>
            <div class="close_btn" id="close_btn">X</div>
       </div>
       <div class="m_body">
            <div id="modal_label"></div>
       </div>
       <div class="m_footer">
            <div class="modal_btn cancle" id="close_btn">CANCLE</div>
            <div class="modal_btn save" id="save_btn">SAVE</div>
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
     
     $("#close_btn").click(function(){
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
   //모달 끝
   
   //검색
    $('#searchBtn').on('click', searchMatIn);
   function searchMatIn(e){
	   let mat = $('#matCodeInput').val();
	   let act = $('#actCodeInput').val();
	   let sd = $('#startDate').val();
	   let ed = $('#endDate').val();	   
		  
	   let search = { materialCode : mat , accountCode : act , startDate : sd , endDate : ed };
	   $.ajax({
		   url : 'getMatOrderFilter',
		   method : 'GET',
		   data : search ,
		   success : function(data){
			   
			  for(let i of data){
					let date = new Date(i.matOdAcp);
					let year = date.getFullYear();    //0000년 가져오기
					let month = date.getMonth() + 1;  //월은 0부터 시작하니 +1하기
					let day = date.getDate();        //일자 가져오기
			   		i.matOdAcp = year + "년 " + (("00"+month.toString()).slice(-2)) + "월 " + (("00"+day.toString()).slice(-2)) + "일";
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
	           <c:forEach items="${matOrderList}" var="mat">
	           	{
	           	matOdCd : "${mat.matOdCd}"
	           	matName :"${mat.matName}",
	           	matPrice :"${mat.matPrice}",
	           	matAmt :"${mat.matAmt}",
	           	matTotalPrice : "${mat.matPrice * mat.matAmt}",
	           	actName :"${mat.actName}",
	           	empName : "${mat.empName}",
	           	matOdAcp :`<fmt:formatDate value="${mat.matOdAcp}}" pattern="yyyy년 MM월 dd일"/>`
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
	 	        header: '발주코드',
	 	        name: 'matOdCd',
	 	        filter: 'select'
	 	      },
	 	      {
	 	        header: '자재명',
	 	        name: 'matName'
	 	      },
	 	      {
	 	        header: '단가(원)',
	 	        name: 'matPrice'
	 	      },
	 	      {
	 	        header: '발주량',
	 	        name: 'matAmt'
	 	      },
	 	      {
	 	        header: '총액',
	 	        name: 'matTotalPrice'
	 	      },
	 	      {
		 	    header: '업체명',
		 	    name: 'actName'
		 	  },
		 	  {
		 	    header: '담당자',
		 	    name: 'empName'
		 	  },
		 	  {
			 	header: '납기요청일',
			 	name: 'matOdAcp'
			  }
	 	    ]
	      
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