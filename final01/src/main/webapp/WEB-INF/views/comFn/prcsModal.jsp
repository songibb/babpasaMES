<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공정 목록</title>
</head>
<body>
	<div class="modal" id="psModal">
		<div class="modal_content" title="클릭하면 창이 닫힙니다.">
			<div class="m_head">
				<div class="modal_title"><h3>공정 목록</h3></div>
				<div class="close_btn" id="close_btn2">X</div>
			</div>
			<div class="m_body">
				<div id="modal_label2"></div>
			</div>
<!-- 			<div class="m_footer"> -->
<!-- 				<div class="modal_btn save" id="save_btn">SAVE</div> -->
<!-- 			</div> -->
		</div>
	</div>

	<script type="text/javascript">
	//공정 모달
	var Grid;
	$("#prcsModal").click(function(){
	    $("#psModal").fadeIn();
	    Grid = createPrcsGrid();
	    
	    Grid.on('dblclick', () => {
	        let rowKey = Grid.getFocusedCell().rowKey;
	        let prcsCode = Grid.getValue(rowKey, 'prcsCode');
	        let prcsName = Grid.getValue(rowKey, 'prcsName');
	        $("#searchPrcsCode").val(prcsCode);
	        $("#prcsNameFix").val(prcsName);	        
	        
	        //모달창 닫기
	        if(rowKey != null){
	            $(".modal").fadeOut();
	            Grid.destroy();
	        }

	    });
	});
	
	function createPrcsGrid(){
	    var prcsGrid = new tui.Grid({
	        el: document.getElementById('modal_label2'),
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
	                header: '공정코드',
	                name: 'prcsCode',
	            },
	            {
	                header: '공정명',
	                name: 'prcsName'
	            },
	        ]       
	    });
		
		$.ajax({
		    url : 'selectPrcsManageList',
		    method : 'GET',
		    success : function(data){
		    	prcsGrid.resetData(data);
		    },
		    error : function(reject){
		        console.log(reject);
		    }	
		})
	    return prcsGrid;
	}
	
	
	$("#close_btn2").click(function(){
	    $(".modal").fadeOut();
	    if (Grid != null && Grid.el != null) {
	        Grid.destroy();
	    }
	});
	</script>
	
</body>
</html>