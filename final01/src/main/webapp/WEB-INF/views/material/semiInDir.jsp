<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>반제품 입고 관리</title>
<!-- 토스트 페이지 네이션 -->
<script type="text/javascript" src="https://uicdn.toast.com/tui.code-snippet/latest/tui-code-snippet.js"></script>
<link rel="stylesheet" href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css" />
<script src="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.js"></script>
<!-- 페이지 네이션 끝 -->
<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
<style>
	#save, #delete, #dirAdd, .excelDownload{
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
	  margin-bottom: 15px;
	  border: 1px solid #ccc;
	  border-radius: 4px;
	}
	
	#searchP input[type="checkbox"]{
		margin-bottom: 35px;
	}
	
	#searchP label[for="after"]{
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
		height : 600px;
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
	
	td[data-column-name="semiInd"], td[data-column-name="semiExd"]{
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
<body>
   <h1>반제품 입고 관리</h1>
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
	    			
		            <h2>검사 완료된 반제품</h2>
		            <br>
		            <div id="grid2"></div>
		            
		            
		            <div id="grid">
		            	<h2>입고 목록</h2>
			            <button type="button" class="btn btn-info btn-icon-text excelDownload">
	                      	 Excel
	                      	<i class="bi bi-printer"></i>                                                                              
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
	
		//반제품 입고 목록
		var inGrid = new tui.Grid({
		    el: document.getElementById('grid'),
		    data: [<c:forEach items="${inList}" var="semi">
		        {
		            semiLot: "${semi.semiLot}",
		            prodCode: "${semi.prodCode}",
		            prodName: "${semi.prodName}",
		            semiInAmt: "${semi.semiInAmt}",
		            empCode: "${semi.empCode}",
		            empName: "${semi.empName}",
		            semiInd: `<fmt:formatDate value="${semi.semiInd}" pattern="yyyy-MM-dd"/>`,
		            semiExd: `<fmt:formatDate value="${semi.semiExd}" pattern="yyyy-MM-dd"/>`,
		            prcsIngCode: "${semi.prcsIngCode}",
		            useYn: "${semi.useYn}"
		        },
		    </c:forEach>
		        ],
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
		            header: '반제품코드',
		            name: 'prodCode',
		            hidden: true
		        }, {
		            header: '반제품명',
		            name: 'prodName',
		            align: 'left'
		        }, {
		            header: '생산공정',
		            name: 'prcsIngCode',
		            align: 'center'
		        }, {
		            header: '입고일자',
		            name: 'semiInd',
		            editor: {
		                type: 'datePicker',
		                options: {
		                    language: 'ko'
		                }
		            },
		            className: 'yellow-background',
		            align: 'center'
		        },{
		            header: '입고량',
		            name: 'semiInAmt',
		            formatter(e) {
		                if (e['value'] != null) {
		                    val = e['value']
		                        .toString()
		                        .replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		                    return val;
		                }
		            },
		            align: 'right'
		        },   {
		            header: '유통기한',
		            name: 'semiExd',
		            editor: {
		                type: 'datePicker',
		                options: {
		                    language: 'ko'
		                }
		            },
		            className: 'yellow-background',
		            align: 'center'
		        },  {
		            header: '사용여부',
		            name: 'useYn',
		            align: 'left'
		        }, {
		            header: '담당자',
		            name: 'empName',
		            align: 'center'
		        },{
		            header: '담당자코드',
		            name: 'empCode',
		            hidden: true
		        }
		    ]
	
		});
	
		setDisabled();
	
		//test완료 목록 그리드
		var testGrid = new tui.Grid({
		    el: document.getElementById('grid2'),
		    data: [<c:forEach items="${testList}" var="test">
		        {
		            prcsIngCode: "${test.prcsIngCode}",
		            prodCode: "${test.prodCode}",
		            prodName: "${test.prodName}",
		            testAmt: "${test.testAmt}",
		            testDate: `<fmt:formatDate value="${test.testDate}" pattern="yyyy-MM-dd"/>`
		        },
		    </c:forEach>
		        ],
		    scrollX: false,
		    scrollY: false,
		    minBodyHeight: 160,
		    rowHeaders: ['rowNum'],
		    pagination: true,
		    pageOptions: {
		        //백엔드와 연동 없이 페이지 네이션 사용가능하게 만듦
		        useClient: true,
		        perPage: 4
		    },
		    columns: [
		        {
		            header: '생산공정코드',
		            name: 'prcsIngCode',
		            align: 'center'
		        }, {
		            header: '반제품코드',
		            name: 'prodCode',
		            align: 'center'
		        }, {
		            header: '반제품명',
		            name: 'prodName',
		            align: 'left'
		        }, {
		            header: '생산량',
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
		            header: '검수일자',
		            name: 'testDate',
		            editor: {
		                type: 'datePicker',
		                options: {
		                    language: 'ko'
		                }
		            },
		            className: 'yellow-background',
		            align: 'center'
		        }
		    ]
	
		});
	
		//비활성화
		function setDisabled() {
		    $.each(inGrid.getData(), function (idx, obj) {
	
		        if (obj['semiLot'] != null && (obj['useYn'] == '사용중' || obj['useYn'] == '사용완료')) {
		            inGrid.disableRow(obj['rowKey']);
		        }
		    })
		}
	
		//삭제버튼
		$('#delete').on("click", function () {
		    let checkList = inGrid.getCheckedRows();
	
		    deleteList = [];
		    $.each(checkList, function (idx, obj) {
		        deleteObj = {};
		        deleteObj['prcsIngCode'] = obj['prcsIngCode'];
		        deleteList.push(deleteObj);
		    })
	
		    $.ajax({
		        url: 'getDeletedSemiInfo',
		        method: 'POST',
		        contentType: 'application/json',
		        data: JSON.stringify(deleteList),
		        success: function (data) {
		        	$.each(data, function (idx, obj) {
		                let date = new Date(obj['testDate']);
		                let year = date.getFullYear(); //0000년 가져오기
		                let month = date.getMonth() + 1; //월은 0부터 시작하니 +1하기
		                let day = date.getDate(); //일자 가져오기
		                obj['testDate'] = year + "-" + (
		                    ("00" + month.toString()).slice(-2)
		                ) + "-" + (
		                    ("00" + day.toString()).slice(-2)
		                );
		                
		                testGrid.appendRow(obj, {at: 0});
		            })
	
		        },
		        error: function (reject) {
		            console.log(reject);
		        }
		    })
	
		    //그리드에서 행 지움
		    inGrid.removeCheckedRows(false);
		    //마우스 커서 없앰
		    inGrid.blur();
		});
		
		inGrid.on('click', ()=>{
		    //선택한 행 색깔 바꾸기
		    	  let selectKey = inGrid.getFocusedCell().rowKey;
		    	  inGrid.addRowClassName(selectKey, 'selected-cell');
		    	  //다른 행 선택시 기존에 클릭했던 행은 class제거
		    	  inGrid.on('focusChange', () => {
		    		  inGrid.removeRowClassName(selectKey, 'selected-cell');
		    	  })
		})
		
		testGrid.on('click', ()=>{
		    //선택한 행 색깔 바꾸기
		    	  let selectKey = testGrid.getFocusedCell().rowKey;
		    	  testGrid.addRowClassName(selectKey, 'selected-cell');
		    	  //다른 행 선택시 기존에 클릭했던 행은 class제거
		    	  testGrid.on('focusChange', () => {
		    		  testGrid.removeRowClassName(selectKey, 'selected-cell');
		    	  })
		})
	
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
		        swal("경고", "변경사항이 없습니다", "warning");
		        return false;
		    }
	
		    //flag가 true = 입력폼이나 수정폼에 빠뜨린 데이터가 없다
		    var flag = true;
		    //create, modify, delete 포함하는 전체 배열을 도는 each문
	
		    if (inGrid.getModifiedRows().createdRows.length > 0) {
	
		        $.each(inGrid.getModifiedRows().createdRows, function (idx2, obj2) {
		            if (obj2['prodCode'] == "" || obj2['prodCode'] == null || obj2['semiInAmt'] == "" || obj2['semiInAmt'] == null || obj2['semiExd'] == null ||  obj2['semiExd'] == "" ||obj2['semiInd'] == null ||obj2['semiInd'] == null ||obj2['prcsIngCode'] == "" || obj2['prcsIngCode'] == null) {
		                flag = false;
		                return false;
		            }
		        })
		    }
	
		    if (inGrid.getModifiedRows().updatedRows.length > 0) {
	
		        $.each(inGrid.getModifiedRows().updatedRows, function (idx2, obj2) {
		            if (obj2['semiInd'] == null || obj2['semiInd'] == "" ||obj2['semiExd'] == null || obj2['semiExd'] == "") {
		                flag = false;
		                return false;
		            }
		        })
	
		    }
	
		    if (flag) {
		        $.ajax({
		            url: 'semiInDirSave',
		            method: 'POST',
		            data: JSON.stringify(inGrid.getModifiedRows()),
		            contentType: 'application/json',
		            success: function (data) {
		                swal("성공", data + "건이 처리되었습니다.", "success");
		                selectAjax();
	
		            },
		            error: function (reject) {
		                swal("실패", "", "error");
		            }
		        })
		    } else {
		        swal("경고", "값이 입력되지 않았습니다", "warning");
		    }
	
		}
	
		//검색 또는 DML 후 다시 LIST 불러오는 함수
		function selectAjax() {
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
		        success: function (data2) {
	
		            $.each(data2, function (idx, obj) {
	
		                let date = new Date(obj['semiInd']);
		                let year = date.getFullYear(); //0000년 가져오기
		                let month = date.getMonth() + 1; //월은 0부터 시작하니 +1하기
		                let day = date.getDate(); //일자 가져오기
		                obj['semiInd'] = year + "-" + (
		                    ("00" + month.toString()).slice(-2)
		                ) + "-" + (
		                    ("00" + day.toString()).slice(-2)
		                );
	
		                date = new Date(obj['semiExd']);
		                year = date.getFullYear(); //0000년 가져오기
		                month = date.getMonth() + 1; //월은 0부터 시작하니 +1하기
		                day = date.getDate(); //일자 가져오기
		                obj['semiExd'] = year + "-" + (
		                    ("00" + month.toString()).slice(-2)
		                ) + "-" + (
		                    ("00" + day.toString()).slice(-2)
		                );
	
		            })
		            inGrid.resetData(data2);
		            setDisabled();
		        }
		    })
		}
	
		//insert 후에는 1번 그리드도 내용이 업데이트 되어야 함
		function resetTestList() {
		    $.ajax({
		        url: 'getSemiTestFinish',
		        method: 'GET',
		        data: search,
		        success: function (data2) {
	
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
		            inGrid.resetData(data);
		        },
		        error: function (reject) {
		            console.log(reject);
		        }
		    })
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
	
		//검색버튼 검색
		$('#searchBtn').on('click', searchSemiIn);
		function searchSemiIn(e) {
		    selectAjax();
		}
	
		//검색 옆 초기화버튼
		$('#searchResetBtn').on('click', resetInput);
		function resetInput(e) {
		    $('input').each(function (idx, obj) {
		        obj.value = '';
		        obj.checked = false;
		    })
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
		    let rowKey = testGrid
		        .getFocusedCell()
		        .rowKey;
		    // let columnName = orderGrid.getFocusedCell().columnName; let value =
		    // orderGrid.getFocusedCell().value;
	
		    if (rowKey != null && rowKey >= 0) {
		        let prcsIngCode = testGrid.getValue(rowKey, 'prcsIngCode');
		        let prodCode = testGrid.getValue(rowKey, 'prodCode');
		        let prodName = testGrid.getValue(rowKey, 'prodName');
		        let testAmt = testGrid.getValue(rowKey, 'testAmt');
	
		        testGrid.removeRow(rowKey);
				
		        let now = new Date(); // 현재 날짜 및 시간
		        let year = now.getFullYear();
		        let month = ('0' + (
		            now.getMonth() + 1
		        )).substr(-2);
		        let day = ('0' + now.getDate()).substr(-2);
		        let semiInd = year + "-" + month + "-" + day;
		        
		        testGrid.blur();
		        inGrid.appendRow({
		            'prcsIngCode': prcsIngCode,
		            'prodCode': prodCode,
		            'prodName': prodName,
		            'semiInAmt': testAmt,
		            'semiInd' : semiInd,
		            'empCode': `${user.id}`,
		            'empName': `${user.empName}`
		        }, {at: 0});
		    }
	
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
		
		document.getElementById('startDate').value = new Date().toISOString().substring(0, 10);
		document.getElementById('endDate').value = new Date().toISOString().substring(0, 10);
    </script>
</body>
</html>