<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>출고 관리</title>

<!-- 토스트 페이지 네이션 -->
<script type="text/javascript" src="https://uicdn.toast.com/tui.code-snippet/latest/tui-code-snippet.js"></script>
<link rel="stylesheet" href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css" />
<script src="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.js"></script>
<!-- 페이지 네이션 끝 -->
<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>

<script src="https://uicdn.toast.com/tui.time-picker/latest/tui-time-picker.js"></script>
<script src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
<script src="https://uicdn.toast.com/calendar/latest/toastui-calendar.min.js"></script>
<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
<script src="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.js"></script>

<link rel="stylesheet" href="https://uicdn.toast.com/tui.time-picker/latest/tui-time-picker.css" />
<link rel="stylesheet" href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />
<link rel="stylesheet" href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css" />
<link rel="stylesheet" href="https://uicdn.toast.com/calendar/latest/toastui-calendar.min.css" />
<link rel="stylesheet" href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css"/>

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
#actModal, #prodModal, #delete{ 
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
	  line-height:23px;
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
.yellow-background {
        background-color: rgb(255,253,235);
}
</style>    
       
</head>
<body>
<div class="black_bg"></div>
	<h2>출고 관리</h2>
	<div class="col-lg-12 stretch-card">
		<div class="card">
			<div class="card-body">
				<div class="table-responsive pt-3">
					<button type="button" class="btn btn-info btn-icon-text excelDownload">
		                Excel <i class="bi bi-printer"></i>                                                                              
					</button>
					
						<div id="customtemplateSearchAndButton">		
							<p>제품</p>
                  <input type="text" placeholder="검색어를 입력하세요" id="prodCodeInput">
                  <i class="bi bi-search" id="prodModal"></i> <!-- 돋보기 아이콘 -->
                  <input type="text" class="blackcolorInputBox" id="prodNameFix" readonly>
                   <br>
                  <p>거래처</p>
                  <input type="text" placeholder="검색어를 입력하세요" id="actCodeInput">
                    <i class="bi bi-search" id="actModal"></i>
                  <input type="text" class="blackcolorInputBox" id="actNameFix" readonly>
                  <br>
                  <p>주문일자</p>
                  <input id="startDate" type="date">&nbsp;&nbsp;-&nbsp;&nbsp;<input id="endDate" type="date">
                  <button type="button" class="btn btn-info btn-icon-text" id="searchBtn">
                     <i class="fas fa-search"></i>
                     검색
                  </button>
                  <button type="button" class="btn btn-info btn-icon-text" id="searchResetBtn">
                     초기화
                  </button>
		            	</div>
	            
	            	<button class="btn btn-info btn-icon-text" id="save">저장</button>
	            	<button class="btn btn-info btn-icon-text" id="delete">삭제</button>
	            	<button class="btn btn-info btn-icon-text" id="dirAdd">행추가</button>
	           		<div id="grid"></div>
				</div>
	   		</div>
		</div>
	</div>
	<div class="modal">
   
  <div class="modal_content" 
       title="클릭하면 창이 닫힙니다.">
          <div class="m_head">
            <div class="modal_title"><h3>목록</h3></div>
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
	document.getElementById('save').addEventListener('click', saveServer);
	document.getElementById('dirAdd').addEventListener('click', addDirRow);
	//삭제버튼
	$('#delete').on("click",function(){
	//그리드에서 행 지움
	outGrid.removeCheckedRows(false);
	//마우스 커서 없앰
	outGrid.blur();
	});
	
	//행추가 버튼 클릭시 주문등록 행 추가
	function addDirRow(){
		let now = new Date();	// 현재 날짜 및 시간
		let year = now.getFullYear();
		let month = ('0' + (now.getMonth() + 1)).substr(-2);
		let day = ('0' + now.getDate()).substr(-2);
		let salesOutDate = year + "-" + month + "-" + day;
		outGrid.appendRow({'salesOutDate' : salesOutDate, 'empCode' : `${user.id}`, 'empName' : `${user.empName}`}, { at: 0 });
	}

	
	//출고 form
	var outGrid = new tui.Grid({
	        el: document.getElementById('grid'),
	        data: [
	        	<c:forEach items="${outNList}" var="out">
	              {
		           		salesOutCode : "${out.salesOutCode}",
		           		prodLot : "${out.prodLot}",
			           	salesOrdDeCode : "${out.salesOrdDeCode}",
			           	actName : "${out.actName}",
			           	salesOutAmt : "${out.salesOutAmt}",
			           	salesOutDate : `<fmt:formatDate value="${out.salesOutDate}" pattern="yyyy-MM-dd"/>`,
			           	empCode : "${out.empCode}",
			           	empName : "${out.empName}",
			           	prodSaveAmt : "${out.prodSaveAmt}"
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
	        	// header : [필수] 컬럼 이름
                // name : [필수] 컬럼 매핑 이름 값
                // hidden : [선택] 숨김 여부
	       		{
		           header: '출고코드',
		           name: 'salesOutCode',
		         },
		         {
		           header: '제품Lot',
		           name: 'prodLot',
		           editor : 'text',
		           value : '${out.prodLot}'
		         },
		         {
		           header: '상세주문코드',
		           name: 'salesOrdDeCode',
		           editor: 'text',
		           value : '${out.salesOrdDeCode}'
		         },
		         {
		           header: '거래처명',
		           name: 'actName',
		           value : '${out.actName}'
		         },
		         {
		           header: '재고량',
		           name: 'prodSaveAmt',
		           editor : 'text'
		         },
		         {
		           header: '출고량',
		           name: 'salesOutAmt',
		           editor : 'text'
		         },
		         {
		           header: '출고날짜',
		           name: 'salesOutDate',
		           editor: {
		    		      type: 'datePicker',
		    		      options: {
		    		    	  language: 'ko'
		    		      }
		    		    },
		    		    className: 'yellow-background'
		         },
		         {
		           header: '직원이름',
		           name: 'empName'
		         },
		         {
		           header: '직원코드',
		           name: 'empCode',
		           editor: 'text',
		           hidden : true
		         },
	         	{
		           header: '출고여부',
		           name: 'actCode',
		           hidden : true
		         },
	         	{
		           header: '출고여부',
		           name: 'prodCode',
		           hidden : true
		         }
	        ]
	      });
		
	 //거래처 리스트 모달 시작
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
     
     //제품 리스트 모달 시작
     $("#prodModal").click(function(){
       $(".modal").fadeIn();
       Grid = createProdGrid();
       Grid.on('click', () => {
        let rowKey = Grid.getFocusedCell().rowKey;
        let prodCode = Grid.getValue(rowKey, 'prodCode');
       	let prodName = Grid.getValue(rowKey, 'prodName');
      $("#prodCodeInput").val(prodCode);
      $("#prodNameFix").val(prodName);
       
         $("#prodCodeInput").val(prodCode);
         //모달창 닫기
         if(rowKey != null){
         $(".modal").fadeOut();
          Grid.destroy();
         }
         });
     });
     
	
	//거래처명, 자재명, 담당자명 클릭하면 모달창 나온 후 선택할 수 있음. 선택 시 hidden cell에 데이터 넘어감
		var Grid;
		outGrid.on('click', () => {
    	let rowKey = outGrid.getFocusedCell().rowKey;
    	let columnName = outGrid.getFocusedCell().columnName;
    	if(columnName == "prodLot"){
    		$(".modal").fadeIn();
    	       Grid = createLotGrid();
    	       
    	       Grid.on('click', () => {
    	       		let rowKey2 = Grid.getFocusedCell().rowKey;
    	        	let prodLot = Grid.getValue(rowKey2, 'prodLot');
    	        	let prodCode = Grid.getValue(rowKey2, 'prodCode');
    	        	let prodSaveAmt = Grid.getValue(rowKey2, 'prodSaveAmt');
    	        	console.log(prodLot);
    	        	console.log(prodCode);
    	        	console.log(prodCode);
    	    		//$("#actCodeInput").val(actCode);
    	    		//$("#actNameFix").val(actName);
    	    		outGrid.setValue(rowKey, 'prodLot', prodLot);
    	    		outGrid.setValue(rowKey, 'prodCode', prodCode);
    	    		outGrid.setValue(rowKey, 'prodSaveAmt', prodSaveAmt);
    	    		//선택시 모달창 닫기
    	    		if(rowKey != null){
    	    			$(".modal").fadeOut();
    	        		Grid.destroy();
    	    		}

    	       });
    	} else if(columnName == 'salesOrdDeCode'){
    		$(".modal").fadeIn();
 	       Grid = createODGrid();
 	       
 	       Grid.on('click', () => {
 	       		let rowKey2 = Grid.getFocusedCell().rowKey;
 	        	let salesOrdDeCode = Grid.getValue(rowKey2, 'salesOrdDeCode');
 	        	let actName = Grid.getValue(rowKey2, 'actName');
 	        	let actCode = Grid.getValue(rowKey2, 'actCode');
 	        	let prcsRqAmt = Grid.getValue(rowKey2, 'prcsRqAmt');
 	        	console.log(salesOrdDeCode);
 	        	console.log(actName);
 	        	console.log(actCode);
 	        	console.log(prcsRqAmt);
 	    		//$("#actCodeInput").val(actCode);
 	    		//$("#actNameFix").val(actName);
 	    		outGrid.setValue(rowKey, 'salesOrdDeCode', salesOrdDeCode);
 	    		outGrid.setValue(rowKey, 'actName', actName);
 	    		outGrid.setValue(rowKey, 'actCode', actCode);
 	    		outGrid.setValue(rowKey, 'salesOutAmt', prcsRqAmt);
 	    		//선택시 모달창 닫기
 	    		if(rowKey != null){
 	    			$(".modal").fadeOut();
 	        		Grid.destroy();
 	    		}

 	       });
    	} //else if(columnName == 'empName'){ session에서 받아오기
    		
    	//}
    	

  	});
	
	//prodLot modal
	 function createLotGrid(){
  	   var odGrid = new tui.Grid({
  	       el: document.getElementById('modal_label'),
  	       data: [
  	    	   <c:forEach items="${lotList}" var="lot" varStatus="status">
  	          	{
  	          	prodLot : "${lot.prodLot}",
  	          	prodCode : "${lot.prodCode}",
  	        	salesInDate : `<fmt:formatDate value="${lot.salesInDate}" pattern="yyyy-MM-dd"/>`,
  	      		salesInAmt : "${lot.salesInAmt}",
  	    		prodSaveAmt : "${lot.prodSaveAmt}",
  	  			salesInExd : `<fmt:formatDate value="${lot.salesInExd}" pattern="yyyy-MM-dd"/>`,
  				empCode : "${lot.empCode}",
  				testNum : "${lot.testNum}"
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
  	               header: '제품Lot',
  	               name: 'prodLot',
  	             },
  	             {
  	               header: '제품코드',
  	               name: 'prodCode'
  	             },
  	             {
  	               header: '입고날짜',
  	               name: 'salesInDate',
  	             className: 'yellow-background'
  	             },
  	             {
  	               header: '입고량',
  	               name: 'salesInAmt'
  	             },
  	             {
   	               header: '재고량',
   	               name: 'prodSaveAmt'
   	             },
	             {
 	  	            header: '유통기한',
 	  	            name: 'salesInExd',
 	  	         className: 'yellow-background'
 	  	          },
 	  	          {
  	    	        header: '직원코드',
  	    	        name: 'empCode'
  	    	       },
  	      	       {
  	    	  	    header: '품질검사번호',
  	    	  	    name: 'testNum'
  	    	  	   }
  	 	    ]
  	      
  	     });
  	   
  	   return odGrid;
     }
	
	//salesOrdDeCode modal
	function createODGrid(){
  	   var lotGrid = new tui.Grid({
  	       el: document.getElementById('modal_label'),
  	       data: [
  	    	   <c:forEach items="${orderDeList}" var="order" varStatus="status">
  	    	 {
	           		salesOrdDeCode : "${order.salesOrdDeCode}",
            	 ordDate : `<fmt:formatDate value="${order.ordDate}" pattern="yyyy-MM-dd"/>`,
            	 actCode : "${order.actCode}",
	           	 actName : "${order.actName}",
	           	 ordSts : "${order.ordSts}",
	           	 prodName : "${order.prodName}",
	           	 prcsRqAmt : "${order.prcsRqAmt}",
	           	 devDate : `<fmt:formatDate value="${order.devDate}" pattern="yyyy-MM-dd"/>`,
	           	 devYn : "${order.devYn}",
	           	 empCode : "${order.empCode}"
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
		           header: '주문상세코드',
		           name: 'salesOrdDeCode',
		         },
		         {
		           header: '주문날짜',
		           name: 'ordDate',
		           editor: {
		    		      type: 'datePicker',
		    		      options: {
		    		    	  language: 'ko'
		    		      }
		    		    },
		    		    className: 'yellow-background'
		         },
		         {
		           header: '거래처명',
		           name: 'actName',
		           editor : 'text',
		           value : '${order.actName}'
		         },
		         {
		           header: '거래처코드',
		           name: 'actCode',
		         },
		         {
		           header: '생산계획상태',
		           name: 'ordSts'
		         },
		         {
		           header: '제품명',
		           name: 'prodName',
		           editor : 'text'
		         },
		         {
		           header: '주문량',
		           name: 'prcsRqAmt',
		           editor : 'text'
		         },
		         {
		           header: '납기일자',
		           name: 'devDate',
		           editor: {
		    		      type: 'datePicker',
		    		      options: {
		    		    	  language: 'ko'
		    		      }
		    		    },
		    		    className: 'yellow-background'
		         },
		         {
		           header: '출고여부',
		           name: 'devYn',
		           value : '${order.devYn}'
		         },
		         {
		           header: '주문코드',
		           name: 'ordCode',
		           hidden : true
		         },
		         {
		           header: '직원코드',
		           name: 'empCode',
		           editor : 'text'
		         },
	         	{
		           header: '생산계획코드',
		           name: 'prcsPlanCode',
		           hidden : true
		         },
	         	{
		           header: '제품코드',
		           name: 'prodCode',
		           hidden : true
		         }
  	 	    ]
  	      
  	     });
  	   
  	   return lotGrid;
     }
		
	//모달창 닫기
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
	
     //제품 리스트 모달 그리드
     function createProdGrid(){
        var prodGrid = new tui.Grid({
            el: document.getElementById('modal_label'),
            data: [
               <c:forEach items="${prodList}" var="p" varStatus="status">
                  {
                  	prodCode : "${p.prodCode}",
                     prodName :"${p.prodName}",
                     prodUnit :"${p.prodUnit}",
                     prodStd :"${p.prodStd}"
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
                    header: '제품코드',
                    name: 'prodCode',
                  },
                  {
                    header: '제품명',
                    name: 'prodName'
                  },
                  {
                    header: '제품단위',
                    name: 'prodUnit'
                  },
                  {
                    header: '제품규격',
                    name: 'prodStd'
                  }
             ]
           
          });
        
        return prodGrid;
     }
	
	//검색 버튼
   $('#searchBtn').on('click', searchOrderList);
   function searchOrderList(e){
	  let actInsert = $('#actCodeInput').val();
	  let prodInsert = $('#prodCodeInput').val();
      let sd = $('#startDate').val();
      let ed = $('#endDate').val();      
        
      let search = { actCode : actInsert, prodCode : prodInsert, startDate : sd , endDate : ed };
      $.ajax({
         url : 'outListFilter',
         method : 'GET',
         data : search ,
         success : function(data2){
        	 
				$.each(data2, function(idx, obj){
					let date = new Date(obj['salesOutDate']);
					let year = date.getFullYear();    //0000년 가져오기
					let month = date.getMonth() + 1;  //월은 0부터 시작하니 +1하기
					let day = date.getDate();        //일자 가져오기
					obj['salesOutDate'] = year + "-" + (("00"+month.toString()).slice(-2)) + "-" + (("00"+day.toString()).slice(-2));
					
				})
           outGrid.resetData(data2);
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
   
    
  //저장 함수
	function saveServer() {	
		outGrid.blur();
		let modifyGridInfo = outGrid.getModifiedRows();
		
		// 수정된게 없으면 바로 빠져나감
		
		if(!outGrid.isModified()){
			swal("", "변경사항이 없습니다", "warning");
			return false;
		}
		
		//flag가 true = 입력폼이나 수정폼에 빠뜨린 데이터가 없다
		var flag = true;
		//create, modify, delete 포함하는 전체 배열을 도는 each문			
		
		if(outGrid.getModifiedRows().createdRows.length > 0 ){
				
				$.each(outGrid.getModifiedRows().createdRows, function(idx2, obj2){
					if(obj2['prodCode'] == "" || obj2['actCode'] == "" || obj2['salesOutDate'] == "" || obj2['salesOutAmt']=="" || obj2['empCode'] == "" || obj2['salesOrdDeCode'] == "" || obj2['prodLot'] == ""){
						
						flag = false;
						return false;
					}
				})
		}
		
// 		if(outGrid.getModifiedRows().updatedRows.length > 0 ){

// 				$.each(outGrid.getModifiedRows().updatedRows, function(idx2, obj2){
// 					if(obj2['prcsRqAmt'] == "" || obj2['prodCode'] == "" || obj2['actCode'] == "" || obj2['ordDate'] == "" || obj2['devDate'] == "" || obj2['empCode'] == "" ){
// 						flag = false;
// 						return false;
// 					}
// 				})
				
// 		}
		
		if(flag){
				$.ajax({
					url : 'outSave',
					method : 'POST',
					data : JSON.stringify(outGrid.getModifiedRows()),
					contentType : 'application/json',
					success : function(data){
						swal("성공", data +"건이 처리되었습니다.", "success");
						console.log(data);
					},
					error : function(reject){
						swal("실패", "", "error");
						console.log(reject);
						
					}
				})
		} else {
			alert("값이 입력되지 않았습니다.");
		}

	}

  //수량체크하는 함수
    function qtyCheck() {
//         let ordersQty = parseInt(document.getElementsByName("ordersQty")[0].value); // 입력수량 150
//         let productQty = parseInt(document.getElementById("productQty")); //재고수량 95
		let modifyGridInfo = outGrid.getModifiedRows();
		$.each(outGrid.getModifiedRows().createdRows, function(idx2, obj2){
			if(obj2['prodCode'] == "" || obj2['actCode'] == "" || obj2['salesOutDate'] == "" || obj2['salesOutAmt']=="" || obj2['empCode'] == "" || obj2['salesOrdDeCode'] == "" || obj2['prodLot'] == ""){
				
			}
		})

        // 반복 코드 줄이기 위해 return false; 를 변수화
        let ret = false;

        console.log("orderQty : " + ordersQty);
        console.log("productQty : " + productQty);

        // 입력 수량이 undefined인지 여부
        if (ordersQty) {
            // 입력수량이 존재함
            // 입력수량 > 재고
            if (ordersQty > productQty) {
                alert("재고 수량을 초과하여 입력할 수 없습니다.");
            }
            // 입력수량 = 0 or 입력수량 < 0
            else if (ordersQty === 0 || ordersQty < 0) {
                alert("1개 이상 입력할 수 있습니다.");
            }
            // 그게 아니라면 true로 반환 !ret 이니까 true임
            else {
                ret = !ret;
            }
        } else {
            // 입력수량이 undefined임
            alert("수량을 입력해 주세요.");
        }
        return ret;
    }
  
    //엑셀 다운로드
    const excelDownload = document.querySelector('.excelDownload');
    
    document.addEventListener('DOMContentLoaded', ()=>{
       excelDownload.addEventListener('click', function(e){
    	   outGrid.export('xlsx');
       })
    })
    </script>
</body>
</html>