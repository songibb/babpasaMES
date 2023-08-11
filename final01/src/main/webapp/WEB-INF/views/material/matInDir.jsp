<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	<h2>자재 입고</h2>
	<div class="col-lg-12 stretch-card">
		<div class="card">
			<div class="card-body">
				<div class="table-responsive pt-3">
					<button type="button" class="btn btn-info btn-icon-text excelDownload">
		                Excel <i class="bi bi-printer"></i>                                                                              
					</button>
					<form>
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
	            	</form>
	            	<button id="save">저장</button>
	            	<button id="dirAdd">행추가</button>
	           		<div id="grid"></div>
				</div>
	   		</div>
		</div>
	</div> 

    
	<script>
	document.getElementById('save').addEventListener('click', saveServer);
	document.getElementById('dirAdd').addEventListener('click', addDirRow);

	//페이지 호출시 생산지시 등록하는 행 자동 생성
	window.onload = function addRow(){
		dirGrid.appendRow();
	} 

	//행추가 버튼 클릭시 상세생산지시 행 추가
	function addDirRow(){
		dirDeGrid.appendRow();
	}
   
   
 

	//생산지시 form
	var grid = new tui.Grid({
	        el: document.getElementById('grid'),
	        scrollX: false,
	        scrollY: false,
	        minBodyHeight: 30,
			rowHeaders: ['rowNum'],	
			pageOptions: {
		        perPage: 5
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
	 	 	        name: 'matName',
	 	 	        editor : 'text'
	 	 	      },
	 	 	      {
	 	 	        header: '거래처명',
	 	 	        name: 'actName'
	 	 	      },
	 	 	      {
                      header: '거래처코드',            // [필수] 컬럼 이름
                      name: 'actCode',                 // [필수] 컬럼 매핑 이름 값
                      hidden: true,                   // [선택] 숨김 여부
                  },
	 	 	      {
	 	 	        header: '입고량',
	 	 	        name: 'matInAmt',
	 	 	        editor : 'text'
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
	 	 	        editor : 'text'
	 		 	  },
	 		 	  {
	 			 	header: '유통기한',
	 			 	name: 'matExd',
	 	 	        editor : 'text'
	 			  }
	        ]
	      });  
	}
	
	//저장 버튼 클릭시 실행 될 함수 -> insert 실행
	function saveServer() {	
		
		//생산지시 객체 -> insert
		let rowKey = grid.getFocusedCell().rowKey;
		let columnName = dirGrid.getFocusedCell().columnName;
		
		dirGrid.finishEditing(rowKey, columnName);
		let obj = {};

		obj['matCode'] = dirGrid.getValue(rowKey, 'matCode');
		obj['actCode'] = dirGrid.getValue(rowKey, 'actCode');
		//name을 code로 가져와야됨..........
		obj['matInAmt'] = dirGrid.getValue(rowKey, 'matInAmt');
		obj['empCode'] = dirGrid.getValue(rowKey, 'empCode');
		//name을 code로 가져와야됨..........
		obj['matInd'] = dirGrid.getValue(rowKey, 'matInd');
		obj['matExd'] = dirGrid.getValue(rowKey, 'matExd');
		
		$.ajax({
			url : 'prcsDirInsert',
			method : 'POST',
			data : JSON.stringify(obj),
			contentType : 'application/json',
			success : function(data){
				console.log(data);
				dirGrid.clear();
				dirGrid.appendRow();
			},
			error : function(reject){
	 			console.log(reject);
	 		}		
		})
	}
		
		
    
	
	


	
	
	



	
	
	
    </script>
</body>
</html>