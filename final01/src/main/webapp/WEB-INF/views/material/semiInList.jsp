<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
    <title>반제품 입고 조회</title>
<!-- 토스트 페이지 네이션 -->
<script type="text/javascript" src="https://uicdn.toast.com/tui.code-snippet/latest/tui-code-snippet.js"></script>
<link rel="stylesheet" href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css" />
<script src="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.js"></script>
<!-- 페이지 네이션 끝 -->
<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
<style>
	.excelDownload{
   		margin: 0px;
   }

	h1{
		margin-left: 15px;
	}
	
	h1, h2{
		font-weight: 800;
	}
	
	h2{
		clear: both;
		display : inline-block;
	}
	
	#searchP input[type="text"] {
	  width: 15%;
	  padding: 6px;
	  margin-bottom: 15px;
	  border: 1px solid #ccc;
	  border-radius: 4px;
	}
	#searchP input[type="date"]{
	  width: 15%;
	  padding: 5px;
	  margin-bottom: 15px;
	  border: 1px solid #ccc;
	  border-radius: 4px;
	}
	
	#searchP p{
		width: 80px;
		display: inline-block;
		font-size: 20px;
	}
	
	#searchP label[for="before"]{
		margin-bottom : 35px;
	}
	
	#searchP label[for="after"]{
		margin-right : 20px;
	}
	
	.yellow-background {
        background-color: rgb(255,253,235);
	}
	
	.modal_content{
	  /*모달창 크기 조절*/
	  width:600px; height:700px;
	  background:#fff; border-radius:10px;
	  /*모달창 위치 조절*/
	  position:relative; top:33%; left:45%;
	  margin-top:-100px; margin-left:-200px;
	  text-align:center;
	  box-sizing:border-box;
	  line-height:23px;
	}
	
	.m_body > p{
		display : inline-block;
	}
	
	#customtemplateSearchAndButton p{
		width : 100px;
	}
	
	#prodNameFix {
		background-color : #868e96;
		border-color: #868e96;
	}
	
	#prodModal{
		cursor : pointer;
	}
	
	#modalSearch{
		width: 30%;
	  	padding: 6px;
	  	margin-bottom: 15px;
	  	border: 1px solid #ccc;
	  	border-radius: 4px;	
	}
	
	.selected-cell{
   		background-color: #ffd09e;
	}
	
	.btn-icon-text2 {
	    margin: -5px;
	    width : 70px;
	    border-radius: 0;
	    height: 33px;
	    line-height: 20px;
	}

	.btn-info2 {
	    color: black;
	    background-color: white;
	    border-color: #ccc;
	    
	}

	#todayBtn {
		margin-left: 2px !important;
		border-radius: 5px 0 0 5px;
		border : 1px solid #ccc;
	}
	#todayBtn:hover{
		background-color : #f4f4f4;
		border : 1px solid #868e96;
		color: black;
	}
	#resetBtn:hover{
		background-color : #f4f4f4;
		border : 1px solid #868e96;
		color: black;
	}
	#weekBtn:hover, #monthBtn:hover{
	    background-color : #f4f4f4;
	    border : 1px solid #868e96;
	    color: black;
	}
	
	#monthBtn{
			border-radius: 0 5px 5px 0;
			border : 1px solid #ccc;
	}
</style>    
       
</head>
<body>
   <h1>반제품 입고 조회</h1>
   <div class="col-lg-12 stretch-card">
       <div class="card">
           <div class="card-body">
               <div class="table-responsive pt-3">
               		
                  	
        				<div id="searchP" style="display: flex; justify-content: space-between;">
            				<div style="flex: 1;">
                				<p>반제품명</p>
				                <input type="text" id="prodCodeInput" placeholder="검색어를 선택하세요" readonly>
				                <i class="bi bi-search" id="prodModal"></i> <!-- 돋보기 아이콘 -->
				                <input type="text" class="blackcolorInputBox" id="prodNameFix" readonly>
				                <br>
				                <p>입고일자</p>
				                <input id="startDate" type="date">&nbsp;&nbsp;-&nbsp;&nbsp;<input id="endDate" type="date">
				                <button type="button" class="btn btn btn-info btn-icon-text btn-info2 btn-icon-text2" id="todayBtn">오늘</button>
								<button type="button" class="btn btn btn-info btn-icon-text btn-info2 btn-icon-text2" id="weekBtn">일주일</button>								
								<button type="reset" class="btn btn btn-info btn-icon-text btn-info2 btn-icon-text2" id="monthBtn">한달</button>
				                <br>
                				<p>사용여부</p>
                				<label for="before"><input type="checkbox" id="before" value="사용전">사용전</label>
                				<label for="ing"><input type="checkbox" id="ing" value="사용중">사용중</label>
                				<label for="after"><input type="checkbox" id="after" value="사용완료">사용완료</label>
                				<button type="button" class="btn btn-info btn-icon-text" id="searchBtn">
                    				<i class="fas fa-search"></i>
                    					검색
                				</button>
                				<button type="button" class="btn btn-info btn-icon-text" id="searchResetBtn">
                    				초기화
                				</button>
            				</div>
        				</div>
	    			
		            
		            
		            <div id="grid">
		            	<h2>입고 목록</h2>
		            
		            	<button type="button" class="btn btn-info btn-icon-text excelDownload">
                      	 Excel
                      	<i class="bi bi-printer"></i>                                                                              
                   	</button>
		            </div>
				</div>
			</div>
		</div>
	</div> 
	<div class="modal">
   		<div class="modal_content">
        	<div class="m_head">
            	<div class="modal_title"><h3>목록</h3></div>
            	<div class="close_btn" id="close_btn">X</div>
       		</div>
       		<div class="m_body">
       			<p>이름</p>
                <input type="text" id="modalSearch">
                <button type="button" class="btn btn-info btn-icon-text" id="modalSearchBtn">검색</button>
            	<div id="modal_label"></div>
       		</div>
       		<div class="m_footer">
            	<div class="modal_btn cancle close_btn">CANCLE</div>
    		</div>
  		</div>
	</div>
	<div>
		<jsp:include page="../comFn/dateFormat.jsp"></jsp:include>
	</div>

	<script>
	
	//오늘
	document.getElementById('todayBtn').addEventListener('click', todayBtn);
	//일주일
	document.getElementById('weekBtn').addEventListener('click', weekBtn);
	//한달
	document.getElementById('monthBtn').addEventListener('click', monthInput);

	//오늘 버튼 클릭시
	function todayBtn(){
		$('#startDate').val(getToday());
		$('#endDate').val(getToday());;
	}
	
	//일주일 버튼 클릭시
	function weekBtn(){
		$('#startDate').val(getWeek());
		$('#endDate').val(getToday());;
	}
	
	function monthInput(){
		$('#startDate').val(getMonth());
		$('#endDate').val(getToday());;
	}
   
		//모달 시작
		var Grid;
		$("#prodModal").click(function () {
		    $(".modal").fadeIn();
		    preventScroll();
		    Grid = createProdGrid();
		    $('.modal_title h3').text('반제품 목록');
		    Grid.on('dblclick', () => {
		        let rowKey = Grid
		            .getFocusedCell()
		            .rowKey;
		        let prodCode = Grid.getValue(rowKey, 'prodCode');
		        let prodName = Grid.getValue(rowKey, 'prodName');
		        $("#prodCodeInput").val(prodCode);
		        $("#prodNameFix").val(prodName);
		        //모달창 닫기
		        if (rowKey != null) {
		            $(".modal").fadeOut();
		            activeScroll();
		            let inputContent = $('#modalSearch').val('');
		            if (Grid != null && Grid.el != null) {
		                Grid.destroy();
		            }
		        }
	
		    });
		});
	
		$(".close_btn").click(function () {
		    $(".modal").fadeOut();
		    activeScroll();
		    let inputContent = $('#modalSearch').val('');
		    if (Grid != null && Grid.el != null) {
		        Grid.destroy();
		    }
		});
	
		//반제품 모달 그리드
		function createProdGrid() {
		    var prodGrid = new tui.Grid({
		        el: document.getElementById('modal_label'),
		        data: [<c:forEach items="${prodList}" var="p" varStatus="status">
		            {
		                prodCode: "${p.prodCode}",
		                prodName: "${p.prodName}"
		            }
		            <c:if test="${not status.last}">,</c:if>
		        </c:forEach>
		            ],
		        scrollX: false,
		        scrollY: false,
		        minBodyHeight: 400,
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
		                header: '반제품코드',
		                name: 'prodCode',
			            align: 'center'
		            }, {
		                header: '반제품명',
		                name: 'prodName',
			            align: 'left'
		            }
		        ]
	
		    });
	
		    return prodGrid;
		}
	
		//모달 검색
		$('#modalSearchBtn').on('click', function (e) {
		    let title = $('.modal_title h3').text();
		    let inputContent = $('#modalSearch').val();
	
		    if (title == '반제품 목록') {
		        let modalSearchData = {
		            prodName: inputContent
		        }
		        $.ajax({
		            url: 'getSemiModalSearch',
		            method: 'GET',
		            data: modalSearchData,
		            success: function (data) {
	
		                Grid.resetData(data);
		            },
		            error: function (reject) {
		                console.log(reject);
		            }
		        })
		    }
		})
	
		//엑셀 다운로드
		const excelDownload = document.querySelector('.excelDownload');
	
		document.addEventListener('DOMContentLoaded', () => {
		    excelDownload.addEventListener('click', function (e) {
		        grid.export('xlsx');
		    })
		})
	
		//전체조회 그리드
		var grid = new tui.Grid({
		    el: document.getElementById('grid'),
		    data: [<c:forEach items="${inList}" var="semi">
		        {
		            semiLot: "${semi.semiLot}",
		            prodName: "${semi.prodName}",
		            semiInAmt: "${semi.semiInAmt}",
		            empName: "${semi.empName}",
		            useYn: "${semi.useYn}",
		            semiInd: `<fmt:formatDate value="${semi.semiInd}" pattern="yyyy-MM-dd"/>`,
		            semiExd: `<fmt:formatDate value="${semi.semiExd}" pattern="yyyy-MM-dd"/>`
		        },
		    </c:forEach>
		        ],
		    scrollX: false,
		    scrollY: false,
		    minBodyHeight: 400,
		    rowHeaders: ['rowNum'],
		    pagination: true,
		    pageOptions: {
		        //백엔드와 연동 없이 페이지 네이션 사용가능하게 만듦
		        useClient: true,
		        perPage: 10
		    },
		    columns: [
		    	{
		            header: '반제품 LOT',
		            name: 'semiLot',
		            sortable: true,
		            sortingType: 'asc',
		            align: 'center'
		        },
		        {
		            header: '반제품명',
		            name: 'prodName',
		            align: 'left'
		        },
		        {
		            header: '입고일자',
		            name: 'semiInd',
		            className: 'yellow-background',
		            align: 'center'
		        },
		        {
		            header: '입고량',
		            name: 'semiInAmt',
		            formatter(e) {
		                val = e['value']
		                    .toString()
		                    .replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		                return val;
		            },
		            align: 'right'
		        },   {
		            header: '유통기한',
		            name: 'semiExd',
		            className: 'yellow-background',
		            align: 'center'
		        }, {
		            header: '사용여부',
		            name: 'useYn',
		            align: 'left'
		        }, {
		            header: '담당자',
		            name: 'empName',
		            align: 'center'
		        }
		    ]
	
		});
	
		//검색
		$('#searchBtn').on('click', searchSemiIn);
		function searchSemiIn(e) {
		    let prod = $('#prodCodeInput').val();
		    let sd = $('#startDate').val();
		    let ed = $('#endDate').val();
	
		    var checkboxList = [];
		    let checkedList = $('input[type="checkbox"]:checked');
		    $.each(checkedList, function (idx, obj) {
		        checkboxList.push(obj.value);
		    })
	
		    let search = {
		        productCode: prod,
		        startDate: sd,
		        endDate: ed,
		        checkList: checkboxList
		    };
		    $.ajax({
		        url: 'getSemiInFilter',
		        method: 'GET',
		        data: search,
		        success: function (data) {
	
		            for (let i of data) {
		                let date = new Date(i.semiInd);
		                let year = date.getFullYear(); //0000년 가져오기
		                let month = date.getMonth() + 1; //월은 0부터 시작하니 +1하기
		                let day = date.getDate(); //일자 가져오기
		                i.semiInd = year + "-" + (
		                    ("00" + month.toString()).slice(-2)
		                ) + "-" + (
		                    ("00" + day.toString()).slice(-2)
		                );
	
		                date = new Date(i.semiExd);
		                year = date.getFullYear(); //0000년 가져오기
		                month = date.getMonth() + 1; //월은 0부터 시작하니 +1하기
		                day = date.getDate(); //일자 가져오기
		                i.semiExd = year + "-" + (
		                    ("00" + month.toString()).slice(-2)
		                ) + "-" + (
		                    ("00" + day.toString()).slice(-2)
		                );
		            }
		            grid.resetData(data);
		        },
		        error: function (reject) {
		            console.log(reject);
		        }
		    });
		}
	
		//초기화 버튼
		$('#searchResetBtn').on('click', resetInput);
		function resetInput(e) {
		    $('input').each(function (idx, obj) {
		        obj.value = '';
		        obj.checked = false;
		    })
		}
	
		//스크롤 막기
		function preventScroll() {
		    $('html, body').css({'overflow': 'hidden', 'height': '100%'}); // 모달팝업 중 html,body의 scroll을 hidden시킴
		    $('#element').on(
		        'scroll touchmove mousewheel',
		        function (event) { // 터치무브와 마우스휠 스크롤 방지
		            event.preventDefault();
		            event.stopPropagation();
	
		            return false;
		        }
		    );
		}
	
		//스크롤 활성화
		function activeScroll() {
		    $('html, body').css({'overflow': 'visible', 'height': '100%'}); //scroll hidden 해제
		    $('#element').off('scroll touchmove mousewheel'); // 터치무브 및 마우스휠 스크롤 가능
		}
	
		//이전 날짜 선택불가
		$('#startDate').on('change', function () {
		    $('#endDate').attr('min', $('#startDate').val());
		});
		//이후날짜 선택불가
		$('#endDate').on('change', function () {
		    $('#startDate').attr('max', $('#endDate').val());
		});
		
		grid.on('click', ()=>{
		    //선택한 행 색깔 바꾸기
		    	  let selectKey = grid.getFocusedCell().rowKey;
		    	  grid.addRowClassName(selectKey, 'selected-cell');
		    	  //다른 행 선택시 기존에 클릭했던 행은 class제거
		    	  grid.on('focusChange', () => {
		    		  grid.removeRowClassName(selectKey, 'selected-cell');
		    	  })
		})
   

</script>
</body>
</html>