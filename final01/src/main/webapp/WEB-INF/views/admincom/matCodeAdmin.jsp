<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>생산 지시</title>


<!-- 반드시 순서 중요함 time-picker date-picker가 toastui-calendar.min.js -->
<script src="https://uicdn.toast.com/tui.time-picker/latest/tui-time-picker.js"></script>
<script src="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.js"></script>
<script src="https://uicdn.toast.com/calendar/latest/toastui-calendar.min.js"></script>
<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
<script src="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.js"></script>

<link rel="stylesheet" href="https://uicdn.toast.com/tui.time-picker/latest/tui-time-picker.css" />
<link rel="stylesheet" href="https://uicdn.toast.com/tui.date-picker/latest/tui-date-picker.css" />
<link rel="stylesheet" href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css" />
<link rel="stylesheet" href="https://uicdn.toast.com/calendar/latest/toastui-calendar.min.css" />
<link rel="stylesheet" href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css"/>

</head>
<body>
<div class="black_bg"></div>
	<h3>자재 관리</h3>
	<div class="col-lg-12 stretch-card">
		<div class="card">
			<div class="card-body">
				<div class="table-responsive pt-3">
					<div id="">		
	                  자재명 <input type="text"  id="matCodeInput">
	                   <button type="button" class="btn btn-info btn-icon-text" id="searchBtn">
	                     <i class="fas fa-search"></i>
	                     검색
	                  </button>
	                  <button type="button" class="btn btn-info btn-icon-text" id="searchResetBtn">
	                     초기화
	                  </button>
		          	</div>
		          </div>
		          <div>
	            	<button id="matSave" class="btn btn-info btn-icon-text" >저장</button>
	            	<button id="delete" class="btn btn-info btn-icon-text" >삭제</button>
	            	<button id="matAdd" class="btn btn-info btn-icon-text">행추가</button>
	            	</div>
	           		<div id="grid"></div>
				
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
       </div>
       <div class="m_footer">
            
    </div>
  </div>
	</div>
<script>
		//삭제버튼
		$('#delete').on("click",function(){
			//그리드 행 지움
			grid.removeCheckedRows(true);
			//마우스 커서 없앰
			grid.blur();
			});
		
		
		//저장버튼
		document.getElementById('matSave').addEventListener('click', matSave);
		//행추가
		document.getElementById('matAdd').addEventListener('click', addMatRow);
		
		function addMatRow(){
			grid.appendRow({},{ at: 0 });
		}
		
		function matSave(){
			grid.blur();
			let modifyGridInfo = grid.getModifiedRows();
			let flag = true;
			
			var list = [];
			var list2 = [];
			var list3 = [];
			
			$.each(modifyGridInfo, function(idx, obj){
				
				if(!flag){
					alert("값이 입력되지 않았습니다");
					return;
				}else if(idx == 'createdRows' && obj.length != 0){
					$.each(obj, function(idx2,obj2){
						 if(obj2['matName'] == '' ||obj2['matUnit'] =='' || obj2['matStd'] == '' || obj2['matSafe'] == '' || obj2['matPrice']=='' || obj2['empCode'] == ''){
			                  flag = false;
			                  return;
			               }
						 
						 let customObj = {};
							customObj['matName'] = obj2['matName'];
							customObj['matUnit'] = obj2['matUnit'];
							customObj['matStd'] = obj2['matStd'];
							customObj['matSafe'] = obj2['matSafe'];
							customObj['empCode'] = obj2['empCode'];
							list.push(customObj);
							console.log(list);
							
							
							})
				}else if(idx == 'updatedRows' && obj.length != 0){
					$.each(obj, function(idx2, obj2){
			               if(obj2['matName'] == '' ||obj2['matUnit'] =='' ||obj2['matStd'] == '' || obj2['matSafe'] == '' || obj2['empCode']==''){
			                  flag = false;
			                  return;
			               }
			               
			               let customObj = {};
							customObj['matCode'] = obj2['matCode'];
							customObj['matName'] = obj2['matName'];
							customObj['matUnit'] = obj2['matUnit'];
							customObj['matStd'] = obj2['matStd'];
							customObj['matSafe'] = obj2['matSafe'];
							customObj['empCode'] = obj2['empCode'];
							list2.push(customObj);
							console.log(list2);

						})
						
				
				}else if(idx == 'deletedRows' && obj.length != 0){
					
					 
		            $.each(obj, function(idx2, obj2){
		                  
		                  let customObj = {};
		                  customObj['matCode'] = obj2['matCode'];
		                  list3.push(customObj);
		                  console.log(list3);
		            })

				}
				
				
			})
				 if(flag){
					 
					 if(list3.length !=0){
				            $.ajax({
				               url : 'matCodeDelete',
				               method : 'POST',
				               data : JSON.stringify(list3),
				               contentType : 'application/json',
				               success : function(data){
				            	   $.ajax({
				           			url : "ajaxMatCodeList",
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
				            });
				         }
					 if(list2.length !=0){
				            $.ajax({
				               url : 'matCodeUpdate',
				               method : 'POST',
				               data : JSON.stringify(list2),
				               contentType : 'application/json',
				               success : function(data){
				            	   $.ajax({
				           			url : "ajaxMatCodeList",
				           			 method :"GET",
				           		       success : function(result){
				           		    	 $.ajax({
							           			url : "ajaxMatCodeList",
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
				           		});
				               },
				               error : function(reject){
				                  console.log(reject);
				               }
				            });
				         }
					 if(list.length !=0){
				            $.ajax({
				               url : 'matCodeInsert',
				               method : 'POST',
				               data : JSON.stringify(list),
				               contentType : 'application/json',
				               success : function(data){
				            	   $.ajax({
				           			url : "ajaxMatCodeList",
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
				            });
				         }



				 }else{
					 return;

				 }
				
		}
			
		/* 
		function matSave(){
			grid.blur();
			let modifyGridInfo = grid.getModifiedRows();
			let flag = true;
			
			$.each(modifyGridInfo, function(idx, obj){
				if(idx == 'createdRows' && obj.length != 0){
					let inList = [];
					
					$.each(obj, function(idx2,obj2){
						for(let j in obj2){
							if(j  != 'matCode' && obj2[j] == null){
								alert('추가할 값이 입력되지 않았습니다.');
								flag = false;
								break;
							}
						}
						
					if(flag){
						let customObj = {};
						customObj['matName'] = obj2['matName'];
						customObj['matUnit'] = obj2['matUnit'];
						customObj['matStd'] = obj2['matStd'];
						customObj['matSafe'] = obj2['matSafe'];
						customObj['empCode'] = obj2['empCode'];
						inList.push(customObj);
					}
					
					if(flag){
						$.ajax({
							url : 'matCodeInsert',
							method : 'POST',
							data : JSON.stringify(inList),
							contentType : 'application/json',
							success : function(data){
								
								$.ajax({
									url : "ajaxMatCodeList",
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
					})
				}else if(idx == 'updatedRows' && obj.length != 0){
					let upList = [];
					
					$.each(obj, function(idx2, obj2){
						for(let j in obj2){
							//matTestYn, matTotalPrice는 사용자가 입력하는 값이라서 입력될 수 없으므로 제외함
							if(j != 'matCode' && obj2[j] == null){
								alert('수정할 값이 입력되지 않았습니다.');
								flag = false;
								break;
								
								
							}
							
						}
						if(flag){
							let customObj = {};
							customObj['matCode'] = obj2['matCode'];
							customObj['matName'] = obj2['matName'];
							customObj['matUnit'] = obj2['matUnit'];
							customObj['matStd'] = obj2['matStd'];
							customObj['matSafe'] = obj2['matSafe'];
							customObj['empCode'] = obj2['empCode'];
							upList.push(customObj);
				 			
						}
						console.log(upList);
						
					})
					if(flag){
						$.ajax({
							url : 'matCodeUpdate',
							method : 'POST',
							data : JSON.stringify(upList),
							contentType : 'application/json',
							success : function(data){
								$.ajax({
									url : "ajaxMatCodeList",
									 method :"GET",
								       success : function(result){
								           grid.resetData(result);
								       },
								       error : function(reject){
											console.log(reject);
										}
								})
							},
							error : function(reject){
								console.log(reject);
							}
						})
					}
					
				}else if(idx == 'deletedRows' && obj.length != 0){
					let deList = [];
					if(flag){
						$.each(obj, function(idx2, obj2){
							
							let customObj = {};
							customObj['matCode'] = obj2['matCode'];
							deList.push(customObj);
					})

					}
					
					if(flag){
						$.ajax({
							url : 'matCodeDelete',
							method : 'POST',
							data : JSON.stringify(deList),
							contentType : 'application/json',
							success : function(data){
								$.ajax({
									url : "ajaxMatCodeList",
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
						});
					}
				}
			})
			
			
		} */
		
		//자재 리스트 조회
		$.ajax({
			url : "ajaxMatCodeList",
			 method :"GET",
		       success : function(result){
		           grid.resetData(result);
		       },
		       error : function(reject){
					console.log(reject);
				}
		});
		
		var grid = new tui.Grid({
			  el: document.getElementById('grid'),
			 	scrollX: false,
		        scrollY: false,
		        minBodyHeight: 30,
		        rowHeaders: [{type: 'rowNum'},{type: 'checkbox'}],
				pageOptions: {
					useClient: true,
			        perPage: 10
			      },
		        columns: [
		        	  {
			 	 	        header: '자재코드',
			 	 	        name: 'matCode'
		 	 	      },
		 	 	      {
			 	 	        header: '자재명',
			 	 	        name: 'matName',
			 	 	    	editor : 'text'
			 	 	        
			 	 	  },
		 	 	      {
				 			header: '단위',
				 		 	name: 'matUnit',
				 		 	formatter: 'listItemText',
				            editor: {
				                type: 'select',
				                options: {
				                  listItems: [
				                	<c:forEach items="${unitList}" var="u">
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
		                    header: '규격',           
		                    name: 'matStd',
		                    editor : 'text'
		              },
		              {
			 	 	        header: '안전재고량',
			 	 	        name: 'matSafe',
			 	 	        editor : 'text'
			 	 	  },
			 	 	  {
			 	 	        header: '담당자',
			 	 	        name: 'empName',
				 	 	    editor : 'text'
			 	 	  },
			 	 	{
			 	 	        header: '담당자',
			 	 	        name: 'empCode',
				 	 	    hidden: true
			 	 	  }
		        ]
		      });
		
		//사원 모달창 출력
		 var Grid;
		$("empModal").on('click', event =>{

			  $(".modal").fadeIn();
			  Grid = createEmpGrid();	
			  
			  Grid.on('click', event => {	
					let rowKey = Grid.getFocusedCell().rowKey;
					let empName = Grid.getValue(rowKey, 'empName');
					let empCode = Grid.getValue(rowKey, 'empCode');
					$(event.currentTarget).prev().val(empCode);
					$(event.currentTarget).next().val(empName);
					if(event.currentTarget.id == 'empModal'){
			        	  obj.empCode = empCode;
		    			  obj.empName = empName;
			          }
			  
					$("#close_btn").click(function(){
						  $(".modal").fadeOut(); 
							Grid.destroy();
							
					})
					});
		})
			  
			  grid.on('dblclick' , () => {
				  let rowKey = grid.getFocusedCell().rowKey;
			      let columnName = grid.getFocusedCell().columnName;
			      let value = grid.getFocusedCell().value;
			      
			    	if(columnName == 'empName'){
			    		$(".modal").fadeIn();
			 	       Grid = createEmpGrid();
			 	       
			 	       Grid.on('click', () => {
			 	       		let rowKey2 = Grid.getFocusedCell().rowKey;
			 	        	let empCode = Grid.getValue(rowKey2, 'empCode');
			 	        	let empName = Grid.getValue(rowKey2, 'empName');
			 	        	grid.finishEditing(rowKey, columnName);

			 	    		if(empCode != null){
			 	    			grid.setValue(rowKey, 'empCode', empCode);
			 	    		}
			 	    		if(empName != null){
			 	    			grid.setValue(rowKey, 'empName', empName);
			 	    		}
			 	    		
			 	    		
			 	    		//선택시 모달창 닫기
			 	    		if(empCode != null){
			 	    			$(".modal").fadeOut();
			 	        		Grid.destroy();
			 	    		}

			 	       });
			    	} 
			  	});
		
		   $("#close_btn").click(function(){
		        $(".modal").fadeOut();
		         
		  		Grid.destroy();
		     });
		   
		 //모달창 닫기
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
				   };
		

				    
		
</script>

</body>
</html>