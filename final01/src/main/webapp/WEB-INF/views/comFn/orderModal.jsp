<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>미계획 주문서 목록</title>
<style type="text/css">
.m_body p{
	display: inline-block;
}
.m_body input[type="date"]{
	width: 130px;
}
#save_btn{
	cursor : pointer;
}
</style>
</head>
<body>\
	<div class="modal">
		<div class="modal_content" title="클릭하면 창이 닫힙니다.">
			<div class="m_head">
				<div class="modal_title"><h3>미계획 주문서 목록</h3></div>
				<div class="close_btn" id="close_btn">X</div>
			</div>
			<div class="m_body">
				<form>
					<p>납기일자</p>
					<input type="date" id="searchStartDate" name="searchStartDate" value="">&nbsp;&nbsp;-&nbsp;&nbsp;<input type="date" id="searchEndDate" name="searchEndDate" value="">		
	
					<button type="button" class="btn btn-info btn-icon-text" id="modalSearchBtn">
						<i class="fas fa-search"></i>검색
					</button>
					<button type="reset" class="btn btn-info btn-icon-text">초기화</button>
				</form>
				<div id="modal_label"></div>
			</div>
			<div class="m_footer">
				<div class="modal_btn save" id="save_btn">선택</div>
			</div>
		</div>
	</div>
	
	
	<script type="text/javascript">	
	//미계획 주문서 모달
	var Grid;
	$("#orderModal").click(function(){
	    $(".modal").fadeIn();
	    Grid = createOrderGrid();
	});
	
	
	//save버튼 클릭 후 그리드 내용 지우고 모달창에서 선택한 데이터 넣은 후
    $('#save_btn').click(function(){
    	
    	//검색을 사용했다면 form의 내용 초기화
    	$('form').each(function(){
    		this.reset();
    	})
    	 
		//체크박스 체크한 주문서 데이터
		let checkList = Grid.getCheckedRows();

		let deList = [];
		$.each(checkList, function(i, obj){
			let deObj = {};
			deObj['ordCode'] = checkList[i]['ordCode'];			
			deList.push(deObj);
		})
		
		//모달창 닫기
		if(deList.length > 0){
            $(".modal").fadeOut();
            Grid.destroy();   
			
    		$.ajax({
    			url : 'notPlanOrderDeList',
    			method : 'POST',
    			data : JSON.stringify(deList),
    			contentType : 'application/json',
    			success : function(data){
    				console.log(data);
    				//현재 날짜 구하기
    				function getDate(){
    					var today = new Date();
    					
    					var year = today.getFullYear();
    					var month = ('0' + (today.getMonth() + 1)).substr(-2);
    					var day = ('0' + today.getDate()).substr(-2);
    				
    					return year + '-' + month  + '-' + day;		
    				}
    				
    				planGrid.clear();
    		    	planGrid.appendRow({'prcsPlanDate': getDate(), 'empCode' : ${user.id}, 'empName' : `${user.empName}`});
    				planDeGrid.clear();
    				planDeGrid.appendRow();
    				
    	          	//체크박스 체크한 주문서의 상세 내역(제품코드, 주문수량) 그리드에 가져오기
    	          	planDeGrid.resetData(data);
    	          	
    	          	//삭제버튼 안보이게 하기
    	          	remove.style.display = 'none';
    			},
    			error : function(reject){
    	 			console.log(reject);
    	 		}	
    		})
    		
    		gridClick = 'N';
        }
		
		
    }); 
		
	
	
	function createOrderGrid(){
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
	            perPage: 8
	        },
	        columns: [
	            {
	                header: '주문코드',
	                name: 'ordCode',
	                align: 'center'
	            },
	            {
	                header: '주문일자',
	                name: 'ordDate',
	                sortable: true,
	                sortingType: 'asc',
	                align: 'center'
	            },
	            {
	                header: '거래처명',
	                name: 'actName'
	            },
	            {
	                header: '납기일자',
	                name: 'devDate',
	                sortable: true,
	                sortingType: 'asc',
	                align: 'center'
	            },
	        ]       
	    });
		
		$.ajax({
		    url : 'notPlanOrderList',
		    method : 'GET',
		    success : function(data){
		    	//날짜 츨력 포맷 변경
				$.each(data, function(i, objDe){
					let od = data[i]['ordDate'];
					let dd = data[i]['devDate'];
					data[i]['ordDate'] = getDate(od);
					data[i]['devDate'] = getDate(dd);
				})
		    	orderGrid.resetData(data);
		    },
		    error : function(reject){
		        console.log(reject);
		    }	
		})
	    return orderGrid;
	}
	
	//검색 버튼 누를때
	$('#modalSearchBtn').click(function(){
		
	    let searchObj = {};
		searchObj['startDate'] = $('#searchStartDate').val();
		searchObj['endDate'] = $('#searchEndDate').val();	   

		$.ajax({
			url : 'notPlanOrderList',
			method : 'GET',
			data : searchObj, 
			success : function(data){	
				//날짜 츨력 포맷 변경
				$.each(data, function(i, objDe){
					let od = data[i]['ordDate'];
					let dd = data[i]['devDate'];
					data[i]['ordDate'] = getDate(od);
					data[i]['devDate'] = getDate(dd);
				})
				
				Grid.resetData(data);
			},
			error : function(reject){
				console.log(reject);
			}
		});
	})
	
	
	$("#close_btn").click(function(){
	    $(".modal").fadeOut();
	  	Grid.destroy();
	});	
	</script>
</body>
</html>