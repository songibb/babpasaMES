<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>미지시 생산계획 목록</title>
<style type="text/css">
 .selected-cell{
	background-color: #ffd09e;
}
</style>
</head>
<body>

	<div class="modal">
		<div class="modal_content" title="클릭하면 창이 닫힙니다.">
			<div class="m_head">
				<div class="modal_title"><h3>미지시 생산계획 목록</h3></div>
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
	//미지시 생산계획 모달
	$("#planModal").click(function(){
	    $(".modal").fadeIn();
	    Grid = createPlanGrid();
	    
	    Grid.on('click', () => {
		    
			let rowKey = Grid.getFocusedCell().rowKey;
	        let planCode = Grid.getValue(rowKey, 'prcsPlanCode');
	        let prcsStartDate = Grid.getValue(rowKey, 'prcsStartDate');

	        //모달창 닫기
	        if(rowKey != null){
	        	
	            $(".modal").fadeOut();
	            Grid.destroy();   
				
	    		$.ajax({
	    			url : 'notDirPlanDeList',
	    			method : 'GET',
	    			data : { prcsPlanCode : planCode },
	    			success : function(data){
	    				//현재 날짜 구하기
	    				function getDate(){
	    					var today = new Date();
	    					
	    					var year = today.getFullYear();
	    					var month = ('0' + (today.getMonth() + 1)).substr(-2);
	    					var day = ('0' + today.getDate()).substr(-2);
	    				
	    					return year + '-' + month  + '-' + day;		
	    				}
	    				
	    				dirGrid.clear();
	    				dirGrid.appendRow({'prcsDirDate': getDate(),'empCode' : ${user.id}, 'empName' : `${user.empName}`});
	    				dirDeGrid.clear();
	    				dirDeGrid.appendRow();
	    				
	    	          	//선택한 계획의 내역(계획코드, 제품코드, 주문수량) 그리드에 가져오기
	    	          	dirGrid.setColumnValues('prcsPlanCode', planCode);
	    	          	dirGrid.setColumnValues('prcsStartDate', prcsStartDate);
	    	          	console.log(data);
	    	          	dirDeGrid.resetData(data);
	    	          	dirDeGrid.setColumnValues('empCode', ${user.id});
	    	          	dirDeGrid.setColumnValues('empName', `${user.empName}`);
	    	          	

	    			},
	    			error : function(reject){
	    	 			console.log(reject);
	    	 		}	
	    		})
	    		gridClick = 'N';
	        }
	    });
	    
	});

	
	
	function createPlanGrid(){
	    var planGrid = new tui.Grid({
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
	                header: '계획코드',
	                name: 'prcsPlanCode',
	                width: 'auto',
	                align: 'center'
	            },
	            {
	                header: '계획명',
	                name: 'prcsPlanName',
	                width: 'auto'
	            },
	            {
	                header: '계획일자',
	                name: 'prcsPlanDate',
	                align: 'center'
	            },
	            {
	                header: '제품명',
	                name: 'prodCode',
	                hidden: true
	            },
	            {
	                header: '생산계획량',
	                name: 'prcsPlanAmt',
	                hidden: true,
	                formatter(e) {
	                	if (e['value'] != null){
	    	                val = e['value']
	    	                    .toString()
	    	                    .replace(/\B(?=(\d{3})+(?!\d))/g, ',');
	    	                return val;
	                	}
	                },
	                align: 'right'
	            },
	            {
	            	header: '생산예정일',
	            	name: 'prcsStartDate',
	            	align: 'center'
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
	    return planGrid;
	}
	
	
	$("#close_btn").click(function(){
	    $(".modal").fadeOut();
	  	Grid.destroy();
	});	
	</script>
</body>
</html>