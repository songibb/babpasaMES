<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<title>거래처관리</title>
<!-- 토스트 페이지 네이션 dd-->
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
		<form id="id">
		<div>
		<p>등록/수정</p>
		</div>
			<table>
				<tr>
					<th>거래처코드</th>
					<td><input type="text" name="actCode" id="actCode" readonly="readonly" style="background-color: skyblue;"></td>
				</tr>
				<tr>
					<th>거래처명</th>
					<td><input type="text" name="actName" id="actName"></td>
				</tr>
				<tr>
					<th>사업자번호</th>
					<td><input type="text" name="actNum" id="actNum"></td>
				</tr>
				<tr>
					<th>연락처</th>
					<td><input type="text" name="actTel" id="actTel"></td>
				</tr>
				<tr>
					<th>거래상태</th>
					<td>
						<select id="inputActList" name="actSts">
							<c:forEach items="${actStsList}" var="s">
								<option value="${s.commdeCode }">${s.commdeName }</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<th>거래처구분</th>
					<td>
						<select id="actTypeList" name="actKind">
							<c:forEach items="${actTypeList}" var="a">
								<option value="${a.commdeCode }">${a.commdeName }</option>
							</c:forEach>
						</select>
					</td>
				</tr>
			</table>
			<button type="submit" class="btn btn-info btn-icon-text">저장</button>
			<button type="reset" class="btn btn-info btn-icon-text">취소</button>
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
						<button type="button" class="btn btn-info btn-icon-text">초기화</button>
						<button type="reset" class="btn btn-info btn-icon-text" id="deleteAct">삭제</button>
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

		   //거래처 리스트 출력
		
		    var grid = new tui.Grid({
		        el: document.getElementById('grid'),
		        scrollX: false,
		        scrollY: false,
		        minBodyHeight: 30,
				 rowHeaders: [{type: 'rowNum'},{type: 'checkbox'}],
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
		        	//codeName
		            header: '거래여부',
		            name: 'sts'
		          },
		          {
		        	  //code 값 가져오기위한 것
			            header: '거래여부',
			            name: 'actSts',
			            hidden:true
			          },
		          {
			        	  //codeName
		              header: '거래처구분',
		              name: 'kind',
		              filter: 'select'
		            },
		            {
		            	 //code값 가져오기위한 것
			              header: '거래처구분',
			              name: 'actKind',
			              hidden:true
			            }
		        ]
		      })  
		   
			//거래처 등록/수정 한개버튼으로 같이하기
			
			
			$("form").on('submit', function(e){
				  
				  let actInfo = getActInfo(); 
				  
				  
				  if(actInfo.actCode != ''){
					  e.preventDefault();
					if(actInfo.actName =='' || actInfo.actNum =='' || actInfo.actTel==''){
						
						alert('모든 정보를 입력해 주세요.');
						}else{ 

					//수정 ajax
					actUpdate(actInfo);
						}
				  }else{
					  e.preventDefault();
					  if(actInfo.actName =='' || actInfo.actNum =='' || actInfo.actTel==''){
						 
							alert('모든 정보를 입력해 주세요.');
							}else{ 

					  
					  //등록 ajax 
					  actInsert(actInfo);
							}
						
					 
				  }
			});
			
			
			//form에 입력된 값들가져오기
			function getActInfo(){
			let inputList = $('form').serializeArray();
			
			let actInfo = {};
			$.each(inputList, function(idx, obj){
				actInfo[obj.name] = obj.value;
			})
			
			return actInfo;
			};
			
			
			//등록 ajax 함수
			function actInsert(actInfo){
			
			  $.ajax({
					url : 'actCodeInsert',
					type : 'post',
					contentType : 'application/json',
					data :  JSON.stringify(actInfo)
				})
				.done(data => { 
					if(data != null && data['결과'] == 'Success'){   //데이터의 key가 한글이라면 반드시 대괄호[''] 사용해야함
						alert( '거래처 등록이 정상적으로 처리되었습니다.');
					
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
						 $('form')[0].reset();
					} else{
						alert('거래처 등록처리가 실패되었습니다.');
					}   	
				})
				.fail(reject => console.log(reject));
			}
			
			
			//수정 ajax 함수
			  function actUpdate(actInfo){
				
			
			  $.ajax({
					url : 'actCodeUpdate',
					type : 'post',
					contentType : 'application/json',
					data :  JSON.stringify(actInfo)
				})
				.done(data => { 
					if(data != null && data['결과'] == 'Success'){   //데이터의 key가 한글이라면 반드시 대괄호[''] 사용해야함
						alert( '거래처 정보수정이 정상적으로 처리되었습니다.');
					
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
						 $('form')[0].reset();
					} else{
						alert('거래처 정보 수정이 실패되었습니다.');
					}   	
				})
				.fail(reject => console.log(reject));
			}
		   
			
			
		    
		    //수정진행 클릭시 데이터 input에 가져오기
		    grid.on('click', () => {
		    	//클릭한 제품 BOM가져오기
		    	let rowKey = grid.getFocusedCell().rowKey;
		    	let actCode = grid.getValue(rowKey, 'actCode');
		    	let actName = grid.getValue(rowKey, 'actName');
		    	let actNum = grid.getValue(rowKey, 'actNum');
		    	let actTel = grid.getValue(rowKey, 'actTel');
		    	let actSts = grid.getValue(rowKey, 'actSts');
		    	let actKind = grid.getValue(rowKey, 'actKind');
		    	
		    	$("#actCode").val(actCode);
				$("#actName").val(actName);
				$("#actNum").val(actNum);
				$("#actTel").val(actTel);
				$("#inputActList option[value='" + actSts + "']").prop("selected", true);
				$("#actTypeList option[value='" + actKind + "']").prop("selected", true);
				});
		    
		    
		    //거래처 삭제 

		    $("#deleteAct").on('click', checked);
		    
		    function checked() {
		        var checkedRows = grid.getCheckedRows();
		        let checkedAct = [];
		        if (checkedRows.length > 0) {
		            var selectedRowIds = checkedRows.map(function(row) {
		            	let actCode = grid.getValue(row.rowKey, 'actCode');
		            	let obj = {actCode :actCode};
		            	checkedAct.push(obj);   
		            });
		            
		        }
		        
		        $.ajax({
	                url : 'actCheckedDelete',
	                type : 'POST',
	                contentType : 'application/json',
	                data : JSON.stringify(checkedAct),
	                success : function(result){
	                	alert(result + '개의 거래처가 삭제되었습니다.');
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
	                 
	                },
	                error : function(reject){
	                    console.log(reject);
	                }
	            })
		        
		    }
		    
		    
		    	/* 
		    	var data = grid.getCheckedValues(actCode);
		         actCode = grid.getValue(data,'actCode');
		    	
		    	var test = JSON.stringify(data);
		    	alert(test);
		    	
		    	
		    	$.ajax({
		    		url : 'actCheckedDelete',
					type : 'post',
					contentType : 'application/json',
					data : test,
					 success : function(result){
		                    //데이터가 돌아오는 방식을 확인하기
		                    //console.log(result);

		                    if(result != null){
		                        let message = result.success + '건이 삭제되었습니다.'   //result.success : 성공 횟수
		                        alert(message);
		                        selectEmployees();
		                    }
		                },
		                error : function(reject){
		                    console.log(reject);
		                }
		            }) */
		    
		    
/* 		    function checked(e){
		    	let checks = [];
		    	let rowKey = grid.getCheckedrowKeys;
		    	let actCode = grid.getValue(rowKey, 'actCode');
		    	var drow = grid.removeCheckedRows(true);
		    	checks.push(actCode);
		    	console.log(drow);
		    	console.log(checks);
		    } */
		 
		    //수정말고 거래처 등록만 ajax 진행시
		    /*     $('form').on('submit', ajaxActCodeInsert);
		        
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
		    	   			
		    				
		    		} */
	</script>
</body>
</html>