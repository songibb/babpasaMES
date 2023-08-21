<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품 목록</title>
</head>
<body>
	<div class="modal">
		<div class="modal_content" title="클릭하면 창이 닫힙니다.">
			<div class="m_head">
				<div class="modal_title"><h3>제품 목록</h3></div>
				<div class="close_btn" id="close_btn">X</div>
			</div>
			<div class="m_body">
				<div id="modal_label"></div>
			</div>
<!-- 			<div class="m_footer"> -->
<!-- 				<div class="modal_btn save" id="save_btn">SAVE</div> -->
<!-- 			</div> -->
		</div>
	</div>

	<script type="text/javascript">
	//제품 모달
	$("#prodModal").click(function(){
	    $(".modal").fadeIn();
	    Grid = createProdGrid();
	    
	    Grid.on('dblclick', () => {
	        let rowKey = Grid.getFocusedCell().rowKey;
	        let prodCode = Grid.getValue(rowKey, 'prodCode');
	        let prodName = Grid.getValue(rowKey, 'prodName');
	        $("#searchProdCode").val(prodCode);
	        $("#prodNameFix").val(prodName);	        
	        
	        //모달창 닫기
	        if(rowKey != null){
	            $(".modal").fadeOut();
	            Grid.destroy();
	        }

	    });
	});
	
	function createProdGrid(){
	    var prodGrid = new tui.Grid({
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
	                header: '제품코드',
	                name: 'prodCode',
	            },
	            {
	                header: '제품명',
	                name: 'prodName'
	            },
	        ]       
	    });
		
		$.ajax({
		    url : 'ajaxProdCodeList',
		    method : 'GET',
		    success : function(data){
		        prodGrid.resetData(data);
		    },
		    error : function(reject){
		        console.log(reject);
		    }	
		})
	    return prodGrid;
	}
	
	
	$("#close_btn").click(function(){
	    $(".modal").fadeOut();
	  	Grid.destroy();
	});
	</script>
	
</body>
</html>