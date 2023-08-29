<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<title>출고 조회</title>
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
#actModal, #prodModal {
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
</style>
</head>
<body>
	<div class="black_bg"></div>
	<h1>완제품 출고 조회</h1>
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
						<p>출고일자</p>
						<input id="startDate" type="date">&nbsp;&nbsp;-&nbsp;&nbsp;<input id="endDate" type="date"> <br>
						<p>출고상태</p>
						<label for="before"><input type="checkbox" id="before" value="before">출고전</label> 
						<label for="comple" style="margin-right: 20px;"><input type="checkbox" id="comple" value="comple">출고완료</label>
						<button type="button" class="btn btn-info btn-icon-text" id="searchBtn">
							<i class="fas fa-search"></i> 검색
						</button>
						<button type="button" class="btn btn-info btn-icon-text" id="searchResetBtn">초기화</button>
					</form>

					<div id="grid">
						<h2>출고 목록</h2>
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
				<input type="text" id="modalSearch">
				<button type="button" class="btn btn-info btn-icon-text" id="modalSearchBtn">검색</button>
				<div id="modal_label"></div>
			</div>
			<div class="m_footer">
				<div class="modal_btn cancle close_btn">CANCLE</div>
			</div>
		</div>
	</div>

	<script>
    //거래처 리스트 모달 시작
    var Grid;
    $("#actModal").click(function () {
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
            console.log(rowKey);
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

    $("#close_btn").click(function () {
        $(".modal").fadeOut();

        Grid.destroy();
    });

    //모달 끝 모달 검색
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
    $("#close_btn").click(function () {
        $(".modal").fadeOut();
        activeScroll();
        let inputContent = $('#modalSearch').val('');
        if (Grid != null && Grid.el != null) {
            Grid.destroy();
        }
    });

    //엑셀 다운로드
    const excelDownload = document.querySelector('.excelDownload');

    document.addEventListener('DOMContentLoaded', () => {
        excelDownload.addEventListener('click', function (e) {
            grid.export('xlsx');
        })
    })

    //거래처 리스트 모달 그리드
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
                    name: 'actCode'
                }, {
                    header: '거래처명',
                    name: 'actName'
                }, {
                    header: '거래상태',
                    name: 'actSts'
                }, {
                    header: '거래처구분',
                    name: 'actKind'
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
                    name: 'prodCode'
                }, {
                    header: '제품명',
                    name: 'prodName'
                }, {
                    header: '제품단위',
                    name: 'prodUnit'
                }, {
                    header: '제품규격',
                    name: 'prodStd'
                }
            ]

        });

        return prodGrid;
    }

    //전체 출고 목록 조회 그리드
    var grid = new tui.Grid({
        el: document.getElementById('grid'),
        data: [<c:forEach items="${outNList}" var="out">
            {
                salesOutCode: "${out.salesOutCode}",
                prodLot: "${out.prodLot}",
                salesOrdDeCode: "${out.salesOrdDeCode}",
                actName: "${out.actName}",
                salesOutAmt: "${out.salesOutAmt}",
                salesOutDate: `<fmt:formatDate value="${out.salesOutDate}" pattern="yyyy-MM-dd"/>`,
                empCode: "${out.empCode}",
                empName: "${out.empName}",
                prodSaveAmt: "${out.prodSaveAmt}",
                prodName: "${out.prodName}"
            }<c:if test="${not status.last}">,</c:if>
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
                header: '출고코드',
                name: 'salesOutCode'
            }, {
                header: '제품LOT',
                name: 'prodLot',
                value: '${out.prodLot}'
            }, {
                header: '제품명',
                name: 'prodName'
            }, {
                header: '상세주문코드',
                name: 'salesOrdDeCode',
                value: '${out.salesOrdDeCode}'
            }, {
                header: '거래처',
                name: 'actName',
                value: '${out.actName}'
            }, {
                header: '재고량',
                name: 'prodSaveAmt',
                formatter(e) {
                	if (e['value'] != null){
	                val = e['value']
	                    .toString()
	                    .replace(/\B(?=(\d{3})+(?!\d))/g, ',');
	                return val;
                	}
	            }
            }, {
                header: '출고량',
                name: 'salesOutAmt',
                formatter(e) {
                	if (e['value'] != null){
	                val = e['value']
	                    .toString()
	                    .replace(/\B(?=(\d{3})+(?!\d))/g, ',');
	                return val;
                	}
	            }
            }, {
                header: '출고일자',
                name: 'salesOutDate',
                className: 'yellow-background'
            }, {
                header: '담당자',
                name: 'empName'
            }, {
                header: '직원코드',
                name: 'empCode',
                hidden: true
            }, {
                header: '출고여부',
                name: 'actCode',
                hidden: true
            }, {
                header: '출고여부',
                name: 'prodCode',
                hidden: true
            }
        ]

    });
    setDisabled();

    //비활성화
    function setDisabled() {
        $.each(grid.getData(), function (idx, obj) {

            if (obj['salesOutCode'] != null && (obj['prodSaveAmt'] < 1)) {
                grid.disableRow(obj['rowKey']);
            }
        })
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
            url: 'outListFilter',
            method: 'GET',
            data: search,
            success: function (data2) {
                $.each(data2, function (idx, obj) {
                    let date = new Date(obj['salesOutDate']);
                    let year = date.getFullYear(); //0000년 가져오기
                    let month = date.getMonth() + 1; //월은 0부터 시작하니 +1하기
                    let day = date.getDate(); //일자 가져오기
                    obj['salesOutDate'] = year + "-" + (
                        ("00" + month.toString()).slice(-2)
                    ) + "-" + (
                        ("00" + day.toString()).slice(-2)
                    );

                })
                grid.resetData(data2);
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
	</script>
</body>
</html>