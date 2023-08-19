<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>작업 등록</title>
</head>
<style>
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
	justify-content: space-between;
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
						
							<label for="inputAmt">투입량</label>
							<input type="text" name="inputAmt" id="inputAmt" readonly>	
						</div>	
						<div>
							<label for="empCode">담당자</label>
							<input type="text" name="empCode" id="empCode">	
						
							<label for="errAmt">불량량</label>
							<input type="number" name="errAmt" id="errAmt">		
						</div>	
					</div>	
					<div id="gridContainer">
						<div>
							<span>사용 가능한 설비</span>
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
	var eqGrid;
	var prcsBomGrid;
	
    ingGrid.on('click', () => {
		$(".modal").fadeIn();   
		
		//모달창 내 공정명, 투입량 정보 가져오기
	  	let rowKey = ingGrid.getFocusedCell().rowKey;
    	let prcsName = ingGrid.getValue(rowKey, 'prcsName');
    	let inputAmt = ingGrid.getValue(rowKey, 'inputAmt');  	
		$('#prcsName').val(prcsName);
		$('#inputAmt').val(inputAmt);
		
		//모달 창 내 공정 실적관리 정보 가져오기
// 		$.ajax({
// 			url : 'select',
// 			method : 'GET',
// 			success : function(data){
				
// 				if(data != null){
// 					$('#prcsStartTime').val(data);
// 					$('#prcsEndTime').val(data);
// 				}
				
// 		    },
// 		    error : function(reject){
// 		        console.log(reject);
// 		    }	
			
// 		})
		
		
		//그리드 생성
		eqGrid = createEqGrid();
		prcsBomGrid = createPrcsBomGrid();
		
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
		
    	
    	//작업 시작 버튼
    	$('#prcsStartBtn').click(function(){
			
			//작업 시작 시간 입력
			let startTime = getDateTime();
			$('#prcsStartTime').val(startTime);
			
			//담당자 input 비활성화
			$('#empCode').prop('readonly', true);
			
			//작업 시작 버튼 비활성화
			$('#prcsStartBtn').prop('disabled', true);
			

			//프로시저에 필요한 값 prcs_dir_de_code, eq_code, emp_code, prcs_start_time
						
			//prcsDirDeCode 가져오기
			let rowKey = dirDeGrid.getFocusedCell().rowKey;
	    	let prcsDirDeCode = dirDeGrid.getValue(rowKey, 'prcsDirDeCode');
	    	
	    	//eqCode 가져오기
			let eqRowKey = eqGrid.getFocusedCell().rowKey;
			let eqCode = eqGrid.getValue(rowKey, 'eqCode');
			
			//input태그에 입력된 empCode 값 가져오기
			let empCode = document.getElementById('empCode').value;	
			
						
	    	//프로시저 매개변수에 필요한 값이 담긴 list 만들기
			let prcsStartList = [];
			let startObj = {};
	    	startObj['prcsDirDeCode'] = prcsDirDeCode;
			startObj['eqCode'] = eqCode;
			startObj['empCode'] = empCode;
			startObj['prcsStartTime'] = startTime;
			
	    	prcsStartList.push(startObj);
	    	
	    	console.log(prcsStartList);
	    	
// 			//체크한 행들의 prcsPlanCode가 담긴 list 만들기
// 			let checkList = planGrid.getCheckedRows();
// 			let planCodeList = [];			
// 			$.each(checkList, function(i, obj){
// 				//let planCodeObj = {};
// 				//planCodeObj['prcsPlanCode'] = checkList[i]['prcsPlanCode'];
// 				planCode = checkList[i]['prcsPlanCode'];
// 				planCodeList.push(planCode);
// 				//planCodeList.push(planCodeObj);
// 			})
			
			
			
			//ajax 프로시저(대기중->가동중 update / prcsList에 진행 공정 정보 + 작업시작시간 insert)
			$.ajax({
			    url : 'callPrcsStart',
			    method : 'POST',
			    data : JSON.stringify(prcsStartList),
			    contentType : 'application/json',
			    success : function(data){
			    	eqGrid.resetData(data);
			    },
			    error : function(reject){
			        console.log(reject);
			    }	
			})
    	})
    	
    	//작업 종료 버튼
    	$('#prcsEndBtn').click(function(){
			
			//작업 종료 시간 입력
			let endTime = getDateTime();
			$('#prcsEndTime').val(endTime);
			
			//불량량 input 비활성화
			$('#errAmt').prop('readonly', true);
			
			//작업 시작 버튼 비활성화
			$('#prcsEndBtn').prop('disabled', true);
			
			
			//input태그에 입력된 값 가져오기
			let errAmt = document.getElementById('errAmt').value;			
			
			//ajax 프로시저(가동중->대기중 update / prcsList에 + 작업종료시간 udaate)
    	})

    })
    
    
   //닫기 버튼 
   	$("#close_btn").click(function(){
    	$(".modal").fadeOut();
    	
    	//input태그 값 지우기(update된 해당 정보를 조회해서 불러올 것이므로)
    	$('#inputContainer input').val('');
    	//document.getElementById(id).value = null;;
    	

		eqGrid.destroy();
		prcsBomGrid.destroy();
	});	
	
	
    
    
    
    //설비 그리드 생성
	function createEqGrid(){   	  	
    	var eqGrid = new tui.Grid({
			el: document.getElementById('eqGrid'),
	        scrollX: false,
	        scrollY: true,
	        minBodyHeight: 30,
	        rowHeaders: ['rowNum'],
	        selectionUnit: 'row',
	        bodyHeight: 250,
	        pageOptions : {
	        	useClient : true,
	        	type: 'scroll',
	        	perPage: 10
	        },
	        columns: [
	            {
	                header: '설비코드',
	                name: 'eqCode',
	            },
	            {
	                header: '설비명',
	                name: 'eqName'
	            }
	        ]       
		});
    	
    	let rowKey = ingGrid.getFocusedCell().rowKey;
    	let ingList = ingGrid.getRow(rowKey);

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
    
    
    //공정별 자재 그리드 생성
    function createPrcsBomGrid(){
    	var prcsBomGrid = new tui.Grid({
            el: document.getElementById('prcsBomGrid'),
            scrollX: false,
            scrollY: true,
            minBodyHeight: 30,
    		rowHeaders: ['rowNum'],
    		bodyHeight: 250,
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
                name: 'bomAmt'
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
    
 	


	</script>
</body>
</html>