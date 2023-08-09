<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>생산 관리</title>
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
	<h2>생산 관리</h2>
	<div class="col-lg-12 stretch-card">
		<div class="card">
			<div class="card-body">
				<div class="table-responsive pt-3">
					<button type="button" class="btn btn-info btn-icon-text excelDownload">
		                Excel <i class="bi bi-printer"></i>                                                                              
					</button>
					<form>
						<div id="customtemplateSearchAndButton">		
							<p>검색</p>
							<input type="text" placeholder="검색어를 입력하세요" name="prcsSearch" value="">
							
							<button type="button" class="btn btn-info btn-icon-text" >
								<i class="fas fa-search"></i>검색
							</button>
							<button type="button" class="btn btn-info btn-icon-text">초기화</button>
		            	</div>
	            	</form>
	           		<div id="grid"></div>
	           		<div id="grid2"></div>
	           		<div id="grid3"></div>
				</div>
	   		</div>
		</div>
	</div> 

    
	<script>
	
	//생산지시 조회
    var grid = new tui.Grid({
        el: document.getElementById('grid'),
        data: [
	           <c:forEach items="${dirList}" var="d" varStatus="status">
	           	{
	           		prcsDirCode : "${d.prcsDirCode}",
	           		prcsPlanCode :"${d.prcsPlanCode}",
	           		prcsDirName :"${d.prcsDirName}",
	           		prcsDirDate :"<fmt:formatDate value='${d.prcsDirDate}' pattern='yyyy-MM-dd'/>",
	           		prcsDirSts : "${d.prcsDirSts}",
	           		empCode :"${d.empCode}"
	           	} <c:if test="${not status.last}">,</c:if>
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
            header: '지시코드',
            name: 'prcsDirCode'
          },
          {
            header: '계획코드',
            name: 'prcsPlanCode'
          },
          {
            header: '지시명',
            name: 'prcsDirName'
          },
          {
            header: '지시일자',
            name: 'prcsDirDate'
          },
          {
            header: '지시상태',
            name: 'prcsDirSts'
          },
          {
            header: '담당자',
            name: 'empCode'
          }
        ]
      })  

	
	//상세생산지시 조회
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
            header: '상세지시코드',
            name: 'prcsDirDeCode'
          },
          {
            header: '제품코드',
            name: 'prodCode'
          },
          {
            header: '생산계획량',
            name: 'prcsPlanAmt'
          },
          {
            header: '지시수량',
            name: 'prcsDirAmt'
          },
          {
            header: '생산시작일자',
            name: 'prcsStartDeDate'
          },
          {
            header: '생산마감일자',
            name: 'prcsEndDeDate'
          },
          {
            header: '공정진행상태',
            name: 'prcsIngSts'
          },
          {
            header: '담당자',
            name: 'empCode'
          }
        ]
      })  
	
    prcsIngCode;
	private String prcsDirDeCode;
	private String prodCode;
	private String prcsCode;
	private int prcsSeq;
	private int inputAmt;
	private int errAmt;
	private int prcsAmt;
	private String prcsDirIngSts;
	
	
 	//진행 공정 조회
// 	var grid3 = new tui.Grid({
//         el: document.getElementById('grid3'),
//         scrollX: false,
//         scrollY: false,
//         minBodyHeight: 30,
// 		rowHeaders: ['rowNum'],
// 		pagination: true,
// 		pageOptions: {
// 			useClient: true,
// 			perPage: 10,
// 		},
//         columns: [
//           {
//             header: '',
//             name: 'prcsIngCode'
//           },
//           {
//             header: '',
//             name: 'prcsDirDeCode'
//           },
//           {
//             header: '',
//             name: 'prodCode'
//           },
//           {
//             header: '',
//             name: 'prcsCode'
//           },
//           {
//             header: '',
//             name: 'prcsSeq'
//           },
//           {
//             header: '',
//             name: 'inputAmt'
//           },
//           {
//             header: '',
//             name: 'errAmt'
//           },
//           {
//             header: '',
//             name: 'prcsAmt'
//           },
//           {
//             header: '',
//             name: 'prcsDirIngSts'
//           },

//         ]
//       })  
	
	//생산 지시 클릭시 해당 지시의 상세생산지시 조회
    grid.on('click', () => {
    	//클릭한 지시의 지시코드 가져오기
    	let rowKey = grid.getFocusedCell().rowKey;
    	let dirCode = grid.getValue(rowKey, 'prcsDirCode');

    	$.ajax({
			url : 'prcsDirDeList',
			method : 'GET',
			data : { prcsDirCode : dirCode },
			success : function(data){
 				grid2.resetData(data);
 		    },
			error : function(reject){
	 			console.log(reject);
	 		}	
		})
  	});
	
	
//   	//상세 생산 지시 클릭시 해당 지시의 상세생산지시 조회
//      grid2.on('click', () => {
//     	//클릭한 상세 지시의 상세지시코드 가져오기
//     	let rowKey = grid.getFocusedCell().rowKey;
//     	let dirCode = grid.getValue(rowKey, 'prcsDirDeCode');
// 		//클릭한 상세 지시의 제품코드 가져오기
//     	$.ajax({
// 			url : 'prcsIngList',
// 			method : '',
// 			data : { prcsDirDeCode : dirDeCode },
// 			success : function(data){
//  				grid2.resetData(data);
//  		    },
// 			error : function(reject){
// 	 			console.log(reject);
// 	 		}	
// 		})
//   	});
    
    
    
	</script>
</body>
</html>