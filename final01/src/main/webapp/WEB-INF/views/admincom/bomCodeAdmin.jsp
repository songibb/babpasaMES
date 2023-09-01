<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
/*모달시작*/

.modal{ 
	position:absolute; width:100%; height:100%; background: rgba(0,0,0,0.8); top:0; left:0; display:none;
}
.modal{
	position: fixed;
}
  
.modal_content{
	  /*모달창 크기 조절*/
	  width:850px; height:600px;
	  background:#fff; border-radius:10px;
	  /*모달창 위치 조절*/
	  position:relative; top:33%; left:45%;
	  margin-top:-100px; margin-left:-200px;
	  text-align:center;
	  box-sizing:border-box;
	  line-height:23px;
}

.m_head{
	height: 10%;
	margin : 0;
	/*제목 높낮이 조절*/
	padding: 17px;
	display: flex;
	justify-content: space-between;
	background-color:rgb(232, 143, 33);
	border-top-left-radius: 10px;
	border-top-right-radius: 10px;
}
     
.close_btn{
	font-size: 20px;
	color: black;
	font-weight: 900;
	cursor: pointer;
}

.modal_btn{
	width: 80px;
	height: 30px;
	border-radius: 5px;
	text-align: center;
	font-size: 14px;
	font-weight: bolder;
	padding-top: 5px;
	margin-left: 5px;
	font-family: sans-serif;
}
.m_head{
	height: 10%;
	padding: 20px;
	display: flex;
	justify-content: space-between;
	border-top-left-radius: 10px;
	border-top-right-radius: 10px;
	font-family: sans-serif;
}

.m_body{
	height: 80%;
	padding: 20px;
}

.m_footer{
	height: 10%;
	padding: 15px;
	border-bottom-left-radius: 10px;
	border-bottom-right-radius: 10px;
	display: flex;
	justify-content: end;
}
.cancle{
	background-color: black;
	color: white;
}
.save{
	background-color: black;
	color: white;
}

	input[type="text"],
	select {
	  width: 28%;
	  padding: 5px;
	  margin-bottom: 15px;
	  border: 1px solid #ccc;
	  border-radius: 4px;
	}
	input[type="date"],
	select {
	  width: 15%;
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
	h2{
		display : inline-block;
	}
	
	.modal input{
		 width: 60%;
	}
	
	.selected-cell{
	   background-color: #ffd09e;
	}
/*모달끝*/

.my-styled-cell {background-color: rgb(255, 229, 229)}
</style>
<title>BOM관리</title>
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
	<h1>BOM 관리</h1>
	<div class="col-lg-12 stretch-card">
		<div class="card">
			<div class="card-body">
				<div style="display: flex; justify-content: space-between;">
					<form style="width: 800px">
							<p>제품명</p>
							<input type="text" placeholder="검색어를 입력하세요" id="bomSearch" style="margin-bottom: 35px">
							<button type="button" class="btn btn-info btn-icon-text" id="searchBtn">
								<i class="fas fa-search"></i>검색
							</button>
							<button type="reset" class="btn btn-info btn-icon-text">초기화</button>
					</form>
					<button id="prodListModal" class="btn btn-info btn-icon-text">BOM 등록 가능 제품 가져오기</button>	
		 	    </div>
					<div>
	            		<br>
	            		<div style="display: flex; justify-content: space-between;">
		            	<h2>BOM 목록</h2>
		            	<div>
			            	<button id = "deleteBom" class="btn btn-info btn-icon-text">삭제</button>
			            	<button id = "deSave" class="btn btn-info btn-icon-text">저장</button>
			           	</div>
		           		</div>
		           		<div id="bomgrid"></div>
		           		
		           		<br>
		           		<div>
		           			<div style="display: flex; flex; justify-content: space-between;">
			           		<h2> BOM 상세 목록 </h2>
			           		<button id = "deAdd" class="btn btn-info btn-icon-text" style="float: right; display: none;">상세추가</button>
			           		</div>
			           		<div id="deBomgrid"></div>
						</div>
					</div>
	   		</div>
		</div>
	</div> 
<div class="modal" id="oneModal">
  <div class="modal_content" 
       title="클릭하면 창이 닫힙니다.">
          <div class="m_head">
            <div class="modal_title"><h3>공정 목록</h3></div>
            <div class="close_btn" id="close_btn">X</div>
       </div>
       <div class="m_body">
            <div id="modal_label_one"></div>
       </div>
       <div class="m_footer">
    </div>
  </div>
</div>

<div class="modal" id="prodModal">
  <div class="modal_content" 
       title="클릭하면 창이 닫힙니다.">
          <div class="m_head">
            <div class="modal_title"><h3>BOM 등록안된 제품 목록</h3></div>
            <div class="close_btn" id="close_btn">X</div>
       </div>
       <div class="m_body">
            <div id="modal_label_prod"></div>
       </div>
       <div class="m_footer">
    </div>
  </div>
</div>


<div class="modal" id="twoModal">
  <div class="modal_content" 
       title="클릭하면 창이 닫힙니다.">
          <div class="m_head">
            <div class="modal_title"><h3>자재/반제품 목록</h3></div>
            <div class="close_btn" id="close_btn">X</div>
       </div>
       <div class="m_body">
       		<div style="display: flex;  justify-content: space-between; margin-bottom: 10px;" >
       			<div>
       				반제품  <input type="text" id="SemiSearchInput">
       				<button type="button" class="btn btn-info btn-icon-text" id="semiSearchBtn">검색</button>
       			</div>
       			<div>
       				자재  <input type="text" id="matSearchInput">
       				<button type="button" class="btn btn-info btn-icon-text" id="matSearchBtn">검색</button>
       			</div>
       		</div>
            <div style="display: flex; justify-content: center;">
	             <div id="modal_label2" style="width: 400px; margin-right: 12px"></div>
	             <div id="modal_label3" style="width: 400px;"></div>
	        </div>
       </div>
       <div class="m_footer">
    </div>
  </div>
</div>

    
	<script>
	
	
	//페이지 호출할떄 BOM등록하는 창 호출
/* 	window.onload = function addRow(){
		bomgrid.appendRow();
		deBomgrid.appendRow();
	} */
	
	//상세BOM행추가
	document.getElementById('deAdd').addEventListener('click', addDeBom);
	function addDeBom(){
		deBomgrid.appendRow();
	}
	
	
	//상세 BOM행삭제
/* 	document.getElementById('deDelete').addEventListener('click', deleteDeBom);
	function deleteDeBom(){
		deBomgrid.removeCheckedRows(false);
	} */
	
	//저장 버튼 클릭시 insert 진행
	document.getElementById('deSave').addEventListener('click', saveServer);
	
	/* 삭제,버튼은 등록시에 안보이게 상세 추가 버튼은 등록시에만 보이게 하기 */
	  var deleteBom = document.getElementById('deleteBom');
	  var deAdd = document.getElementById('deAdd');
	
	
	function saveServer(){
		//BOM
		let rowKey = bomgrid.getFocusedCell().rowKey;
		let columnName = bomgrid.getFocusedCell().columnName;
		
		//편집 종료시켜야 마지막 입력 클릭된게 없어짐
		bomgrid.finishEditing(rowKey, columnName);
		
		let rowKeyDe = deBomgrid.getFocusedCell().rowKey;
		let columnNameDe = deBomgrid.getFocusedCell().columnName;
		deBomgrid.finishEditing(rowKeyDe, columnNameDe);
		
		let bomInfo =  bomgrid.getModifiedRows();
		let bomDeInfo = deBomgrid.getModifiedRows();
		
		console.log(bomInfo);
    	console.log(bomDeInfo);
    	
    	
		
		let bNoValue = bomgrid.getValue(rowKey, 'bomNo');
		
		let flagIn = true;
			
		let noData = false;
			

		
		//변경사항없으면 빠져나감
		if(!bomgrid.isModified()){
			swal("경고","변경사항이 없습니다","warning");
			return false;
		}else if(bNoValue == null){
			bomInsert();
			
		}else{
			$.each(bomInfo, function(field, array){
				if(field == 'upDateRows' && array.length != 0){
					
					$.each(array, function(i, obj){
						for(let field in obj){
							if(obj[field] == null){
								flagIn = false;
							
							}
							
						}
					})
					
				}
			})
			if(flagIn){
				if(!bomgrid.isModified()){
					swal("경고","변경사항이 없습니다","warning");
					return false;
				}
				
				bomUpdate();
			}else{
				swal("경고","모든 값이 입력되지 않았습니다","warning");
			}
		
		};
			
		}
		
		
		
/* 		$.each(bomDeInfo, function(deField, deArray){
			if( deField == 'updatedRows' && deArray.length != 0){
				$.each(deArray, function(i,obj2){
					
						for(let field in obj2){
							if( field = ''&& obj2[field] == null ){
								flagIn = false;
							}
						}
				})
				
			}
		})	 */
		
	//등록 함수
	function bomInsert(){
		
		let flag= true;
		
		let list = bomgrid.getData();
		let object = list[0];

		//빈데이터 확인
		$.each(list, function(i, obj){
			for(let field in obj){
					if(field != 'bomNo' && field != 'bomPrcsYnName' && obj[field] == null){
						flag = false;
					}
			}
		})
		
		
		let deList = deBomgrid.getData();
						
		$.each(deList, function(i, objDe){
			
			for(let field in objDe){
				if(field != 'bomCode' && field != 'bomNo' && objDe[field] == null){
					flag = false;
				}
				 if(isNaN(objDe['bomAmt'])==true || objDe['bomAmt']>999999999){
					flag = false;
					
				} 
			}
		})
			
			if (flag) {
				
				let bomInsertList = {
					bomCodeVO: object,
					bomList: deList
		        };
					
				$.ajax({
		            url: 'bomInsert',
		            method: 'POST',
		            data: JSON.stringify(bomInsertList),
		            contentType: 'application/json',
		            success: function(data) {
		                // 등록 후 그리드 내용 지우고, 행 추가
		                bomgrid.clear();
		 				bomgrid.appendRow();
		 				deBomgrid.clear()
						deBomgrid.appendRow();
		 				
		                swal("성공","BOM 등록이 정상적으로 처리되었습니다","success");
		            },
		            error: function(reject) {
		                console.log(reject);
		            }
		        });
			}else{
				 swal("경고","모든값이 입력되지 않았거나 정보 타입을 확인해 주세요","warning"); 

				
			} 
	}	
			
/* 			if(falg){
				$.ajax({
					url:'bomInsert',
					method:'POST',
					data:JSON.stringify(object),
					contentType: 'application/json',
					async:false,
					success: function(data){
												
						let deList = deBomgrid.getData();
						
						$.each(deList, function(i, objDe){
							deList[i]['bomNo'] = data;
							
							for(let field in objDe){
								if(field != 'bomCode' && objDe[field] == null){
								
									flag = false;
								}
							}
						})
						
						
						$.ajax({
							url : 'bomDeInsert',
							method : 'POST',
							data : JSON.stringify(deList),
							contentType : 'application/json',
							async : false, 
							success : function(data){
								//등록 후 그리드 내용 지우고, 행추가
		 						bomgrid.clear();
		 						bomgrid.appendRow();
		 						deBomgrid.clear()
								deBomgrid.appendRow();
								alert('등록이 완료되었습니다.');
							},
							error : function(reject){
					 			console.log(reject);
					 		}
						})
					},
					error:function(reject){
			 			console.log(reject)
					}
				})
			}else{
				alert('모든 값이 입력되지 않았습니다.');
			} 

	
	 */
	//수정 함수
	/* function bomUpdate(){
		let updateOk = 0;
		let list = bomgrid.getData();
		let deList = deBomgrid.getData();
		
		let bomUpdateList = {
				bomUpList: list,
				bomUpDeList: deList
	        };
		
		$.ajax({
			url : 'bomUpdate',
			method : 'POST',
			data : JSON.stringify(bomUpdateList),
			contentType : 'application/json',
			success : function(data){	
				if(data>1){
					swal("수정이 완료되었습니다.","","success");
				}
				deBomgrid.clear();
				deBomgrid.appendRow();
			},
			error : function(reject){
	 			console.log(reject);
	 		}
		})
		
	} */
	
	function bomUpdate(){
	let updateOk = 0;
	let list = bomgrid.getData();


	$.ajax({
		url : 'bomUpdateHeader',
		type : 'POST',
		contentType : 'application/json',
		 data : JSON.stringify(list),
		success : function(data){	
			if(data>=1){
				swal("성공","BOM 정보수정이 정상적으로 처리되었습니다","success");
				$('form')[0].reset();
				 let content = $('#bomSearch').val();
				   let search = { prodName : content };
				   $.ajax({
					   url : 'bomSearch',
					   method : 'GET',
					   data : search ,
					   success : function(data){
						   bomgrid.resetData(data);
						   deBomgrid.clear();
						   stopEdit();
						   deleteBom.style.display = 'inline-block';
						   deAdd.style.display = 'none';
					   },
					   error : function(reject){
						   console.log(reject);
					   }
				   })
			}
			//deBomgrid.clear();
			stopEdit();
		},
		error : function(reject){
 			console.log(reject);
 		}
	})
	
	}
	
	//BOM header 및 관련 detail 삭제
	
	$("#deleteBom").on('click',checked);
	
	function checked(){
		var checkedRows = bomgrid.getCheckedRows();
		let checkedBom = [];
		if(checkedRows.length > 0){
			var selectedRowIds = checkedRows.map(function(row){
				let bomNo = bomgrid.getValue(row.rowKey, 'bomNo');
				let obj = {bomNo:bomNo};
				checkedBom.push(obj);
			});
			
			swal({
				  title: "정말삭제하시겠습니까?",
				  text: "",
				  icon: "warning",
				  buttons: true,
				  dangerMode: true,
				})
				.then((willDelete) => {
				  if (willDelete) {
						$.ajax({
							url :'bomDelete',
							type : 'POST',
							contentType : 'application/json',
							data : JSON.stringify(checkedBom),
							success : function(result){
									swal("성공","BOM 삭제가 정상적으로 처리되었습니다", "success");
									   $('form')[0].reset();
									   let content = $('#bomSearch').val();
									   let search = { prodName : content };
									   $.ajax({
										   url : 'bomSearch',
										   method : 'GET',
										   data : search ,
										   success : function(data){
											   bomgrid.resetData(data);
											   deBomgrid.clear();
											   stopEdit();
											   //수정시 사용할 그리드
											    bomgrid.on('click', () => {
											    	//클릭한 제품 BOM가져오기
											    	let rowKey = bomgrid.getFocusedCell().rowKey;
											    	let bomNo = bomgrid.getValue(rowKey, 'bomNo');

											    	$.ajax({
														url : 'bomDecodeList',
														method : 'GET',
														data : { bomNo : bomNo },
														success : function(data){
															deBomgrid.resetData(data);
															stopEdit();
											 		    },
														error : function(reject){
												 			console.log(reject);
												 		}	
													})
											  	});
										   },
										   error : function(reject){
											   console.log(reject);
										   }
									   })
									
							}
						})
				    
				  } else {
				    swal("삭제가 취소되었습니다","","warning");
				  }
				});
		}else{
			swal("경고","선택된 체크박스가 없습니다","warning");
		}
		
		

	}
	
	
	
	
	var bomgrid = new tui.Grid({
        el: document.getElementById('bomgrid'),
        scrollX: false,
        scrollY: false,
        minBodyHeight: 120,
		rowHeaders: [{type: 'rowNum'},{type: 'checkbox'}],
		pagination: true,
		pageOptions: {
			useClient: true,
			perPage: 3,
		},
        columns: [
          {
            header: 'NO',
            name: 'bomNo',
            align: 'center',
            sortable: true,
	        sortingType: 'asc'
          },
          {
              header: '제품코드',
              name: 'prodCode',
              align: 'center'
            },
          {
              header: '제품명',
              name: 'prodName'
            },
          {
            header: '사용여부',
            name: 'bomYn',
            align: 'center',
            formatter: 'listItemText',
            editor: {
                type: 'select',
                options: {
                  listItems: [
                	<c:forEach items="${bomUseInfoList}" var="b">
                	 {
                         text: '${b.commdeName }',
                         value: '${b.commdeCode }'
                       }, 
					</c:forEach>
                  ]
                }
              } 
          },
          {
            header: '공정사용여부',
            name: 'bomPrcsYnName',
            align: 'center'
          }
    
        ]
      });
	
	
	//상세 BOM코드 grid 만들기
	 var deBomgrid = new tui.Grid({
        el: document.getElementById('deBomgrid'),
        scrollX: false,
        scrollY: false,
        minBodyHeight: 400,
        rowHeaders: ['rowNum'],
        pagination: true,
		pageOptions: {
			useClient: true,
			perPage: 10,
		},
        columns: [
          {
            header: 'NO',
            name: 'bomNo',
            align: 'center'
          },
          {
              header: 'BOM코드',
              name: 'bomCode',
              align: 'center'
            },
          {
                header: '공정코드',
                name: 'prcsCode',
                align: 'center'
            },
            {
                header: '공정명',
                name: 'prcsName',
                editor: 'text'
            },
          {
            header: '자재/반제품구분',
            name: 'mpKind',
            hidden: true
          },
          {
            header: '자재/반제품코드',
            name: 'mpCode',
            hidden: true
          },
          {
              header: '자재/반제품명',
              name: 'mpName',
              editor: 'text'
            },
          {
            header: '단위',
            name: 'bomUnit',
            align: 'center',
            formatter: 'listItemText',
            editor: {
                type: 'select',
                options: {
                  listItems: [
                	<c:forEach items="${bomUnit}" var="u">
                	 {
                         text: '${u.commdeCode }',
                         value: '${u.commdeCode }'
                       }, 
					</c:forEach>
                  ]
                }
              }
          },
          {
            header: '사용량',
            name: 'bomAmt',
            align: 'right',
            editor: 'text',
            validation: {
 	 	        dataType: 'number',
 	 	        required: true
 	 	      },
 	 	      
          }
        ]
      });
	
 	 function checkBomNo(ev){

		 var rowKey = ev.rowKey;
			 var rows = deBomgrid.findRows({
			 		bomNo :null
			 });
			 
		 let flag = false;
		 $.each(rows, function(idx, obj){
			 if(obj['rowKey'] ==rowKey){
				 flag =true;
				 return flag;
			 }
		 })
		 return flag;
		 
	 }
	
	 deBomgrid.on('editingStart', function(ev){
		 let flag = checkBomNo(ev);
		 
		 if(!flag){
			 ev.stop();
			 
		 }
	 }) 
	 
	 //공정진행중인것은 수정못하게 막기
	 function stopEdit(){
		$.each(bomgrid.getData(), function(idx, obj){
			
			if(obj['bomPrcsYnName'] == '공정사용중'){
				bomgrid.disableRow(obj['rowKey']);
			}
		})
	}
 	/* function checkPrcsUse(ev){
		 
		 var rowKey = ev.rowKey;
		 	var rows = bomgrid.findRows({
		 		bomPrcsYnName : '공정사용중'
		 	});
		 let prflag = false;
		 $.each(rows,function(idx, obj){
			 if(obj['rowKey'] ==rowKey){
				 prflag=true;
			 }return prflag;
		 })
		 return prflag;	
	 }
	 
	 bomgrid.on('editingStart', function(ev){
		 let prflag = checkPrcsUse(ev);
		 
		 if(prflag){
			 ev.stop();
		 }
	 })  */
/* 	var Grid;
	bomgrid.on('dblclick' ,() => {
		let rowKey = bomgrid.getFocusedCell().rowKey;
    	let columnName = bomgrid.getFocusedCell().columnName;
    	let value = bomgrid.getFocusedCell().value; 
    	
    	if(columnName == 'prodName'){
    		$(".modal").fadeIn();
  	       Grid = createProdGrid();
  	       
  	       Grid.on('dblclick', () => {
  	    	 let rowKey2 = Grid.getFocusedCell().rowKey;
  	    	 if(rowKey2 != null){
  	    		let prodCode = Grid.getValue(rowKey2, 'prodCode');
 	        	let prodName = Grid.getValue(rowKey2, 'prodName');
 	        	bomgrid.finishEditing(rowKey, columnName);
 	        	
 	        	if(prodCode != null){
 	        		bomgrid.setValue(rowKey, 'prodCode', prodCode);
 	        	}
 	        	if(prodName != null){
 	        		bomgrid.setValue(rowKey, 'prodName', prodName);
 	        	}
  	    	 }
  	    	 
  	    	 if(rowKey2 != null){
  	    		$(".modal").fadeOut();
	        		Grid.destroy();
  	    	 }
  	    	 
  	    	 
  	       });
    	}
	}); */
	
	var Grid;
	$("#prodListModal").click(function(){
		
    	
    		$("#prodModal").fadeIn();
  	       Grid = createProdGrid();
  	       
  	       Grid.on('dblclick', () => {
  	    		 bomgrid.clear();
				bomgrid.appendRow();
				deBomgrid.clear();
  	    	 let rowKey2 = Grid.getFocusedCell().rowKey;
  	    	 if(rowKey2 != null){
  	    		let prodCode = Grid.getValue(rowKey2, 'prodCode');
 	        	let prodName = Grid.getValue(rowKey2, 'prodName');
 	        	bomgrid.setValue([0],'prodCode', prodCode);
	        	bomgrid.setValue([0], 'prodName', prodName); 	        	
 	        	if(prodCode != null && prodName != null){
 	        		
 	        		$("#prodModal").fadeOut();
	        		Grid.destroy();
	        		deleteBom.style.display = 'none';
	        		deAdd.style.display = 'inline-block';
	        		$('form')[0].reset();

 	        	}
  	    	 }
  	    	 
  	    	 
  	    	 
  	    	 
  	       });
    	
	});
	
	function createProdGrid(){
		
			$.ajax({
				url:"ajaxNoBOMList",
				method:"GET",
				success : function(result){
			           Grid.resetData(result);
			       },
			       error : function(reject){
						console.log(reject);
				   }
			})
		
		var pordGrid = new tui.Grid({
			el: document.getElementById('modal_label_prod'),
		       data: [
		    	   <c:forEach items="${prodNoBomList}" var="p" varStatus="status">
		          	{
		          		prodCode : "${p.prodCode}",
		          		prodName :"${p.prodName}",
		          		kindName : "${p.kindName}",
		          		prodUnit : "${p.prodUnit}",
		          		prodStd : "${p.prodStd}"
		          	} <c:if test="${not status.last}">,</c:if>
		          </c:forEach>
		          ],
			   scrollX: false,
		       scrollY: false,
		       minBodyHeight: 320,
		       rowHeaders: ['rowNum'],
		       selectionUnit: 'row',
		       pagination: true,
		       pageOptions: {
		       //백엔드와 연동 없이 페이지 네이션 사용가능하게 만듦
		         useClient: true,
		         perPage: 8
		       },
		       columns: [
		    	     {
		               header: '제품코드',
		               name: 'prodCode',
		             },
		             {
		               header: '제품명',
		               name: 'prodName',
			         },
		             {
		               header: '제품구분',
		               name: 'kindName'
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
		
		
		return pordGrid
	}
	
	
	deBomgrid.on('dblclick' ,() => {
		
		let rowKey = deBomgrid.getFocusedCell().rowKey;
    	let columnName = deBomgrid.getFocusedCell().columnName;
    	let value = deBomgrid.getFocusedCell().value; 
    	let no = deBomgrid.getValue(rowKey,'bomNo');
    	if(columnName == 'prcsName' && no ==null){
    		$("#oneModal").fadeIn();
  	       Grid = createPrcsGrid();
  	       
  	       Grid.on('dblclick', () => {
  	    	 let rowKey2 = Grid.getFocusedCell().rowKey;
  	    	 if(rowKey2 != null){
  	    		let prcsCode = Grid.getValue(rowKey2, 'prcsCode');
 	        	let prcsName = Grid.getValue(rowKey2, 'prcsName');
 	        	deBomgrid.finishEditing(rowKey, columnName);
 	        	
 	        	if(prcsCode != null){
 	        		deBomgrid.setValue(rowKey, 'prcsCode', prcsCode);
 	        	}
 	         	if(prcsName != null){
 	        		deBomgrid.setValue(rowKey, 'prcsName', prcsName);
 	        	} 
  	    	 }
  	    	 
  	    	 if(rowKey2 != null){
  	    		$("#oneModal").fadeOut();
	        		Grid.destroy();
  	    	 }
  	    	 
  	    	 
  	       });
    	}
    	

    	if(columnName == 'mpName' && no ==null){
    		$("#twoModal").fadeIn();
  	       matGrid = createMatGrid();
  	       halfProdGrid = createHalfProdGrid();
  	      
  	
  	     	matGrid.on('dblclick', () => {
  	     		let rowKey2 = matGrid.getFocusedCell().rowKey;
  	    	 if(rowKey2 != null){
  	    		let matCode = matGrid.getValue(rowKey2, 'matCode');
 	        	let matName = matGrid.getValue(rowKey2, 'matName');
 	        	deBomgrid.finishEditing(rowKey, columnName);
 	        	
 	        	if(matCode != null){
 	        		deBomgrid.setValue(rowKey, 'mpCode', matCode);
 	        		deBomgrid.setValue(rowKey, 'mpKind', 'M');
 	        	}
 	        	 if(matName != null){
 	        		deBomgrid.setValue(rowKey, 'mpName', matName);
 	        	} 
  	    	 }
  	    	if(rowKey2 != null){
  	    		$("#twoModal").fadeOut();
  	    			matGrid.destroy();
  	    			halfProdGrid.destroy();
  	    			
  	    	 } 
  	    	 
  	       });
  	     
  	     	halfProdGrid.on('dblclick', () => {
  	     		let rowKey3 = halfProdGrid.getFocusedCell().rowKey;
  	  	    	 if(rowKey3 != null){
  	  	    		let prodCode = halfProdGrid.getValue(rowKey3, 'prodCode');
  	 	        	let prodName = halfProdGrid.getValue(rowKey3, 'prodName');
  	 	        	deBomgrid.finishEditing(rowKey, columnName);
  	 	        	
  	 	        	if(prodCode != null){
  	 	        		deBomgrid.setValue(rowKey, 'mpCode', prodCode);
  	 	        		deBomgrid.setValue(rowKey, 'mpKind', 'P');
  	 	        	}
  	 	         	if(prodName != null){
  	 	        		deBomgrid.setValue(rowKey, 'mpName', prodName);
  	 	        	} 
  	  	    	 }
  	  	    	if(rowKey3 != null){
  	  	    		$(".modal").fadeOut();
  	  	    		halfProdGrid.destroy();
  	  	    		matGrid.destroy();	
  	  	    			
  	  	    	 }  	
  	  	    	 
  	  	       });

  	     	
  	     	
    	}
    	
    	
    	
	});
	
	function createPrcsGrid(){
		
		var prcsGrid = new tui.Grid({
			el: document.getElementById('modal_label_one'),
		       data: [
		    	   <c:forEach items="${prcsList}" var="p" varStatus="status">
		          	{
		          		prcsCode : "${p.prcsCode}",
		          		prcsType :"${p.prcsType}",
		          		prcsName : "${p.prcsName}",
		          		prcsTypeKr : "${p.prcsTypeKr}",
		          		semiYn : "${p.semiYn}"
		          	} <c:if test="${not status.last}">,</c:if>
		          </c:forEach>
		          ],
			   scrollX: false,
		       scrollY: false,
		       minBodyHeight: 320,
		       rowHeaders: ['rowNum'],
		       selectionUnit: 'row',
		       pagination: true,
		       pageOptions: {
		       //백엔드와 연동 없이 페이지 네이션 사용가능하게 만듦
		         useClient: true,
		         perPage: 8
		       },
		       columns: [
		    	     {
		               header: '공정코드',
		               name: 'prcsCode',
		             },
		             {
		               header: '공정구분',
		               name: 'prcsTypeKr',
			         },
		             {
		               header: '공정이름',
		               name: 'prcsName'
		             }
		 	    ]
		      
		     });
		
		
		return prcsGrid
	}
	
	var matGrid2;
	// 자재 반제품 가져오는 그리드
	function createMatGrid(){
		var matGrid2 = new tui.Grid({
			el: document.getElementById('modal_label3'),
		       data: [
		    	   <c:forEach items="${matList}" var="m" varStatus="status">
		          	{
		          		matCode : "${m.matCode}",
		          		matName :"${m.matName}",
		          		matUnit : "${m.matUnit}",
		          		matStd : "${m.matStd}"
		          	} <c:if test="${not status.last}">,</c:if>
		          </c:forEach>
		          ],
			   scrollX: false,
		       scrollY: false,
		       minBodyHeight: 320,
		       rowHeaders: ['rowNum'],
		       selectionUnit: 'row',
		       pagination: true,
		       pageOptions: {
		       //백엔드와 연동 없이 페이지 네이션 사용가능하게 만듦
		         useClient: true,
		         perPage: 8
		       },
		       columns: [
		    	     {
		               header: '자재코드',
		               name: 'matCode',
		             },
		             {
		               header: '자재이름',
		               name: 'matName',
			         },
		             {
		               header: '단위',
		               name: 'matUnit'
		             },
		             {
			           header: '규격',
			           name: 'matStd'
			         }
		 	    ]
		      
		     });
		
		
		return matGrid2
		
	}
	
	var halfProdGrid3;
	function createHalfProdGrid(){
		var halfProdGrid3 = new tui.Grid({
			el: document.getElementById('modal_label2'),
		       data: [
		    	   <c:forEach items="${semiProdList}" var="m" varStatus="status">
		          	{
		          		prodCode : "${m.prodCode}",
		          		prodName :"${m.prodName}",
		          		prodUnit : "${m.prodUnit}"
		          	} <c:if test="${not status.last}">,</c:if>
		          </c:forEach>
		          ],
			   scrollX: false,
		       scrollY: false,
		       minBodyHeight: 320,
		       rowHeaders: ['rowNum'],
		       selectionUnit: 'row',
		       pagination: true,
		       pageOptions: {
		       //백엔드와 연동 없이 페이지 네이션 사용가능하게 만듦
		         useClient: true,
		         perPage: 8
		       },
		       columns: [
		    	     {
		               header: '반제품코드',
		               name: 'prodCode',
		             },
		             {
		               header: '반제품이름',
		               name: 'prodName',
			         },
		             {
		               header: '단위',
		               name: 'prodUnit'
		             }
		 	    ]
		      
		     });
		
		
		return halfProdGrid3
	}
	
	
	
	
	
	$(".close_btn").click(function(){
        $(".modal").fadeOut();
        try {
        	Grid.destroy();
       } catch {}
        try{
        	matGrid.destroy();
	  		halfProdGrid.destroy();
        }catch {}
	  	
     
     });
	
	
	
	
	
	//제품명으로 BOM조회
	 $('#searchBtn').on('click', searchProdIn);
   function searchProdIn(e){
	   let content = $('#bomSearch').val();
	   let search = { prodName : content };
	   $.ajax({
		   url : 'bomSearch',
		   method : 'GET',
		   data : search ,
		   success : function(data){
			   bomgrid.resetData(data);
			   deBomgrid.clear();
			   stopEdit();
			   deleteBom.style.display = 'inline-block';
			   deAdd.style.display = 'none';
		   },
		   error : function(reject){
			   console.log(reject);
		   }
	   })
   }
   
   
	// 전체조회 페이지 띄우기
   let content = $('#bomSearch').val();
   let search = { prodName : content };
   $.ajax({
	   url : 'bomSearch',
	   method : 'GET',
	   data : search ,
	   success : function(data){
		   bomgrid.resetData(data);
		   deBomgrid.clear();
		   //수정시 사용할 그리드
		   //공정사용중인것 수정못하게 막기
		 	 stopEdit();
		    bomgrid.on('click', () => {
		    	//클릭한 제품 BOM가져오기
		    	let rowKey = bomgrid.getFocusedCell().rowKey;
		    	let bomNo = bomgrid.getValue(rowKey, 'bomNo');

		    	$.ajax({
					url : 'bomDecodeList',
					method : 'GET',
					data : { bomNo : bomNo },
					success : function(data){
						deBomgrid.resetData(data);
		 		    },
					error : function(reject){
			 			console.log(reject);
			 		}	
				})
				
				
				let selectKey = bomgrid.getFocusedCell().rowKey;
		    	bomgrid.addRowClassName(selectKey, 'selected-cell');
				//다른 행 선택시 기존에 클릭했던 행은 class제거
				bomgrid.on('focusChange', () => {
					bomgrid.removeRowClassName(selectKey, 'selected-cell');
				})
		  	});
		    
	   },
	   error : function(reject){
		   console.log(reject);
	   }
   })
    
   


		//모달 검색

		$('#matSearchBtn').on('click', function(e){
			let inputContent = $('#matSearchInput').val();
			let matName = {matName : inputContent}
				$.ajax({
					url : 'searchMatCodeList',
					method : 'GET',
					data : matName,
					success : function(data){
						console.log(data);
						matGrid.resetData(data);
					},
					error : function(reject){
						console.log(reject);
					}
				})
		})

		$('#semiSearchBtn').on('click', function(e){
			let inputContent = $('#SemiSearchInput').val();
			let ProdName = {ProdName : inputContent}
				$.ajax({
					url : 'semiProdModalSearch',
					method : 'GET',
					data : ProdName,
					success : function(data){
						console.log(data);
						halfProdGrid.resetData(data);
					},
					error : function(reject){
						console.log(reject);
					}
				})
		})




   
      
	
	</script>
</body>
</html>