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
				<div class="modal_title"><h3>발주 목록</h3></div>
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
	$("#matDeModal").click(function(){
	    $(".modal").fadeIn();
	    Grid = creatematDeGrid();
	});
	
	//save버튼 클릭 후 그리드 내용 지우고 모달창에서 선택한 데이터 넣은 후
    $('#save_btn').click(function(){
    
  
    	//모달창 닫기
		 

        let checkList = Grid.getCheckedRows();
      	matgrid.appendRows(checkList,{ at: 0 });

        $(".modal").fadeOut();
        Grid.destroy();  
	
		
		
    }); 
		
	
	
	function creatematDeGrid(){
	    var matDeModal = new tui.Grid({
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
	                header: '발주코드',
	                name: 'matOdDeCd',
	            },
	            {
	                header: '자재코드',
	                name: 'matCode'
	            },
	            {
	                header: '자재명',
	                name: 'matName'
	            },
	            {
	                header: '발주총량',
	                name: 'matAmt'
	            }
	        ]       
	    })
		
		$.ajax({
		    url : 'notChkMatList',
		    method : 'GET',
		    success : function(data){
		    	matDeModal.resetData(data);
		    },
		    error : function(reject){
		        console.log(reject);
		    }	
		})
		
	    return matDeModal;
	}
	
	
	$("#close_btn").click(function(){
	    $(".modal").fadeOut();
	  	Grid.destroy();
	});	
	</script>
</body>
</html>