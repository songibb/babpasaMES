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
	justify-content: center;
}
#eqGrid{
	width: 400px;
	height: 50px;
}
#prcsBomGrid{
	width: 400px;
	height: 50px;
}
#timeContainer{
	height: 70px;
	display: flex; 
	justify-content: space-between;
	flex-direction: column;
}
#timeContainer input {
	width: 150px;
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
							<input type="text" name="prcsName" id="prcsName">	
						
							<label for="inputAmt">투입량</label>
							<input type="text" name="inputAmt" id="inputAmt">	
						</div>	
						<div>
							<label for="empCode">담당자</label>
							<input type="text" name="empCode" id="empCode">	
						
							<label for="errAmt">불량량</label>
							<input type="text" name="errAmt" id="errAmt">		
						</div>	
					</div>	
					
					<div id="gridContainer">
						<div id="eqGrid"></div>
						<div id="prcsBomGrid"></div>
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
	var Grid;
	var Grid2;
    ingGrid.on('click', () => {
 
		$(".modal").fadeIn();   	   	
		
		Grid = createEqGrid();
    	Grid2 = createPrcsBomGrid();
    	
    	//작업 시작 버튼 or 작업 종료 버튼 클릭 시 -> 모달창 닫기
    	$('#prcsStartBtn').click(function(){
// 			$(".modal").fadeOut();
// 			Grid.destroy();
// 			Grid2.destroy();
			
			//ajax 프로시저(대기중->가동중 update / prcsList에 진행 공정 정보 + 작업시작시간 insert)
// 			$.ajax({
// 			    url : '',
// 			    method : 'POST',
// 			    data : JSON.stringify(i),
// 			    contentType : 'application/json',
// 			    success : function(data){
// 			    	eqGrid.resetData(data);
// 			    },
// 			    error : function(reject){
// 			        console.log(reject);
// 			    }	
// 			})
    	})
    	
    	$('#prcsEndBtn').click(function(){
// 			$(".modal").fadeOut();
// 			Grid.destroy();
// 			Grid2.destroy();
			
			//ajax 프로시저(가동중->대기중 update / prcsList에 + 작업종료시간 udaate)
    	})

    })
    
    
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
    	
    	console.log(ingList);
    	console.log(prcsDirAmt);
    	
    	ingList['prcsDirAmt'] = prcsDirAmt;

		console.log(ingList);
    	
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
    
 	
	$("#close_btn").click(function(){
	    $(".modal").fadeOut();
	    Grid.destroy();
		Grid2.destroy();
// 		eqGrid.destroy();
// 		prcsBomGrid.destroy();
	});	
	
	

	</script>
</body>
</html>