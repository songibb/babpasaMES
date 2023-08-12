<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>미계획 주문서 목록</title>
</head>
<body>

	<div class="modal">
		<div class="modal_content" title="클릭하면 창이 닫힙니다.">
			<div class="m_head">
				<div class="modal_title"><h3>미계획 주문서 목록</h3></div>
				<div class="close_btn" id="close_btn">X</div>
			</div>
			<div class="m_body">
				<div id="modal_label"></div>
			</div>
			<div class="m_footer">
				<div class="modal_btn save" id="save_btn">선택</div>
			</div>
		</div>
	</div>
	
	<script type="text/javascript">	
	//미계획 주문서 모달
	$("#orderModal").click(function(){
	    $(".modal").fadeIn();
	    Grid = createActGrid();
	});
	
	//save버튼 클릭 후 그리드 내용 지우고 모달창에서 선택한 데이터 넣은 후
    $('#save_btn').click(function(){
    	
    	//검색을 사용했다면 form의 내용 초기화
    	$('form').each(function(){
    		this.reset();
    	})
    	 
		planGrid.clear();
		planGrid.appendRow();
		planDeGrid.clear();
		planDeGrid.appendRow();
		
		//체크박스 체크한 데이터
		var rowList = Grid.getCheckedRows();
		
		//모달창 닫기
		if(rowList != null){
            $(".modal").fadeOut();
            Grid.destroy();   

          	//체크박스 체크한 데이터 그리드에 가져오기
          	planDeGrid.resetData(rowList);
          	
          	gridClick = 'N';
    		console.log(gridClick);
        }
		
		
    }); 
		
	
	
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
	                header: '주문날짜',
	                name: 'ordDate'
	            },
	            {
	                header: '제품코드',
	                name: 'prodCode'
	            },
	            {
	                header: '주문수량',
	                name: 'prcsRqAmt'
	            },
	            {
	                header: '납기일자',
	                name: 'devDate'
	            }
	        ]       
	    });
		
		$.ajax({
		    url : 'notPlanOrderList',
		    method : 'GET',
		    success : function(data){
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