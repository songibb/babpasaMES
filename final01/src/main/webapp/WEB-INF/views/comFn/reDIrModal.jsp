<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재지시 목록</title>
</head>
<body>

	<div class="modal">
		<div class="modal_content" title="클릭하면 창이 닫힙니다.">
			<div class="m_head">
				<div class="modal_title"><h3>재지시 목록</h3></div>
				<div class="close_btn" id="close_btn">X</div>
			</div>
			<div class="m_body">
				<div id="modal_label"></div>
			</div>
<!-- 			<div class="m_footer"> -->
<!-- 				<div class="modal_btn save" id="save_btn">선택</div> -->
<!-- 			</div> -->
		</div>
	</div>
	
	
	<script type="text/javascript">	
	//재지시 목록 모달
	$("#reDirModal").click(function(){
	    $(".modal").fadeIn();
	    Grid = createReDirGrid();
	    
	    Grid.on('click', () => {

// 			dirGrid.clear();
// 			dirGrid.appendRow({'empCode' : ${user.id}, 'empName' : `${user.empName}`});
// 			dirDeGrid.clear();
// 			dirDeGrid.appendRow();
			
// 			let rowKey = Grid.getFocusedCell().rowKey;
// 	        let planCode = Grid.getValue(rowKey, 'prcsPlanCode');
// 	        let prcsStartDate = Grid.getValue(rowKey, 'prcsStartDate');

	        //모달창 닫기
	        if(rowKey != null){
	            $(".modal").fadeOut();
	            Grid.destroy();   
				
	    		$.ajax({
	    			url : 'prcsPlanDeList',
	    			method : 'GET',
	    			data : { prcsPlanCode : planCode },
	    			success : function(data){
	    	          	//선택한 계획의 내역(계획코드, 제품코드, 주문수량) 그리드에 가져오기
	    	          	dirGrid.setColumnValues('prcsPlanCode', planCode);
	    	          	dirGrid.setColumnValues('prcsStartDate', prcsStartDate);
	    	          	dirDeGrid.resetData(data);

	    	          	dirDeGrid.setColumnValues('empCode', ${user.id});
	    	          	dirDeGrid.setColumnValues('empName', `${user.empName}`);
	    			},
	    			error : function(reject){
	    	 			console.log(reject);
	    	 		}	
	    		})
	        }
	    });
	    
	});
	

	
	function createReDirGrid(){
	    var reDirGrid = new tui.Grid({
	        el: document.getElementById('modal_label'),
	        scrollX: false,
	        scrollY: false,
	        minBodyHeight: 30,
	        rowHeaders: ['rowNum'],
	        selectionUnit: 'row',
	        pagination: true,
	        pageOptions: {
	            useClient: true,
	            perPage: 10
	        },
	        columns: [
	            {
	                header: '지시코드',
	                name: 'prcsDirCode',
	            },
	            {
	                header: '지시명',
	                name: 'prcsDirName'
	            },
	            {
	                header: '지시일자',
	                name: 'prcsDirDate'
	            },
	            {
	                header: '제품명',
	                name: 'prodCode',
	                hidden: true
	            },
	            {
	                header: '생산계획량',
	                name: 'prcsPlanAmt',
	                hidden: true
	            },
	            {
	            	header: '생산예정일',
	            	name: 'prcsStartDate'
	            }
	            
	        ]       
	    });
		
		$.ajax({
		    url : 'notDirPlanList',
		    method : 'GET',
		    success : function(data){
		    	//날짜 츨력 포맷 변경
				$.each(data, function(i, objDe){
					let ppd = data[i]['prcsPlanDate'];
					let psd = data[i]['prcsStartDate'];
					data[i]['prcsPlanDate'] = getDate(ppd);
					data[i]['prcsStartDate'] = getDate(psd);
					
				})
		    	Grid.resetData(data);
		    },
		    error : function(reject){
		        console.log(reject);
		    }	
		})
	    return reDirGrid;
	}
	
	
	$("#close_btn").click(function(){
	    $(".modal").fadeOut();
	  	Grid.destroy();
	});	
	</script>
</body>
</html>