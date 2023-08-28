<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자재 폐기 관리</title>
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
	
	#searchP  input[type="text"]{
	  width: 15%;
	  padding: 6px;
	  margin-bottom: 15px;
	  border: 1px solid #ccc;
	  border-radius: 4px;
	}
	#searchP input[type="date"]{
	  width: 15%;
	  padding: 5px;
	  margin-bottom: 30px;
	  border: 1px solid #ccc;
	  border-radius: 4px;
	}
	
	#searchP p{
		width: 80px;
		display: inline-block;
		font-size: 20px;
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
	
	#m_body_s > p{
		display : inline-block;
	}
	
	#m_body_s > input{
		border : 1px solid black;
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
	
	#endDate{
		margin-right : 20px;
	}
	
</style>    
       
</head>
<body>
   <h1>자재 폐기 관리</h1>
   <div class="col-lg-12 stretch-card">
       <div class="card">
           <div class="card-body">
               <div class="table-responsive pt-3">
               		
                  	
        				<div id="searchP" style="display: flex; justify-content: flex-end;">
            				<div style="flex: 1;">
                				<p>자재명</p>
                				<input type="text" id="matCodeInput">
                				<i class="bi bi-search" id="matModal"></i> <!-- 돋보기 아이콘 -->
                				<input type="text" class="blackcolorInputBox" id="matNameFix" readonly>
                				<br>
                				<p>폐기일자</p>
                				<input id="startDate" type="date">&nbsp;&nbsp;-&nbsp;&nbsp;<input id="endDate" type="date">
                				<button type="button" class="btn btn-info btn-icon-text" id="searchBtn">
                    				<i class="fas fa-search"></i>
                    					검색
                				</button>
                				<button type="button" class="btn btn-info btn-icon-text" id="searchResetBtn">
                    				초기화
                				</button>
            				</div>
        				</div>
	    			
				</div>
	    			<div id="container" style="display: flex;">
		           		<div style="flex: 1;"><h2>유통기한 지난 자재 목록</h2>
			            <br>
			            <div id="grid3" style="width: 730px;"></div></div>
		           		<div style="flex: 1;"><h2>반품 실패 자재 목록</h2>
			            <br>
			            <div id="grid2" style="width: 730px; margin-right: 20px"></div></div>
	   				</div>
			            
			            
			            <div id="grid">
			            	<h2>폐기 목록</h2>
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
	<div class="modal">
   		<div class="modal_content">
        	<div class="m_head">
            	<div class="modal_title"><h3>목록</h3></div>
            	<div class="close_btn" id="close_btn">X</div>
       		</div>
       		<div class="m_body">
       			<div id="m_body_s">
       			<p>이름</p>
                <input type="text" id="modalSearch">
                <button type="button" class="btn btn-info btn-icon-text" id="modalSearchBtn">검색</button>
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
	<script>
		//전체조회 그리드
		var grid = new tui.Grid({
		    el: document.getElementById('grid'),
		    data: [<c:forEach items="${disList}" var="mat">
		        {
		            matDpCode: "${mat.matDpCode}",
		            matIdentiCode: "${mat.matIdentiCode}",
		            matCode: "${mat.matCode}",
		            matName: "${mat.matName}",
		            matStd: "${mat.matStd}",
		            matDpDate: `<fmt:formatDate value="${mat.matDpDate}" pattern="yyyy-MM-dd"/>`,
		            matUnit: "${mat.matUnit}",
		            matDpAmt: "${mat.matDpAmt}",
		            empCode: "${mat.empCode}",
		            empName: "${mat.empName}",
		            matDpInfo: "${mat.matDpInfo}",
		            matChangeAmt: 0
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
		            header: '자재폐기코드',
		            name: 'matDpCode',
		            hidden: true
		        }, {
		            header: '자재 LOT / 발주상세코드',
		            name: 'matIdentiCode',
		            width: 200
		        }, {
		            header: '자재코드',
		            name: 'matCode',
		            hidden: true
		        }, {
		            header: '자재명',
		            name: 'matName'
		        }, {
		            header: '단위',
		            name: 'matUnit'
		        }, {
		            header: '규격',
		            name: 'matStd'
		        }, {
		            header: '폐기수량',
		            name: 'matDpAmt',
		            formatter(e) {
		                if (e['value'] != null) {
		                    val = e['value']
		                        .toString()
		                        .replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		                    return val;
		                } else {
		                    return 0;
		                }
		            }
	
		        }, {
		            header: '폐기일자',
		            name: 'matDpDate',
		            className: 'yellow-background'
		        }, {
		            header: '담당자코드',
		            name: 'empCode',
		            hidden: true
		        }, {
		            header: '담당자명',
		            name: 'empName'
		        }, {
		            header: '비고',
		            name: 'matDpInfo',
		            width: 400,
		            editor: 'text'
		        }, {
		            header: '차이수량',
		            name: 'matChangeAmt',
		            hidden: true
		        }
	
		    ]
	
		});
	
		//rt 목록 그리드
		var rtGrid = new tui.Grid({
		    el: document.getElementById('grid2'),
		    data: [<c:forEach items="${rtList}" var="rt">
		        {
		            matOdDeCd: "${rt.matOdDeCd}",
		            matCode: "${rt.matCode}",
		            matName: "${rt.matName}",
		            matStd: "${rt.matStd}",
		            matUnit: "${rt.matUnit}",
		            matRtAmt: "${rt.matRtAmt}",
		            errInfo: "${rt.errInfo}",
		            matRtDate: `<fmt:formatDate value="${rt.matRtDate}" pattern="yyyy-MM-dd"/>`
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
		            header: '발주상세코드',
		            name: 'matOdDeCd',
		            width: 150
		        }, {
		            header: '자재코드',
		            name: 'matCode',
		            hidden: true
		        }, {
		            header: '자재명',
		            name: 'matName'
		        }, {
		            header: '단위',
		            name: 'matUnit'
		        }, {
		            header: '규격',
		            name: 'matStd'
		        }, {
		            header: '반품실패량',
		            name: 'matRtAmt'
		        }, {
		            header: '불량내용',
		            name: 'errInfo'
		        }, {
		            header: '반품요청일',
		            name: 'matRtDate'
		        }
		    ]
	
		});
	
		//유통기한 임박 목록 그리드
		var exdGrid = new tui.Grid({
		    el: document.getElementById('grid3'),
		    data: [<c:forEach items="${exdList}" var="exd">
		        {
		            matLot: "${exd.matLot}",
		            matCode: "${exd.matCode}",
		            matName: "${exd.matName}",
		            matUnit: "${exd.matUnit}",
		            matStd: "${exd.matStd}",
		            matStock: "${exd.matStock}",
		            matExd: `<fmt:formatDate value="${exd.matExd}" pattern="yyyy-MM-dd"/>`
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
		            header: '자재 LOT',
		            name: 'matLot',
		            width: 150
		        }, {
		            header: '자재코드',
		            name: 'matCode',
		            hidden: true
		        }, {
		            header: '자재명',
		            name: 'matName'
		        }, {
		            header: '단위',
		            name: 'matUnit'
		        }, {
		            header: '규격',
		            name: 'matStd'
		        }, {
		            header: '현재고',
		            name: 'matStock'
		        }, {
		            header: '유통기한',
		            name: 'matExd'
		        }
		    ]
	
		});
	
		//삭제버튼
		$('#delete').on("click", function () {
		    let checkList = grid.getCheckedRows();
	
		    let deleteRtList = [];
		    let deleteExdList = [];
		    $.each(checkList, function (idx, obj) {
		        if (obj['matIdentiCode'].substr(0, 4) == 'MODC') {
		            deleteRtObj = {};
		            deleteRtObj['matIdentiCode'] = obj['matIdentiCode'];
		            deleteRtList.push(deleteRtObj);
		        } else {
		            deleteExdObj = {};
		            deleteExdObj['matIdentiCode'] = obj['matIdentiCode'];
		            deleteExdList.push(deleteExdObj);
		        }
	
		    })
	
		    $.ajax({
		        url: 'getDeletedRtDisInfo',
		        method: 'POST',
		        contentType: 'application/json',
		        data: JSON.stringify(deleteRtList),
		        success: function (data) {
		            $.each(data, function (idx, obj) {
		                let date = new Date(obj['matRtDate']);
		                let year = date.getFullYear(); //0000년 가져오기
		                let month = date.getMonth() + 1; //월은 0부터 시작하니 +1하기
		                let day = date.getDate(); //일자 가져오기
		                obj['matRtDate'] = year + "-" + (
		                    ("00" + month.toString()).slice(-2)
		                ) + "-" + (
		                    ("00" + day.toString()).slice(-2)
		                );
		            })
		            rtGrid.appendRows(data);
	
		        },
		        error: function (reject) {
		            console.log(reject);
		        }
		    })
	
		    $.ajax({
		        url: 'getDeletedExdDisInfo',
		        method: 'POST',
		        contentType: 'application/json',
		        data: JSON.stringify(deleteExdList),
		        success: function (data) {
		            $.each(data, function (idx, obj) {
		                let date = new Date(obj['matExd']);
		                let year = date.getFullYear(); //0000년 가져오기
		                let month = date.getMonth() + 1; //월은 0부터 시작하니 +1하기
		                let day = date.getDate(); //일자 가져오기
		                obj['matExd'] = year + "-" + (
		                    ("00" + month.toString()).slice(-2)
		                ) + "-" + (
		                    ("00" + day.toString()).slice(-2)
		                );
		            })
		            exdGrid.appendRows(data);
	
		        },
		        error: function (reject) {
		            console.log(reject);
		        }
		    })
	
		    //그리드에서 행 지움
		    grid.removeCheckedRows(false);
		    //마우스 커서 없앰
		    grid.blur();
		});
	
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
		        swal("", "변경사항이 없습니다", "warning");
		        return false;
		    }
	
		    //flag가 true = 입력폼이나 수정폼에 빠뜨린 데이터가 없다
		    var flag = true;
		    //create, modify, delete 포함하는 전체 배열을 도는 each문
	
		    if (grid.getModifiedRows().createdRows.length > 0) {
	
		        $.each(grid.getModifiedRows().createdRows, function (idx, obj) {
		            if (obj['matIdentiCode'] == "" || obj['matName'] == "" || obj['matUnit'] == "" || obj['matStd'] == "" || obj['matDpAmt'] == "" || obj['matDpDate'] == null || obj['empName'] == "") {
		                flag = false;
		                return false;
		            }
		        })
		    }
	
		    if (grid.getModifiedRows().updatedRows.length > 0) {
		        $.each(grid.getModifiedRows().updatedRows, function (idx, obj) {
	
		            if (obj['matDpAmt'] == "") {
		                flag = false;
		                return false;
		            }
	
		        })
		    }
	
		    if (flag) {
		        $.ajax({
		            url: 'matDisDirSave',
		            method: 'POST',
		            data: JSON.stringify(grid.getModifiedRows()),
		            contentType: 'application/json',
		            success: function (data) {
		                swal("성공", data + "건이 처리되었습니다.", "success");
		                selectAjax();
		                getReRtList();
		                getReExdList();
		            },
		            error: function (reject) {
		                console.log(reject);
		                swal("실패", "", "error");
		            }
		        })
		    } else {
		        swal("", "값이 입력되지 않았습니다", "warning");
		    }
		}
	
		//검색 또는 DML 후 다시 LIST 불러오는 함수
		function selectAjax() {
		    let mat = $('#matCodeInput').val();
		    let sd = $('#startDate').val();
		    let ed = $('#endDate').val();
	
		    let search = {
		        materialCode: mat,
		        startDate: sd,
		        endDate: ed
		    };
		    $.ajax({
		        url: 'getMatDisFilter',
		        method: 'GET',
		        data: search,
		        success: function (data2) {
	
		            $.each(data2, function (idx, obj) {
	
		                let date = new Date(obj['matDpDate']);
		                let year = date.getFullYear(); //0000년 가져오기
		                let month = date.getMonth() + 1; //월은 0부터 시작하니 +1하기
		                let day = date.getDate(); //일자 가져오기
		                obj['matDpDate'] = year + "-" + (
		                    ("00" + month.toString()).slice(-2)
		                ) + "-" + (
		                    ("00" + day.toString()).slice(-2)
		                );
	
		            })
		            grid.resetData(data2);
	
		        }
		    })
		}
	
		//save후 rt 다시 불러옴
		function getReRtList() {
		    $.ajax({
		        url: 'getRtFailFilter',
		        method: 'GET',
		        success: function (result) {
		            $.each(result, function (idx, obj) {
	
		                let date = new Date(obj['matRtDate']);
		                let year = date.getFullYear(); //0000년 가져오기
		                let month = date.getMonth() + 1; //월은 0부터 시작하니 +1하기
		                let day = date.getDate(); //일자 가져오기
		                obj['matRtDate'] = year + "-" + (
		                    ("00" + month.toString()).slice(-2)
		                ) + "-" + (
		                    ("00" + day.toString()).slice(-2)
		                );
	
		            })
		            rtGrid.resetData(result);
		        },
		        error: function (reject) {
		            console.log(reject);
		        }
		    })
		}
	
		//save후 exd 다시 불러옴
		function getReExdList() {
		    $.ajax({
		        url: 'getOverDateFilter',
		        method: 'GET',
		        success: function (result) {
		            $.each(result, function (idx, obj) {
	
		                let date = new Date(obj['matExd']);
		                let year = date.getFullYear(); //0000년 가져오기
		                let month = date.getMonth() + 1; //월은 0부터 시작하니 +1하기
		                let day = date.getDate(); //일자 가져오기
		                obj['matExd'] = year + "-" + (
		                    ("00" + month.toString()).slice(-2)
		                ) + "-" + (
		                    ("00" + day.toString()).slice(-2)
		                );
	
		            })
	
		            exdGrid.resetData(result);
		        },
		        error: function (reject) {
		            console.log(reject);
		        }
		    })
		}
	
		//거래처 검색 모달창
		var Grid;
		//자재 모달창
		$("#matModal").click(function () {
		    $(".modal").fadeIn();
		    $("#reset_btn").css("display", "none");
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
	
		//자재 모달창 내용 그리드
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
		                name: 'matCode'
		            }, {
		                header: '자재명',
		                name: 'matName'
		            }, {
		                header: '단위',
		                name: 'matUnit'
		            }, {
		                header: '규격',
		                name: 'matStd'
		            }
		        ]
	
		    });
	
		    return matGrid;
		}
	
		//모달 검색
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
		    }
		})
	
		//모달창 닫기버튼
		$(".close_btn").click(function () {
		    $(".modal").fadeOut();
		    activeScroll();
		    let inputContent = $('#modalSearch').val('');
		    if (Grid != null && Grid.el != null) {
		        Grid.destroy();
		    }
		    $("#reset_btn").css("display", "block");
		    $("#m_body_s").css("display", "block");
		});
	
		//검색버튼 검색
		$('#searchBtn').on('click', selectAjax);
	
		//검색 옆 초기화버튼
		$('#searchResetBtn').on('click', resetInput);
		function resetInput(e) {
		    $('input').each(function (idx, obj) {
		        obj.value = '';
		    })
		}
	
		//엑셀 다운로드
		const excelDownload = document.querySelector('.excelDownload');
		document.addEventListener('DOMContentLoaded', () => {
		    excelDownload.addEventListener('click', function (e) {
		        grid.export('xlsx');
		    })
		});
	
		//상단 그리드 셀 클릭시 하단 그리드로 데이터 넘어가는 이벤트
		rtGrid.on('dblclick', () => {
		    let rowKey = rtGrid
		        .getFocusedCell()
		        .rowKey;
	
		    if (rowKey != null && rowKey >= 0) {
		        let matOdDeCd = rtGrid.getValue(rowKey, 'matOdDeCd');
		        let matCode = rtGrid.getValue(rowKey, 'matCode');
		        let matName = rtGrid.getValue(rowKey, 'matName');
		        let matStd = rtGrid.getValue(rowKey, 'matStd');
		        let matUnit = rtGrid.getValue(rowKey, 'matUnit');
		        let matRtAmt = rtGrid.getValue(rowKey, 'matRtAmt');
		        //상단의 행 정보는 삭제 그리드에서 행 지움
		        rtGrid.removeRow(rowKey);
		        //마우스 커서 없앰
		        rtGrid.blur();
	
		        let now = new Date(); // 현재 날짜 및 시간
		        let year = now.getFullYear();
		        let month = ('0' + (
		            now.getMonth() + 1
		        )).substr(-2);
		        let day = ('0' + now.getDate()).substr(-2);
		        let matDpDate = year + "-" + month + "-" + day;
	
		        grid.appendRow({
		            'matIdentiCode': matOdDeCd,
		            'matCode': matCode,
		            'matName': matName,
		            'matUnit': matUnit,
		            'matStd': matStd,
		            'matDpAmt': matRtAmt,
		            'matDpDate': matDpDate,
		            'empCode': `${user.id}`,
		            'empName': `${user.empName}`
		        }, {at: 0});
		    }
	
		});
	
		exdGrid.on('dblclick', () => {
		    let rowKey = exdGrid
		        .getFocusedCell()
		        .rowKey;
	
		    if (rowKey != null && rowKey >= 0) {
		        let matLot = exdGrid.getValue(rowKey, 'matLot');
		        let matCode = exdGrid.getValue(rowKey, 'matCode');
		        let matName = exdGrid.getValue(rowKey, 'matName');
		        let matUnit = exdGrid.getValue(rowKey, 'matUnit');
		        let matStd = exdGrid.getValue(rowKey, 'matStd');
		        let matStock = exdGrid.getValue(rowKey, 'matStock');
		        //상단의 행 정보는 삭제 그리드에서 행 지움
		        exdGrid.removeRow(rowKey);
		        //마우스 커서 없앰
		        exdGrid.blur();
	
		        let now = new Date(); // 현재 날짜 및 시간
		        let year = now.getFullYear();
		        let month = ('0' + (
		            now.getMonth() + 1
		        )).substr(-2);
		        let day = ('0' + now.getDate()).substr(-2);
		        let matDpDate = year + "-" + month + "-" + day;
		        grid.appendRow({
		            'matIdentiCode': matLot,
		            'matCode': matCode,
		            'matName': matName,
		            'matUnit': matUnit,
		            'matStd': matStd,
		            'matDpAmt': matStock,
		            'matDpDate': matDpDate,
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
    
  
	
	</script>
</body>
</html>