<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>생산 지시</title>

<!-- 토스트 페이지 네이션 -->
<script type="text/javascript" src="https://uicdn.toast.com/tui.code-snippet/latest/tui-code-snippet.js"></script>
<link rel="stylesheet" href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css" />
<script src="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.js"></script>
<!-- 페이지 네이션 끝 -->
<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>

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
#find{ 
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
</style>    
       
</head>
<body>
<div class="black_bg"></div>
	<h2>생산 지시</h2>
	<div class="col-lg-12 stretch-card">
		<div class="card">
			<div class="card-body">
				<div class="table-responsive pt-3">
					<button type="button" class="btn btn-info btn-icon-text excelDownload">
		                Excel <i class="bi bi-printer"></i>                                                                              
					</button>
					<form>
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
	            	</form>
	            	<button id="save">저장</button>
	            	<button id="Add">행추가</button>
	           		<div id="ordGrid"></div>
	           		<div id="deGrid"></div>
	           		<div id="matGrid"></div>
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
            <div class="modal_btn save" id="save_btn">SAVE</div>
    </div>
  </div>
</div>

    
	<script>
	
	document.getElementById('save').addEventListener('click', saveServer);
	document.getElementById('Add').addEventListener('click', addRow);

	//페이지 호출시 생산지시 등록하는 행 자동 생성
	window.onload = function addRow(){
		ordGrid.appendRow();
	} 

	//행추가 버튼 클릭시 상세생산지시 행 추가
	function addRow(){
		deGrid.appendRow();
	}
		
	//저장 버튼 클릭시 실행 될 함수 -> insert 실행
	function saveServer() {	
		//생산지시 객체 -> insert
		let rowKey = ordGrid.getFocusedCell().rowKey;
		let columnName = ordGrid.getFocusedCell().columnName;
		
		ordGrid.finishEditing(rowKey, columnName);
	
		let obj = {};

		obj['prcsPlanCode'] = ordGrid.getValue(rowKey, 'prcsPlanCode');
		obj['prcsDirName'] = ordGrid.getValue(rowKey, 'prcsDirName');
		obj['prcsStartDate'] = ordGrid.getValue(rowKey, 'prcsStartDate');
		obj['empCode'] = ordGrid.getValue(rowKey, 'empCode');
		
		$.ajax({
			url : 'prcsDirInsert',
			method : 'POST',
			data : JSON.stringify(obj),
			contentType : 'application/json',
			success : function(data){
				console.log(data);
				ordGrid.clear();
				ordGrid.appendRow();
			},
			error : function(reject){
	 			console.log(reject);
	 		}		
		})
		
		//상세생산지시 객체 -> insert
// 		let objDe = {}
		
// 		$.each()
// 		obj[]
		
// 		list.push(objDe);
		
	};
	
	
	
	//주문서 form
    var ordGrid = new tui.Grid({
        el: document.getElementById('ordGrid'),
        scrollX: false,
        scrollY: false,
        minBodyHeight: 30,
		rowHeaders: ['rowNum'],		
        columns: [
          {
            header: '주문상세코드',
            name: 'salesOrdDeCode'
          },
          {
            header: '주문코드',
            name: 'ordCode'
          },
          {
            header: '제품명',
            name: 'prodName',
            editor: 'text'
          },
          {
            header: '주문량',
            name: 'prcsRqAmt',
            editor: 'text'
          },
          {
			header: '계획상태',
            name: 'ordSts'
          },
          {
            header: '납기일자',
            name: 'devDate',
            editor: 'text'
          }
        ]
	})  
	
  //주문서 관리 - 미계획 주문 목록 띄우는 모달창 호출
    var Grid;
     $("#find").click(function(){
       $(".modal").fadeIn();
       Grid = noPlanOrderGrid();
       
//        Grid.on('click', () => {
//            let rowKey = Grid.getFocusedCell().rowKey;
//            let actCode = Grid.getValue(rowKey, 'actCode');
//            let actName = Grid.getValue(rowKey, 'actName');
//           $("#actCodeInput").val(actCode);
//           $("#actNameFix").val(actName);
//           //모달창 닫기
//           console.log(rowKey);
//           if(rowKey != null){
//              $(".modal").fadeOut();
//               Grid.destroy();
//           }
//           });
         });
	
   //주문서 관리 - 미계획 주문 목록 띄우는 모달창 출력
     function noPlanOrderGrid(){
        var npoGrid = new tui.Grid({
            el: document.getElementById('modal_label'),
            data: [
               <c:forEach items="${noPlanList}" var="no" varStatus="status">
                  {
                	  salesOrdDeCode : "${no.salesOrdDeCode}",
                	  ordCode : "${no.ordCode}",
                	  prodName : "${no.prodName}",
                	  prcsRqAmt : "${no.prcsRqAmt}",
                	  ordSts : "${no.ordSts}",
                	  devDate : "${no.devDate}"
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
                    name: 'salesOrdDeCode'
                  },
                  {
                    header: '주문코드',
                    name: 'ordCode'
                  },
                  {
                    header: '제품명',
                    name: 'prodName',
                    editor: 'text'
                  },
                  {
                    header: '주문량',
                    name: 'prcsRqAmt',
                    editor: 'text'
                  },
                  {
        			header: '계획상태',
                    name: 'ordSts'
                  },
                  {
                    header: '납기일자',
                    name: 'devDate',
                    editor: 'text'
                  }
             ]
           
          });
        
        return npoGrid;
     }
	
    </script>
</body>
</html>