<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
	<h2>자재 발주 관리</h2>
	<div class="col-lg-12 stretch-card">
		<div class="card">
			<div class="card-body">
				<div class="table-responsive pt-3">
					<button type="button" class="btn btn-info btn-icon-text excelDownload">
		                Excel <i class="bi bi-printer"></i>                                                                              
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
	            
	            	<button id="save">저장</button>
	            	<button id="dirAdd">행추가</button>
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

	

	//행추가 버튼 클릭시 상세생산지시 행 추가
	function addDirRow(){
		orderGrid.appendRow();
	}
   
   
 

	//발주 form
	var orderGrid = new tui.Grid({
	        el: document.getElementById('grid'),
	        data: [
	        	<c:forEach items="${matOrderList}" var="mat" varStatus="status">
	           	{
	           	matOdCd : "${mat.matOdCd}",
	           	matName :"${mat.matName}",
	           	matPrice :"${mat.matPrice}",
	           	matAmt :"${mat.matAmt}",
	           	matTotalPrice : "${mat.matPrice * mat.matAmt}",
	           	actName :"${mat.actName}",
	           	empName : "${mat.empName}",
	           	matOdAcp :`<fmt:formatDate value="${mat.matOdAcp}" pattern="yyyy년 MM월 dd일"/>`
	           	}<c:if test="${not status.last}">,</c:if>
	           </c:forEach>
		          ],
	        scrollX: false,
	        scrollY: false,
	        minBodyHeight: 30,
			rowHeaders: ['rowNum'],	
			pageOptions: {
				useClient: true,
		        perPage: 10
		      },
	        columns: [
	        	  {
	 	 	        header: '발주코드',
	 	 	        name: 'matOdCd'
	 	 	      },
	 	 	      {
			 			header: '자재명',
			 		 	name: 'matName',
			 	 	    editor : 'text'
			 	  },
			 	  {
	                    header: '자재코드',            // [필수] 컬럼 이름
	                    name: 'matCode',                 // [필수] 컬럼 매핑 이름 값
	                    hidden: true,                   // [선택] 숨김 여부
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
	 	 	        header: '거래처명',
	 	 	        name: 'actName',
		 	 	    editor : 'text'
	 	 	      },
	 	 	      {
	                header: '거래처코드',            // [필수] 컬럼 이름
	                name: 'actCode',                 // [필수] 컬럼 매핑 이름 값
	                hidden: true,                   // [선택] 숨김 여부
	              },
	 	 	      {
                    header: '담당자명',            // [필수] 컬럼 이름
                    name: 'empName'                 // [필수] 컬럼 매핑 이름 값                   // [선택] 숨김 여부
                  },
                  {
                    header: '담당자코드',            // [필수] 컬럼 이름
                    name: 'empCode',                 // [필수] 컬럼 매핑 이름 값
                    hidden: true,                   // [선택] 숨김 여부
                  },
	 	 	      {
	 	 	        header: '발주일자',
	 	 	        name: 'matOdRq',
	 	 	        editor : 'text'
	 	 	      },
	 	 	      {
		 	 	    header: '납기요청일',
		 	 	    name: 'matOdAcp',
		 	 	    editor : 'text'
		 	 	  }
	        ]
	      });
	
	
	
	
	//저장 버튼 클릭시 실행 될 함수 -> insert 실행
	function saveServer() {	
		
		//생산지시 객체 -> insert
		let rowKey = orderGrid.getFocusedCell().rowKey;
		let columnName = orderGrid.getFocusedCell().columnName;
		
		orderGrid.finishEditing(rowKey, columnName);
		let list2 = orderGrid.getData();
		console.log(list2);
		
		let list = [];
		$.each(list2, function(idx, obj){
			if(obj.matOdCd == null){
				list.push(obj);
			}
		})
		console.log(list);
		let customList = [];
		$.each(list, function(idx, obj){
			let customObj = {};
			customObj['empCode'] = "이슬";	//고치기
			customObj['actCode'] = obj['actCode'];
			customObj['matAmt'] = obj['matAmt'];
			customObj['matCode'] = obj['matCode'];
			customObj['matOdAcp'] = obj['matOdAcp'];
			customObj['matPrice'] = obj['matPrice'];
			customObj['matOdRq'] = obj['matOdRq'];
	 		customList.push(customObj);
		});
		
		//ajax로 데이터 보내기
		
		$.ajax({
			url : 'matOrderDirInsert',
			method : 'POST',
			data : JSON.stringify(customList),
			contentType : 'application/json',
			success : function(data){
				console.log(data);
				
			},
			error : function(reject){
				console.log(reject);
			}
		})
			
		
		
	}
		
	
	
	//거래처명, 자재명, 담당자명 클릭하면 모달창 나온 후 선택할 수 있음. 선택 시 hidden cell에 데이터 넘어감
		var Grid;
		orderGrid.on('click', () => {
    	let rowKey = orderGrid.getFocusedCell().rowKey;
    	let columnName = orderGrid.getFocusedCell().columnName;
    	if(columnName == "actName"){
    		$(".modal").fadeIn();
    	       Grid = createActGrid();
    	       
    	       Grid.on('click', () => {
    	       		let rowKey2 = Grid.getFocusedCell().rowKey;
    	        	let actCode = Grid.getValue(rowKey2, 'actCode');
    	        	let actName = Grid.getValue(rowKey2, 'actName');
    	        	console.log(actCode);
    	        	console.log(actName);
    	    		//$("#actCodeInput").val(actCode);
    	    		//$("#actNameFix").val(actName);
    	    		orderGrid.setValue(rowKey, 'actCode', actCode);
    	    		orderGrid.setValue(rowKey, 'actName', actName);
    	    		//선택시 모달창 닫기
    	    		if(rowKey != null){
    	    			$(".modal").fadeOut();
    	        		Grid.destroy();
    	    		}

    	       });
    	} else if(columnName == 'matName'){
    		$(".modal").fadeIn();
 	       Grid = createMatGrid();
 	       
 	       Grid.on('click', () => {
 	       		let rowKey2 = Grid.getFocusedCell().rowKey;
 	        	let matCode = Grid.getValue(rowKey2, 'matCode');
 	        	let matName = Grid.getValue(rowKey2, 'matName');
 	        	console.log(matCode);
 	        	console.log(matName);
 	    		//$("#actCodeInput").val(actCode);
 	    		//$("#actNameFix").val(actName);
 	    		orderGrid.setValue(rowKey, 'matCode', matCode);
 	    		orderGrid.setValue(rowKey, 'matName', matName);
 	    		//선택시 모달창 닫기
 	    		if(rowKey != null){
 	    			$(".modal").fadeOut();
 	        		Grid.destroy();
 	    		}

 	       });
    	} //else if(columnName == 'empName'){ session에서 받아오기
    		
    	//}
    	

  	});
	
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
	
	//필요한 데이터만 list에 담음
    </script>
</body>
</html>