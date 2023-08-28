<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>생산 관리</title>

<!-- 토스트 페이지 네이션 -->
<script type="text/javascript" src="https://uicdn.toast.com/tui.code-snippet/latest/tui-code-snippet.js"></script>
<link rel="stylesheet" href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css" />
<script src="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.js"></script>
<!-- 페이지 네이션 끝 -->
<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>

<style type="text/css">
#customtemplateSearchAndButton{
	margin-bottom: 30px;
}
#dirContainer{
	display: flex;
	justify-content: space-between;
}
.leftGrid{
    width: 800px;
    margin-right: 20px;
}
.leftGridHeader{
	height: 45px;
	display: flex;
	justify-content: space-between;
}
.rightGrid{
    width: 800px;
}
.rightGridHeader{
	height: 45px;
	display: flex;
	justify-content: space-between;
}

.yellow-background {
	background-color: rgb(255,253,235);
}

input[type="date"] {
  width: 15%;
  padding: 5px;
  margin-bottom: 35px;
  border: 1px solid #ccc;
  border-radius: 4px;
}

form p{
	width: 125px;
	display: inline-block;
	font-size: 20px;
}

h1{
	margin-left: 15px;
}
h1, h2{
	font-weight: 800;
}
</style>
</head>
<body>
	<div class="black_bg"></div>
	<h1>생산 관리</h1>
	<div class="col-lg-12 stretch-card">
		<div class="card">
			<div class="card-body">
				<div class="table-responsive pt-3">	
					<form>
						<p>생산 시작일자</p>
						<input type="date" id="startDate" name="startDate" value="">&nbsp;&nbsp;-&nbsp;&nbsp;<input type="date" id="endDate" name="endDate" value="">		

						<button type="button" class="btn btn-info btn-icon-text" id="searchBtn">
							<i class="fas fa-search"></i>검색
						</button>
						<button type="reset" class="btn btn-info btn-icon-text">초기화</button>
	            	</form>
	            </div>
	            	
	            <div>
	           		<div id="dirContainer">
						<div class="leftGrid">
							<div class="leftGridHeader">
				            	<h2>생산 지시</h2>	
							</div>
							<div id="dirGrid"></div>
						</div>
						
						<div class="rightGrid">
							<div class="rightGridHeader">
		           				<h2>상세 생산 지시</h2>
		           				<div>
		           					<button id="reDir" class="btn btn-info btn-icon-text">재지시</button>
		           				</div>
		      				</div>
		           			<div id="dirDeGrid"></div>
						</div>
					</div>
	           		
	           		<div id="ingGrid"></div>
				</div>
	   		</div>
		</div>
	</div> 
	
	
	
	<div>
		<jsp:include page="../comFn/dateFormat.jsp"></jsp:include>
	</div>
    
	<script>
	
	//검색
	document.getElementById('searchBtn').addEventListener('click', searchDirist);
	//재지시
	document.getElementById('reDir').addEventListener('click', reDirInsert);
	
	//검색 
	function searchDirist(){
		let searchObj = {};
		searchObj['startDate'] = $('#startDate').val();
		searchObj['endDate'] = $('#endDate').val();	   

		$.ajax({
			url : 'selectPrcsDirList',
			method : 'GET',
			data : searchObj,
			success : function(data){	
				//날짜 츨력 포맷 변경
				$.each(data, function(i, objDe){
					let psd = data[i]['prcsStartDate'];
					data[i]['prcsStartDate'] = getDate(psd);
				})
				dirGrid.resetData(data);
				dirDeGrid.clear();	
				ingGrid.clear();
				},
			error : function(reject){
				console.log(reject);
			}
		});
	};
	
	//재지시 등록 (품질검사부적합시 사용)
	function reDirInsert(){
		//체크한 행들의 정보 가져오기
		let checkList = dirDeGrid.getCheckedRows();

		//체크한 행들에서 품질검사부적합이 있는지 체크할 변수
		let nonPassCk = 0;
		
		$.each(checkList, function(i, obj){
			//담당자는 재지시 버튼 누르는 사람으로 바뀌어야하므로 다시 지정
			checkList[i]['empCode'] = ${user.id};

			//품질검사부적합이 있을 때마다 1씩 증가
			if(checkList[i]['prcsIngSts'] == '품질검사부적합'){
				nonPassCk++;
			}

		})
		
		console.log(checkList);
		if(nonPassCk == 0){
			//체크한 리스트에 품질검사부적합이 없을시 경고창
			swal("경고", "재지시를 등록할 사항이 없습니다.", "warning");	
			
		} else if(nonPassCk != checkList.length){
			//체크한 리스트에 품질검사부적합이 없는 사항을 포함했을시 경고창
			swal("경고", "체크사항을 다시 확인해주세요", "warning");
			
		} else{
			$.ajax({
				url : 'insertReDirDe',
				method : 'POST',
				data : JSON.stringify(checkList),
				contentType : 'application/json',
				success : function(data){	
					console.log(data);
					swal("등록이 완료되었습니다.", "", "success");
					
					//클릭한 지시의 지시코드 가져오기
			    	let rowKey = dirGrid.getFocusedCell().rowKey;
			    	let dirCode = dirGrid.getValue(rowKey, 'prcsDirCode');

			    	$.ajax({
						url : 'prcsDirDeList',
						method : 'GET',
						data : { prcsDirCode : dirCode },
						success : function(data){
							//날짜 츨력 포맷 변경
							$.each(data, function(i, objDe){
								let psdd = data[i]['prcsStartDeDate'];
								let pedd = data[i]['prcsEndDeDate'];
								data[i]['prcsStartDeDate'] = getDate(psdd);
								data[i]['prcsEndDeDate'] = getDate(pedd);
							})
							
							dirDeGrid.resetData(data);
							
							//재지시 완료된 행들은 사용불가
							$.each(checkList, function(idx, obj){
								dirDeGrid.disableRow(obj['rowKey']);
							});
							
			 		    },
						error : function(reject){
				 			console.log(reject);
				 		}	
					})
				
				},
				error : function(reject){
					console.log(reject);
				}
			});

		}

	}
	
	//생산지시 조회
    var dirGrid = new tui.Grid({
        el: document.getElementById('dirGrid'),
        data: [
	           <c:forEach items="${dirList}" var="d" varStatus="status">
	           	{
	           		prcsDirCode : "${d.prcsDirCode}",
	           		prcsPlanCode : "${d.prcsPlanCode}",
	           		prcsDirName : "${d.prcsDirName}",
	           		prcsStartDate : "<fmt:formatDate value='${d.prcsStartDate}' pattern='yyyy-MM-dd'/>",
	           		prcsDirSts : "${d.prcsDirSts}",
	           		empName : "${d.empName}"
	           	} <c:if test="${not status.last}">,</c:if>
	           </c:forEach>
	          ],
        scrollX: false,
        scrollY: false,
        minBodyHeight: 120,
		rowHeaders: ['rowNum'],
		pagination: true,
		pageOptions: {
			useClient: true,
			perPage: 3,
		},
		 
        columns: [
          {
            header: '지시코드',
            name: 'prcsDirCode'
          },
          {
            header: '계획코드',
            name: 'prcsPlanCode'
          },
          {
            header: '지시명',
            name: 'prcsDirName'
          },
          {
            header: '생산시작일자',
            name: 'prcsStartDate',
            className: 'yellow-background'
          },
          {
            header: '지시상태',
            name: 'prcsDirSts'
          },
          {
            header: '담당자코드',
            name: 'empCode',
            hidden: true
          },
          {
            header: '담당자',
            name: 'empName'
          },
        ]
      })  

	
	//상세생산지시 조회
	var dirDeGrid = new tui.Grid({
        el: document.getElementById('dirDeGrid'),
        scrollX: false,
        scrollY: false,
        minBodyHeight: 120,
		rowHeaders: ['rowNum', 'checkbox'],
		pagination: true,
		pageOptions: {
			useClient: true,
			perPage: 3,
		},
        columns: [
          {
            header: '상세지시코드',
            name: 'prcsDirDeCode',
            width: 'auto'
          },
          {
            header: '제품코드',
            name: 'prodCode',
            hidden: true
          },
          {
            header: '제품명',
            name: 'prodName'
          },
          {
            header: '생산계획량',
            name: 'prcsPlanAmt'
          },
          {
            header: '지시수량',
            name: 'prcsDirAmt'
          },
//           {
//             header: '생산시작일자',
//             name: 'prcsStartDeDate'
//           },
//           {
//             header: '생산마감일자',
//             name: 'prcsEndDeDate'
//           },
          {
            header: '공정진행상태',
            name: 'prcsIngSts'
          },
          {
            header: '담당자코드',
            name: 'empCode',
            hidden: true
          },
          {
            header: '담당자',
            name: 'empName'
          },
          {
            header: '재지시여부',
            name: 'reDirCk',
            hidden: true
          }
        ]
      })  
	
	
 	//진행 공정 조회
	var ingGrid = new tui.Grid({
        el: document.getElementById('ingGrid'),
        scrollX: false,
        scrollY: false,
        minBodyHeight: 280,
		rowHeaders: ['rowNum'],
		pagination: true,
		pageOptions: {
			useClient: true,
			perPage: 10
		},
        columns: [
          {
            header: '진행공정관리코드',
            name: 'prcsIngCode'
          },
          {
            header: '상세지시코드',
            name: 'prcsDirDeCode',
            hidden: true
          },
          {
            header: '제품코드',
            name: 'prodCode',
            hidden: true
          },
          {
            header: '제품명',
            name: 'prodName'
          },
          {
            header: '공정코드',
            name: 'prcsCode',
            hidden: true
          },
          {
            header: '공정명',
            name: 'prcsName'
          },
          {
            header: '공정순서',
            name: 'prcsSeq'
          },
          {
            header: '투입량',
            name: 'inputAmt'
          },
          {
            header: '불량량',
            name: 'errAmt'
          },
          {
            header: '생산량',
            name: 'prcsAmt'
          },
          {
            header: '공정상태',
            name: 'prcsDirIngSts'
          }
        ]
      })  
	
	
	//생산지시 클릭시 해당 지시의 상세 생산지시 조회
    dirGrid.on('click', () => {
    	//클릭한 지시의 지시코드 가져오기
    	let rowKey = dirGrid.getFocusedCell().rowKey;
    	let dirCode = dirGrid.getValue(rowKey, 'prcsDirCode');

    	$.ajax({
			url : 'prcsDirDeList',
			method : 'GET',
			data : { prcsDirCode : dirCode },
			success : function(data){
				//날짜 츨력 포맷 변경
				$.each(data, function(i, objDe){
					let psdd = data[i]['prcsStartDeDate'];
					let pedd = data[i]['prcsEndDeDate'];
					data[i]['prcsStartDeDate'] = getDate(psdd);
					data[i]['prcsEndDeDate'] = getDate(pedd);
				})
				
				dirDeGrid.resetData(data);
				
				let dirDeList = dirDeGrid.getData();
				
				//재지시 완료된 행들은 사용불가
				$.each(dirDeList, function(i, obj){
					if(dirDeList[i]['reDirCk'] == 'Y'){		
						dirDeGrid.disableRow(obj['rowKey']);
					}
				});	
				
 		    },
			error : function(reject){
	 			console.log(reject);
	 		}	
		})
  	});
	
	
  	//상세 생산지시 클릭시 해당 지시의 진행 공정 조회
    dirDeGrid.on('click', () => {
    	//클릭한 상세 지시의 상세지시코드, 제품코드 가져오기
    	let rowKey = dirDeGrid.getFocusedCell().rowKey;
    	let dirDeCode = dirDeGrid.getValue(rowKey, 'prcsDirDeCode');
    	let prodCode = dirDeGrid.getValue(rowKey, 'prodCode');
    	
		//클릭한 상세 지시의 제품코드 가져오기
    	$.ajax({
			url : 'prcsIngList',
			method : 'GET',
			data : { prcsDirDeCode : dirDeCode, prodCode : prodCode },
			success : function(data){
				ingGrid.resetData(data);
 		    },
			error : function(reject){
	 			console.log(reject);
	 		}	
		})
  	});
  	
  	
  	//생산지시 -> 생산완료 update
	let dirList = dirGrid.getData();
	
	function updateDirPrcsStsAjax(){
		$.ajax({
			url : 'updateDirPrcsSts',
			method : 'POST',
			data : JSON.stringify(dirList),
			contentType : "application/json",
			success : function(data){
				//console.log(data);
			},
			error : function(reject){
	 			console.log(reject);
	 		}
		})
	}

	updateDirPrcsStsAjax();
   
 
	
	
    
	</script>
	
	<div>
		<jsp:include page="../comFn/prcsIngModal.jsp"></jsp:include>
	</div>
</body>
</html>