<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>반품 관리</title>

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
 #prodModal, #delete{ 
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
	<h2>반품 관리</h2>
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
	rtGrid.removeCheckedRows(false);
	//마우스 커서 없앰
	rtGrid.blur();
	});
	
	//행추가 버튼 클릭시 주문등록 행 추가
	function addDirRow(){
		rtGrid.appendRow({}, { at: 0 });
	}

	
	//반품 form
	var rtGrid = new tui.Grid({
	        el: document.getElementById('grid'),
	        data: [
	        	<c:forEach items="${rtList}" var="rt" varStatus="status">
	           	{
	           		salesRtCode : "${rt.salesRtCode}",
	           		prodLot : "${rt.prodLot}",
	           		salesOutCode : "${rt.salesOutCode}",
	           		salesRtAmt : "${rt.salesRtAmt}",
	           		salesRtDate : `<fmt:formatDate value="${rt.salesRtDate}" pattern="yyyy-MM-dd"/>`,
	           		salesRtWhy : "${rt.salesRtWhy}",
	           		empCode : "${rt.empCode}"
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
		           header: '반품코드',
		           name: 'salesRtCode',
	        	   value : '${rt.salesRtCode}'
		         },
		         {
		           header: '출고코드',
		           name: 'salesOutCode',
		           editor : 'text',
		           value : '${rt.salesOutCode}'
		        	  	
		         },
		         {
		           header: '제품LOT',
		           name: 'prodLot',
		           editor : 'text',
		           value : '${rt.prodLot}'
		         },
		         	{
			           header: '제품코드',
			           name: 'prodCode',
			           value : '${rt.prodCode}'
			         },
		         {
		           header: '반품량',
		           name: 'salesRtAmt',
	        	   editor : 'text'
		         },
		         {
		           header: '빈품일',
		           name: 'salesRtDate',
		           editor: {
		    		      type: 'datePicker',
		    		      options: {
		    		    	  language: 'ko'
		    		      }
		    		    }
		         },
		         {
		           header: '반품사유',
		           name: 'salesRtWhy',
		           editor : 'text',
		           value : '${rt.salesRtWhy}'
		         },
		         {
		           header: '직원코드',
		           name: 'empCode',
		           editor : 'text',
		           value : '${rt.empCode}'
		         }
	        ]
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
		rtGrid.on('click', () => {
    	let rowKey = rtGrid.getFocusedCell().rowKey;
    	let columnName = rtGrid.getFocusedCell().columnName;
		 if(columnName == 'salesOutCode'){
    		$(".modal").fadeIn();
 	       Grid = createOutGrid();
 	       
 	       Grid.on('click', () => {
 	       		let rowKey2 = Grid.getFocusedCell().rowKey;
 	        	let salesOutCode = Grid.getValue(rowKey2, 'salesOutCode');
 	        	let prodLot = Grid.getValue(rowKey2, 'prodLot');
 	        	let prodCode = Grid.getValue(rowKey2, 'prodCode');
 	        	console.log(salesOutCode);
 	        	console.log(prodLot);
 	        	console.log(prodCode);
 	    		//$("#actCodeInput").val(actCode);
 	    		//$("#actNameFix").val(actName);
 	    		rtGrid.setValue(rowKey, 'salesOutCode', salesOutCode);
 	    		rtGrid.setValue(rowKey, 'prodLot', prodLot);
 	    		rtGrid.setValue(rowKey, 'prodCode', prodCode);
 	    		//선택시 모달창 닫기
 	    		if(rowKey != null){
 	    			$(".modal").fadeOut();
 	        		Grid.destroy();
 	    		}

 	       });
    	} //else if(columnName == 'empName'){ session에서 받아오기
    		
    	//}
    	

  	});
		
		//출고목록 모달
		function createOutGrid(){
        var prodGrid = new tui.Grid({
            el: document.getElementById('modal_label'),
            data: [
               <c:forEach items="${outList}" var="out" varStatus="status">
                  {
                	  salesOutCode : "${out.salesOutCode}",
                	  prodCode : "${out.prodCode}",
                	  actCode : "${out.actCode}",
                	  salesOutDate : "${out.salesOutDate}",
                	  salesOutAmt : "${out.salesOutAmt}",
                	  empCode : "${out.empCode}",
                	  salesOrdDeCode : "${out.salesOrdDeCode}",
                	  prodLot : "${out.prodLot}",
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
                    header: '출고코드',
                    name: 'salesOutCode',
                  },
                  {
                    header: '제품코드',
                    name: 'prodCode'
                  },
                  {
                    header: '거래처코드',
                    name: 'actCode'
                  },
                  {
                    header: '출고날짜',
                    name: 'salesOutDate'
                  },
                  {
                      header: '출고량',
                      name: 'salesOutAmt'
                    },
                    {
                        header: '직원코드',
                        name: 'empCode'
                      },
                      {
                          header: '상세주문코드',
                          name: 'salesOrdDeCode'
                        },
                        {
                            header: '제품LOT',
                            name: 'prodLot'
                          }
             ]
           
          });
        
        return prodGrid;
     }
		
		
	
	//모달창 닫기
	$("#close_btn").click(function(){
        $(".modal").fadeOut();
         
  		Grid.destroy();
     });
	
	
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
	  let prodInsert = $('#prodCodeInput').val();
        
      let search = { prodCode : prodInsert };
      $.ajax({
         url : 'inListFilter',
         method : 'GET',
         data : search ,
         success : function(data2){
        	 
           rtGrid.resetData(data2);
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
		rtGrid.blur();
		let modifyGridInfo = rtGrid.getModifiedRows();
		
		// 수정된게 없으면 바로 빠져나감
		
		if(!rtGrid.isModified()){
			swal("", "변경사항이 없습니다", "warning");
			return false;
		}
		
		//flag가 true = 입력폼이나 수정폼에 빠뜨린 데이터가 없다
		var flag = true;
		//create, modify, delete 포함하는 전체 배열을 도는 each문			
			
		if(rtGrid.getModifiedRows().createdRows.length > 0 ){
				
				$.each(rtGrid.getModifiedRows().createdRows, function(idx2, obj2){
					if( obj2['prodCode'] == "" || obj2['salesOutCode'] == "" || obj2['salesRtAmt']== "" || obj2['salesRtDate'] == "" || obj2['salesRtWhy'] == "" || obj2['empCode'] == "" || obj2['prodLot'] == ""){
						flag = false;
						return false;
					}
				})
		}
		
		if(rtGrid.getModifiedRows().updatedRows.length > 0 ){

				$.each(rtGrid.getModifiedRows().updatedRows, function(idx2, obj2){
					if(obj2['salesInDate'] == "" || obj2['salesInExd'] == "" || obj2['devDate'] == "" || obj2['salesOrdDeCode'] == ""){
						flag = false;
						return false;
					}
				})
				
		}
		
		if(flag){
				$.ajax({
					url : 'rtSave',
					method : 'POST',
					data : JSON.stringify(rtGrid.getModifiedRows()),
					contentType : 'application/json',
					success : function(data){
						swal("성공", data +"건이 처리되었습니다.", "success");
// 						rtGrid.resetData(data);
					},
					error : function(reject){
						console.log(reject);
						swal("실패", "", "error");
					}
				})
		} else {
			swal("", "값이 입력되지 않았습니다", "warning");
		}

	}
  	

    </script>
</body>
</html>