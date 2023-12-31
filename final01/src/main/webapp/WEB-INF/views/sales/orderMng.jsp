<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 관리</title>

<!-- 토스트 페이지 네이션 -->
<script type="text/javascript"src="https://uicdn.toast.com/tui.code-snippet/latest/tui-code-snippet.js"></script>
<link rel="stylesheet"href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css" />
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
<link rel="stylesheet" href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" />

<style>
h1 {
	font-weight: 700;
	margin-left: 15px;
}

h2 {
	clear: both;
	font-weight: 700;
	display: inline-block;
}

body {
	font-family: 'Nanum Gothic', sans-serif;
	font-family: 'Noto Sans KR', sans-serif;
}

.m_body>p {
	display: inline-block;
}

.m_body>input {
	border: 1px solid black;
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

.col-lg-12 stretch-card {
	margin-top: 30px;
}

#customtemplateSearchAndButton {
	margin-bottom: 80px;
	float: left;
}

#customtemplateSearchAndButton input, #modalTitle input {
	border: 1px solid black;
	display: inline-block;
}

#customtemplateSearchAndButton p, #modalTitle p {
	display: inline-block;
	padding-bottom: 10px;
	padding-right: 10px;
}

#customtemplateSearchAndButton .blackcolorInputBox {
	background-color: #868e96;
}

.btn-icon-text {
	margin: 5px;
	padding: 7px;
	border-radius: 9px;
	height: 33px;
}

.excelDownload {
	float: right;
}

/*모달시작*/
#actModal, #prodModal, #delete {
	cursor: pointer;
}

.modal {
	position: absolute;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.8);
	top: 0;
	left: 0;
	display: none;
}

.modal_content {
	/*모달창 크기 조절*/
	width: 600px;
	height: 600px;
	background: #fff;
	border-radius: 10px;
	/*모달창 위치 조절*/
	position: relative;
	top: 33%;
	left: 45%;
	margin-top: -100px;
	margin-left: -200px;
	text-align: center;
	box-sizing: border-box;
	line-height: 23px;
}

.m_head {
	height: 10%;
	margin: 0;
	/*제목 높낮이 조절*/
	padding: 17px;
	display: flex;
	justify-content: space-between;
	background-color: rgb(232, 143, 33);
	border-top-left-radius: 10px;
	border-top-right-radius: 10px;
}

.close_btn {
	font-size: 20px;
	color: black;
	font-weight: 900;
	cursor: pointer;
}

.modal_btn {
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

.m_head {
	height: 10%;
	padding: 20px;
	display: flex;
	justify-content: space-between;
	border-top-left-radius: 10px;
	border-top-right-radius: 10px;
	font-family: sans-serif;
}

.m_body {
	height: 80%;
	padding: 20px;
}

.m_footer {
	height: 10%;
	padding: 15px;
	border-bottom-left-radius: 10px;
	border-bottom-right-radius: 10px;
	display: flex;
	justify-content: end;
}

.cancle {
	background-color: black;
	color: white;
}

.save {
	background-color: black;
	color: white;
}
/*모달끝*/
.yellow-background {
	background-color: rgb(255, 253, 235);
}

#save, #delete, #dirAdd {
	float: right;
}

input[type="text"], select {
	width: 15%;
	padding: 6px;
	margin-bottom: 15px;
	border: 1px solid #ccc;
	border-radius: 4px;
}

input[type="date"], select {
	width: 15%;
	padding: 5px;
	margin-bottom: 15px;
	border: 1px solid #ccc;
	border-radius: 4px;
}

select {
	background-color: white;
}

form p {
	width: 80px;
	display: inline-block;
	font-size: 20px;
}

form {
	margin-bottom: 35px;
}

#prodNameFix, #actNameFix {
	background-color: #868e96;
	border-color: #868e96;
}

.selected-cell{
   background-color: #ffd09e;
}

td[data-column-name="actName"], td[data-column-name="prodName"], td[data-column-name="prcsRqAmt"], td[data-column-name="devDate"]{
		cursor : pointer;
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
#weekBtn:hover{
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
	<div class="black_bg"></div>
	<h1>주문 관리</h1>
	<div class="col-lg-12 stretch-card">
		<div class="card">
			<div class="card-body">
				<div class="table-responsive pt-3">
					<form>
						<p>제품명</p>
						<input type="text" placeholder="검색어를 선택하세요" id="prodCodeInput" readonly>
						<i class="bi bi-search" id="prodModal"></i>
						<!-- 돋보기 아이콘 -->
						<input type="text" class="blackcolorInputBox" id="prodNameFix" readonly> 
						<br>
						<p>거래처</p>
						<input type="text" placeholder="검색어를 입력하세요" id="actCodeInput" readonly>
						<i class="bi bi-search" id="actModal"></i> <input type="text" class="blackcolorInputBox" id="actNameFix" readonly> 
						<br>
						<p>주문일자</p>
						<input id="startDate" type="date">&nbsp;&nbsp;-&nbsp;&nbsp;<input id="endDate" type="date"> 
						<button type="button" class="btn btn btn-info btn-icon-text btn-info2 btn-icon-text2" id="todayBtn">오늘</button>
						<button type="button" class="btn btn btn-info btn-icon-text btn-info2 btn-icon-text2" id="weekBtn">일주일</button>
						<button type="button" class="btn btn btn-info btn-icon-text btn-info2 btn-icon-text2" id=monthBtn>한달</button>
						<br>
						<p>출고상태</p>
						<label for="before"><input type="checkbox" id="before" value="before">출고전</label> 
						<label for="comple" style="margin-right: 20px;"><input type="checkbox" id="comple" value="comple">출고완료</label>
						<button type="button" class="btn btn-info btn-icon-text" id="searchBtn">
							<i class="fas fa-search"></i> 검색
						</button>
						<button type="button" class="btn btn-info btn-icon-text" id="searchResetBtn">초기화</button>
					</form>
					<div id="grid">
						<h2>주문 목록</h2>
						<button class="btn btn-info btn-icon-text" id="save">저장</button>
						<button class="btn btn-info btn-icon-text" id="delete">삭제</button>
						<button class="btn btn-info btn-icon-text" id="dirAdd">행추가</button>
						<button type="button" class="btn btn-info btn-icon-text excelDownload">
							Excel <i class="bi bi-printer"></i>
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div class="modal">
		<div class="modal_content">
			<div class="m_head">
				<div class="modal_title">
					<h3>목록</h3>
				</div>
				<div class="close_btn" id="close_btn">X</div>
			</div>
			<div class="m_body">
				<p>이름</p>
				<input type="text" id="modalSearch" style=" width: 164px;">
				<button type="button" class="btn btn-info btn-icon-text" id="modalSearchBtn">검색</button>
				<div id="modal_label"></div>
			</div>
			<div class="m_footer">
				<div class="modal_btn cancle close_btn" id="cancle_btn">CANCLE</div>
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
	
    document
        .getElementById('save')
        .addEventListener('click', saveServer);
    document
        .getElementById('dirAdd')
        .addEventListener('click', addDirRow);
    
    //삭제버튼
    $('#delete').on("click", function () {
        //그리드에서 행 지움
        orderGrid.removeCheckedRows(false);
        //마우스 커서 없앰
        orderGrid.blur();
    });

    //행추가 버튼 클릭시 주문등록 행 추가
    function addDirRow() {
        let now = new Date(); // 현재 날짜 및 시간
        let year = now.getFullYear();
        let month = ('0' + (
            now.getMonth() + 1
        )).substr(-2);
        let day = ('0' + now.getDate()).substr(-2);
        let ordDate = year + "-" + month + "-" + day;
        if (orderGrid.getModifiedRows().createdRows.length > 0) {
            orderGrid.appendRow({
                'ordDate': ordDate,
                'empCode': `${user.id}`,
                'empName': `${user.empName}`,
                'actName': orderGrid
                    .getModifiedRows()
                    .createdRows[0]
                    .actName
            }, {at: 0});
        } else {
            orderGrid.appendRow({
                'ordDate': ordDate,
                'empCode': `${user.id}`,
                'empName': `${user.empName}`
            }, {at: 0});
        }
    }

    //주문 form
    var orderGrid = new tui.Grid({
        el: document.getElementById('grid'),
//         data: [<c:forEach items="${orderNList}" var="order" varStatus="status">
//             {
//                 salesOrdDeCode: "${order.salesOrdDeCode}",
//                 ordDate: "<fmt:formatDate value='${order.ordDate}' pattern='yyyy-MM-dd'/>",
//                 actName: "${order.actName}",
//                 ordSts: "${order.ordSts}",
//                 prodName: "${order.prodName}",
//                 prcsRqAmt: "${order.prcsRqAmt}",
//                 devDate: "<fmt:formatDate value='${order.devDate}' pattern='yyyy-MM-dd'/>",
//                 devYn: "${order.devYn}",
//                 empCode: "${order.empCode}",
//                 empName: "${order.empName}",
//                 prodCode: "${order.prodCode}",
//                 ordCode: "${order.ordCode}"
//             }<c:if test="${not status.last}">,</c:if>
//         </c:forEach>
//             ],
        scrollX: false,
        scrollY: false,
        minBodyHeight: 400,
        rowHeaders: [
            {
                type: 'rowNum'
            }, {
                type: 'checkbox'
            }
        ],
        pageOptions: {
            useClient: true,
            perPage: 10
        },
        columns: [
            // header : [필수] 컬럼 이름 name : [필수] 컬럼 매핑 이름 값 hidden : [선택] 숨김 여부
            {
                header: '주문상세코드',
                name: 'salesOrdDeCode',
                sortable: true,
                sortingType: 'asc',
                align: 'center'
            }, {
                header: '주문날짜',
                name: 'ordDate',
                value: '${order.ordDate}',
                editor: {
                    type: 'datePicker',
                    options: {
                        language: 'ko'
                    },
                    sortable: true,
                    sortingType: 'asc'
                },
                className: 'yellow-background',
                align: 'center'
            }, {
                header: '거래처',
                name: 'actName',
                editor: 'text',
                value: '${order.actName}'
            }, {
                header: '생산계획상태',
                name: 'ordSts',
                formatter: function (e) {
                    if (e.value == 'P1') {
                        return "계획전";
                    } else if (e.value == 'P2') {
                        return "계획완료";
                    }
                }
            }, {
                header: '제품명',
                name: 'prodName',
                editor: 'text'
            }, {
                header: '주문량',
                name: 'prcsRqAmt',
                editor: 'text',
                formatter(e) {
                    if (e['value'] != null) {
                        val = e['value']
                            .toString()
                            .replace(/\B(?=(\d{3})+(?!\d))/g, ',');
                        return val;
                    }
                },
                sortable: true,
                sortingType: 'asc',
                align: 'right'
            }, {
                header: '납기일자',
                name: 'devDate',
                editor: {
                    type: 'datePicker',
                    options: {
                        language: 'ko'
                    }
                },
                className: 'yellow-background',
                sortable: true,
                sortingType: 'asc',
                align: 'center'
            }, {
                header: '출고여부',
                name: 'devYn',
                value: '${order.devYn}',
                formatter: function (e) {
                    if (e.value == 'Y') {
                        return "출고완료";
                    } else if (e.value == 'N') {
                        return "출고전";
                    }
                }
            }, {
                header: '주문코드',
                name: 'ordCode',
                hidden: true
            }, {
                header: '거래처코드',
                name: 'actCode',
                hidden: true
            }, {
                header: '담당자',
                name: 'empName',
                align: 'center'
            }, {
                header: '생산계획코드',
                name: 'prcsPlanCode',
                hidden: true
            }, {
                header: '제품코드',
                name: 'prodCode',
                hidden: true
            }, {
                header: '직원코드',
                name: 'empCode',
                hidden: true
            }
        ]
    });
    setDisabled();
    
  //주문조회(오늘 날짜)
	let searchObj = {};
 	searchObj['startDate'] = getToday();
 	searchObj['endDate'] = getToday();

	$.ajax({
        url : "orderMngFilter",
        method :"GET",
        data : searchObj,
        success : function(data){
        	
       		//날짜 츨력 포맷 변경
		      $.each(data, function (idx, obj) {
	    	  	let date = new Date(obj['ordDate']);
                let year = date.getFullYear(); //0000년 가져오기
                let month = date.getMonth() + 1; //월은 0부터 시작하니 +1하기
                let day = date.getDate(); //일자 가져오기
                obj['ordDate'] = year + "-" + (
                    ("00" + month.toString()).slice(-2)
                ) + "-" + (
                    ("00" + day.toString()).slice(-2)
                );

                date = new Date(obj['devDate']);
                year = date.getFullYear(); //0000년 가져오기
                month = date.getMonth() + 1; //월은 0부터 시작하니 +1하기
                day = date.getDate(); //일자 가져오기
                obj['devDate'] = year + "-" + (
                    ("00" + month.toString()).slice(-2)
                ) + "-" + (
                    ("00" + day.toString()).slice(-2)
                );
               })
        	orderGrid.resetData(data);
	      	setDisabled();
        },
        error : function(reject){
 			console.log(reject);
 		}
	});

    //비활성화
    function setDisabled() {
        $.each(orderGrid.getData(), function (idx, obj) {

            if (obj['ordCode'] != null && (obj['ordSts'] == 'P2')) {
                orderGrid.disableRow(obj['rowKey']);
            }
        })
    }

    //거래처명, 자재명, 담당자명 클릭하면 모달창 나온 후 선택할 수 있음. 선택 시 hidden cell에 데이터 넘어감
    var Grid;

    //거래처 리스트 모달 시작
    $("#actModal").click(function (ev) {
        $(".modal").fadeIn();
        preventScroll();
        Grid = createActGrid();
        $('.modal_title h3').text('거래처 목록');
        Grid.on('click', () => {
            let rowKey = Grid
                .getFocusedCell()
                .rowKey;
            let actCode = Grid.getValue(rowKey, 'actCode');
            let actName = Grid.getValue(rowKey, 'actName');
            $("#actCodeInput").val(actCode);
            $("#actNameFix").val(actName);
            //모달창 닫기
            if (rowKey != null) {
                $(".modal").fadeOut();
                Grid.destroy();
            }

        });
    });

    //제품 리스트 모달 시작
    $("#prodModal").click(function () {
        $(".modal").fadeIn();
        preventScroll();
        Grid = createProdGrid();
        $('.modal_title h3').text('제품 목록');
        Grid.on('click', () => {
            let rowKey = Grid
                .getFocusedCell()
                .rowKey;
            let prodCode = Grid.getValue(rowKey, 'prodCode');
            let prodName = Grid.getValue(rowKey, 'prodName');
            $("#prodCodeInput").val(prodCode);
            $("#prodNameFix").val(prodName);

            $("#prodCodeInput").val(prodCode);
            //모달창 닫기
            if (rowKey != null) {
                $(".modal").fadeOut();
                Grid.destroy();
            }
        });
    });

    orderGrid.on('click', ev => {

        //선택한 행 색깔 바꾸기
        let selectKey = orderGrid
            .getFocusedCell()
            .rowKey;
        orderGrid.addRowClassName(selectKey, 'selected-cell');
        //다른 행 선택시 기존에 클릭했던 행은 class제거
        orderGrid.on('focusChange', () => {
            orderGrid.removeRowClassName(selectKey, 'selected-cell');
        })
        let rowKey = orderGrid
            .getFocusedCell()
            .rowKey;
        let columnName = orderGrid
            .getFocusedCell()
            .columnName;

        let ordCode = orderGrid.getValue(rowKey, 'ordCode');
        if (ordCode != null) {
            ev.stop();
            return false;
        }

        if (columnName == "actName") {
            $(".modal").fadeIn();
            preventScroll();
            Grid = createActGrid();
            $('.modal_title h3').text('거래처 목록');
            Grid.on('click', () => {
                let rowKey2 = Grid
                    .getFocusedCell()
                    .rowKey;
                let actCode = Grid.getValue(rowKey2, 'actCode');
                let actName = Grid.getValue(rowKey2, 'actName');

                let beforeAct = orderGrid
                    .getModifiedRows()
                    .createdRows;
                for (data of beforeAct) {
                    orderGrid.setValue(data.rowKey, 'actCode', actCode);
                    orderGrid.setValue(data.rowKey, 'actName', actName);
                }
                //선택시 모달창 닫기
                if (rowKey2 != null) {
                    $(".modal").fadeOut();
                    Grid.destroy();
                }

            });
        } else if (columnName == 'prodName') {
            $(".modal").fadeIn();
            preventScroll();
            Grid = createProdGrid();
            $('.modal_title h3').text('제품 목록');
            Grid.on('click', () => {
                let rowKey2 = Grid
                    .getFocusedCell()
                    .rowKey;
                let prodCode = Grid.getValue(rowKey2, 'prodCode');
                let prodName = Grid.getValue(rowKey2, 'prodName');
                
                orderGrid.setValue(rowKey, 'prodCode', prodCode);
                orderGrid.setValue(rowKey, 'prodName', prodName);
                //선택시 모달창 닫기
                if (rowKey2 != null) {
                    $(".modal").fadeOut();
                    Grid.destroy();
                }

            });
        } //else if(columnName == 'empName'){ session에서 받아오기

        //}

    });

    //모달 검색
    $('#modalSearchBtn').on('click', function (e) {
        let title = $('.modal_title h3').text();
        let inputContent = $('#modalSearch').val();

        if (title == '제품 목록') {
            let modalSearchData = {
                prodName: inputContent
            }
            $.ajax({
                url: 'getProdModalSearch',
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
                url: 'getActModalSearch',
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

    //모달창 닫기
    $("#close_btn, #cancle_btn").click(function () {
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
            minBodyHeight: 320,
            rowHeaders: ['rowNum'],
            selectionUnit: 'row',
            pagination: true,
            pageOptions: {
                //백엔드와 연동 없이 페이지 네이션 사용가능하게 만듦
                useClient: true,
                perPage: 8
            },
            columns: [
                {
                    header: '거래처코드',
                    name: 'actCode',
                    align: 'center'
                }, {
                    header: '거래처명',
                    name: 'actName'
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

    //제품 리스트 모달 그리드
    function createProdGrid() {
        var prodGrid = new tui.Grid({
            el: document.getElementById('modal_label'),
            data: [<c:forEach items="${prodList}" var="p" varStatus="status">
                {
                    prodCode: "${p.prodCode}",
                    prodName: "${p.prodName}",
                    prodUnit: "${p.prodUnit}",
                    prodStd: "${p.prodStd}"
                }
                <c:if test="${not status.last}">,</c:if>
            </c:forEach>
                ],
            scrollX: false,
            scrollY: false,
            minBodyHeight: 320,
            rowHeaders: ['rowNum'],
            selectionUnit: 'row',
            pagination: true,
            pageOptions: {
                //백엔드와 연동 없이 페이지 네이션 사용가능하게 만듦
                useClient: true,
                perPage: 8
            },
            columns: [
                {
                    header: '제품코드',
                    name: 'prodCode',
                    align: 'center'
                }, {
                    header: '제품명',
                    name: 'prodName'
                }, {
                    header: '제품단위',
                    name: 'prodUnit',
                    align: 'center'
                }, {
                    header: '제품규격',
                    name: 'prodStd',
                    align: 'center'
                }
            ]

        });

        return prodGrid;
    }

    //검색 버튼
    $('#searchBtn').on('click', searchOrderList);
    function searchOrderList(e) {
        let actInsert = $('#actCodeInput').val();
        let prodInsert = $('#prodCodeInput').val();
        let sd = $('#startDate').val();
        let ed = $('#endDate').val();

        let before = '1';
        let comple = '1';
        let beforeCheck = document.getElementById('before');
        let compleCheck = document.getElementById('comple');
        if (beforeCheck.checked && !compleCheck.checked) {
            comple = '2';
        } else if (!beforeCheck.checked && compleCheck.checked) {
            before = '2';
        }

        let search = {
            actCode: actInsert,
            prodCode: prodInsert,
            startDate: sd,
            endDate: ed,
            before: before,
            comple: comple
        };
        $.ajax({
            url: 'orderMngFilter',
            method: 'GET',
            data: search,
            success: function (data2) {

                $.each(data2, function (idx, obj) {
                    let date = new Date(obj['ordDate']);
                    let year = date.getFullYear(); //0000년 가져오기
                    let month = date.getMonth() + 1; //월은 0부터 시작하니 +1하기
                    let day = date.getDate(); //일자 가져오기
                    obj['ordDate'] = year + "-" + (
                        ("00" + month.toString()).slice(-2)
                    ) + "-" + (
                        ("00" + day.toString()).slice(-2)
                    );

                    date = new Date(obj['devDate']);
                    year = date.getFullYear(); //0000년 가져오기
                    month = date.getMonth() + 1; //월은 0부터 시작하니 +1하기
                    day = date.getDate(); //일자 가져오기
                    obj['devDate'] = year + "-" + (
                        ("00" + month.toString()).slice(-2)
                    ) + "-" + (
                        ("00" + day.toString()).slice(-2)
                    );

                })
                orderGrid.resetData(data2);
                setDisabled();
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

    //이전 날짜 선택불가
    $('#startDate').on('change', function () {
        $('#endDate').attr('min', $('#startDate').val());
    });
    //이후날짜 선택불가
    $('#endDate').on('change', function () {
        $('#startDate').attr('max', $('#endDate').val());
    });

    //저장 함수
    function saveServer() {
        orderGrid.blur();
        let modifyGridInfo = orderGrid.getModifiedRows();

        // 수정된게 없으면 바로 빠져나감

        if (!orderGrid.isModified()) {
            swal("", "변경사항이 없습니다", "warning");
            return false;
        }

        //flag가 true = 입력폼이나 수정폼에 빠뜨린 데이터가 없다
        var flag = true;
        //create, modify, delete 포함하는 전체 배열을 도는 each문

        if (orderGrid.getModifiedRows().createdRows.length > 0) {

            $.each(orderGrid.getModifiedRows().createdRows, function (idx2, obj2) {
                if (obj2['ordDate'] == null || obj2['ordDate'] == "" ||
                		obj2['actCode'] == "" || obj2['actCode'] == null ||
                		obj2['prodCode'] == "" || obj2['prodCode'] == null ||
                		obj2['prcsRqAmt'] == "" || obj2['prcsRqAmt'] == null ||
                		obj2['devDate'] == "" || obj2['devDate'] == null ||
                		obj2['empCode'] == "" || obj2['empCode'] == null
                		) {
                    flag = false;
                    return false;
                }
            })
        }

        if (orderGrid.getModifiedRows().updatedRows.length > 0) {

            $.each(orderGrid.getModifiedRows().updatedRows, function (idx2, obj2) {
                if (obj2['prcsRqAmt'] == "" || obj2['prcsRqAmt'] == null ||
                		obj2['devDate'] == "" || obj2['devDate'] == null ||
                		obj2['salesOrdDeCode'] == "" || obj2['salesOrdDeCode'] == null
                		) {
                    flag = false;
                    return false;
                }
            })

        }
        
        if (flag) {
            $.ajax({
                url: 'orderSave',
                method: 'POST',
                data: JSON.stringify(orderGrid.getModifiedRows()),
                contentType: 'application/json',
                success: function (data) {
                    swal("성공", "작업이 성공하였습니다.", "success");
                    //                     orderGrid.resetData(data);
                    searchOrderList();
                    setDisabled();
                    activeScroll();

                },
                error: function (reject) {
                    console.log(reject);
//                     swal("실패", "작업을 실패했습니다.", "error");
                }
            })
        } else {
            swal("경고", "값이 입력되지 않았습니다.", "warning");
        }

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

    //엑셀 다운로드
    const excelDownload = document.querySelector('.excelDownload');

    document.addEventListener('DOMContentLoaded', () => {
        excelDownload.addEventListener('click', function (e) {
            orderGrid.export('xlsx');
        })
    })
    
    //수정중일때 페이지 나가면 경고창 출력
	$(document).ready(function(){ 
	    window.onbeforeunload = function(){
	        if(orderGrid.isModified()){
	        	doExit();
	        }
	    };
	});
	
	function doExit(){
	    event.returnValue = '"저장되지 않은 데이터가 있습니다."';
	}
	
	document.getElementById('startDate').value = new Date().toISOString().substring(0, 10);
	document.getElementById('endDate').value = new Date().toISOString().substring(0, 10);
</script>
</body>
</html>