<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>거래처 목록</title>
</head>
<body>

	<div class="modal">
		<div class="modal_content" title="클릭하면 창이 닫힙니다.">
			<div class="m_head">
				<div class="modal_title"><h3>거래처 목록</h3></div>
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
	//거래처 모달
	$("#actModal").click(function(){
	    $(".modal").fadeIn();
	    Grid = createActGrid();
	    
	    Grid.on('click', () => {
	        let rowKey = Grid.getFocusedCell().rowKey;
	        let actCode = Grid.getValue(rowKey, 'actCode');
	        let actName = Grid.getValue(rowKey, 'actName');
	        $("#actCodeInput").val(actCode);
	        $("#actNameFix").val(actName);
	        //모달창 닫기
	        console.log(rowKey);
	        if(rowKey != null){
	            $(".modal").fadeOut();
	            Grid.destroy();
	        }
	    });
	});
	
	function createActGrid(){
	    var actGrid = new tui.Grid({
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
	                header: '거래처코드',
	                name: 'actCode',
	            },
	            {
	                header: '거래처명',
	                name: 'actName'
	            },
	            {
	                header: '거래상태',
	                name: 'actSts'
	            },
	            {
	                header: '거래처구분',
	                name: 'actKind'
	            }
	        ]       
	    });
		
		$.ajax({
		    url : 'ajaxActCodeList',
		    method : 'GET',
		    success : function(data){
		        actGrid.resetData(data);
		    },
		    error : function(reject){
		        console.log(reject);
		    }	
		})
	    return actGrid;
	}
	
	
	$("#close_btn").click(function(){
	    $(".modal").fadeOut();
	  	Grid.destroy();
	});
	</script>




</body>

</html>