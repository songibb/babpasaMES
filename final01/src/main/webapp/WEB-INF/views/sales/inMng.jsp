<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재고 관리</title>

<!-- 토스트 페이지 네이션 -->
<script type="text/javascript" src="https://uicdn.toast.com/tui.code-snippet/latest/tui-code-snippet.js"></script>
<link rel="stylesheet" href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css" />
<script src="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.js"></script>
<!-- 페이지 네이션 끝 -->
<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>

<style>
#save, #delete {
	float: right;
}

h1 {
	font-weight: 700;
	margin-left: 15px;
}

h2 {
	clear: both;
	font-weight: 700;
	display: inline-block;
}
/*grid 날짜 컬럼색*/
.yellow-background {
	background-color: rgb(255, 253, 235);
}

#grid {
	height: 600px;
}

.modal_content {
	/*모달창 크기 조절*/
	width: 600px;
	height: 700px;
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

.m_body>p {
	display: inline-block;
}

.m_body>input {
	border: 1px solid black;
}

.yellow-background {
	background-color: rgb(255, 253, 235);
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

form p {
	width: 80px;
	display: inline-block;
	font-size: 20px;
}

form {
	margin-bottom: 35px;
}

.excelDownload {
	margin-top: 5px;
	float: right;
}

#prodNameFix {
	background-color: #868e96;
	border-color: #868e96;
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
	<h1>완제품 입고 관리</h1>
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
						<p>입고일자</p>
						<input id="startDate" type="date">&nbsp;&nbsp;-&nbsp;
						<input id="endDate" type="date">
						<button type="button" class="btn btn btn-info btn-icon-text btn-info2 btn-icon-text2" id="todayBtn">오늘</button>
						<button type="button" class="btn btn btn-info btn-icon-text btn-info2 btn-icon-text2" id="weekBtn">일주일</button>
						<button type="button" class="btn btn btn-info btn-icon-text btn-info2 btn-icon-text2" id=monthBtn>한달</button>
						<button type="button" class="btn btn-info btn-icon-text" id="searchBtn" style="margin-left: 8px;">
							<i class="fas fa-search"></i> 검색
						</button>
						<button type="button" class="btn btn-info btn-icon-text" id="searchResetBtn">초기화</button>
					</form>
					<h2>검수 완료된 완제품 목록</h2>
					<br>
					<div id="grid2"></div>
					<div id="grid">
						<h2>입고 목록</h2>
						<button type="button" class="btn btn-info btn-icon-text excelDownload">
							Excel <i class="bi bi-printer"></i>
						</button>
						<button class="btn btn-info btn-icon-text" id="save">저장</button>
						<button class="btn btn-info btn-icon-text" id="delete">삭제</button>
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
				<input type="text" id="modalSearch" style="width: 164px;">
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
	
    // 입고 목록
    var inGrid = new tui.Grid({
        el: document.getElementById('grid'),
//         data: [<c:forEach items="${inMngList}" var="in">
//             {
//                 prodLot: "${in.prodLot}",
//                 salesInDate: `<fmt:formatDate value="${in.salesInDate}" pattern="yyyy-MM-dd"/>`,
//                 salesInAmt: "${in.salesInAmt}",
//                 prodSaveAmt: "${in.prodSaveAmt}",
//                 salesInExd: `<fmt:formatDate value="${in.salesInExd}" pattern="yyyy-MM-dd"/>`,
//                 empCode: "${in.empCode}",
//                 empName: "${in.empName}",
//                 testNum: "${in.testNum}",
//                 prodName: "${in.prodName}"
//             },
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
        pagination: true,
        pageOptions: {
            useClient: true,
            perPage: 10
        },
        columns: [

            {
                header: '제품LOT',
                name: 'prodLot',
                sortable: true,
                sortingType: 'asc',
                align: 'center'
            }, {
                header: '제품명',
                name: 'prodName'
            }, {
                header: '입고일자',
                name: 'salesInDate',
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
                header: '입고량',
                name: 'salesInAmt',
                editor: 'text',
                formatter(e) {
                	if (e['value'] != null) {
                        val = e['value']
                            .toString()
                            .replace(/\B(?=(\d{3})+(?!\d))/g, ',');
                        return val;
                    }
                },
                align: 'right'
            }, {
                header: '재고량',
                name: 'prodSaveAmt',
                editor: 'text',
                formatter(e) {
                	if (e['value'] != null) {
                        val = e['value']
                            .toString()
                            .replace(/\B(?=(\d{3})+(?!\d))/g, ',');
                        return val;
                    }
                },
                align: 'right'
            }, {
                header: '유통기한',
                name: 'salesInExd',
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
                header: '직원코드', // [필수] 컬럼 이름
                name: 'empCode', // [필수] 컬럼 매핑 이름 값
                hidden: true
            }, {
                header: '담당자', // [필수] 컬럼 이름
                name: 'empName',
                align: 'center' // [필수] 컬럼 매핑 이름 값
            }, {
                header: '검사번호', // [필수] 컬럼 이름
                name: 'testNum', // [필수] 컬럼 매핑 이름 값
                hidden: true // [선택] 숨김 여부
            }

        ]
    });
    
  //입고조회(오늘 날짜)
	let searchObj = {};
 	searchObj['startDate'] = getToday();
 	searchObj['endDate'] = getToday();

	$.ajax({
        url : "inListFilter",
        method :"GET",
        data : searchObj,
        success : function(data){
        	
        		//날짜 츨력 포맷 변경
			      $.each(data, function (idx, obj) {
                    let date = new Date(obj['salesInDate']);
                    let year = date.getFullYear(); //0000년 가져오기
                    let month = date.getMonth() + 1; //월은 0부터 시작하니 +1하기
                    let day = date.getDate(); //일자 가져오기
                    obj['salesInDate'] = year + "-" + (
                        ("00" + month.toString()).slice(-2)
                    ) + "-" + (
                        ("00" + day.toString()).slice(-2)
                    );
                    
                    date = new Date(obj['salesInExd']);
                    year = date.getFullYear(); //0000년 가져오기
                    month = date.getMonth() + 1; //월은 0부터 시작하니 +1하기
                    day = date.getDate(); //일자 가져오기
                    obj['salesInExd'] = year + "-" + (
                        ("00" + month.toString()).slice(-2)
                    ) + "-" + (
                        ("00" + day.toString()).slice(-2)
                    );

                })
        	inGrid.resetData(data);
        },
        error : function(reject){
 			console.log(reject);
 		}
	});

    //조건맞는 행(추가되는 행)인지 체크
    function checkChangeable(ev) {
        var rowKey = ev.rowKey;
        var rows = inGrid.findRows({prodLot: null});

        let flag = false;
        $.each(rows, function (idx, obj) {
            if (obj['rowKey'] == rowKey) {
                flag = true;
                return false;
            }
        });

        return flag;
    }

    //추가되는 행만 edit가능
    inGrid.on('editingStart', function (ev) {
        let flag = checkChangeable(ev);

        if (!flag) {
            ev.stop();
        }
    });

    inGrid.on('click', ev => {
        let flag = checkChangeable(ev);
        //선택한 행 색깔 바꾸기
        let selectKey = inGrid
            .getFocusedCell()
            .rowKey;
        inGrid.addRowClassName(selectKey, 'selected-cell');
        //다른 행 선택시 기존에 클릭했던 행은 class제거
        inGrid.on('focusChange', () => {
            inGrid.removeRowClassName(selectKey, 'selected-cell');
        })
    })

    //test완료 목록 그리드
    var testGrid = new tui.Grid({
        el: document.getElementById('grid2'),
        data: [<c:forEach items="${CProdList}" var="test">
            {
                testNum: "${test.testNum}",
                prodCode: "${test.prodCode}",
                prodName: "${test.prodName}",
                testDate: `<fmt:formatDate value="${test.testDate}" pattern="yyyy-MM-dd"/>`,
                testAmt: "${test.testAmt}"
            },
        </c:forEach>
            ],
        scrollX: false,
        scrollY: false,
        minBodyHeight: 200,
        rowHeaders: ['rowNum'],
        pagination: true,
        pageOptions: {
            //백엔드와 연동 없이 페이지 네이션 사용가능하게 만듦
            useClient: true,
            perPage: 5
        },
        columns: [
            {
                header: '검사코드',
                name: 'testNum',
                sortable: true,
                sortingType: 'asc',
                align: 'center'
            }, {
                header: '제품코드',
                name: 'prodCode',
                sortable: true,
                sortingType: 'asc',
                align: 'center'
            }, {
                header: '제품명',
                name: 'prodName'
            }, {
                header: '검사일자',
                name: 'testDate',
                className: 'yellow-background',
                sortable: true,
                sortingType: 'asc',
                align: 'center'
            }, {
                header: '검사량',
                name: 'testAmt',
                formatter(e) {
                    if (e['value'] != null) {
                        val = e['value']
                            .toString()
                            .replace(/\B(?=(\d{3})+(?!\d))/g, ',');
                        return val;
                    }
                },
                align: 'right'
            }, {
                header: '제품LOT', // [필수] 컬럼 이름
                name: 'prodLot', // [필수] 컬럼 매핑 이름 값
                hidden: true // [선택] 숨김 여부
            }, {
                header: '입고일자',
                name: 'salesIndate',
                hidden: true
            }, {
                header: '입고량',
                name: 'salesInAmt',
                hidden: true
            }, {
                header: '재고량',
                name: 'prodSaveAmt',
                hidden: true
            }, {
                header: '유통기한',
                name: 'salesInExd',
                hidden: true
            }
        ]

    });

    //삭제버튼
    $('#delete').on("click", ev => {
        let checkList = inGrid.getCheckedRows();

        deleteList = [];
        $.each(checkList, function (idx, obj) {
            deleteObj = {};
            deleteObj['prodLot'] = obj['prodLot'];
            deleteList.push(deleteObj);
        })

        inGrid.removeCheckedRows(false);
        //마우스 커서 없앰
        inGrid.blur();
    });

    //저장버튼
    document
        .getElementById('save')
        .addEventListener('click', saveServer);

    //저장 함수
    function saveServer() {
        inGrid.blur();
        let modifyGridInfo = inGrid.getModifiedRows();

        // 수정된게 없으면 바로 빠져나감

        if (!inGrid.isModified()) {
            swal("", "변경사항이 없습니다", "warning");
            return false;
        }

        //flag가 true = 입력폼이나 수정폼에 빠뜨린 데이터가 없다
        var flag = true;
        //create, modify, delete 포함하는 전체 배열을 도는 each문

        if (inGrid.getModifiedRows().createdRows.length > 0) {

            $.each(inGrid.getModifiedRows().createdRows, function (idx2, obj2) {
                if (obj2['prodCode'] == "" || obj2['salesInDate'] == null || obj2['salesInAmt'] == "" || obj2['prodSaveAmt'] == "" || obj2['salesInExd'] == null || obj2['empCode'] == "") {
                    flag = false;
                    return false;
                }
            })
        }

        if (flag) {
            $.ajax({
                url: 'modifyProdIn',
                method: 'POST',
                data: JSON.stringify(inGrid.getModifiedRows()),
                contentType: 'application/json',
                success: function (data) {
                    swal("성공", "작업이 성공하였습니다.", "success");
                    selectAjax();
                },
                error: function (reject) {
                    console.log(reject);
//                  swal("실패", "작업을 실패했습니다.", "error");
                }
            })
        } else {
            swal("경고", "값이 입력되지 않았습니다.", "warning");
        }

    }

    //검색 또는 DML 후 다시 LIST 불러오는 함수
    function selectAjax() {
        let prod = $('#prodCodeInput').val();

        let sd = $('#startDate').val();
        let ed = $('#endDate').val();

        let search = {
            prodCode: prod,
            startDate: sd,
            endDate: ed
        };
        $.ajax({
            url: 'inListFilter',
            method: 'GET',
            data: search,
            success: function (data2) {

                $.each(data2, function (idx, obj) {

                    let date = new Date(obj['salesInDate']);
                    let year = date.getFullYear(); //0000년 가져오기
                    let month = date.getMonth() + 1; //월은 0부터 시작하니 +1하기
                    let day = date.getDate(); //일자 가져오기
                    obj['salesInDate'] = year + "-" + (
                        ("00" + month.toString()).slice(-2)
                    ) + "-" + (
                        ("00" + day.toString()).slice(-2)
                    );

                    date = new Date(obj['salesInExd']);
                    year = date.getFullYear(); //0000년 가져오기
                    month = date.getMonth() + 1; //월은 0부터 시작하니 +1하기
                    day = date.getDate(); //일자 가져오기
                    obj['salesInExd'] = year + "-" + (
                        ("00" + month.toString()).slice(-2)
                    ) + "-" + (
                        ("00" + day.toString()).slice(-2)
                    );

                })
                inGrid.resetData(data2);
            },
            error: function (reject) {
                console.log(reject);
            }
        });
    }

    //제품 검색 모달창
    var Grid;
    $("#prodModal").click(function () {
        $(".modal").fadeIn();
        preventScroll();
        Grid = createProdGrid();
        $('.modal_title h3').text('제품 목록');
        Grid.on('dblclick', () => {
            let rowKey = Grid
                .getFocusedCell()
                .rowKey;
            let prodCode = Grid.getValue(rowKey, 'prodCode');
            let prodName = Grid.getValue(rowKey, 'prodName');
            $("#prodCodeInput").val(prodCode);
            $("#prodNameFix").val(prodName);

            $("#prodCodeInput").val(prodCode);
            //선택시 모달창 닫기
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

    //제품 모달창 내용 그리드
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

    //검색버튼 검색
    $('#searchBtn').on('click', searchMatIn);
    function searchMatIn(e) {
        let prod = $('#prodCodeInput').val();
        let sd = $('#startDate').val();
        let ed = $('#endDate').val();

        let search = {
            prodCode: prod,
            startDate: getToday(),
            endDate: getToday()
        };
        selectAjax();
    }

    //검색 옆 초기화버튼
    $('#searchResetBtn').on('click', resetInput);
    function resetInput(e) {
        $('input').each(function (idx, obj) {
            obj.value = '';
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

    //엑셀 다운로드
    const excelDownload = document.querySelector('.excelDownload');
    document.addEventListener('DOMContentLoaded', () => {
        excelDownload.addEventListener('click', function (e) {
            inGrid.export('xlsx');
        })
    })

    //상단 그리드 셀 클릭시 하단 그리드로 데이터 넘어가는 이벤트
    testGrid.on('dblclick', () => {
        //선택한 행 색깔 바꾸기
        let selectKey = testGrid
            .getFocusedCell()
            .rowKey;
        testGrid.addRowClassName(selectKey, 'selected-cell');
        //다른 행 선택시 기존에 클릭했던 행은 class제거
        testGrid.on('focusChange', () => {
            testGrid.removeRowClassName(selectKey, 'selected-cell');
        })
        let rowKey = testGrid
            .getFocusedCell()
            .rowKey;

        let testNum = testGrid.getValue(rowKey, 'testNum');
        let prodCode = testGrid.getValue(rowKey, 'prodCode');
        let testAmt = testGrid.getValue(rowKey, 'testAmt');
        let prodLot = testGrid.getValue(rowKey, 'prodLot');

        let now = new Date(); // 현재 날짜 및 시간
        let years = now.getFullYear();
        let months = ('0' + (
            now.getMonth() + 1
        )).substr(-2);
        let days = ('0' + now.getDate()).substr(-2);
        let salesInDate = years + "-" + months + "-" + days;

        let salesInAmt = testGrid.getValue(rowKey, 'salesInAmt');
        let prodSaveAmt = testGrid.getValue(rowKey, 'prodSaveAmt');
        let salesInExd = testGrid.getValue(rowKey, 'salesInExd');
        let prodName = testGrid.getValue(rowKey, 'prodName');
        
        //유통기한 계산
        let today = new Date();
        let year = today.getFullYear();
        let month = ('0' + (today.getMonth() + 1)).slice(-2);
        let day = ('0' + today.getDate()).slice(-2);

        let dateString = year + '-' + month  + '-' + day;

        // Date(YYYY-MM-DD) + n일
        function StringToDate(date, n) {
        	let yyyy = date.substring(0, 4);
        	let mm = date.substring(5, 7);
        	let dd = date.substring(8, 10);
        	mm = Number(mm) - 1;
            
        	let stringNewDate = new Date(yyyy, mm, dd);
        	stringNewDate.setDate(stringNewDate.getDate() + n);
            
        	return stringNewDate.getFullYear() +
        		"-" + ((stringNewDate.getMonth() + 1) > 9 ? (stringNewDate.getMonth() + 1).toString() : "0" + (stringNewDate.getMonth() + 1)) +
        		"-" + (stringNewDate.getDate() > 9 ? stringNewDate.getDate().toString() : "0" + stringNewDate.getDate().toString());
        }

        let expDate = StringToDate(dateString, 365);
        testGrid.removeRow(rowKey);

        testGrid.blur();
        inGrid.appendRow({
            'testNum': testNum, 
            'prodCode': prodCode, 
            'prodName': prodName,
            'prodLot': prodLot,
            'salesInDate': salesInDate,
            'salesInAmt': Math.floor(Number(testAmt) / 50),
            'prodSaveAmt': Math.floor(Number(testAmt) / 50),
            'salesInExd': expDate,
            'empCode': `${user.id}`,
            'empName': `${user.empName}`
        }, {at: 0});

    });
    //이전 날짜 선택불가
    $('#startDate').on('change', function () {
        $('#endDate').attr('min', $('#startDate').val());
    });
    //이후날짜 선택불가
    $('#endDate').on('change', function () {
        $('#startDate').attr('max', $('#endDate').val());
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
    
    document.getElementById('startDate').value = new Date().toISOString().substring(0, 10);
	document.getElementById('endDate').value = new Date().toISOString().substring(0, 10);
</script>
</body>
</html>