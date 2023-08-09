<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false" %>
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

<meta charset="EUC-KR">
<title>설비 등록 페이지</title>
</head>

<h2>설비 관리</h2>
<body>
<hr>
<form name="insertForm" action="equipInsert" method="post">
   <table>
   <button type="button" id="actModal">설비조회</button>
      <tr>
         <th>설비코드</th>
         <td><input type="text" name="eqCode"></td>
         <th>거래처</th>
         <td><input type="text" name="actCode"></td>
      </tr>
      <tr>
         <th>설비구분 <i class="bi bi-search" id="actModal2"></i></th>
         <td><input type="text" name="eqType"></td>
         <th>설비명</th>
         <td><input type="text" name="eqName"></td>
      </tr>
      <tr>
         <th>모델명</th>
         <td><input type="text" name="modelName"></td>
         <th>제작일자</th>
         <td><input type="text" name="makeDate"></td>
      </tr>
      <tr>
         <th>구매일자</th>
         <td><input type="text" name="buyDate"></td>
         <th>점검주기</th>
         <td><input type="text" name="chkCycle"></td>
      </tr>
      <tr>
         <th>가동여부</th>
         <td><input type="text" name="eqSts"></td>
         <th>공정코드</th>
         <td><input type="text" name="prcsType"></td>
      </tr>
      <tr>
         <th>최고온도</th>
         <td><input type="text" name="highTemp"></td>
         <th>최저온도</th>
         <td><input type="text" name="lowTemp"></td>
      </tr>
      <tr>
         <th>설비이미지</th>
         <td><input type="text" name="eqImg"></td>
      </tr>
   </table>
   <br>
   <button type="submit">등록</button>
   <button type="button" onclick="location.href='equipDelete?eqCode=${equipInsert.eqCode}'">삭제</button>
   <button type="button" onclick="location.href='EquipList'">목록</button>
   
   
<div class="modal">
   
  <div class="modal_content" 
       title="클릭하면 창이 닫힙니다.">
          <div class="m_head">
            <div class="modal_title"><h3>설비 목록</h3></div>
            <div class="close_btn" id="close_btn">X</div>
       </div>
       <div class="m_body">
            <div id="actGrid"></div>
       </div>
  </div>
</div>

</form>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
var Grid;
$("#actModal").click(function(){
  $(".modal").fadeIn();
  Grid = createActGrid();
  $.ajax({
	    url : "selectEquipAllList",
	    method :"GET",
	    success : function(result){
	        Grid.resetData(result);
	    },
	    error : function(reject){
				console.log(reject);
			}
	});
});


$("#close_btn").click(function(){
  $(".modal").fadeOut(); 
	Grid.destroy();
});




function createActGrid(){
	   var actGrid = new tui.Grid({
		      el: document.getElementById('actGrid'),
		      /* data: [
		    	  <c:forEach items="${ModalEquip}" var="equip"  varStatus="status">
		      	{
		      		eqCode : "${equip.eqCode}",
		      		actCode : "${equip.actCode}",
		      		eqName :"${equip.eqName}",   		
		      	}<c:if test="${not status.last}">,</c:if>
		      	 </c:forEach>

		         ], */
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
			 	        header: '설비코드',
			 	        name: 'eqCode'
			 	      
			 	      },
			 	      {
			 	    	  header : '설비업체명',
			 	    	  name : 'actCode'		 	    	  
			 	      },
			 	      {
			 	        header: '설비명',
			 	        name: 'eqName'
			 	      }
			    ]
		    })
	   
	   return actGrid;
}



</script>
</body>
</html>
