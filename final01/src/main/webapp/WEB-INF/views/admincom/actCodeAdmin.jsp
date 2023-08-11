<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<title>주문 조회</title>
<!-- 토스트 페이지 네이션 -->
<script type="text/javascript"
	src="https://uicdn.toast.com/tui.code-snippet/latest/tui-code-snippet.js"></script>
<link rel="stylesheet"
	href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css" />
<script
	src="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.js"></script>
<!-- 페이지 네이션 끝 -->
<link rel="stylesheet"
	href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@700&family=Noto+Sans+KR&display=swap"
	rel="stylesheet">
</head>
<body>
	<div class="black_bg"></div>
	<h3>거래처관리</h3>
	<div>
		<form>
			<table>
				<tr>
					<th>거래처코드</th>
					<td><input type="text" name="actCode" id="actCode" readonly="readonly" style="background-color: gray;"></td>
				</tr>
				<tr>
					<th>거래처명</th>
					<td><input type="text" name="actName"></td>
				</tr>
				<tr>
					<th>사업자번호</th>
					<td><input type="text" name="actNum"></td>
				</tr>
				<tr>
					<th>연락처</th>
					<td><input type="text" name="actTel"></td>
				</tr>
				<tr>
					<th>거래처구분</th>
					<td><input type="text" name="commdeName" id="commdeName" readonly="readonly" style="background-color: gray;"></td>
					<td><input type="hidden" name="actKind" id="commdeCode"></td>
					<td><button type="button" id="commdeModal">거래처구분조회</button></td>
				</tr>
				<tr>
					<th>담당자</th>
					<td><input type="text" name="empName" id="empName" readonly="readonly" style="background-color: gray;"></td>
					<td><input type="hidden" name="empCode" id="empCode" readonly="readonly"></td>
					<td><button type="button" id="empModal">사원조회</button></td>
				</tr>
			</table>
			<button type="submit">등록</button>
			<button type="reset">취소</button>
		</form>
	</div>
	<div class="col-lg-12 stretch-card">
		<div class="card">
			<div class="card-body">
				<div class="table-responsive pt-3">
					<form>
						거래처명: <input type="text" placeholder="검색어를 입력하세요" id="actSearch">
						<button type="button" class="btn btn-info btn-icon-text"
							id="searchBtn">
							<i class="fas fa-search"></i>검색
						</button>
						<button type="reset" class="btn btn-info btn-icon-text">초기화</button>
					</form>
				</div>
				<div id="grid"></div>
			</div>
		</div>
	</div>

	<div class="modal">
		<div class="modal_content" title="클릭하면 창이 닫힙니다.">
			<div class="m_head">
				<div class="modal_title">
					<h3>목록</h3>
				</div>
				<div class="close_btn" id="close_btn">X</div>
			</div>
			<div class="m_body">
				<div id="modal_label"></div>
			</div>
		</div>
	</div>


	<script>
	
   //거래처 등록
   
   //거래처 구분 모달 시작
   var Grid;
   $("#commdeModal").click(function(){
		  $(".modal").fadeIn();
		  Grid = createCommdeGrid();
		  
		  Grid.on('click', () => {	
				let rowKey = Grid.getFocusedCell().rowKey;
				let commdeName = Grid.getValue(rowKey, 'commdeName');
				let commdeCode = Grid.getValue(rowKey, 'commdeCode');
				
				$("#commdeName").val(commdeName);
				$("#commdeCode").val(commdeCode);
				
		          if(rowKey != null){
		             $(".modal").fadeOut();
		              Grid.destroy();
		          }
		  
				});
				});

		//구분조회 모달 그리드
		 function createCommdeGrid(){
		      var commdeGrid = new tui.Grid({
		          el: document.getElementById('modal_label'),
		          data: [
		             <c:forEach items="${actTypeList}" var="a" varStatus="status">
		                {
		                	commdeName :"${a.commdeName}",
		                	commdeCode :"${a.commdeCode}"
		                } <c:if test="${not status.last}">,</c:if>
		             </c:forEach>
		             ],
		         scrollX: false,
		          scrollY: false,
		          minBodyHeight: 30,
		          rowHeaders: ['rowNum'],
		          selectionUnit: 'row',
		          pagination: true,
		          pageOptions: {
		          //백엔드와 연동 없이 페이지 네이션 사용가능하게 만듦
		            useClient: true,
		            perPage: 10
		          },
		          columns: [
		                {
		                  header: '구분명',
		                  name: 'commdeName'
		                },
		                {
		                 header: '구분코드',
			             name: 'commdeCode'
		                }
		           ]
		         
		        });
		      
		      return commdeGrid;
		   }
   
   
	 //사원 모달창 시작
	  $("#empModal").click(function(){
		  $(".modal").fadeIn();
		  Grid = createEmpGrid();
		  
		  Grid.on('click', () => {	
				let rowKey = Grid.getFocusedCell().rowKey;
				let empName = Grid.getValue(rowKey, 'empName');
				let empCode = Grid.getValue(rowKey, 'empCode');
				$("#empName").val(empName);
				$("#empCode").val(empCode);
				
		          if(rowKey != null){
		             $(".modal").fadeOut();
		              Grid.destroy();
		          }
		  
				});
				});

		
		$("#close_btn").click(function(){
		  $(".modal").fadeOut(); 
			Grid.destroy();
		});
		
		//사원조회 모달 그리드
		 function createEmpGrid(){
		      var empGrid = new tui.Grid({
		          el: document.getElementById('modal_label'),
		          data: [
		             <c:forEach items="${empList}" var="e" varStatus="status">
		                {
		                	empCode : "${e.empCode}",
		                	empName :"${e.empName}",
		                	commdeName :"${e.commdeName}"
		                } <c:if test="${not status.last}">,</c:if>
		             </c:forEach>
		             ],
		         scrollX: false,
		          scrollY: false,
		          minBodyHeight: 30,
		          rowHeaders: ['rowNum'],
		          selectionUnit: 'row',
		          pagination: true,
		          pageOptions: {
		          //백엔드와 연동 없이 페이지 네이션 사용가능하게 만듦
		            useClient: true,
		            perPage: 10
		          },
		          columns: [
		             {
		                  header: '사원코드',
		                  name: 'empCode'
		                },
		                {
		                  header: '사원명',
		                  name: 'empName'
		                },
		                {
		                  header: '부서명',
		                  name: 'commdeName'
		                }
		           ]
		         
		        });
		      
		      return empGrid;
		   }
		   
		   
		   
		   

		
	//거래처 등록 수정 같이하기
	
	
	
	
	$("form").on('submit', function(e){
		  e.preventDefault();
		  
		  let actInfo = getActInfo(); 
		  
		  if(actInfo.actCode != ''){
			  ajaxActCodeInsert();
		  }
	})
		
		function getActInfo(){
		let inputList = $('form').serializeArray();
		
		let actInfo = {};
		$.each(inputList, function(idx, obj){
			actInfo[obj.name] = obj.value;
		})
		
		return actInfo;
	}		
		
	
	
	
	
	
	
	
   					
    //거래처 등록
/*      $('form').on('submit', ajaxActCodeInsert);*/
    
    function serializeObject() {
		let formData =$('form').serializeArray();
		
		//객체를 배열로 만듬
		let objectData = {};
		$.each(formData, function(idx, obj){
			objectData[obj.name] = obj.value;
		});
			return objectData;
		
	} 
   					
   		function ajaxActCodeInsert(e) {
   			
   			e.preventDefault();
   			
			let obj = serializeObject();
			
				$.ajax({
					url : 'actCodeInsert',
					type : 'post',
					contentType : 'application/json',
					data :  JSON.stringify(obj)
				})
				.done(data => { 
					if(data != null && data['결과'] == 'Success'){   //데이터의 key가 한글이라면 반드시 대괄호[''] 사용해야함
						alert( '거래처가 등록처리되었습니다.');
					
						//밑에 조회 ajax 새로 처리 필요
						$.ajax({
						       url : "ajaxActCodeList",
						       method :"GET",
						       success : function(result){
						           grid.resetData(result);
						       },
						       error : function(reject){
									console.log(reject);
								}
							});
						
						//form 비우기
						 resetForm();
					} else{
						alert('등록처리가 실패되었습니다.');
						//수정은 딱히 reload할 필요가 없음
					}   	
				})
				.fail(reject => console.log(reject));
	   			
				
		}
   		
   		//form 비우기 함수
   		function resetForm(){
   			$('form')[0].reset();
   		} 
   					
		 //거래처 리스트 조회
			$.ajax({
		       url : "ajaxActCodeList",
		       method :"GET",
		       success : function(result){
		           grid.resetData(result);
		       },
		       error : function(reject){
					console.log(reject);
				}
			});
			
			//거래처명 검색조회
			$('#searchBtn').on('click', searchActIn);
		  function searchActIn(e){
			   let content = $('#actSearch').val();
			   let search = { actName : content };
			   $.ajax({
				   url : 'ActCodeSearch',
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
		  
		   
		   function serializeObject(){
			   let formData = $('form').serializeArray();
			   let formObject = {};
			   $.each(formData, function(idx,obj){
					let field = obj.name;
					let val = obj.value;
					
					formObject[field] = val;
				});
					return formObject;
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
					perPage: 5,
				},
		        columns: [
		          {
		            header: '거래처코드',
		            name: 'actCode',
		            filter: 'text'
		          },
		          {
		            header: '거래처명',
		            name: 'actName',
		            filter: 'text'
		          },
		          {
		            header: '사업자번호',
		            name: 'actNum'
		          },
		          {
		            header: '연락처',
		            name: 'actTel'
		          },
		          {
		            header: '거래여부',
		            name: 'sts'
		          },
		          {
		              header: '거래처구분',
		              name: 'kind',
		              filter: 'select'
		            },
		          {
		              header: '담당자',
		              name: 'empName'
		            }
		        ]
		      })  
		    
		    
		    grid.on('click', () => {
		    	//클릭한 제품 BOM가져오기
		    	let rowKey = grid.getFocusedCell().rowKey;
		    	let actCode = grid.getValue(rowKey, 'actCode');
		    	let actName = grid.getValue(rowKey, 'actName');
		    	let actNum = grid.getValue(rowKey, 'actNum');
		    	let actTel = grid.getValue(rowKey, 'actTel');
		    	let kind = grid.getValue(rowKey, 'kind');
		    	let empName = grid.getValue(rowKey, 'empName');
		    	
		    	$("#actCode").val(actCode);
				$("#actName").val(actName);
				$("#actNum").val(actNum);
				$("#actTel").val(actTel);
				$("#kind").val(kind);
				$("#actName").val(actName);
				
				});
		
			
	</script>
</body>
</html>