<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>

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
   #actModal, #matModal{ 
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

    
</style>
</head>
<body>
	<div class="black_bg"></div>
	<h1>설비 점검</h1>
	<div class="col-lg-12 stretch-card">
    	<div class="card">
        	<div class="card-body">
            	<div class="table-responsive pt-3">
            	<form>
            		<div id="customtemplateSearchAndButton">
            			<p>설비구분</p>
            			<select name="job">
						    <option value="">설비구분</option>
						    <option value="증숙">증숙</option>
						    <option value="혼합">혼합</option>
						    <option value="냉동">냉동</option>
						</select><br>
						
						<p>판정구분</p>
						<select name="job">
						    <option value="">판정구분</option>
						    <option value="합격">합격</option>
						    <option value="불합격">불합격</option>
						    <option value="기타">기타</option>
						</select>
						<br>
						<p>점검일자</p>
						 <p><input type="date"></p> ~ <p> <input type="date"></p>
						<button type="button" class="btn btn-info btn-icon-text">검색</button>
						</form>
						
						<button id="save">저장</button>
	            		<button id="remove">삭제</button>
	            		<button id="orderModal">점검대상 조회</button>

		
					<div id="grid"></div>
					</div>
                </div>
			</div>
		</div>
	
<div class="modal"/>
   
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
	
	//저장
	document.getElementById('save').addEventListener('click', saveServer);

	//저장
    function saveServer() {	
    	let rowKey = grid.getFocusedCell();
    	let codeValue = grid.getValue(rowKey, 'eqCode');
    	
		if(eqCode =! null){
			//inse
			ChkequipUpdate();
			
			//if -> 상세생산계획칸 비어있으면 작동X
			
		}

	};
	
			/* //모달
		    var Grid;
		     $("#actModal").click(function(){
		       $(".modal").fadeIn();
		       Grid = createActGrid();
		     });
		     
		     
		     $("#matModal").click(function(){
		       $(".modal").fadeIn();
		       Grid = createMatGrid();
		     });
		     
		     $("#close_btn").click(function(){
		       $(".modal").fadeOut();
		       
				Grid.destroy();
		     }); */


		     function ChkequipUpdate(){
		 		//alert 표시를 위한 변수
		 		var updateOk;
		 		
		 		//생산계획 -> update
		 		let rowKey = grid.getFocusedCell().rowKey;
		 		let columnName = grid.getFocusedCell().columnName;
		 		//편집종료
		 		grid.finishEditing(rowKey, columnName);

		 		let list = grid.getData();

		 		$.ajax({
		 			url : 'updateChkEquip',
		 			method : 'POST',
		 			data : JSON.stringify(list),
		 			contentType : 'application/json',
		 			async : false,  //data 모두 수신 후 변수 updateOk에 담기 위해 동기방식으로 처리
		 			success : function(data){	
		 				updateOk = data;

		 				//수정 후 그리드 내용 지우고, 행추가
		 				grid.clear();
		 				grid.appendRow();
		 			},
		 			error : function(reject){
		 	 			console.log(reject);
		 	 		}		
		 		})
		 		
		 		if(updateOk > 0){
					alert('수정 성공');
				}
		     }
		     
		   //점검 설비 grid
		     var grid = new tui.Grid({
		         el: document.getElementById('grid'),
		         data: [
			        	<c:forEach items="${equipchkList}" var="chk" varStatus="status">
			           	{
			           		eqCode : "${chk.eqCode}",
			           		eqName : "${chk.eqName}",
			           		eqType : "${chk.eqType}",
			           		chkCycle : "${chk.chkCycle}",
			           		chkDate : "<fmt:formatDate value='${chk.chkDate}' pattern='yyyy-MM-dd'/>",
			           		eqChkYn : "${chk.eqChkYn}",
			           		empCode : "${chk.empCode}",
			           		chkNote : "${chk.chkNote}"		   	        
			           	}<c:if test="${not status.last}">,</c:if>
			           </c:forEach>
				          ], 
		         scrollX: false,
		         scrollY: false,
		         minBodyHeight: 30,
		         rowHeaders: ['rowNum', 'checkbox'],
		         pagination: true,
					pageOptions: {
					useClient: true,
					perPage: 10,
					},
		         columns: [
		           {
		             header: '설비코드',
		             name: 'eqCode'
		           },
		           {
			         header: '설비명',
			         name: 'eqName'
			       },
			       {
				     header: '설비구분',
				     name: 'eqType'
				   },
		           {
			         header: '점검주기(일)',
			         name: 'chkCycle'
			       },
		           {
		             header: '점검일자',
		             name: 'chkDate',
		           	 editor : 'text'
		           },
		           {
			         header: '차기점검일자',
			         name: 'chkDate',
			         editor : 'text'
			       },
		         	//지울부분
		           {
		 			header: '점검판정',
		             name: 'eqChkYn',
		             editor : 'text'
		           },
		           {
		        	  header: '담당자',
			 	      name: 'empCode',
			 	      editor : 'text'
		           },
		           {
		        	  header: '비고',
			 	      name: 'chkNote',
			 	      editor : 'text'
		           }
		         ]
		 	});
		   
		     
	</script>
</body>
</html>	
