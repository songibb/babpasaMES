<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공통코드관리</title>
	<!-- 토스트 페이지 네이션 -->
    <script type="text/javascript" src="https://uicdn.toast.com/tui.code-snippet/latest/tui-code-snippet.js"></script>
    <link rel="stylesheet" href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css" />
    <script src="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.js"></script>
    <!-- 페이지 네이션 끝 -->
    <link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
    <script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>   
	<style>
		input[type="text"],
		select {
		  width: 20%;
		  padding: 4px;
		  margin-bottom: 10px;
		  border: 1px solid #ccc;
		  border-radius: 4px;
		}
		
		select {
		  background-color: white; 
		}
	</style>
</head>
<body>
	<div class="black_bg"></div>
	<h3>공통코드관리</h3>
	<div class="col-lg-12 stretch-card">
		<div class="card">
			<div class="card-body">
				<div class="table-responsive pt-3" >
					<form>
						공통코드 <input type="text" placeholder="검색어를 입력하세요" id="commSearch" ">
						<button type="button" class="btn btn-info btn-icon-text" id="searchBtn">
							<i class="fas fa-search"></i>검색
						</button>
						<button type="reset" class="btn btn-info btn-icon-text">초기화</button>
		            </form>
		            
	            	<div style="display: flex; justify-content: flex-end;">
	            		<input type="text" name="commCode" id="commCode" readonly="readonly" style="margin-bottom: 0.2%; width: 5%">
	            	</div>
	            </div>
	            <div id="container" style="display: flex; justify-content: center;">
		           		<div id="grid" style="width: 600px; margin-right: 50px"></div>
		           		<div id="grid2" style="width: 1000px;"></div>
	   			</div>
			</div>
		</div> 
	</div>
	
	<script>
	
	
		//공통코드 조회 ajax
		$.ajax({
			url : 'ajaxCommCodeList',
			method : 'GET',
			success : function(result){
				 grid.resetData(result);
			},
			error : function(reject){
				console.log(reject);
			}
		});
		
		//공통코드 검색 조회
		$('#searchBtn').on('click', searchCommIn);
		function searchCommIn(e){
			let content = $('#commSearch').val();
			let search = {commCode : content};
			$.ajax({
				url: 'commCodeSearch',
				method : 'GET',
				data : search ,
				success : function(data){
					grid.resetData(data);
				},
				error : function(reject){
					console.log(reject);
				}
			})
		}
		
			
		
		var grid = new tui.Grid({
			el: document.getElementById('grid'),
			scrollX: false,
			scrollY: false,
			 minBodyHeight: 30,
			 rowHeaders: ['rowNum'],
			pagination: true,
			pageOptions: {
				useClient: true,
				perPage: 10,
			},
			columns: [
				{
					header: '공통코드',
					name: 'commCode'
				},
				{
					header: '이름',
					name: 'commName'
				},
				{
					header: '내용',
					name: 'commInfo'
				}	
			]
			
		})
		
		//상세공통코드 가져오기
		var grid2 = new tui.Grid({
			el: document.getElementById('grid2'),
			scrollX: false,
			scrollY: false,
			 minBodyHeight: 30,
			 rowHeaders: [{type: 'rowNum'},{type: 'checkbox'}],
			pagination: true,
			pageOptions: {
				useClient: true,
				perPage: 10,
			},
			columns: [
				{
					header: '공통상세코드넘버',
					name: 'commDeNo',
					hidden :true
				},
				{
					header: '공통상세코드',
					name: 'commdeCode'
				},
				{
					header: '공통코드',
					name: 'commCode',
					hidden : true
				},
				{
					header: '이름',
					name: 'commdeName'
				},
				{
					header: '내용',
					name: 'commdeInfo'
				},
				{
					header: '사용여부',
					name: 'useName'
				}
			]
			
		})
		
		grid.on('click', () => {
			let rowKey = grid.getFocusedCell().rowKey;
	    	let commCode = grid.getValue(rowKey, 'commCode');
	    	
	    	$.ajax({
	    		url : 'ajaxCommDeCodeList',
				method : 'GET',
				data : { commCode : commCode },
				success : function(data){
	 				grid2.resetData(data);
	 		    },
				error : function(reject){
		 			console.log(reject);
		 		}
	    	})
	    	
	    	$("#commCode").val(commCode);
		});
		
		
		
		
		
			
		
		
	</script>
</body>
</html>