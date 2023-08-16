<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BOM관리</title>
	<!-- 토스트 페이지 네이션 -->
    <script type="text/javascript" src="https://uicdn.toast.com/tui.code-snippet/latest/tui-code-snippet.js"></script>
    <link rel="stylesheet" href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css" />
    <script src="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.js"></script>
    <!-- 페이지 네이션 끝 -->
    <link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
    <script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>   
</head>
<body>
	<div class="black_bg"></div>
	<h3>BOM관리</h3>
	<div class="col-lg-12 stretch-card">
		<div class="card">
			<div class="card-body">
				<div class="table-responsive pt-3">

					<form>
						<div id="customtemplateSearchAndButton">		
							<p>제품명</p>
							<input type="text" placeholder="검색어를 입력하세요" id="bomSearch" ">
							<button type="button" class="btn btn-info btn-icon-text" id="searchBtn">
								<i class="fas fa-search"></i>검색
							</button>
							<button type="reset" class="btn btn-info btn-icon-text">초기화</button>
		            	</div>
	            	</form>
	            	</div>
	            	<p3> 제품bom등록 </p3>
	           		<div id="bomgrid"></div>
	           		<br>
	           		<div>
		           		<p3> bom상세등록 </p3>
		           		<button id = "deSave" class="btn btn-info btn-icon-text">상세저장</button>
		           		<button id = "deDelete" class="btn btn-info btn-icon-text" >상세삭제</button>
		           		<button id = "deAdd" class="btn btn-info btn-icon-text">추가</button>
		           		<div id="deBomgrid"></div>
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
	//페이지 호출할떄 BOM등록하는 창 호출
	window.onload = function addRow(){
		bomgrid.appendRow();
		deBomgrid.appendRow();
	}
	
	//상세BOM행추가
	document.getElementById('deAdd').addEventListener('click', addDeBom);
	function addDeBom(){
		deBomgrid.appendRow();
	}
	
	var bomgrid = new tui.Grid({
        el: document.getElementById('bomgrid'),
        scrollX: false,
        scrollY: false,
        minBodyHeight: 30,
		rowHeaders: ['rowNum'],
        columns: [
          {
            header: 'NO',
            name: 'bomNo',
          },
          {
              header: '제품코드',
              name: 'prodCode',
              editor: 'text'
            },
          {
              header: '제품명',
              name: 'prodName',
              editor: 'text'
            },
          {
            header: '등록날짜',
            name: 'bomWdate',
          },
          {
            header: '수정날짜',
            name: 'bomUdate'   	
          },
          {
            header: '사용여부',
            name: 'bomYn',
            formatter: 'listItemText',
            editor: {
                type: 'select',
                options: {
                  listItems: [
                	<c:forEach items="${bomUseInfoList}" var="b">
                	 {
                         text: '${b.commdeName }',
                         value: '${b.commdeCode }'
                       }, 
					</c:forEach>
                  ]
                }
              } 
          },
          {
            header: '공정사용여부',
            name: 'bomPrcsYn',
            formatter: 'listItemText',
            editor: {
                type: 'select',
                options: {
                  listItems: [
                	<c:forEach items="${bomPrcsUseList}" var="p">
                	 {
                         text: '${p.commdeName }',
                         value: '${p.commdeCode }'
                       }, 
					</c:forEach>
                  ]
                }
              } 
          }
        ]
      });
	
	
	//상세 BOM코드 grid 만들기
	 var deBomgrid = new tui.Grid({
        el: document.getElementById('deBomgrid'),
        scrollX: false,
        scrollY: false,
        minBodyHeight: 30,
		rowHeaders: ['rowNum'],
        columns: [
          {
            header: 'NO',
            name: 'bomNo',
          },
          {
              header: 'BOM코드',
              name: 'bomCode',
            },
          {
                header: '공정코드',
                name: 'prcsCode',
                editor: 'text'
            },
          {
            header: '자재/반제품구분',
            name: 'mpKind',
            editor: 'text'
          },
          {
            header: '자재/반제품코드',
            name: 'mpCode',
            editor: 'text'
          },
          {
            header: '단위',
            name: 'bomUnit',
            editor: 'text'
          },
          {
            header: '사용량',
            name: 'bomAmt',
            editor: 'text'
          }
        ]
      });
	
	
	
	
	
	/* //제품명으로 BOM조회
	 $('#searchBtn').on('click', searchProdIn);
   function searchProdIn(e){
	   let content = $('#bomSearch').val();
	   let search = { prodName : content };
	   $.ajax({
		   url : 'bomSearch',
		   method : 'GET',
		   data : search ,
		   success : function(data){
			   grid.resetData(data);
		   },
		   error : function(reject){
			   console.log(reject);
		   }
	   })
   }

   //수정시 사용할 그리드
    grid.on('click', () => {
    	//클릭한 제품 BOM가져오기
    	let rowKey = grid.getFocusedCell().rowKey;
    	let bomNo = grid.getValue(rowKey, 'bomNo');

    	$.ajax({
			url : 'bomDecodeList',
			method : 'GET',
			data : { bomNo : bomNo },
			success : function(data){
 				grid2.resetData(data);
 		    },
			error : function(reject){
	 			console.log(reject);
	 		}	
		})
  	});
    
    var bomgrid = new tui.Grid({
        el: document.getElementById('bomgrid'),
        scrollX: false,
        scrollY: false,
        minBodyHeight: 30,
		rowHeaders: ['rowNum'],
        columns: [
          {
            header: 'NO',
            name: 'bomNo',
          },
          {
              header: '제품코드',
              name: 'prodCode',
              editor: 'text'
            },
          {
              header: '제품명',
              name: 'prodName',
              editor: 'text'
            },
          {
            header: '등록날짜',
            name: 'bomWdate',
          },
          {
            header: '수정날짜',
            name: 'bomUdate'   	
          },
          {
            header: '사용여부',
            name: 'bomYn',
            formatter: 'listItemText',
            editor: {
                type: 'select',
                options: {
                  listItems: [
                	<c:forEach items="${bomUseInfoList}" var="b">
                	 {
                         text: '${b.commdeName }',
                         value: '${b.commdeCode }'
                       }, 
					</c:forEach>
                  ]
                }
              } 
          },
          {
            header: '공정사용여부',
            name: 'bomPrcsYn',
            formatter: 'listItemText',
            editor: {
                type: 'select',
                options: {
                  listItems: [
                	<c:forEach items="${bomPrcsUseList}" var="p">
                	 {
                         text: '${p.commdeName }',
                         value: '${p.commdeCode }'
                       }, 
					</c:forEach>
                  ]
                }
              } 
          }
        ]
      });
    
    
    
      */
	
	</script>
</body>
</html>