<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>생산 지시 목록</title>
<style type="text/css">
.m_body p{
	display: inline-block;
}
.m_body input[type="date"]{
	width: 130px;
}
</style>
</head>
<body>
	<div class="modal" id="psdModal">
		<div class="modal_content" title="클릭하면 창이 닫힙니다.">
			<div class="m_head">
				<div class="modal_title"><h3>생산 지시 목록</h3></div>
				<div class="close_btn" id="close_btn3">X</div>
			</div>
			<div class="m_body">
				<form>
					<p>지시일자</p>
					<input type="date" id="searchStartDate" name="searchStartDate" value="">&nbsp;&nbsp;-&nbsp;&nbsp;<input type="date" id="searchEndDate" name="searchEndDate" value="">		
	
					<button type="button" class="btn btn-info btn-icon-text" id="modalSearchBtn">
						<i class="fas fa-search"></i>검색
					</button>
					<button type="reset" class="btn btn-info btn-icon-text">초기화</button>
				</form>
				<div id="modal_label3"></div>
			</div>
<!-- 			<div class="m_footer"> -->
<!-- 				<div class="modal_btn save" id="save_btn">SAVE</div> -->
<!-- 			</div> -->
		</div>
	</div>

	<script type="text/javascript">
	//생산 지시 목록 모달
	var Grid;
	$("#prcsDirModal").click(function(){
	    $("#psdModal").fadeIn();
	    Grid = createPrcsDirGrid();

	    Grid.on('dblclick', () => {
	        let rowKey = Grid.getFocusedCell().rowKey;
	        let prcsDirCode = Grid.getValue(rowKey, 'prcsDirCode');
	        let prcsDirName = Grid.getValue(rowKey, 'prcsDirName');
	        $("#searchPrcsDirCode").val(prcsDirCode);
	        $("#prcsDirNameFix").val(prcsDirName);	        
	        
	        //모달창 닫기
	        if(rowKey != null){
	        	$('input[name=searchStartDate]').val('');
	        	$('input[name=searchEndDate]').val('');
	            $(".modal").fadeOut();
	            Grid.destroy();
	        }

	    });
	});
	
	function createPrcsDirGrid(){
	    var prcsDirGrid = new tui.Grid({
	        el: document.getElementById('modal_label3'),
	        scrollX: false,
	        scrollY: false,
	        minBodyHeight: 30,
	        rowHeaders: ['rowNum'],
	        selectionUnit: 'row',
	        pagination: true,
	        pageOptions: {
	            useClient: true,
	            perPage: 8
	        },
	        columns: [
	            {
	                header: '생산지시코드',
	                name: 'prcsDirCode',
	            },
	            {
	                header: '지시명',
	                name: 'prcsDirName'
	            },
	            {
	                header: '지시일자',
	                name: 'prcsDirDate'
	            }
	        ]       
	    });

		$.ajax({
			url : 'selectPrcsEndDirList',
			method : 'GET',
			success : function(data){	
				//날짜 츨력 포맷 변경
				$.each(data, function(i, objDe){
					let pdd = data[i]['prcsDirDate'];
					data[i]['prcsDirDate'] = getDate(pdd);
				})
				
				prcsDirGrid.resetData(data);
			},
			error : function(reject){
				console.log(reject);
			}
		});
	    return prcsDirGrid;
	}
	
	//검색 버튼 누를때
	$('#modalSearchBtn').click(function(){
		
	    let searchObj = {};
		searchObj['startDate'] = $('#searchStartDate').val();
		searchObj['endDate'] = $('#searchEndDate').val();	   
		
		$.ajax({
			url : 'selectPrcsEndDirList',
			method : 'GET',
			data : searchObj, 
			success : function(data){	
				//날짜 츨력 포맷 변경
				$.each(data, function(i, objDe){
					let pdd = data[i]['prcsDirDate'];
					data[i]['prcsDirDate'] = getDate(pdd);
				})
				
				Grid.resetData(data);
			},
			error : function(reject){
				console.log(reject);
			}
		});
	})
	
	$("#close_btn3").click(function(){
		$('input[name=searchStartDate]').val('');
    	$('input[name=searchEndDate]').val('');
	    $(".modal").fadeOut();
	    if (Grid != null && Grid.el != null) {
	        Grid.destroy();
	    }
	});
	</script>
	
</body>
</html>