<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>작업 등록</title>
</head>
<body>

	<div class="modal">
		<div class="modal_content" title="클릭하면 창이 닫힙니다.">
			<div class="m_head">
				<div class="modal_title"><h3>미계획 주문서 목록</h3></div>
				<div class="close_btn" id="close_btn">X</div>
			</div>
			<div class="m_body">	
				<div id="modal_label">
				
					<div>공정명</div>
					<div>담당자</div>
					<div>투입량</div>
					<div>불량량</div>
					<div id="eqGrid">설비 그리드 </div>
					<div id="prcsMatGrid">공정별 자재그리드</div>

				</div>
			</div>
			<div class="m_footer">
				<div class="modal_btn save" id="save_btn">선택</div>
			</div>
		</div>
	</div>
	
	
	<script type="text/javascript">		
	//진행 공정 클릭시 작업 관리 모달 출력
    ingGrid.on('click', () => {
    	let rowKey = dirDeGrid.getFocusedCell().rowKey;
    	
    	$(".modal").fadeIn();
    	
    	Grid = createActGrid();
    	
    	
    	
    })
	
	
	
	
	
	function createActGrid(){
	    var orderGrid = new tui.Grid({
	        el: document.getElementById('modal_label'),
	        scrollX: false,
	        scrollY: false,
	        minBodyHeight: 30,
	        rowHeaders: ['checkbox'],
	        selectionUnit: 'row',
	        pagination: true,
	        pageOptions: {
	            useClient: true,
	            perPage: 10
	        },
	        columns: [
	            {
	                header: '주문코드',
	                name: 'ordCode',
	            },
	            {
	                header: '주문일자',
	                name: 'ordDate'
	            },
	            {
	                header: '거래처명',
	                name: 'actName'
	            }
	        ]       
	    });
		
		$.ajax({
		    url : 'notPlanOrderList',
		    method : 'GET',
		    success : function(data){
		    	//날짜 츨력 포맷 변경
				$.each(data, function(i, objDe){
					let od = data[i]['ordDate'];
					data[i]['ordDate'] = getDate(od);
				})
		    	orderGrid.resetData(data);
		    },
		    error : function(reject){
		        console.log(reject);
		    }	
		})
	    return orderGrid;
	}
	
	
	$("#close_btn").click(function(){
	    $(".modal").fadeOut();
	  	Grid.destroy();
	});	
	</script>
</body>
</html>