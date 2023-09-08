<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>자재 정산 관리</title>
<!-- 토스트 페이지 네이션 -->
<script type="text/javascript"
	src="https://uicdn.toast.com/tui.code-snippet/latest/tui-code-snippet.js"></script>
<link rel="stylesheet"
	href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css" />
<script
	src="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.js"></script>
<!-- 페이지 네이션 끝 -->
<link rel="stylesheet"
	href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
<style>

	
	
	#save, #delete, #dirAdd, .excelDownload {
		margin-top : 0px;
		float : right;
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
	
	#searchP input[type="text"]{
	  width: 15%;
	  padding: 6px;
	  margin-bottom: 15px;
	  border: 1px solid #ccc;
	  border-radius: 4px;
	}
	
	#modalSearch{
		width: 30%;
	  	padding: 6px;
	  	margin-bottom: 15px;
	  	border: 1px solid #ccc;
	  	border-radius: 4px;	
	}
	
	input[type="date"]{
	  width: 15%;
	  padding: 7px;
	  margin-bottom: 15px;
	  border: 1px solid #ccc;
	  border-radius: 4px;
	}
	
	#searchP p{
		width: 80px;
		display: inline-block;
		font-size: 20px;
	}
	
	#searchP label[for="calOutCheck"]{
		margin-right : 20px;
		margin-bottom : 35px;
	}
	
	.yellow-background {
		background-color: rgb(255, 253, 235);
	}
	
	#grid {
		height: 600px;
	}
	
	.modal_content {
		/*모달창 크기 조절*/
		width: 800px;
		height: 700px;
		background: #fff;
		border-radius: 10px;
		/*모달창 위치 조절*/
		position: relative;
		top: 33%;
		left: 39%;
		margin-top: -100px;
		margin-left: -200px;
		text-align: center;
		box-sizing: border-box;
		line-height: 23px;
	}
	
	#m_body_s>p {
		display: inline-block;
	}
	
	
	
	#customtemplateSearchAndButton p{
			width : 100px;
	}
	
	#matNameFix {
		background-color : #868e96;
		border-color: #868e96;
	}
	
	#matModal{
		cursor : pointer;
	}
	
	.selected-cell{
   		background-color: #ffd09e;
	}
	
	td[data-column-name="calCategory"], td[data-column-name="matName"], td[data-column-name="matUnit"], td[data-column-name="matStd"], td[data-column-name="matLot"], td[data-column-name="calAmt"]{
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
<body onbeforeunload="return myFunction()">
	<h1>자재 정산 등록</h1>
	<div class="col-lg-12 stretch-card">
		<div class="card">
			<div class="card-body">
				<div class="table-responsive pt-3">
					
					
					
						<div id="searchP" style="display: flex; justify-content: space-between;">
							<div style="flex: 1;">
								<p>자재명</p>
								<input type="text" id="matCodeInput" placeholder="검색어를 선택하세요" readOnly> <i
									class="bi bi-search" id="matModal"></i>
								<!-- 돋보기 아이콘 -->
								<input type="text" class="blackcolorInputBox" id="matNameFix"
									readonly> <br>
								<p>정산일자</p><input id="startDate" type="date">&nbsp;&nbsp;-&nbsp;&nbsp;<input
									id="endDate" type="date">
								<button type="button" class="btn btn btn-info btn-icon-text btn-info2 btn-icon-text2" id="todayBtn">오늘</button>
								<button type="button" class="btn btn btn-info btn-icon-text btn-info2 btn-icon-text2" id="weekBtn">일주일</button>								
								<button type="reset" class="btn btn btn-info btn-icon-text btn-info2 btn-icon-text2" id="monthBtn">한달</button>
								<br>
								
								<p>정산구분</p>
								<label for="calInCheck"><input type="checkbox"
									id="calInCheck" value="calIn">정산입고</label> <label
									for="calOutCheck"><input type="checkbox"
									id="calOutCheck" value="calOut">정산출고</label>
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
						<h2>정산 목록</h2>
						<button class="btn btn-info btn-icon-text" id="save">저장</button>
						<button class="btn btn-info btn-icon-text" id="dirAdd">행추가</button>
						<button type="button"
						class="btn btn-info btn-icon-text excelDownload">
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
				<div id="m_body_s">
					<p>이름</p>
					<input type="text" id="modalSearch">
					<button type="button" class="btn btn-info btn-icon-text"
						id="modalSearchBtn">검색</button>
				</div>
				<div id="modal_label"></div>
			</div>
			<div class="m_footer">
				<div id="reset_btn">
					<div class="modal_btn cancle" id="resetModal">RESET</div>
				</div>
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
		$("#matModal").click(function (e) {
		    $("#reset_btn").css("display", "none");
		    $(".modal").fadeIn();
		    preventScroll();
		    Grid = createMatGrid();
		    $('.modal_title h3').text('자재 목록');
		    Grid.on('dblclick', () => {
		        let rowKey = Grid
		            .getFocusedCell()
		            .rowKey;
		        let matCode = Grid.getValue(rowKey, 'matCode');
		        let matName = Grid.getValue(rowKey, 'matName');
		        $("#matCodeInput").val(matCode);
		        $("#matNameFix").val(matName);
	
		        $("#matCodeInput").val(matCode);
		        //모달창 닫기
		        if (rowKey != null) {
		            $(".modal").fadeOut();
		            activeScroll();
		            let inputContent = $('#modalSearch').val('');
		            $("#reset_btn").css("display", "block");
		            if (Grid != null && Grid.el != null) {
		                Grid.destroy();
		            }
	
		        }
		    })
		});
	
		$(".close_btn").click(function () {
		    $(".modal").fadeOut();
		    $("#m_body_s p").text("이름");
		    activeScroll();
		    let inputContent = $('#modalSearch').val('');
		    if (Grid != null && Grid.el != null) {
		        Grid.destroy();
		    }
		    $("#reset_btn").css("display", "block");
		    $("#m_body_s").css("display", "block");
		});
		
		var matCode30 = "";
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
		    } else if(title =='LOT 목록'){
		    	//lot모달창 검색
					
		    		console.log(inputContent);
		    		console.log(matCode30);
					let search = {
					        materialCode: matCode30,
					        lotName: inputContent
					    };
					$.ajax({
						url : 'getMatLotList',
						method : 'GET',
						data : search,
						success : function(data){
							
							
								
								/* for (let i of data) {
				                    let date = new Date(i.matExd);
				                    let year = date.getFullYear(); //0000년 가져오기
				                    let month = date.getMonth() + 1; //월은 0부터 시작하니 +1하기
				                    let day = date.getDate(); //일자 가져오기
			
				                    i.matExd = year + "-" + (
				                        ("00" + month.toString()).slice(-2)
				                    ) + "-" + (
				                        ("00" + day.toString()).slice(-2)
				                    );
				                } */
								
								
								Grid.resetData(data);
							
						},
						error : function(reject){
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
	
		//전체조회 그리드
		var grid = new tui.Grid({
		    el: document.getElementById('grid'),
		    data: [<c:forEach items="${calList}" var="cal">
		        {
		            calCode: "${cal.calCode}",
		            calCategory: "${cal.calCategory}",
		            matCode: "${cal.matCode}",
		            matName: "${cal.matName}",
		            matLot: "${cal.matLot}",
		            matUnit: "${cal.matUnit}",
		            matStd: "${cal.matStd}",
		            calBamt: "${cal.calBamt}",
		            calAmt: "${cal.calAmt}",
		            empCode: "${cal.empCode}",
		            empName: "${cal.empName}",
		            <c:if test="${cal.calCategory eq 'I'}">
		                finalAmt : "${cal.calBamt + cal.calAmt}",
		            </c:if>
		            <c:if test="${cal.calCategory eq 'O'}">
		                finalAmt : "${cal.calBamt - cal.calAmt}",
		            </c:if>
		            calDate: `<fmt:formatDate value="${cal.calDate}" pattern="yyyy-MM-dd"/>`
		        },
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
		            header: '정산 코드',
		            name: 'calCode',
		            sortable: true,
		            sortingType: 'asc',
		            align: 'center'
		        }, {
		            header: '정산구분',
		            name: 'calCategory',
		            formatter: 'listItemText',
		            editor: {
		                type: 'select',
		                options: {
		                    listItems: [
		                        {
		                            text: '정산입고',
		                            value: 'I'
		                        }, {
		                            text: '정산출고',
		                            value: 'O'
		                        }
		                    ]
		                }
		            },
		              align: 'center'
		        }, {
		            header: '자재코드',
		            name: 'matCode',
		            hidden: true
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
		            header: '자재 LOT',
		            name: 'matLot',
		            width: 150,
		              align: 'center'
		        }, {
		            header: '기존수량',
		            name: 'calBamt',
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
		            header: '정산수량',
		            name: 'calAmt',
		            editor: 'text',
		            formatter(e) {
		                if (e['value'] != null) {
		                    val = e['value']
		                        .toString()
		                        .replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		                    return val;
		                }
		            },
		            validation: {
		                dataType: 'number',
		                required: true
		            },
		              align: 'right'
		        }, {
		            header: '정산일자',
		            name: 'calDate',
		            className: 'yellow-background',
		              align: 'center'
		        }, {
		            header: '최종수량',
		            name: 'finalAmt',
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
		            header: '담당자',
		            name: 'empName',
		              align: 'center'
		        }, {
		            header: '담당자코드',
		            name: 'empCode',
		            hidden: true
		        }
		    ]
	
		});
	
		//조건맞는 행(추가되는 행)인지 체크
		function checkChangeable(ev) {
		    var rowKey = ev.rowKey;
		    var rows = grid.findRows({calCode: null});
	
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
		grid.on('editingStart', function (ev) {
		    let flag = checkChangeable(ev);
	
		    if (!flag) {
		        ev.stop();
		    }
		});
	
		grid.on('dblclick', ev => {
		    let flag = checkChangeable(ev);
		    var mainRowKey = ev.rowKey;
		    if (flag) {
		        //추가되는 행일 때 더블클릭 시 자재 모달창
		        if (ev.columnName == 'matName' || ev.columnName == 'matUnit' || ev.columnName == 'matStd') {
		            $(".modal").fadeIn();
		            preventScroll();
		            Grid = createMatGrid();
		            $('.modal_title h3').text('자재 목록');
	
		            Grid.on('dblclick', () => {
		                let modalRowKey = Grid
		                    .getFocusedCell()
		                    .rowKey;
		                if (modalRowKey != null) {
		                    let matCode = Grid.getValue(modalRowKey, 'matCode');
		                    let matName = Grid.getValue(modalRowKey, 'matName');
		                    let matUnit = Grid.getValue(modalRowKey, 'matUnit');
		                    let matStd = Grid.getValue(modalRowKey, 'matStd');
		                    grid.blur();
	
		                    grid.setValue(mainRowKey, 'matCode', matCode);
		                    grid.setValue(mainRowKey, 'matName', matName);
		                    grid.setValue(mainRowKey, 'matUnit', matUnit);
		                    grid.setValue(mainRowKey, 'matStd', matStd);
	
		                    $(".modal").fadeOut();
		                    activeScroll();
		                    let inputContent = $('#modalSearch').val('');
		                    if (Grid != null && Grid.el != null) {
		                        Grid.destroy();
		                    }
	
		                }
	
		            });
	
		            $('#resetModal').on('click', e => {
		                grid.setValue(mainRowKey, 'matCode', '');
		                grid.setValue(mainRowKey, 'matName', '');
		                grid.setValue(mainRowKey, 'matUnit', '');
		                grid.setValue(mainRowKey, 'matStd', '');
	
		                $(".modal").fadeOut();
		                activeScroll();
		                let inputContent = $('#modalSearch').val('');
		                if (Grid != null && Grid.el != null) {
		                    Grid.destroy();
		                }
		                $("#m_body_s").css("display", "block");
		            })
		        } else if (ev.columnName == 'matLot' || ev.columnName == 'matBamt') {
	
		            $("#m_body_s p").text("LOT 이름");
		            var matCode30 = grid.getValue(mainRowKey, 'matCode');
		            //var selectMatCode = grid.getValue(mainRowKey, 'matCode');
	
		            Grid = createLotGrid(matCode30);
		            Grid.refreshLayout();
		            $(".modal").fadeIn();
		            preventScroll();
		            $('.modal_title h3').text('LOT 목록');
	
		            Grid.on('dblclick', ev => {
		                let modalRowKey = Grid
		                    .getFocusedCell()
		                    .rowKey;
		                //이미 해당 LOT로 등록된 행이 있으면 등록 할 수 없게 함
		                let matLot = Grid.getValue(modalRowKey, 'matLot');
	
		                let modifyGridInfo = grid.getModifiedRows();
		                let isNotExist = true;
	
		                $.each(grid.getModifiedRows().createdRows, function (idx, obj) {
	
		                    if (obj['matLot'] == matLot) {
		                        isNotExist = false;
		                        swal("경고", "이미 해당 LOT로 등록된 행이 존재합니다", "warning");
		                        return false;
		                    }
		                })
	
		                // ------------------------------------------------------
		                if (isNotExist) {
		                    if (modalRowKey != null) {
		                        let matLot = Grid.getValue(modalRowKey, 'matLot');
		                        let matStock = Grid.getValue(modalRowKey, 'matStock');
		                        let matCode = Grid.getValue(modalRowKey, 'matCode');
		                        let matName = Grid.getValue(modalRowKey, 'matName');
		                        let matUnit = Grid.getValue(modalRowKey, 'matUnit');
		                        let matStd = Grid.getValue(modalRowKey, 'matStd');
		                        grid.blur();
	
		                        grid.setValue(mainRowKey, 'matLot', matLot);
		                        grid.setValue(mainRowKey, 'calBamt', matStock);
		                        grid.setValue(mainRowKey, 'matCode', matCode);
		                        grid.setValue(mainRowKey, 'matName', matName);
		                        grid.setValue(mainRowKey, 'matUnit', matUnit);
		                        grid.setValue(mainRowKey, 'matStd', matStd);
		                    }
	
		                    $(".modal").fadeOut();
		                    activeScroll();
		                    let inputContent = $('#modalSearch').val('');
		                    if (Grid != null && Grid.el != null) {
		                        Grid.destroy();
		                    }
		                    $("#m_body_s").css("display", "block");
		                    $("#m_body_s p").text("이름");
		                }
	
		            });
	
		            $('#resetModal').on('click', e => {
		                grid.setValue(mainRowKey, 'matLot', '');
		                grid.setValue(mainRowKey, 'calBamt', '');
	
		                $(".modal").fadeOut();
		                $("#m_body_s p").text("이름");
		                activeScroll();
		                let inputContent = $('#modalSearch').val('');
		                if (Grid != null && Grid.el != null) {
		                    Grid.destroy();
		                }
		                $("#m_body_s").css("display", "block");
		            })
		        }
		    }
		});
	
		//lot그리드
		function createLotGrid(selectMatCode) {
		    var lotGrid = new tui.Grid({
		        el: document.getElementById('modal_label'),
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
		            }, {
		                header: '자재 LOT',
		                name: 'matLot',
		                align: 'center'
		            }, {
		                header: '현재고량',
		                name: 'matStock',
		                formatter(e) {
		                    if (e['value'] != null) {
		                        val = e['value']
		                            .toString()
		                            .replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		                        return val;
		                    }
		                },
		                align: 'right'
		            }
		        ]
	
		    });
	
		    $.ajax({
		        url: 'getMatLotList',
		        method: 'GET',
		        data: {
		            materialCode: selectMatCode
		        },
		        success: function (data) {
		            lotGrid.resetData(data);
		        },
		        error: function (reject) {
		            console.log(reject);
		        }
		    })
	
		    return lotGrid;
		}
		
		
	
		//자동 계산
		grid.on('afterChange', (ev) => {
	
		    let change = ev.changes[0];
		    let rowData = grid.getRow(change.rowKey);
		    
		    
	
		    if (change.columnName == 'calBamt' || change.columnName == 'calAmt' || change.columnName == 'calCategory') {
		        if (rowData.calBamt != null && rowData.calAmt != null && rowData.calCategory != null) {
		            let finalAmt;
		            if (rowData.calCategory == 'I') {
		                finalAmt = Number(rowData.calBamt) + Number(rowData.calAmt);
		                grid.setValue(change.rowKey, 'finalAmt', finalAmt);
		            } else if (rowData.calCategory == 'O') {
	
		                finalAmt = Number(rowData.calBamt) - Number(rowData.calAmt);
		                if (finalAmt < 0) {
		                    swal("경고", "기존수량을 넘을 수 없습니다", "warning");
		                    grid.setValue(change.rowKey, 'calAmt', rowData.calBamt);
		                    grid.setValue(change.rowKey, 'finalAmt', 0);
		                } else {
		                    grid.setValue(change.rowKey, 'finalAmt', finalAmt);
		                }
		            }
		        }
		    } else if(change.columnName == 'matCode'){
		    	matCode30 = rowData.matCode;
		    }
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
	
		//저장버튼
		document
		    .getElementById('save')
		    .addEventListener('click', saveServer);
	
		//저장 함수
		function saveServer() {
		    grid.blur();
		    let modifyGridInfo = grid.getModifiedRows();
	
		    // 수정된게 없으면 바로 빠져나감
	
		    if (!grid.isModified()) {
		        swal("경고", "변경사항이 없습니다", "warning");
		        return false;
		    }
	
		    var flag = true;
	
		    if (grid.getModifiedRows().createdRows.length > 0) {
		        $.each(grid.getModifiedRows().createdRows, function (idx2, obj2) {
		            if (obj2['calCategory'] == "" || obj2['calCategory'] == null || obj2['matName'] == "" || obj2['matName'] == null || obj2['matUnit'] == "" || obj2['matUnit'] == null ||obj2['matStd'] == "" ||obj2['matStd'] == null ||obj2['matLot'] == "" || obj2['matLot'] == null || obj2['calAmt'] == "" || obj2['calAmt'] == null) {
		                flag = false;
		                return false;
		            }
		        })
		    }
	
		    if (flag) {
		        $.ajax({
		            url: 'matCalDirSave',
		            method: 'POST',
		            data: JSON.stringify(grid.getModifiedRows()),
		            contentType: 'application/json',
		            success: function (data) {
		                swal("성공", data + "건이 처리되었습니다.", "success");
		                searchMatCal();
		            },
		            error: function (reject) {
		                swal("실패", "", "error");
		            }
		        })
		    } else {
		        swal("경고", "값이 입력되지 않았습니다", "warning");
		    }
	
		}
	
		//검색
		$('#searchBtn').on('click', searchMatCal);
	
		function searchMatCal() {
		    let mat = $('#matCodeInput').val();
		    let calIn = '1';
		    let calOut = '1';
		    let calInCheck = document.getElementById('calInCheck');
		    let calOutCheck = document.getElementById('calOutCheck');
		    if (calInCheck.checked && !calOutCheck.checked) {
		        calOut = '2';
		    } else if (!calInCheck.checked && calOutCheck.checked) {
		        calIn = '2';
		    }
		    let sd = $('#startDate').val();
		    let ed = $('#endDate').val();
	
		    let search = {
		        materialCode: mat,
		        calIn: calIn,
		        calOut: calOut,
		        startDate: sd,
		        endDate: ed
		    };
		    $.ajax({
		        url: 'matCalFilterList',
		        method: 'GET',
		        data: search,
		        success: function (data) {
	
		            for (let i of data) {
		                let date = new Date(i.calDate);
		                let year = date.getFullYear(); //0000년 가져오기
		                let month = date.getMonth() + 1; //월은 0부터 시작하니 +1하기
		                let day = date.getDate(); //일자 가져오기
		                i.calDate = year + "-" + (
		                    ("00" + month.toString()).slice(-2)
		                ) + "-" + (
		                    ("00" + day.toString()).slice(-2)
		                );
	
		                if (i.calCategory == 'I') {
		                    i.finalAmt = i.calBamt + i.calAmt;
		                } else {
		                    i.finalAmt = i.calBamt - i.calAmt;
		                }
	
		            }
		            grid.resetData(data);
		        },
		        error: function (reject) {
		            console.log(reject);
		        }
		    });
		}
	
		document
		    .getElementById('dirAdd')
		    .addEventListener('click', addDirRow);
		//행추가 버튼 클릭시 상세생산지시 행 추가
	
		function addDirRow() {
	
		    //거래처가 등록되어 있을 경우 행추가 허용
		    let now = new Date(); // 현재 날짜 및 시간
		    let year = now.getFullYear();
		    let month = ('0' + (
		        now.getMonth() + 1
		    )).substr(-2);
		    let day = ('0' + now.getDate()).substr(-2);
		    let calDate = year + "-" + month + "-" + day;
	
		    grid.appendRow({
		        'calDate': calDate,
		        'empCode': `${user.id}`,
		        'empName': `${user.empName}`
		    }, {at: 0});
	
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
		
	
		//수정중일때 페이지 나가면 경고창 출력
		$(document).ready(function(){ 
		    window.onbeforeunload = function(){
		        if(grid.isModified()){
		        	doExit();
		        }
		    };
		});
		
		function doExit(){
		    event.returnValue = '"페이지를 벗어 나시겠습니까?"';
		}
		
		
		
		
		
</script>
</body>
</html>