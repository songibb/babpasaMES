<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>작업 등록</title>
</head>
<style>
.modal{
	position: fixed;
}
.m_body{
	height: 420px;
}
#modal_label{
	display: flex; 
	justify-content: space-between;
	flex-direction: column;
}
#inputContainer{
	display: flex; 
	justify-content: space-around;
	margin-bottom: 20px;
}
#gridContainer{
	display: flex; 
	justify-content: space-between;;
}
#eqGrid{
	width: 270px;
	height: 50px;
}
#prcsBomGrid{
	width: 270px;
	height: 50px;
}
#timeContainer{
	height: 70px;
	display: flex; 
	justify-content: space-between;
	flex-direction: column;
	margin-top: 15px;
}
#timeContainer input {
	width: 200px;
}
#leftPrcsStart, #rightPrcsEnd{
	display: flex;
	align-items: center;
	justify-content: center;
}
 
.m_footer{
	display: flex; 
	justify-content: flex-end;
}
.selected-cell{
	background-color: #ffd09e;
}
</style>
<body>

	<div class="modal">
		<div class="modal_content" title="클릭하면 창이 닫힙니다.">
			<div class="m_head">
				<div class="modal_title"><h3>공정 작업 관리</h3></div>
				<div class="close_btn" id="close_btn">X</div>
			</div>
			<div class="m_body">	
				<div id="modal_label">	
					<div id="inputContainer">
						<div>
							<label for="prcName">공정명</label>
							<input type="text" name="prcsName" id="prcsName" readonly>	
							<br>
							<label for="inputAmt">투입량</label>
							<input type="number" name="inputAmt" id="inputAmt" readonly>	
						</div>	
						<div>
							<input type="hidden" id="empCode" name="empCode">
							
							<label for="empName">담당자</label>
							<input type="text" name="empName" id="empName">	
							<br>
							<label for="errAmt">불량량</label>
							<input type="number" name="errAmt" id="errAmt">		
						</div>	
					</div>	
					<div id="gridContainer">
						<div>
							<span id="eqTitle">사용 가능한 설비</span>
							<div id="eqGrid"></div>
						</div>
						<div>
							<span>투입 자재별 소모량</span>
							<div id="prcsBomGrid"></div>
						</div>						
					</div>
				</div>

			</div>
			
			<div id="timeContainer">
				<div id="leftPrcsStart">
					<input type="text" name="prcsStartTime" id="prcsStartTime">		
					<button id="prcsStartBtn" class="btn btn-info btn-icon-text">작업시작</button>
				</div>
				
				<div id="rightPrcsEnd">
					<input type="text" name="prcsEndTime" id="prcsEndTime">	
					<button id="prcsEndBtn" class="btn btn-info btn-icon-text">작업종료</button>
				</div>
			</div>
							
<!-- 			<div class="m_footer">		 -->
<!-- 				<div class="modal_btn save" id="save_btn">닫기</div> -->
<!-- 			</div> -->
		</div>
	</div>
	
	
	<script type="text/javascript">		
	//진행 공정 클릭시 작업 관리 모달 출력	
	var eqGridFn;
	var prcsBomGridFn;
	
	//설비 그리드 생성
	function createEqGrid(){   	  	
    	var eqGrid = new tui.Grid({
			el: document.getElementById('eqGrid'),
	        scrollX: false,
	        scrollY: true,
	        minBodyHeight: 30,
	        rowHeaders: ['rowNum'],
	        selectionUnit: 'row',
	        bodyHeight: 240,
	        pageOptions : {
	        	useClient : true,
	        	type: 'scroll',
	        	perPage: 10
	        },
	        columns: [
	            {
	                header: '설비코드',
	                name: 'eqCode',
	                align: 'center'
	            },
	            {
	                header: '설비명',
	                name: 'eqName'
	            }
	        ]       
		});
    	
    	let rowKey = ingGrid.getFocusedCell().rowKey;
    	let ingList = ingGrid.getRow(rowKey);
		
   		//작업 시작 전: 사용가능한 설비 
   		$.ajax({
   		    url : 'waitEquipList',
   		    method : 'POST',
   		    data : JSON.stringify(ingList),
   		    contentType : 'application/json',
   		    success : function(data){
   		    	eqGrid.resetData(data);
   		    },
   		    error : function(reject){
   		        console.log(reject);
   		    }	
   		})
	    return eqGrid;
	}
    
    
    //선택한 설비 그리드 생성
	function createSelectEqGrid(){   	  	
    	var selEqGrid = new tui.Grid({
			el: document.getElementById('eqGrid'),
	        scrollX: false,
	        scrollY: true,
	        minBodyHeight: 30,
	        rowHeaders: ['rowNum'],
	        selectionUnit: 'row',
	        bodyHeight: 240,
	        pageOptions : {
	        	useClient : true,
	        	type: 'scroll',
	        	perPage: 10
	        },
	        columns: [
	            {
	                header: '설비코드',
	                name: 'eqCode',
	                align: 'center'
	            },
	            {
	                header: '설비명',
	                name: 'eqName'
	            }
	        ]       
		});

		//prcsDirDeCode 가져오기
		let dirRowKey = dirDeGrid.getFocusedCell().rowKey;
    	let prcsDirDeCode = dirDeGrid.getValue(dirRowKey, 'prcsDirDeCode');
		
    	//prcsCode 가져오기
    	let ingRowKey = ingGrid.getFocusedCell().rowKey;
    	let prcsCode = ingGrid.getValue(ingRowKey, 'prcsCode');
    	
   		//작업 시작 후: 선택한 설비 
 		$.ajax({
		    url : 'selectEquip',
		    method : 'POST',
		    data : { prcsDirDeCode : prcsDirDeCode , prcsCode : prcsCode },
		    success : function(data){
		    	selEqGrid.resetData(data);
		    	
		    	//선택된 설비는 파란색 row로 변경
		    	let rowKey = data[0]['rowKey'];
		    	selEqGrid.addRowClassName(rowKey, 'selected-cell');
		    	
		    },
		    error : function(reject){
		        console.log(reject);
		    }	
		})
	    return selEqGrid;
	}

    
    //공정별 자재 그리드 생성
    function createPrcsBomGrid(){
    	var prcsBomGrid = new tui.Grid({
            el: document.getElementById('prcsBomGrid'),
            scrollX: false,
            scrollY: true,
            minBodyHeight: 30,
    		rowHeaders: ['rowNum'],
    		bodyHeight: 240,
	        pageOptions : {
	        	useClient : true,
	        	type: 'scroll',
	        	perPage: 10
	        },
            columns: [
        	  {
                header: '자재코드',
                name: 'mpCode',
                hidden: true
              },
              {
                header: '자재명',
                name: 'matName'
              },
              {
                header: '자재소모량',
                name: 'bomAmt',
                formatter(e) {
                	if (e['value'] != null){
    	                val = e['value']
    	                    .toString()
    	                    .replace(/\B(?=(\d{3})+(?!\d))/g, ',');
    	                return val;
                	}
                },
                align: 'right'
              }
//               {
//                 header: '단위',
//                 name: 'bomUnit'
//               }
            ]
        });	
    	
    	let deRowKey = dirDeGrid.getFocusedCell().rowKey;
    	let prcsDirAmt = dirDeGrid.getValue(deRowKey, 'prcsDirAmt');
    	
    	let rowKey = ingGrid.getFocusedCell().rowKey;
    	let ingList = ingGrid.getRow(rowKey);
    	
    	ingList['prcsDirAmt'] = prcsDirAmt;
    	
		$.ajax({
		    url : 'matBomList',
		    method : 'POST',
		    data : JSON.stringify(ingList),
		    contentType : 'application/json',
		    success : function(data){
		    	prcsBomGrid.resetData(data);
		    },
		    error : function(reject){
		        console.log(reject);
		    }	
		})
		
	    return prcsBomGrid;
	}
	
	
	
	//현재 시간 구하기
	function getDateTime(){
		var today = new Date();
		
		var year = today.getFullYear();
		var month = ('0' + (today.getMonth() + 1)).substr(-2);
		var day = ('0' + today.getDate()).substr(-2);
		var hours = ('0' + today.getHours()).substr(-2); 
		var minutes = ('0' + today.getMinutes()).substr(-2);
		var seconds = ('0' + today.getSeconds()).substr(-2); 

		return year + '-' + month  + '-' + day + ' ' + hours + ':' + minutes  + ':' + seconds;			
	}
	
	
    ingGrid.on('click', () => {
    	
    	//선택한 행 색깔 바꾸기
		let selectKey = ingGrid.getFocusedCell().rowKey;
		ingGrid.addRowClassName(selectKey, 'selected-cell');
		//다른 행 선택시 기존에 클릭했던 행은 class제거
    	ingGrid.on('focusChange', () => {
    		ingGrid.removeRowClassName(selectKey, 'selected-cell');
	    })
    	
		$(".modal").fadeIn();   

		//모달창에 공정명, 투입량 정보 가져오기
	  	let rowKey = ingGrid.getFocusedCell().rowKey;
    	let prcsName = ingGrid.getValue(rowKey, 'prcsName');
    	let inputAmt = ingGrid.getValue(rowKey, 'inputAmt');  
    	$('#prcsName').val(prcsName);
		$('#inputAmt').val(inputAmt);
		
   		//모달창에 담당자 정보 가져오기
    	let empCode = ${user.id};
    	let empName = `${user.empName}`;
		$('#empCode').val(empCode);
		$('#empName').val(empName);
		
		//prcsDirDeCode 가져오기
		let dirRowKey = dirDeGrid.getFocusedCell().rowKey;
    	let prcsDirDeCode = dirDeGrid.getValue(dirRowKey, 'prcsDirDeCode');

    	//prcsCode 가져오기
    	let ingRowKey = ingGrid.getFocusedCell().rowKey;
    	let prcsCode = ingGrid.getValue(ingRowKey, 'prcsCode');
    	
		//모달창에 공정 실적관리 정보 가져오기
		$.ajax({
			url : 'selectPrcsInfoList',
			method : 'GET',
			data : { prcsDirDeCode : prcsDirDeCode , prcsCode : prcsCode },
			async : false,
			success : function(data){	
				
				//data가 빈 객체인지 확인
				let isEmpty = $.isEmptyObject(data);
				
				//공정 실적데이터가 없을 경우
				if(isEmpty){			
					//'사용 가능한 설비'로 문구 적용
					$("#eqTitle").text("사용 가능한 설비");
					
					//설비, bom 그리드 생성
					eqGridFn = createEqGrid();
					prcsBomGridFn = createPrcsBomGrid();	
					
					//선택한 행 색깔 바꾸기
					eqGridFn.on('click', () => {
						let rowKey = eqGridFn.getFocusedCell().rowKey;
						//선택된 설비 색깔 변경
				    	eqGridFn.addRowClassName(rowKey, 'selected-cell');
						//다른 행 선택시 기존에 클릭했던 행은 class제거
				    	eqGridFn.on('focusChange', () => {
					    	eqGridFn.removeRowClassName(rowKey, 'selected-cell');
					    })
					})
					
					//input태그 값 지우기(update된 해당 정보를 조회해서 불러올 것이므로)
			    	$('#empCode').val('');
			    	$('#errAmt').val('');
			    	$('#timeContainer input').val('');

			    	//담당자, 불량량 input 활성화
					$('#empCode').prop('readonly', false);
					$('#errAmt').prop('readonly', false);			
						
					//작업 버튼 활성화
					$('#prcsStartBtn').prop('disabled', false);
					$('#prcsEndBtn').prop('disabled', false);
							
				} else{

					let prcsStartTime = data['prcsStartTime'];
					let prcsEndTime = data['prcsEndTime'];
										
					if(prcsEndTime == null){
						//작업 시작
						
						//'사용 가능한 설비' 문구 -> '사용 중인 설비' 로 바꾸기
						$("#eqTitle").text("사용 중인 설비");
						
						//선택된 설비, bom그리드 생성
						eqGridFn = createSelectEqGrid();
						prcsBomGridFn = createPrcsBomGrid();	

	 					//담당자 가져오기	
	 					$('#empCode').val(data['empCode']);		
	 					//불량량 비워놓기 (비워놓지 않으면 이전에 클릭한 값이 넘어옴)
	 					$('#errAmt').val('');
	 					//작업시작시간 가져오기
	 					$('#prcsStartTime').val(data['prcsStartTime']);
	 					//작업종료시간 비워놓기 (비워놓지 않으면 이전에 클릭한 값이 넘어옴)
	 					$('#prcsEndTime').val('');
	 				
						//담당자 input 비활성화
	 					$('#empCode').prop('readonly', true);
						//불량량 input 활성화 (활성화 해놓지 않으면 이전에 클릭한 값이 비활성화일때 똑같이 비활성화됨)
						$('#errAmt').prop('readonly', false);
	 					//작업시작 버튼 비활성화
	 					$('#prcsStartBtn').prop('disabled', true);	
	 					//작업종료 버튼 활성화 (활성화 해놓지 않으면 이전에 클릭한 값이 비활성화일때 똑같이 비활성화됨)
						$('#prcsEndBtn').prop('disabled', false);
	 					
					} else{		
						//작업 종료
						
						//'사용 가능한 설비' 문구 -> '사용 중인 설비' 로 바꾸기
						$("#eqTitle").text("사용 중인 설비");
						
						//선택된 설비, bom그리드 생성
						eqGridFn = createSelectEqGrid();
						prcsBomGridFn = createPrcsBomGrid();
						
						//담당자 가져오기
						$('#empCode').val(data['empCode']);
						//불량량 가졍오기
						$('#errAmt').val(data['errAmt']);
						//작업시작시간 가져오기
						$('#prcsStartTime').val(data['prcsStartTime']);
						//작업종료시간 가져오기
						$('#prcsEndTime').val(data['prcsEndTime']);
					
						//담당자, 불량량 input 비활성화
						$('#empCode').prop('readonly', true);
						$('#errAmt').prop('readonly', true);					
						//작업시작 버튼 비활성화
						$('#prcsStartBtn').prop('disabled', true);						
						//작업종료 버튼 비활성화
						$('#prcsEndBtn').prop('disabled', true);	
					}
					
				}

		    },
		    error : function(reject){
		        console.log(reject);
		    }				
		})

    })
    

    //작업 시작 버튼
   	$('#prcsStartBtn').click(function(){	
   		
   		//모달창에 담당자 정보 가져오기
    	let empCode = ${user.id};
    	let empName = `${user.empName}`;
		$('#empCode').val(empCode);
		$('#empName').val(empName);
		
		let eqRowKey = eqGridFn.getFocusedCell().rowKey;
		let eqCode = eqGridFn.getValue(eqRowKey, 'eqCode');	

   		if($('#empCode').val() == '' || $('#empCode').val() == null){  			
   			//담당자 미입력시 작동X 
   			swal("경고", "담당자를 입력하세요.", "warning");   	
   			
   		} else if(eqCode == null){  			
   			//설비명 체크 안할 시 작동X
   			swal("경고", "설비를 선택하세요.", "warning"); 	
   			
   		} else{
   			
   			//이전 공정이 완료되었을 시 작업시작버튼 작동 시킬 변수 
   	  		let btnOk = true;
   			
   	  		let deRowKey = dirDeGrid.getFocusedCell().rowKey;
   	    	let dirDeCode = dirDeGrid.getValue(deRowKey, 'prcsDirDeCode');
   	    	let prodCode = dirDeGrid.getValue(deRowKey, 'prodCode');
   	    	  	    	
   	    	let deList = dirDeGrid.getData();
   	    	
   	    	let ingRowKey = ingGrid.getFocusedCell().rowKey;
   	    	let prcsIngCode = ingGrid.getValue(ingRowKey, 'prcsIngCode');
   	    	
   	    	let ingObj = {};
   	    	ingObj['prcsIngCode'] = prcsIngCode;
   	    	ingObj['prcsDirDeCode'] = dirDeCode;
   	    	ingObj['prodCode'] = prodCode;
   			
   			//해당 공정 이전 공정이 공정완료인지 확인할 ajax
   			$.ajax({
   				url : 'selectPrcsIngSts',
   				method : 'GET',
   				data : ingObj,
   				async : false,
   			    success : function(data){
					console.log(data);
   			    	//data가 'false'로 넘어오면 작업시작 할 수 없음
   			    	if(data == 'false'){
   			    		btnOk = false;
   			    	} else{
   			    		btnOk = true;
   			    	}
   			    	
   			    },
   			    error : function(reject){
   			        console.log(reject);
   			    }	  				
   			})
   			
   			if(btnOk){
   				
   				//작업 시작 시간 입력
   	   			let startTime = getDateTime();
   	   			$('#prcsStartTime').val(startTime);
   			
   	   			//prcsDirDeCode 가져오기
   	   			let dirRowKey = dirDeGrid.getFocusedCell().rowKey;
   	   			let prcsDirDeCode = dirDeGrid.getValue(dirRowKey, 'prcsDirDeCode');
   	   			//prcsIngCode 가져오기
   	   			let ingRowKey = ingGrid.getFocusedCell().rowKey;	
   	   			let prcsIngCode = ingGrid.getValue(ingRowKey, 'prcsIngCode');
   	   	    	//eqCode 가져오기
   	   			let eqRowKey = eqGridFn.getFocusedCell().rowKey;
   	   			let eqCode = eqGridFn.getValue(eqRowKey, 'eqCode');				
   	   			//empCode 값 가져오기
   	   			let empCode = document.getElementById('empCode').value;	
   			  			
   	   	    	//프로시저 매개변수에 필요한 값이 담긴 list 만들기
   	   			let startObj = {};
   	   	    	startObj['prcsDirDeCode'] = prcsDirDeCode;
   	   	    	startObj['prcsIngCode'] = prcsIngCode;
   	   			startObj['eqCode'] = eqCode;
   	   			startObj['empCode'] = empCode;
   	   			startObj['prcsStartTime'] = startTime;
   	   			
   	   			//ajax 프로시저
   	   			$.ajax({
   	   			    url : 'callPrcsStart',
   	   			    method : 'POST',
   	   			    data : startObj,
   	   			    success : function(data){
   	   			    	//담당자 input 비활성화
   	   					$('#empCode').prop('readonly', true);	
   	   			    	//작업시작 버튼 비활성화
   	   					$('#prcsStartBtn').prop('disabled', true);	
   	   			    },
   	   			    error : function(reject){
   	   			        console.log(reject);
   	   			    }	
   	   			})
   	   			
   			} else{
   				swal("경고", "이전 공정이 아직 완료되지 않았습니다.", "warning");
   				return false;
   			}
   			
   		}		
   	})

    	
   	//작업 종료 버튼
   	$('#prcsEndBtn').click(function(){
   		//모달창에 담당자 정보 가져오기
    	let empCode = ${user.id};
    	let empName = `${user.empName}`;
		$('#empCode').val(empCode);
		$('#empName').val(empName);
		

		
		if($('#prcsStartTime').val() == '' || $('#prcsStartTime').val() == null){			
			//작업시작시간에 값이 없다면 아직 작업을 시작 안한 것이므로 작동X
			swal("경고", "아직 작업을 시작하지 않았습니다.", "warning");
			
		} else if($('#errAmt').val() == '' || $('#errAmt').val() == null){			
   			//불량량 미입력시 작동X
   			swal("경고", "불량량을 입력하세요.", "warning");
   			
   		} else if(Number($('#errAmt').val()) > Number($('#inputAmt').val())){
   			//불량량이 투입량보다 클 경우 작동X
   			swal("경고", "불량량이 투입량보다 큽니다.", "warning");
   			
   		} else{
			//작업 종료 시간 입력
			let endTime = getDateTime();
			$('#prcsEndTime').val(endTime);		
			
			//prcsDirDeCode 가져오기
			let dirRowKey = dirDeGrid.getFocusedCell().rowKey;
			let prcsDirDeCode = dirDeGrid.getValue(dirRowKey, 'prcsDirDeCode');
			//prcsCode 가져오기
			let ingRowKey = ingGrid.getFocusedCell().rowKey;	
			let prcsIngCode = ingGrid.getValue(ingRowKey, 'prcsIngCode');
			//errAmt 가져오기
			let errAmt = document.getElementById('errAmt').value;					
	    	//eqCode 가져오기
	    	eqGridFn.focus(0, 'eqCode');
			let eqRowKey = eqGridFn.getFocusedCell().rowKey;
			let eqCode = eqGridFn.getValue(eqRowKey, 'eqCode');	
	
			//empCode 가져오기
			let empCode = document.getElementById('empCode').value;	
		
			//프로시저 매개변수에 필요한 값이 담긴 list 만들기
			let endObj = {};
			endObj['prcsDirDeCode'] = prcsDirDeCode;
			endObj['prcsIngCode'] = prcsIngCode;
			endObj['eqCode'] = eqCode;
			endObj['errAmt'] = errAmt;
			endObj['prcsEndTime'] = endTime;
			
			//ajax 프로시저
			$.ajax({
			    url : 'callPrcsEnd',
			    method : 'POST',
			    data : endObj,
			    success : function(data){
			    	//불량량 input 비활성화
					$('#errAmt').prop('readonly', true);			
					//작업 종료 버튼 비활성화
					$('#prcsEndBtn').prop('disabled', true);
			    },
			    error : function(reject){
			        console.log(reject);
			    }	
			})
   		}
   	})
   
   	
    //닫기 버튼 
	$("#close_btn").click(function(){
		let rowKey1 = dirGrid.getFocusedCell().rowKey;
		let rowKey2 = dirDeGrid.getFocusedCell().rowKey;
		let rowKey3 = ingGrid.getFocusedCell().rowKey;

		
		$(".modal").fadeOut();			
	 	eqGridFn.destroy();
	 	prcsBomGridFn.destroy();
	 
	 	//공정진행관리 조회해서 정보 update
    	let deRowKey = dirDeGrid.getFocusedCell().rowKey;
    	let dirDeCode = dirDeGrid.getValue(deRowKey, 'prcsDirDeCode');
    	let prodCode = dirDeGrid.getValue(deRowKey, 'prodCode');	
    	$.ajax({
			url : 'prcsIngList',
			method : 'GET',
			data : { prcsDirDeCode : dirDeCode, prodCode : prodCode },
			success : function(data){
				let ingRowKey = ingGrid.getFocusedCell().rowKey;
				$.each(data,function(i, obj){
					ingGrid.setValue(i, 'inputAmt', obj['inputAmt']);
					ingGrid.setValue(i, 'errAmt', obj['errAmt']);
					ingGrid.setValue(i, 'prcsAmt', obj['prcsAmt']);
					ingGrid.setValue(i, 'prcsDirIngSts', obj['prcsDirIngSts']);
						
// 					if(i == ingRowKey){
// 						ingGrid.setValue(i, 'prcsDirIngSts', obj['prcsDirIngSts']);
// 						ingGrid.setColumnValues(columnName, columnValue, checkCellState)
// 					}
				})
				
				//조회하면서 focus 해제된 부분 다시 focus하고 색깔 채우기
				ingGrid.focus(rowKey3, 'prcsIngCode');
				let selectKey = ingGrid.getFocusedCell().rowKey;
				ingGrid.addRowClassName(selectKey, 'selected-cell');
 		    },
			error : function(reject){
	 			console.log(reject);
	 		}	
		})
		
		//상세생산지시 조회해서 정보 update
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
				
				//공정상태 정보 update
				let deRowKey = dirDeGrid.getFocusedCell().rowKey;
				$.each(data,function(i, obj){
					if(i == deRowKey){
						dirDeGrid.setValue(i, 'prcsIngSts', obj['prcsIngSts']);
					}
				})
				
				//조회하면서 focus 해제된 부분 다시 focus하고 색깔 채우기
				dirDeGrid.focus(rowKey2, 'prcsDirDeCode');
				let selectKey = dirDeGrid.getFocusedCell().rowKey;
				dirDeGrid.addRowClassName(selectKey, 'selected-cell');
				
				//재지시 완료된 행들은 사용불가
				let dirDeList = dirDeGrid.getData();
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
		
		//생산지시 조회해서 '공정진행중' 정보 update
		$.ajax({
			url : 'selectPrcsDirList',
			method : 'GET',
			success : function(data){	
				//날짜 츨력 포맷 변경
				$.each(data, function(i, objDe){
					let psd = data[i]['prcsStartDate'];
					data[i]['prcsStartDate'] = getDate(psd);
				})
				
				dirGrid.resetData(data);
				
				//조회하면서 focus 해제된 부분 다시 focus하고 색깔 채우기
				dirGrid.focus(rowKey1, 'prcsDirCode');
				let selectKey = dirGrid.getFocusedCell().rowKey;
				dirGrid.addRowClassName(selectKey, 'selected-cell');
				
			},
			error : function(reject){
				console.log(reject);
			}
		});

	});	
   



	</script>
</body>
</html>