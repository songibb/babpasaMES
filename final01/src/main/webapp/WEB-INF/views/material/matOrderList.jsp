<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
    <title>자재 발주 목록</title>
<!-- 토스트 페이지 네이션 -->
<script type="text/javascript" src="https://uicdn.toast.com/tui.code-snippet/latest/tui-code-snippet.js"></script>
<link rel="stylesheet" href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css" />
<script src="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.js"></script>
<!-- 페이지 네이션 끝 -->
<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
<style>
	#matModal{
		cursor : pointer;
	}
	
	
	.excelDownload{
		margin-top : 0px;
	}
	h1{
		margin-left: 15px;
	}
	
	h1, h2{
		font-weight: 800;
	}
	
	h2{
		
		display : inline-block;
	}
	
	#searchP input[type="text"] {
	  width: 15%;
	  padding: 6px;
	  margin-bottom: 15px;
	  border: 1px solid #ccc;
	  border-radius: 4px;
	}
	#searchP input[type="date"] {
	  width: 15%;
	  padding: 5px;
	  margin-bottom: 35px;
	  border: 1px solid #ccc;
	  border-radius: 4px;
	}
	
	#searchP input[type="checkbox"]{
		margin-bottom: 35px;
	}
	
	#searchP label[for="comple"]{
		margin-right : 20px;
	}
	
	#searchP p{
		width: 80px;
		display: inline-block;
		font-size: 20px;
	}
	
	.yellow-background {
        background-color: rgb(255,253,235);
	}
	#grid{
		height: 800px;
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
	
	#matNameFix, #actNameFix {
		background-color : #868e96;
		border-color: #868e96;
	}
	
	#modalSearch{
		width: 30%;
	  	padding: 6px;
	  	margin-bottom: 15px;
	  	border: 1px solid #ccc;
	  	border-radius: 4px;	
	}
	
	 #planContainer{ 
 	display: flex; 
 	justify-content: space-between; 
 } 
 #leftGrid{ 
     width: 500px; 
     margin-right: 20px; 
 } 
 #leftGridHeader{ 
 	height: 45px; 
 	display: flex; 
 	justify-content: space-between; 
 } 
 #rightGrid{ 
     width: 1000px; 
 } 
 #rightGridHeader{ 
 	height: 45px; 
 	display: flex; 
 	justify-content: space-between; 
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
   <h1>자재 발주 조회</h1>
   <div class="col-lg-12 stretch-card">
       <div class="card">
           <div class="card-body">
               <div class="table-responsive pt-3">
               		
                   	
                  	
        				<div id="searchP" style="display: flex; justify-content: space-between;">
            				<div style="flex: 1;">
                				
                				<p>거래처</p>
                				<input type="text" id="actCodeInput" placeholder="검색어를 선택하세요" readonly>
                				<i class="bi bi-search" id="actModal"></i>
                				<input type="text" class="blackcolorInputBox" id="actNameFix" readonly>
                				<br>
                				<p>발주일자</p>
                				<input id="startDate" type="date">&nbsp;&nbsp;-&nbsp;&nbsp;<input id="endDate" type="date">
                				<button type="button" class="btn btn btn-info btn-icon-text btn-info2 btn-icon-text2" id="todayBtn">오늘</button>
								<button type="button" class="btn btn btn-info btn-icon-text btn-info2 btn-icon-text2" id="weekBtn">일주일</button>								
								<button type="reset" class="btn btn btn-info btn-icon-text btn-info2 btn-icon-text2" id="monthBtn">한달</button>
                				<button type="button" class="btn btn-info btn-icon-text" id="searchBtn">
                    				<i class="fas fa-search"></i>
                    					검색
                				</button>
                				<button type="button" class="btn btn-info btn-icon-text" id="searchResetBtn">
                    				초기화
                				</button>
            				</div>
        				</div>
	    			<div id="planContainer">
					<div id="leftGrid">
						<div id="leftGridHeader">
							<h2>발주 목록</h2>	
						<button type="button"
						class="btn btn-info btn-icon-text excelDownload">
						Excel <i class="bi bi-printer"></i>
						</button>	            	
							
						</div>
		           		<div id="grid2"></div>					
					</div>
					<div id="rightGrid">
						<div id="rightGridHeader">
							<h2>상세 발주 조회</h2>
						<button type="button"
						class="btn btn-info btn-icon-text excelDownload2">
						Excel <i class="bi bi-printer"></i>
						</button>
										
						</div>		
	           			<div id="grid"></div>
					</div>
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
		$("#actModal").click(function () {
		    $(".modal").fadeIn();
		    preventScroll();
		    Grid = createActGrid();
		    $('.modal_title h3').text('거래처 목록');
		    Grid.on('dblclick', () => {
		        let rowKey = Grid
		            .getFocusedCell()
		            .rowKey;
		        if (rowKey != null) {
		            let actCode = Grid.getValue(rowKey, 'actCode');
		            let actName = Grid.getValue(rowKey, 'actName');
		            $("#actCodeInput").val(actCode);
		            $("#actNameFix").val(actName);
		        }
	
		        //모달창 닫기
	
		        if (rowKey != null) {
		            $(".modal").fadeOut();
		            activeScroll();
		            let inputContent = $('#modalSearch').val('');
		            if (Grid != null && Grid.el != null) {
		                Grid.destroy();
		            }
		        }
	
		    })
		});
	
		$("#matModal").click(function () {
		    $(".modal").fadeIn();
		    preventScroll();
		    Grid = createMatGrid();
		    $('.modal_title h3').text('자재 목록');
		    Grid.on('dblclick', () => {
		        let rowKey = Grid
		            .getFocusedCell()
		            .rowKey;
		        if (rowKey != null) {
		            let matCode = Grid.getValue(rowKey, 'matCode');
		            let matName = Grid.getValue(rowKey, 'matName');
		            $("#matCodeInput").val(matCode);
		            $("#matNameFix").val(matName);
		        }
	
		        //모달창 닫기
		        if (rowKey != null) {
		            $(".modal").fadeOut();
		            activeScroll();
		            let inputContent = $('#modalSearch').val('');
		            if (Grid != null && Grid.el != null) {
		                Grid.destroy();
		            }
	
		        }
		    })
		});
	
		$(".close_btn").click(function () {
		    $(".modal").fadeOut();
		    activeScroll();
		    let inputContent = $('#modalSearch').val('');
		    if (Grid != null && Grid.el != null) {
		        Grid.destroy();
		    }
		});
	
		//거래처 모달 그리드
		function createActGrid() {
		    var actGrid = new tui.Grid({
		        el: document.getElementById('modal_label'),
		        data: [<c:forEach items="${actList}" var="a" varStatus="status">
		            {
		                actCode: "${a.actCode}",
		                actName: "${a.actName}",
		                actSts: "${a.actSts}",
		                actKind: "${a.actKind}"
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
		                header: '거래처코드',
		                name: 'actCode',
			            align: 'center'
		            }, {
		                header: '거래처명',
		                name: 'actName',
			            align: 'left'
		            }, {
		                header: '거래상태',
		                name: 'actSts',
			            align: 'center'
		            }, {
		                header: '거래처구분',
		                name: 'actKind',
			            align: 'center'
		            }
		        ]
	
		    });
	
		    return actGrid;
		}
	
		//자재 모달 그리드
		function createMatGrid() {
		    var matGrid = new tui.Grid({
		        el: document.getElementById('modal_label'),
		        data: [<c:forEach items="${matList}" var="m" varStatus="status">
		            {
		                matCode: "${m.matCode}",
		                matName: "${m.matName}",
		                matUnit: "${m.matUnit}",
		                matStd: "${m.matStd}"
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
		                header: '자재코드',
		                name: 'matCode',
			            align: 'center'
		            }, {
		                header: '자재명',
		                name: 'matName',
			            align: 'left'
		            }, {
		                header: '단위',
		                name: 'matUnit',
			            align: 'left'
		            }, {
		                header: '규격',
		                name: 'matStd',
			            align: 'left'
		            }
		        ]
	
		    });
	
		    return matGrid;
		}
		//모달 끝
	
		$('#modalSearchBtn').on('click', function (e) {
		    let title = $('.modal_title h3').text();
		    let inputContent = $('#modalSearch').val();
	
		    if (title == '자재 목록') {
		        let modalSearchData = {
		            matName: inputContent
		        }
		        $.ajax({
		            url: 'getMatModalSearch',
		            method: 'GET',
		            data: modalSearchData,
		            success: function (data) {
		                
		                Grid.resetData(data);
		            },
		            error: function (reject) {
		                console.log(reject);
		            }
		        })
		    } else if (title == '거래처 목록') {
		        let modalSearchData = {
		            actName: inputContent
		        }
		        $.ajax({
		            url: 'getActMatModalSearch',
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
	
		//검색
		$('#searchBtn').on('click', searchMatIn);
		function searchMatIn(e) {
		    
		    let act = $('#actCodeInput').val();
		    let sd = $('#startDate').val();
		    let ed = $('#endDate').val();
		   
	
		    let search = {
		        
		        accountCode: act,
		        startDate: sd,
		        endDate: ed
		    };
		    $.ajax({
		        url: 'getMatOrderListFilter',
		        method: 'GET',
		        data: search,
		        success: function (data) {
	
		            for (let i of data) {
		                date = new Date(i.matOdRq);
		                year = date.getFullYear();
		                month = date.getMonth() + 1;
		                day = date.getDate();
		                i.matOdRq = year + "-" + (
		                    ("00" + month.toString()).slice(-2)
		                ) + "-" + (
		                    ("00" + day.toString()).slice(-2)
		                );
		            }
		            grid2.resetData(data);
		            let matOdCd;
		            resetOrderDeGrid(matOdCd);
		        },
		        error: function (reject) {
		            console.log(reject);
		        }
		    });
		}
	
		//초기화
		$('#searchResetBtn').on('click', resetInput);
		function resetInput(e) {
		    $('input').each(function (idx, obj) {
		        obj.value = '';
		        obj.checked = false;
		    })
		}
	
		
		
		//헤더 조회 그리드
		var grid2 = new tui.Grid({
		    el: document.getElementById('grid2'),
		    data: [<c:forEach items="${matOrderList}" var="mat" varStatus="status">
		        {
		            matOdCd: "${mat.matOdCd}",
		            actName: "${mat.actName}",
		            empName: "${mat.empName}",
		           
		            matOdRq: `<fmt:formatDate value="${mat.matOdRq}" pattern="yyyy-MM-dd"/>`
		            
		        }<c:if test="${not status.last}">,</c:if>
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
		            header: '발주코드',
		            name: 'matOdCd',
		            width: 150,
		            sortable: true,
		            sortingType: 'asc',
		            align: 'center'
		        }, {
		            header: '발주일자',
		            name: 'matOdRq',
		            className: 'yellow-background',
		            align: 'center'
		        }, {
		            header: '거래처',
		            name: 'actName',
		            align: 'left'
		        }, {
		            header: '담당자',
		            name: 'empName',
		            align: 'center'
		        }
		    ]
	
		});
		
		grid2.on('dblclick', event => {
	        let rowKey = grid2.getFocusedCell().rowKey;
	        let matOdCd = grid2.getValue(rowKey, 'matOdCd');
	        
	        //선택시 모달창 닫기
	        if (rowKey != null && rowKey >= 0) {
	        	resetOrderDeGrid(matOdCd);
	        }

	    });
		
		function resetOrderDeGrid(matOdCd){
			$.ajax({
           		url: 'getMatOrderDeList',
           		method : 'GET',
           		data : { matOdCd : matOdCd },
           		success: function(result){
           			$.each(result, function(idx, obj){
           				obj['matTotalPrice'] = obj['matAmt'] * obj['matPrice'];
           				let date = new Date(obj['matOdAcp']);
		                let year = date.getFullYear(); //0000년 가져오기
		                let month = date.getMonth() + 1; //월은 0부터 시작하니 +1하기
		                let day = date.getDate(); //일자 가져오기
		                obj['matOdAcp'] = year + "-" + (
		                    ("00" + month.toString()).slice(-2)
		                ) + "-" + (
		                    ("00" + day.toString()).slice(-2)
		                );
           			})
           			grid.resetData(result);
           		},
           		error : function(reject){
           			console.log(reject);
           		}
           	})
		}
		
		//상세 조회 그리드
		var grid = new tui.Grid({
		    el: document.getElementById('grid'),
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
		            header: '발주상세코드',
		            name: 'matOdDeCd',
		            width: 150,
		            align: 'center'
		        }, {
		            header: '자재명',
		            name: 'matName',
		            align: 'left'
		        }, {
		            header: '단위',
		            name: 'matUnit',
		            align: 'left'
		        }, {
		            header: '규격',
		            name: 'matStd',
		            align: 'left'
		        }, {
		            header: '단가(원)',
		            name: 'matPrice',
		            formatter(e) {
		                val = e['value']
		                    .toString()
		                    .replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		                return val + "원";
		            },
		            width: 120,
		            align: 'right'
		        }, {
		            header: '발주량',
		            name: 'matAmt',
		            formatter(e) {
		                val = e['value']
		                    .toString()
		                    .replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		                return val;
		            },
		            align: 'right'
		        }, {
		            header: '총액',
		            name: 'matTotalPrice',
		            formatter(e) {
		            	
		            		val = e['value']
		                    .toString()
		                    .replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		                	return val + "원";
		            	
		                
		            },
		            width: 120,
		            align: 'right'
		        },   {
		            header: '납기요청일',
		            name: 'matOdAcp',
		            className: 'yellow-background',
		            align: 'center'
		        }, {
		            header: '검수여부',
		            name: 'matTestYn',
		            formatter: function (e) {
		                if (e.value == 'Y') {
		                    return "검수완료";
		                } else if (e.value == 'N') {
		                    return "검수전";
		                }
		            },
		            align: 'left'
		        }
		    ]
	
		});
	
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
		
		//엑셀 다운로드
		
		const excelDownload = document.querySelector('.excelDownload');
		document.addEventListener('DOMContentLoaded', () => {
		    excelDownload.addEventListener('click', function (e) {
		        grid2.export('xlsx');
		    })
		})
		
		const excelDownload2 = document.querySelector('.excelDownload2');
		document.addEventListener('DOMContentLoaded', () => {
		    excelDownload2.addEventListener('click', function (e) {
		        grid.export('xlsx');
		    })
		})
		
		grid.on('click', ()=>{
		    //선택한 행 색깔 바꾸기
		    	  let selectKey = grid.getFocusedCell().rowKey;
		    	  grid.addRowClassName(selectKey, 'selected-cell');
		    	  //다른 행 선택시 기존에 클릭했던 행은 class제거
		    	  grid.on('focusChange', () => {
		    		  grid.removeRowClassName(selectKey, 'selected-cell');
		    	  })
		})
		
		grid2.on('click', ()=>{
		    //선택한 행 색깔 바꾸기
		    	  let selectKey = grid2.getFocusedCell().rowKey;
		    	  grid2.addRowClassName(selectKey, 'selected-cell');
		    	  //다른 행 선택시 기존에 클릭했던 행은 class제거
		    	  grid2.on('focusChange', () => {
		    		  grid2.removeRowClassName(selectKey, 'selected-cell');
		    	  })
		})
   		
		
		
	</script>
</body>
</html>