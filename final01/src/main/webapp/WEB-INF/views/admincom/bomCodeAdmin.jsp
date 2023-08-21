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
#actModal{ 
	cursor:pointer;
}
  
.modal{ 
	position:absolute; width:100%; height:100%; background: rgba(0,0,0,0.8); top:0; left:0; display:none;
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
/*모달끝*/
</style>
<title>BOM관리</title>
	<!-- 토스트 페이지 네이션 -->
    <script type="text/javascript" src="https://uicdn.toast.com/tui.code-snippet/latest/tui-code-snippet.js"></script>
    <link rel="stylesheet" href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css" />
    <script src="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.js"></script>
    <!-- 페이지 네이션 끝 -->
    <link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
    <script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>   
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</head>
<body>
	<div class="black_bg"></div>
	<h3>BOM관리</h3>
	<div class="col-lg-12 stretch-card">
		<div class="card">
			<div class="card-body">
					<form>
						<!-- <div id="customtemplateSearchAndButton">	 -->

							제품명 <input type="text" placeholder="검색어를 입력하세요" id="bomSearch">
							<button type="button" class="btn btn-info btn-icon-text" id="searchBtn">
								<i class="fas fa-search"></i>검색
							</button>
							<button type="reset" class="btn btn-info btn-icon-text">초기화</button>
		            	<!-- </div> -->
	            	</form>
	            	<div>
	            		<br>
	            		<div style="display: flex; justify-content: space-between;">
		            	<h5>제품bom등록</h5>
		            	<button id = "deSave" class="btn btn-info btn-icon-text">저장</button>
			           		<!-- <button id = "deDelete" class="btn btn-info btn-icon-text" >상세삭제</button> -->
		           		</div>
		           		<div id="bomgrid"></div>
		           		
		           		<br>
		           		<div>
		           			<div style="display: flex; flex; justify-content: space-between;">
			           		<h5> bom상세등록 </h5>
			           		<button id = "deAdd" class="btn btn-info btn-icon-text" style="float: right">상세추가</button>
			           		</div>
			           		<div id="deBomgrid"></div>
						</div>
					</div>
	   		</div>
		</div>
	</div> 
<div class="modal">
   
  <div class="modal_content" 
       title="클릭하면 창이 닫힙니다.">
          <div class="m_head">
            <div class="modal_title"><h3>목록</h3></div>
            <div class="close_btn" id="close_btn">X</div>
       </div>
       <div class="m_body">
            <div id="modal_label"></div>
            <div style="display: flex; justify-content: center;">
	             <div id="modal_label2" style="width: 400px; margin-right: 10px"></div>
	             <div id="modal_label3" style="width: 400px;"></div>
	        </div>
       </div>
       <div class="m_footer">
            <div class="modal_btn cancle" id="close_btn">CANCLE</div>
            <div class="modal_btn save" id="save_btn">SAVE</div>
    </div>
  </div>
</div>

    
	<script>
	
	//페이지 호출할떄 BOM등록하는 창 호출
	window.onload = function addRow(){
		bomgrid.appendRow();
		deBomgrid.appendRow();
	}
	
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
		if(bNoValue == null){
			bomInsert();
			
		}
		
		let flagIn = true;
		
		let noData = false;
		
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
		
		$.each(bomDeInfo, function(deField, deArray){
			if( deField == 'updatedRows' && deArray.length != 0){
				$.each(deArray, function(i,obj2){
					
						for(let field in obj2){
							if( field = ''&& obj2[field] == null ){
								flagIn = false;
							}
						}
				})
				
			}
		})	
		if(flagIn){
			
			bomUpdate();
		}else{
			swal("수정값이 모두 입력되지 않았습니다.","","warning");
		}
	
	};
		
	//등록 함수
	function bomInsert(){
		
		let flag= true;
		
		let list = bomgrid.getData();
		let object = list[0];

		//빈데이터 확인
		$.each(list, function(i, obj){
			for(let field in obj){
					if(field != 'bomNo' && obj[field] == null){
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

		                swal("등록이 완료되었습니다.","","success");
		            },
		            error: function(reject) {
		                console.log(reject);
		            }
		        });
			}else{

				swal("모든 값이 입력되지 않았습니다.","","warning");

				
			} 
			
			
			if(falg){
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

	}
	
	//수정 함수
	function bomUpdate(){
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
		
	}
	
	
	var bomgrid = new tui.Grid({
        el: document.getElementById('bomgrid'),
        scrollX: false,
        scrollY: false,
        minBodyHeight: 30,
		rowHeaders: ['rowNum'],
		pagination: true,
		pageOptions: {
			useClient: true,
			perPage: 3,
		},
        columns: [
          {
            header: 'NO',
            name: 'bomNo',
          },
          {
              header: '제품코드',
              name: 'prodCode'
            },
          {
              header: '제품명',
              name: 'prodName',
              editor: 'text'
            },
          {
            header: '사용여부',
            name: 'bomYn',
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
            name: 'bomPrcsYn',
            formatter: 'listItemText',
                         text: '${p.commdeName }',
                         value: '${p.commdeCode }'
          }
    
        ]
      });
	
	
	//상세 BOM코드 grid 만들기
	 var deBomgrid = new tui.Grid({
        el: document.getElementById('deBomgrid'),
        scrollX: false,
        scrollY: false,
        minBodyHeight: 30,
        rowHeaders: ['rowNum'],
        columns: [
          {
            header: 'NO',
            name: 'bomNo',
          },
          {
              header: 'BOM코드',
              name: 'bomCode',
            },
          {
                header: '공정코드',
                name: 'prcsCode'
            },
            {
                header: '공정이름',
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
              header: '자재/반제품이름',
              name: 'mpName',
              editor: 'text'
            },
          {
            header: '단위',
            name: 'bomUnit',
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
            editor: 'text'
          }
        ]
      });
	
	var Grid;
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
	});
	
	function createProdGrid(){
		
		var pordGrid = new tui.Grid({
			el: document.getElementById('modal_label'),
		       data: [
		    	   <c:forEach items="${prodList}" var="p" varStatus="status">
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
    	
    	if(columnName == 'prcsName'){
    		$(".modal").fadeIn();
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
  	    		$(".modal").fadeOut();
	        		Grid.destroy();
  	    	 }
  	    	 
  	    	 
  	       });
    	}
    	

    	if(columnName == 'mpName'){
    		$(".modal").fadeIn();
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
  	    		$(".modal").fadeOut();
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
			el: document.getElementById('modal_label'),
		       data: [
		    	   <c:forEach items="${prcsList}" var="p" varStatus="status">
		          	{
		          		prcsCode : "${p.prcsCode}",
		          		prcsType :"${p.prcsType}",
		          		prcsName : "${p.prcsName}",
		          		semiYn : "${p.semiYn}"
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
		               header: '공정코드',
		               name: 'prcsCode',
		             },
		             {
		               header: '공정구분',
		               name: 'prcsType',
			         },
		             {
		               header: '공정이름',
		               name: 'prcsName'
		             },
		             {
			           header: '반제품공정구분',
			           name: 'semiYn'
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

 
    
   
      
	
	</script>
</body>
</html>