<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>작업 등록</title>
</head>
<style>
#gridContainer{
	display: flex; 
	justify-content: center;
}
#eqGrid{
	width: 400px;
}
#prcsBomGrid{
	width: 400px;
}

</style>
<body>

	<div class="modal">
		<div class="modal_content" title="클릭하면 창이 닫힙니다.">
			<div class="m_head">
				<div class="modal_title"><h3>미계획 주문서 목록</h3></div>
				<div class="close_btn" id="close_btn">X</div>
			</div>
			<div class="m_body">	
				<div id="modal_label">
				
					<table>
						<tr>
							<th>공정명</th>
							<td><input type="text" name="prcsName" id="prcsName"></td>
							<th>담당자</th>
							<td><input type="text" name="empCode" id="empCode"></td>
						</tr>
						<tr>
							<th>투입량</th>
							<td><input type="text" name="inputAmt" id="inputAmt"></td>
							<th>불량량</th>
							<td><input type="text" name="errAmt" id="errAmt"></td>
						</tr>
					</table>
					<div id="gridContainer">
						<div id="eqGrid"></div>
						<div id="prcsBomGrid"></div>
					</div>
					
					<button id="prcsStartBtn">작업시작</button>
					<button id="prcsEndBtn">작업종료</button>

				</div>
			</div>
			<div class="m_footer">
				<div class="modal_btn save" id="save_btn">선택</div>
			</div>
		</div>
	</div>
	
	
	<script type="text/javascript">		
	//진행 공정 클릭시 작업 관리 모달 출력	
	var Grid;
	var Grid2;
    ingGrid.on('click', () => {
    	let rowKey = dirGrid.getFocusedCell().rowKey;
    	let ingList = ingGrid.getRow(rowKey);
    	  	
		$(".modal").fadeIn();   	   	
		
		Grid = createEqGrid();
    	Grid2 = createPrcsBomGrid();

    	
    	//작업 시작 버튼 or 작업 종료 버튼 클릭 시 -> 모달창 닫기
    	$('#prcsStartBtn').click(function(){
			$(".modal").fadeOut();
			Grid.destroy();
			Grid2.destroy();
			
			//ajax 프로시저(대기중->가동중 update / prcsList에 + 작업시작시간 insert)
    	})
    	
    	$('#prcsEndBtn').click(function(){
			$(".modal").fadeOut();
			Grid.destroy();
			Grid2.destroy();
			
			//ajax 프로시저(가동중->대기중 update / prcsList에 + 작업종료시간 udaate)
    	})

    })
    
    
    //설비 그리드 생성
	function createEqGrid(){   	  	
    	var eqGrid = new tui.Grid({
			el: document.getElementById('eqGrid'),
	        scrollX: false,
	        scrollY: false,
	        minBodyHeight: 30,
	        rowHeaders: ['checkbox'],
	        selectionUnit: 'row',
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
    	
    	let rowKey = dirGrid.getFocusedCell().rowKey;
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
            scrollY: false,
            minBodyHeight: 30,
    		rowHeaders: ['rowNum'],
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
		
    	let rowKey = dirGrid.getFocusedCell().rowKey;
    	let ingList = ingGrid.getRow(rowKey);
    	
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