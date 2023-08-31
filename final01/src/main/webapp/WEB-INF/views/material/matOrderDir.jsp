<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자재 발주 관리</title>
<!-- 토스트 페이지 네이션 -->
<script type="text/javascript" src="https://uicdn.toast.com/tui.code-snippet/latest/tui-code-snippet.js"></script>
<link rel="stylesheet" href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css" />
<script src="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.js"></script>
<!-- 페이지 네이션 끝 -->
<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
<style>
  

	#newPrcsPlanView, #save, #delete, #dirAdd, .excelDownload{
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
	
	#grid input[type="text"] ,#searchP input[type="text"] {
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
		margin-bottom: 40px;
	}
	
	#searchP label[for="comple"]{
		margin-right : 20px;
	}
	
	#searchP p{
		width: 80px;
		display: inline-block;
		font-size: 20px;
	}
	
	/*grid 날짜 컬럼색*/
	.yellow-background {
	        background-color: rgb(255,253,235);
	}
	
	
	#grid {
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
	.yellow-background {
        background-color: rgb(255,253,235);
	}
	
	#grid{
		height: 700px;
		
	}
	
	#grid p{
		margin-left : 400px;
		display : inline-block;
	}
	
	.modal_content{
	  /*모달창 크기 조절*/
	  width:600px; height:700px;
	  background:#fff; border-radius:10px;
	  /*모달창 위치 조절*/
	  position:relative; top:28%; left:45%;
	  margin-top:-100px; margin-left:-200px;
	  text-align:center;
	  box-sizing:border-box;
	  line-height:23px;
	}
	
	.m_body > p{
		display : inline-block;
	}
	
	.m_body > input{
		border : 1px solid black;
	}

	
	#customtemplateSearchAndButton p{
		width : 100px;
	}
	
	#selectActCodeInput{
		margin-bottom : 35px;
	}
	
	#matNameFix, #actNameFix, #selectActNameFix {
		background-color : #868e96;
		border-color: #868e96;
	}
	
	#matModal, #selectActModal{
		cursor : pointer;
	}
	
	#modalSearch{
		width: 30%;
	  	padding: 6px;
	  	margin-bottom: 15px;
	  	border: 1px solid #ccc;
	  	border-radius: 4px;	
	}
	
/*모달끝*/
	.my-styled-cell {background-color: rgb(255, 229, 229)}
</style>    
       
</head>
<body>
   <h1>자재 발주 관리</h1>
   <div class="col-lg-12 stretch-card">
       <div class="card">
           <div class="card-body">
               <div class="table-responsive pt-3">
        				<div id="searchP" style="display: flex; justify-content: space-between;">
            				<div style="flex: 1;">
                				<p>자재명</p>
                				<input type="text" id="matCodeInput" placeholder="검색어를 선택하세요">
                				<i class="bi bi-search" id="matModal"></i> <!-- 돋보기 아이콘 -->
                				<input type="text" class="blackcolorInputBox" id="matNameFix" readonly>
                				<br>
                				<p>거래처</p>
                				<input type="text" id="actCodeInput" placeholder="검색어를 선택하세요">
                				<i class="bi bi-search" id="actModal"></i>
                				<input type="text" class="blackcolorInputBox" id="actNameFix" readonly>
                				<br>
                				<p>발주일자</p>
                				<input id="startDate" type="date">&nbsp;&nbsp;-&nbsp;&nbsp;<input id="endDate" type="date">
                				<br>
                				<p>검수상태</p>
                				<label for="before"><input type="checkbox" id="before" value="before">검수전</label>
                				<label for="comple"><input type="checkbox" id="comple" value="comple">검수완료</label>
                				<button type="button" class="btn btn-info btn-icon-text" id="searchBtn">
                    				<i class="fas fa-search"></i>
                    					검색
                				</button>
                				<button type="button" class="btn btn-info btn-icon-text" id="searchResetBtn">
                    				초기화
                				</button>
            				</div>
        				</div>
		            <div id="container" style="display: flex;">
		           		<div style="flex: 1;"><h2>현재 자재 재고</h2>
			            <br>
			            <div id="grid2" style="width: 730px;"></div></div>
		           		<div style="flex: 1;"><h2>거래처 목록</h2>
			            <br>
			            <div id="grid3" style="width: 730px; margin-right: 20px"></div></div>
	   				</div>
		            	
		            
		            </div>
		            
		            
		            <div id="grid">
		            <h2>발주 목록</h2>	<p>등록 거래처</p> <input type="text" id="matBuyActInput" readOnly><input type="hidden" id="matBuyActInputHidden">
		            <button type="button" class="btn btn-info btn-icon-text excelDownload">
                      	 Excel
                      	<i class="bi bi-printer"></i>                                                                              
                   	</button>
                   	<button class="btn btn-info btn-icon-text" id="save">저장</button>
                	<button class="btn btn-info btn-icon-text" id="delete">삭제</button></div>
				</div>
			</div>
		</div>
	</div> 
	<div class="modal" id="modal">
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


	<script>
		//그리드2 생성
		var planGrid = new tui.Grid({
		    el: document.getElementById('grid2'),
		    data: [<c:forEach items="${stockList}" var="stock" varStatus="status">
		        {
		        	matCode: "${stock.matCode}",
		            matName: "${stock.matName}",
		            matUnit: "${stock.matUnit}",
		            matStd: "${stock.matStd}",
		            totalStock: "${stock.totalStock}",
		            matSafe: "${stock.matSafe}",
		            willUseAmt: "${stock.willUseAmt}"
		        }
		        <c:if test="${not status.last}">,</c:if>
		    </c:forEach>
		        ],
		    scrollX: false,
		    scrollY: false,
		    minBodyHeight: 160,
		    rowHeaders: [
		        {
		            type: 'rowNum'
		        }
		    ],
		    pageOptions: {
		        useClient: true,
		        perPage: 4
		    },
		    columns: [
		    	{
		            header: '자재코드',
		            name: 'matCode',
		            align: 'center',
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
		            header: '현재고',
		            name: 'totalStock',
		            formatter(e) {
		                val = e['value']
		                    .toString()
		                    .replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		                return val;
		            },
		            align: 'right'
		        }, {
		            header: '안전재고',
		            name: 'matSafe',
		            formatter(e) {
		                val = e['value']
		                    .toString()
		                    .replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		                return val;
		            },
		            align: 'right'
		        }, {
		        	header: '소모예정량',
		            name: 'willUseAmt',
		            formatter(e) {
		                val = e['value']
		                    .toString()
		                    .replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		                return val;
		            },
		            align: 'right'
		        }
		    ]
		});
		
		
		
		planGrid.on('dblclick', () => {
		    let rowKey = planGrid
		        .getFocusedCell()
		        .rowKey;
	
		    if (rowKey != null && rowKey >= 0) {
		        let matCode = planGrid.getValue(rowKey, 'matCode');
		        let matName = planGrid.getValue(rowKey, 'matName');
		        let matStd = planGrid.getValue(rowKey, 'matStd');
		        let matUnit = planGrid.getValue(rowKey, 'matUnit');
		        let matAmt = planGrid.getValue(rowKey, 'bomAmt');
		        
		      	
		        //마우스 커서 없앰
		        planGrid.blur();
	
		        let now = new Date(); // 현재 날짜 및 시간
		        let year = now.getFullYear();
		        let month = ('0' + (
		            now.getMonth() + 1
		        )).substr(-2);
		        let day = ('0' + now.getDate()).substr(-2);
		        let matOdRq = year + "-" + month + "-" + day;
	
		        if(orderGrid.getModifiedRows().createdRows.length > 0){
		        	orderGrid.appendRow({
		        		'matOdRq': matOdRq,
			            'matCode': matCode,
			            'matName': matName,
			            'matStd': matStd,
			            'matUnit': matUnit,
			            'matAmt': matAmt,
			            'empCode': `${user.id}`,
			            'empName': `${user.empName}`,
			            'actCode': orderGrid.getModifiedRows().createdRows[0].actCode,
		                'actName': orderGrid.getModifiedRows().createdRows[0].actName
		            }, {at: 0});
		        }else {
		        	orderGrid.appendRow({
			            'matOdRq': matOdRq,
			            'matCode': matCode,
			            'matName': matName,
			            'matStd': matStd,
			            'matUnit': matUnit,
			            'matAmt': matAmt,
			            'empCode': `${user.id}`,
			            'empName': `${user.empName}`
			        }, {at: 0});
		        }
		    }
		});
		
		planGrid.on('onGridMounted', function (e) {
		    let data = planGrid.getData();
	
		    $.each(data, function (idx, obj) {
	
		        if (Number(obj['matStock']) < Number(obj['bomAmt'])) {
		            let rowKey = obj['rowKey'];
		            planGrid.addCellClassName(rowKey, 'matStock', 'my-styled-cell');
		        }
		    })
		});
		
		//거래처 그리드
		var matActGrid = new tui.Grid({
		    el: document.getElementById('grid3'),
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
		        	header:'거래처코드',
		        	name:'actCode'
		        },
		        {
		        	header:'거래처명',
		        	name:'actName'
		        },
		        {
		        	header:'거래횟수',
		        	name:'actCount'
		        }
		    ]
	
		});
		
		planGrid.on('click', event => {
			let rowKey = event.rowKey;
			let matCode = planGrid.getValue(rowKey, 'matCode');
			
			$.ajax({
		        url: 'getMatBuyAct',
		        method: 'GET',
		        data : { matCode : matCode },
		        success: function(result) {
		        	matActGrid.resetData(result);
		        },
		        error : function(reject){
		        	console.log(reject);
		        }
			})
		})
		
		matActGrid.on('click', () => {
        	let rowKey = matActGrid
            						.getFocusedCell()
            						.rowKey;
        
     		
            let actCode = matActGrid.getValue(rowKey, 'actCode');
            let actName = matActGrid.getValue(rowKey, 'actName');
                
            $('#matBuyActInput').val(actName);
           	$('#matBuyActInputHidden').val(actCode);
            let beforeAct = orderGrid.getModifiedRows().createdRows;
            for(data of beforeAct){
	        	orderGrid.setValue(data.rowKey, 'actCode', actCode);
	            orderGrid.setValue(data.rowKey, 'actName', actName);
            }

    	});
		

		//삭제버튼
		$('#delete').on("click", function () {
		    //그리드에서 행 지움
		    orderGrid.removeCheckedRows(false);
		    //마우스 커서 없앰
		    orderGrid.blur();
		});
	
		//저장버튼
		document
		    .getElementById('save')
		    .addEventListener('click', saveServer);
	
		
	
		//발주 form
		var orderGrid = new tui.Grid({
		    el: document.getElementById('grid'),
		    data: [<c:forEach items="${matOrderList}" var="mat" varStatus="status">
		        {
		            matOdCd: "${mat.matOdCd}",
		            matOdDeCd: "${mat.matOdDeCd}",
		            matName: "${mat.matName}",
		            matCode: "${mat.matCode}",
		            matUnit: "${mat.matUnit}",
		            matStd: "${mat.matStd}",
		            matPrice: "${mat.matPrice}",
		            matAmt: "${mat.matAmt}",
		            matTotalPrice: "${mat.matPrice * mat.matAmt}",
		            actName: "${mat.actName}",
		            actCode: "${mat.actCode}",
		            empName: "${mat.empName}",
		            empCode: "${mat.empCode}",
		            matTestYn: "${mat.matTestYn}",
		            matOdRq: `<fmt:formatDate value="${mat.matOdRq}" pattern="yyyy-MM-dd"/>`,
		            matOdAcp: `<fmt:formatDate value="${mat.matOdAcp}" pattern="yyyy-MM-dd"/>`
		        }
		        <c:if test="${not status.last}">,</c:if>
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
		    pageOptions: {
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
		        },
		        {
		            header: '발주일자',
		            name: 'matOdRq',
		            className: 'yellow-background',
		            align: 'center'
		        },
		        {
		            header: '업체코드', // [필수] 컬럼 이름
		            name: 'actCode',// [선택] 숨김 여부
		            editor : 'text',
		            align: 'center'
		        },
		        {
		            header: '거래처',
		            name: 'actName',
		            editor : 'text',
		            align: 'left'
		        }, {
		            header: '자재명',
		            name: 'matName',
		            editor: 'text',
		            align: 'left'
		        }, {
		            header: '자재코드', // [필수] 컬럼 이름
		            name: 'matCode', // [선택] 숨김 여부
		            hidden: true
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
		            editor: 'text',
		            formatter(e) {
		                if (e['value'] != null) {
		                    val = e['value']
		                        .toString()
		                        .replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		                    return val + "원";
		                }
		            },
		            width: 120,
		            validation: {
		                dataType: 'number',
		                required: true
		            },
		            align: 'right'
		        }, {
		            header: '발주량',
		            name: 'matAmt',
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
		            header: '총액',
		            name: 'matTotalPrice',
		            value: '${mat.matPrice * mat.matAmt}',
		            formatter(e) {
		                if (e['value'] != null) {
		                    val = e['value']
		                        .toString()
		                        .replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		                    return val + "원";
		                }
		            },
		            width: 120,
		            align: 'right'
		        },    {
		            header: '납기요청일',
		            name: 'matOdAcp',
		            editor: {
		                type: 'datePicker',
		                options: {
		                    language: 'ko'
		                }
		            },
		            className: 'yellow-background',
		            align: 'center'
		        }, {
		            header: '발주상세코드',
		            name: 'matOdDeCd',
		            hidden: true
		        }, {
		            header: '담당자코드', // [필수] 컬럼 이름
		            name: 'empCode',
		            hidden: true
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
	
		        }, {
		            header: '담당자', // [필수] 컬럼 이름
		            name: 'empName',
		            align: 'center' // [필수] 컬럼 매핑 이름 값                    [선택] 숨김 여부
		        }
		    ]
		});
	
		setDisabled();
	
		orderGrid.on('afterChange', (ev) => {
	
		    let change = ev.changes[0];
		    let rowData = orderGrid.getRow(change.rowKey);
		    let totalPrice = rowData.matPrice * rowData.matAmt;
	
		    if (change.columnName == 'matAmt' || change.columnName == 'matPrice') {
		        if (rowData.matAmt != null && rowData.matPrice != null) {
		            orderGrid.setValue(change.rowKey, 'matTotalPrice', totalPrice);
		        }
		    }
		});
	
		function saveServer() {
		    orderGrid.blur();
		    let modifyGridInfo = orderGrid.getModifiedRows();
	
		    // 수정된게 없으면 바로 빠져나감
	
		    if (!orderGrid.isModified()) {
		        swal("경고", "변경사항이 없습니다", "warning");
		        return false;
		    }
	
		    //flag가 true = 입력폼이나 수정폼에 빠뜨린 데이터가 없다
		    var flag = true;
		    //create, modify, delete 포함하는 전체 배열을 도는 each문
	
		    if (orderGrid.getModifiedRows().createdRows.length > 0) {
	
		        $.each(orderGrid.getModifiedRows().createdRows, function (idx2, obj2) {
		            if (obj2['actCode'] == "" || obj2['matAmt'] == "" || obj2['matCode'] == "" || obj2['matOdAcp'] == null || obj2['matPrice'] == "" || obj2['matOdRq'] == null) {
		                flag = false;
		                return false;
		            }
		        })
		    }
	
		    if (orderGrid.getModifiedRows().updatedRows.length > 0) {
		        $.each(orderGrid.getModifiedRows().updatedRows, function (idx2, obj2) {
		            if (obj2['matOdDeCd'] == "" || obj2['actCode'] == "" || obj2['matAmt'] == "" || obj2['matCode'] == "" || obj2['matOdAcp'] == null || obj2['matPrice'] == "") {
		                flag = false;
		                return false;
		            }
	
		        })
		    }
	
		    if (flag) {
		        $.ajax({
		            url: 'matOrderDirSave',
		            method: 'POST',
		            data: JSON.stringify(orderGrid.getModifiedRows()),
		            contentType: 'application/json',
		            success: function (data) {
		                swal("성공", data + "건이 처리되었습니다.", "success");
		                selectAjax();
		                resetPlanGrid();
		            },
		            error: function (reject) {
		                console.log(reject);
		                swal("실패", "", "error");
		            }
		        })
		    } else {
		        swal("경고", "값이 입력되지 않았습니다", "warning");
		    }
	
		}
		//두번째 그리드 데이터 리셋
		function resetPlanGrid(){
			$.ajax({
		        url: 'getResetPlanGridData',
		        method: 'GET',
		        success: function(result) {
		        	planGrid.resetData(result);
		        },
		        error : function(reject){
		        	console.log(reject);
		        }
			})
		        
		}
	
		//검색
		function selectAjax() {
		    let mat = $('#matCodeInput').val();
		    let act = $('#actCodeInput').val();
		    let sd = $('#startDate').val();
		    let ed = $('#endDate').val();
		    let comple = '1';
		    let before = '1';
		    let beforeCheck = document.getElementById('before');
		    let compleCheck = document.getElementById('comple');
		    if (beforeCheck.checked && !compleCheck.checked) {
		        comple = '2';
		    } else if (!beforeCheck.checked && compleCheck.checked) {
		        before = '2';
		    }
	
		    let search = {
		        materialCode: mat,
		        accountCode: act,
		        startDate: sd,
		        endDate: ed,
		        before: before,
		        comple: comple
		    };
		    $.ajax({
		        url: 'getMatOrderFilter',
		        method: 'GET',
		        data: search,
		        success: function (data2) {
	
		            $.each(data2, function (idx, obj) {
		                obj['matTotalPrice'] = obj['matPrice'] * obj['matAmt'];
		                let date = new Date(obj['matOdRq']);
		                let year = date.getFullYear(); //0000년 가져오기
		                let month = date.getMonth() + 1; //월은 0부터 시작하니 +1하기
		                let day = date.getDate(); //일자 가져오기
		                obj['matOdRq'] = year + "-" + (
		                    ("00" + month.toString()).slice(-2)
		                ) + "-" + (
		                    ("00" + day.toString()).slice(-2)
		                );
	
		                date = new Date(obj['matOdAcp']);
		                year = date.getFullYear(); //0000년 가져오기
		                month = date.getMonth() + 1; //월은 0부터 시작하니 +1하기
		                day = date.getDate(); //일자 가져오기
		                obj['matOdAcp'] = year + "-" + (
		                    ("00" + month.toString()).slice(-2)
		                ) + "-" + (
		                    ("00" + day.toString()).slice(-2)
		                );
	
		            })
		            orderGrid.resetData(data2);
		            setDisabled();
		        }
		    })
		}
	
		function findColumns() {
		    var rows = orderGrid.findRows({matOdCd: null});
		    return rows;
		}
	
		//거래처명, 자재명, 담당자명 클릭하면 모달창 나온 후 선택할 수 있음. 선택 시 hidden cell에 데이터 넘어감
		var Grid;
		$("#actModal, #selectActModal").on('click', event => {
	
		    $("#modal").fadeIn();
		    preventScroll();
		    Grid = createActGrid();
		    $('.modal_title h3').text('거래처 목록');
		    Grid.on('dblclick', event2 => {
		        let rowKey = Grid
		            .getFocusedCell()
		            .rowKey;
		        if (rowKey != null) {
		            let actCode = Grid.getValue(rowKey, 'actCode');
		            let actName = Grid.getValue(rowKey, 'actName');
		            $(event.currentTarget)
		                .prev()
		                .val(actCode);
		            $(event.currentTarget)
		                .next()
		                .val(actName);
		            if (event.currentTarget.id == 'selectActModal') {
		                var rows = findColumns();
		                $.each(rows, function (idx, obj) {
		                    obj.actCode = actCode;
		                    obj.actName = actName;
		                })
		            }
		        }
	
		        //모달창 닫기
		        if (rowKey != null) {
		            $("#modal").fadeOut();
		            activeScroll();
		            let inputContent = $('#modalSearch').val('');
		            if (Grid != null && Grid.el != null) {
		                Grid.destroy();
		            }
		        }
	
		    })
		});
	
		$("#matModal").click(function () {
		    $("#modal").fadeIn();
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
		            $("#matNameFix").val(matName);
	
		            $("#matCodeInput").val(matCode);
		        }
	
		        //모달창 닫기
		        if (rowKey != null) {
		            $("#modal").fadeOut();
		            activeScroll();
		            let inputContent = $('#modalSearch').val('');
		            if (Grid != null && Grid.el != null) {
		                Grid.destroy();
		            }
	
		        }
		    })
		});
	
		orderGrid.on('dblclick', ev => {
		    let rowKey = orderGrid
		        .getFocusedCell()
		        .rowKey;
		    let columnName = orderGrid
		        .getFocusedCell()
		        .columnName;
		    let value = orderGrid
		        .getFocusedCell()
		        .value;
	
		    let matOdCd = orderGrid.getValue(rowKey, 'matOdCd');
		    let matTestYn = orderGrid.getValue(rowKey, 'matTestYn');
		    if (matOdCd != null) {
		        if (matTestYn == 'Y') {
		            ev.stop();
		            return false;
		        }
		    }
	
		    if (columnName == 'matName') {
		        $("#modal").fadeIn();
		        preventScroll();
		        Grid = createMatGrid();
		        $('.modal_title h3').text('자재 목록');
		        Grid.on('dblclick', () => {
		            let rowKey2 = Grid
		                .getFocusedCell()
		                .rowKey;
		            if (rowKey2 != null) {
		                let matCode = Grid.getValue(rowKey2, 'matCode');
		                let matName = Grid.getValue(rowKey2, 'matName');
		                let matUnit = Grid.getValue(rowKey2, 'matUnit');
		                let matStd = Grid.getValue(rowKey2, 'matStd');
		                orderGrid.finishEditing(rowKey, columnName);
	
		                if (matCode != null) {
		                    orderGrid.setValue(rowKey, 'matCode', matCode);
		                }
		                if (matName != null) {
		                    orderGrid.setValue(rowKey, 'matName', matName);
		                }
		                if (matUnit != null) {
		                    orderGrid.setValue(rowKey, 'matUnit', matUnit);
		                }
		                if (matStd != null) {
		                    orderGrid.setValue(rowKey, 'matStd', matStd);
		                }
		            }
	
		            //선택시 모달창 닫기
		            if (rowKey2 != null) {
		                $("#modal").fadeOut();
		                activeScroll();
		                let inputContent = $('#modalSearch').val('');
		                if (Grid != null && Grid.el != null) {
		                    Grid.destroy();
		                }
		            }
	
		        })
		    }
	
		});
	
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
	
		//비활성화
		function setDisabled() {
		    $.each(orderGrid.getData(), function (idx, obj) {
	
		        if (obj['matOdCd'] != null && obj['matTestYn'] == 'Y') {
		            orderGrid.disableRow(obj['rowKey']);
		        }
		    })
		}
	
		//모달창 닫기
		$(".close_btn").click(function () {
		    $("#modal").fadeOut();
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
	
		//이전 날짜 선택불가
		$('#startDate').on('change', function () {
		    $('#endDate').attr('min', $('#startDate').val());
		});
		//이후날짜 선택불가
		$('#endDate').on('change', function () {
		    $('#startDate').attr('max', $('#endDate').val());
		});
	
		//검색
		$('#searchBtn').on('click', searchMatIn);
		function searchMatIn(e) {
		    let mat = $('#matCodeInput').val();
		    let act = $('#actCodeInput').val();
		    let sd = $('#startDate').val();
		    let ed = $('#endDate').val();
	
		    let search = {
		        materialCode: mat,
		        accountCode: act,
		        startDate: sd,
		        endDate: ed
		    };
		    selectAjax();
		}
	
		//초기화
		$('#searchResetBtn').on('click', resetInput);
		function resetInput(e) {
		    $('#searchP input').each(function (idx, obj) {
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
	
		//엑셀 다운로드
		const excelDownload = document.querySelector('.excelDownload');
	
		document.addEventListener('DOMContentLoaded', () => {
		    excelDownload.addEventListener('click', function (e) {
		        orderGrid.export('xlsx');
		    })
		})
	
		
	

    </script>
</body>
</html>