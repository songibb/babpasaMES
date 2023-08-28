<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<title>제품관리</title>
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
<style>
	label {
	  display: block;
	  margin-bottom: 7px;
	  margin-top: 2px;
	  font-weight: bold;
	}
	input[type="text"],
	select {
	  width: 21%;
	  padding: 6px;
	  margin-bottom: 15px;
	  border: 1px solid #ccc;
	  border-radius: 4px;
	}
	
	select {
	  width: 21%;
	  padding: 5px;
	  margin-bottom: 15px;
	  border: 1px solid #ccc;
	  border-radius: 4px;
	}
	
	select {
	  background-color: white; 
	}
	form p{
		width: 80px;
		display: inline-block;
		font-size: 20px;
	}
	h1{
		margin-left: 15px;
	}
	h1, h2{
		font-weight: 800;
	}
	#id input, 
	#id select{
		width: 100%;
		 padding: 8px;
		
	}
	#id label {
		margin-top: 19.5px;
		margin-bottom : 14px;
		font-size: 20px;
		font-weight: 400;
	}
	
	#deleteProd{
		float : right;
	}
	h2{
		display: inline-block;
	}
	
	button {
		margin-top: 0;
	}
</style>
</head>
<body>
	<div class="black_bg"></div>
	<h1>제품 관리</h1>
	<div style="display: flex;">
		<div style="width: 25%">
				<div class="col-lg-12 stretch-card">
					<div class="card">
						<div class="card-body">
							<div class="table-responsive pt-3">
								<form id="id">
									<h2 style="margin-bottom: 10px">등록/수정</h2>
										<label>제품코드</label>
										<input type="text" name="prodCode" id="prodCode" readonly="readonly" style="background-color: skyblue;">
										<label>제품명</label>
										<input type="text" name="prodName" id="prodName">
										<input type="text" name="prodBeforeName" id="prodBeforeName" style="display: none">
										<label>반/완제품구분</label>
										<select id="prodTypeList" name="prodKind">
											<c:forEach items="${prodTypeList}" var="p">
												<option value="${p.commdeCode }">${p.commdeName }</option>
											</c:forEach>
										</select>
										<label>단위</label>
										<input type="text" name="prodUnit" id="prodUnit">
										<label>규격</label>
										<input type="text" name="prodStd" id="prodStd" style="margin-bottom: 55px">
										<div style="text-align: center;">
											<button type="submit" class="btn btn-info btn-icon-text" style="margin-top: 20px; margin-bottom: 10px">저장</button>
											<button type="reset" class="btn btn-info btn-icon-text" style="margin-top: 20px; margin-bottom: 10px">취소</button>
										</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		<div style="width: 75%">
			<div class="col-lg-12 stretch-card" >
				<div class="card">
					<div class="card-body">
						<div class="table-responsive pt-3">
							<form>
								<div>		
									<p>제품명</p>
									<input type="text" placeholder="검색어를 입력하세요" id="prodSearch" >
									<br>
									<p>제품구분</p>
									<select id="prodTypeListSearch" name="prodKind" style="margin-bottom: 35px">
											<option value="">선택</option>
											<c:forEach items="${prodTypeList}" var="p">
												<option value="${p.commdeCode }">${p.commdeName }</option>
											</c:forEach>
									</select>
									<button type="button" class="btn btn-info btn-icon-text" id="searchBtn" >
										<i class="fas fa-search"></i>검색
									</button>
									
									<button type="reset" class="btn btn-info btn-icon-text">초기화</button>
				            	</div>
			            	</form>
			            	<div>
				            	<h2>제품 목록</h2>
				            	<button type="button" class="btn btn-info btn-icon-text" id="deleteProd">삭제</button>
			           		</div>
			           		<div id="grid"></div>
						</div>
			   		</div>
				</div>
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
	
	
	//전체조회 ajax
	   let prodName = $('#prodSearch').val();
	   let prodKind = $('#prodTypeList').val();
	   let search = { prodName : prodName, prodKind:prodKind };
	$.ajax({
		   url : "ajaxProdCodeList",
	       method :"GET",
	       success : function(result){
	           grid.resetData(result);
	       },
	       error : function(reject){
				console.log(reject);
			}
	});
	
	//제품검색조회
	$('#searchBtn').on('click', searchProdIn);
   function searchProdIn(e){
	   let prodName = $('#prodSearch').val();
	   let prodKind = $('#prodTypeListSearch').val();
	   let search = { prodName : prodName, prodKind:prodKind };
	   $.ajax({
		   url : 'getProdCodeFilter',
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
        minBodyHeight: 400,
		rowHeaders: [{type:'rowNum'},{type: 'checkbox'}],
		pagination: true,
		pageOptions: {
			useClient: true,
			perPage: 10,
		},
        columns: [
          {
            header: '제품코드',
            name: 'prodCode',
            filter: 'text'
          },
          {
            header: '제품명',
            name: 'prodName',
            filter: 'text'
          },
          {
            header: '반/완제품구분',
            name: 'prodKind',
            filter: 'select',
            hidden:true
          },
          {
            header: '반/완제품구분',
            name: 'kindName',
            filter: 'select'
            },
          {
            header: '단위',
            name: 'prodUnit'
          },
          {
            header: '규격',
            name: 'prodStd'
          }
        ]
      });
    
    $("#id").on('submit', function(e){
    	let prodInfo = getProdInfo();
    	
    	if(prodInfo.prodCode != ''){
    		 e.preventDefault();
    		 
    		 if(prodInfo.prodName == '' || prodInfo.prodUnit ==''){
    			 swal("필요한 정보를 모두 입력해 주세요.","","warning");
    		 }else{
    			 if(prodInfo.prodName == prodInfo.prodBeforeName){
    				 //수정 ajax
        			 prodUpdate(prodInfo);
    			 }else{
    				 let prodNameCheck = {prodNameUse : prodInfo.prodName};
    				 $.ajax({
    		   			   url : 'prodCheck',
    		   			   method : 'GET',
    		   			   data : prodNameCheck,
    		   			   success : function(data){
    		   				   console.log(data);
    		   				   if(data== 1){
    		   					//동록 ajax
    		   					 prodUpdate(prodInfo);
    		   				   }else{
    		   					swal("이미 존재하는 제품명입니다.","","warning");
    		   				   }
    		   			   },
    		   			   error : function(reject){
    		   				   console.log(reject);
    		   			   }
    		   		   })
    			 }
    			
    		 }
    	}else{
    		e.preventDefault();
    		if(prodInfo.prodName == '' || prodInfo.prodUnit ==''){
    			swal("필요한 정보를 모두 입력해 주세요.","","warning");
   		 }else{
   			 	let prodNameCheck = {prodNameUse : prodInfo.prodName};
   			 	
	   			 $.ajax({
	   			   url : 'prodCheck',
	   			   method : 'GET',
	   			   data : prodNameCheck,
	   			   success : function(data){
	   				   console.log(data);
	   				   if(data== 1){
	   					//동록 ajax
	   		   			 prodInsert(prodInfo);
	   				   }else{
	   					swal("이미 존재하는 제품명입니다.","","warning");
	   				   }
	   			   },
	   			   error : function(reject){
	   				   console.log(reject);
	   			   }
	   		   })
   			 
   		 }
    	}
    })

    //form에 입력된 값들가져오기
    function getProdInfo(){
		let inputList = $('#id').serializeArray();
		
		let prodInfo = {};
		$.each(inputList, function(idx, obj){
			prodInfo[obj.name] = obj.value;
		})
		
		return prodInfo;
		};
		
		//등록 ajax 함수
	function prodInsert(prodInfo){
		
		$.ajax({
			url : 'prodCodeInsert',
			type : 'post',
			contentType : 'application/json',
			data :  JSON.stringify(prodInfo)
		})
		.done(data => {
			if(data != null && data['결과'] == 'Success'){   //데이터의 key가 한글이라면 반드시 대괄호[''] 사용해야함
				swal("제품 등록이 정상적으로 처리되었습니다","","success");
			
				//밑에 조회 ajax 새로 처리 필요
				$.ajax({
					   url : "ajaxProdCodeList",
				       method :"GET",
				       success : function(result){
				           grid.resetData(result);
				       },
				       error : function(reject){
							console.log(reject);
						}
				});
				
				//form 비우기
				 $('form')[1].reset();
			} else{
				swal("제품 등록처리가 실패되었습니다","","error");
			}
		})
		.fail(reject => console.log(reject));
	}
		
		//수정 ajax
		function prodUpdate(prodInfo){
			
			$.ajax({
				url : 'prodCodeUpdate',
				type : 'post',
				contentType : 'application/json',
				data :  JSON.stringify(prodInfo)
			})
			.done(data => { 
				console.log(data);
				if(data != null && data['결과'] == 'Success'){   //데이터의 key가 한글이라면 반드시 대괄호[''] 사용해야함
					swal("제품 정보수정이 정상적으로 처리되었습니다","","success");
				
					//밑에 조회 ajax 새로 처리 필요
					$.ajax({
					   url : "ajaxProdCodeList",
				       method :"GET",
				       success : function(result){
				           grid.resetData(result);
				       },
				       error : function(reject){
							console.log(reject);
						}
					});
					
					//form 비우기
					 $('form')[1].reset();
				} else{
					swal("제품 정보 수정이 실패되었습니다","","error");
				}   	
			})
			.fail(reject => console.log(reject));
		}
		
		//조회 그리드 행 클릭시 해당 행 정보 input박스에 채우기 
		grid.on('click', () => {
			let rowKey = grid.getFocusedCell().rowKey;
			let prodCode = grid.getValue(rowKey, 'prodCode');
			let prodName = grid.getValue(rowKey, 'prodName');
			let prodKind = grid.getValue(rowKey, 'prodKind');
			let prodUnit = grid.getValue(rowKey, 'prodUnit');
			let prodStd = grid.getValue(rowKey, 'prodStd');
			
			$("#prodCode").val(prodCode);
			$("#prodName").val(prodName);
			$("#prodBeforeName").val(prodName);
			$("#prodTypeList option[value='" + prodKind + "']").prop("selected", true);
			$("#prodUnit").val(prodUnit);
			$("#prodStd").val(prodStd);
		});
		
		
		//삭제 버튼 클릭시 체크박스 체크된 행 모두 삭제
		$("#deleteProd").on('click', checked);
		
		function checked(){
			 var checkedRows = grid.getCheckedRows();
		        let checkedProd = [];
		        if (checkedRows.length > 0) {
		            var selectedRowIds = checkedRows.map(function(row) {
		            	let prodCode = grid.getValue(row.rowKey, 'prodCode');
		            	let obj = {prodCode :prodCode};
		            	checkedProd.push(obj);   
		            	
		            	swal({
			      			  title: "정말삭제하시겠습니까?",
			      			  text: "",
			      			  icon: "warning",
			      			  buttons: true,
			      			  dangerMode: true,
			      			})
			      			.then((willDelete) => {
			      				if(willDelete){
			      					$.ajax({
					    		    	url : 'prodCheckedDelete',
					                    type : 'POST',
					                    contentType : 'application/json',
					                    data : JSON.stringify(checkedProd),
					                    success : function(result){
					                    	console.log(result.length);
					                    	  let errCount = result.length;
					                    	  let checkCount = checkedProd.length;
					                    	  let successCount = checkCount-errCount;
					                    	  
					                    	  if(errCount==0){
						                		  swal("삭제 완료되었습니다","", {icon: "success",});
						                		
						                	  }else if(successCount==0){
						                		  swal("모두 이미 사용중인 제품으로 삭제가 실패되었습니다","", {icon: "error",});
						                	  }else{
						                	  swal(successCount +"개 제품 삭제 성공!\n "
						                			  + errCount +"개 제품 삭제 실패!","사용중인 제품의 경우 삭제되지 않았습니다","success");
						                	  }
           	 
					                    	$.ajax({
					     					   url : "ajaxProdCodeList",
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
			      					
			      				}else{
			      					 swal("삭제가 취소되었습니다","",{icon: "warning",});
			      				}
		      				});
		            	
		            }); 
		            
				}else{
					swal("선택된 체크박스가 없습니다","","warning");
				}
		        
		    
		}
	</script>
</body>
</html>