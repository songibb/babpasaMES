<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>

	 <!-- 토스트 페이지 네이션 -->
	 <script type="text/javascript" src="https://uicdn.toast.com/tui.code-snippet/latest/tui-code-snippet.js"></script>
	 <link rel="stylesheet" href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css" />
	 <script src="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.js"></script>
	 
	 <!-- 페이지 네이션 끝 -->
	 <link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
	 <script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
	 <link rel="preconnect" href="https://fonts.googleapis.com">
	 <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	 <link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@700&family=Noto+Sans+KR&display=swap" rel="stylesheet">
<style>
	.yellow-background {
	        background-color: rgb(255,253,235);
		}
		
	#save{
		margin-bottom : 20px;
		radius : 5px;
	}
</style>
</head>
<body>
	<div class="black_bg"></div>
	<h1>설비 점검</h1>
	<div class="col-lg-12 stretch-card">
    	<div class="card">
        	<div class="card-body">
            	<div class="table-responsive pt-3">
	            	<form>
	            		<div id="customtemplateSearchAndButton">
	            			<p>설비구분</p>
	            			<select name="job">
							    <option value="">설비구분</option>
							    <option value="증숙">증숙</option>
							    <option value="혼합">혼합</option>
							    <option value="냉동">냉동</option>
							</select><br>
							
							<p>판정구분</p>
							<select name="job">
							    <option value="">판정구분</option>
							    <option value="합격">합격</option>
							    <option value="불합격">불합격</option>
							    <option value="기타">기타</option>
							</select>
						
							<br>
							<p>점검일자</p>
							 <p><input type="date"></p> ~ <p> <input type="date"></p>
							<button type="button" class="btn btn-info btn-icon-text">검색</button>
							</div>
							

			
						</div>	
					</form>
					
					<div style="display: flex; justify-content: flex-end;">

							<button id="save" class="btn btn-info btn-icon-text">저장</button>          	
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
            <div class="modal_btn cancle" id="close_btn">CANCLE</div>
            <div class="modal_btn save" id="save_btn">SAVE</div>
    </div>
  </div>
</div>

	
	<script>
	
	//저장
	document.getElementById('save').addEventListener('click', saveServer);

	//저장
    function saveServer() {	
    	let rowKey = grid.getFocusedCell();
    	let codeValue = grid.getValue(rowKey, 'eqCode');
    	
		if(eqCode =! null){
			//inse
			ChkequipUpdate();
			
			//if -> 상세생산계획칸 비어있으면 작동X
			
		}

	};
	
			
	     function ChkequipUpdate(){
	 		//alert 표시를 위한 변수
	 		var updateOk;
	 		
	 		//생산계획 -> update
	 		let rowKey = grid.getFocusedCell().rowKey;
	 		let columnName = grid.getFocusedCell().columnName;
	 		//편집종료
	 		grid.finishEditing(rowKey, columnName);

	 		let list = grid.getData();
	 		console.log(list);

	 		$.ajax({
	 			url : 'updateChkEquip',
	 			method : 'POST',
	 			data : JSON.stringify(list),
	 			contentType : 'application/json',
	 			async : false,  //data 모두 수신 후 변수 updateOk에 담기 위해 동기방식으로 처리
	 			success : function(data){	
	 				updateOk = data;

	 				//수정 후 그리드 내용 지우고, 행추가
	 				grid.clear();
	 				grid.appendRow();
	 			},
	 			error : function(reject){
	 	 			console.log(reject);
	 	 		}		
	 		})
	 		
	 		if(updateOk > 0){
	 			alert('정보가 업데이트 되었습니다.')
	 			/* swal("정보가 업데이트 되었습니다.","","success"); */
			}
	     }
	     
	     
	     
	   //점검 설비 grid
	     var grid = new tui.Grid({
	         el: document.getElementById('grid'),
	         data: [
		        	<c:forEach items="${equipchkList}" var="chk" varStatus="status">
		           	{
		           		eqCode : "${chk.eqCode}",
		           		eqName : "${chk.eqName}",
		           		eqType : "${chk.eqType}",
		           		chkCycle : "${chk.chkCycle}",
		           		chkDate : "<fmt:formatDate value='${chk.chkDate}' pattern='yyyy-MM-dd'/>",
		           		chkNextDate : "<fmt:formatDate value='${chk.chkNextDate}' pattern='yyyy-MM-dd'/>",
		           		eqChkYn : "${chk.eqChkYn}",
		           		empCode : "${chk.empCode}",
		           		chkNote : "${chk.chkNote}"		   	        
		           	}<c:if test="${not status.last}">,</c:if>
		           </c:forEach>
			          ], 
	         scrollX: false,
	         scrollY: false,
	         minBodyHeight: 30,
	         rowHeaders: ['rowNum', 'checkbox'],
	         pagination: true,
				pageOptions: {
				useClient: true,
				perPage: 10,
				},
	         columns: [
	           {
	             header: '설비코드',
	             name: 'eqCode'
	           },
	           {
		         header: '설비명',
		         name: 'eqName'
		       },
		       {
			     header: '설비구분',
			     name: 'eqType'
			   },
	           {
		         header: '점검주기(일)',
		         name: 'chkCycle'
		       },
	           {
	             header: '점검일자',
	             name: 'chkDate',
	           	 editor : 'text',
	           	 className: 'yellow-background'
	           },
	           {
	               header: '차기점검일자',
	               name: 'chkNextDate',
	               formatter: function(props) {
	                   const rowData = props.row;
	                   const chkDate = new Date(rowData.chkDate);
	                   const chkCycle = parseInt(rowData.chkCycle);
	                   
	                   if (!isNaN(chkCycle)) {
	                       const chkNextDate = new Date(chkDate.getTime() + chkCycle * 24 * 60 * 60 * 1000);
	                       const formattedChkNextDate = chkNextDate.toISOString().split('T')[0];
	                       return formattedChkNextDate;
	                   }
	                   
	                   return ''; // Return empty string if chkCycle is not a valid number
	               }
	           },
	         	//지울부분
	           {
	 			header: '점검판정',
	             name: 'eqChkYn',
	             formatter: 'listItemText',
					editor: {
		                type: 'select',
		                options: {
		                  listItems: [
		                	<c:forEach items="${equipPassType}" var="u">
		                	 {
		                         text: '${u.commdeName }',
		                         value: '${u.commdeCode }'
		                       }, 
							</c:forEach>
		                  ]
		                }
		              }
	           },
	           {
	        	  header: '담당자코드',
		 	      name: 'empCode',
		 	      editor : 'text',
		 	      value : '${chk.empCode}'
			 	      
	           },	          
	           {
	        	  header: '비고',
		 	      name: 'chkNote',
		 	      editor : 'text'
	           }
	         ]
	 	});
	   
	   //행 클릭 모달
	     var Grid;
	     grid.on('click', () => {
	    	let rowKey = grid.getFocusedCell().rowKey;
	    	let columnName = grid.getFocusedCell().columnName;
	    	if(columnName == "empCode"){
	    		$(".modal").fadeIn();
	    	       Grid = createProdGrid();
	    	       
	    	       Grid.on('click', () => {
	    	       		let rowKey2 = Grid.getFocusedCell().rowKey;
	    	        	let empCode = Grid.getValue(rowKey2, 'empCode');
	    	        	let empName = Grid.getValue(rowKey2, 'empName');
	    	        	
	    	        	console.log(empCode);
	    	        	console.log(empName);

	    	        	grid.setValue(rowKey, 'empCode', empCode);
	    	        	grid.setValue(rowKey, 'empName', empName);
	    	    		//선택시 모달창 닫기
	    	    		if(rowKey != null){
	    	    			$(".modal").fadeOut();
	    	        		Grid.destroy();
	    	    		}

	    	       });
	    	}

	  	});
		
		//모달창 닫기
		$("#close_btn").click(function(){
	        $(".modal").fadeOut();
	         
	  		Grid.destroy();
	     });
		
		 
	     //사원 목록모달 그리드
	     function createProdGrid(){
	        var prodGrid = new tui.Grid({
	            el: document.getElementById('modal_label'),
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
	                    header: '사원번호',
	                    name: 'empCode',
	                  },                  
	                  {
	                    header: '사원명',
	                    name: 'empName'
	                  }
	             ]
	           
	          });
	        
	        
	        $.ajax({
			    url : 'empCodeList',
			    method : 'GET',
			    success : function(data){
			    	prodGrid.resetData(data);
			    },
			    error : function(reject){
			        console.log(reject);
			    }	
			})		 
	        return prodGrid;
	     }
		     
	     
	     
	     grid.on('afterChange', (ev) => {
	         let change = ev.changes[0];
	         let rowData = grid.getRow(change.rowKey);

	         // Convert chkDate string to a Date object
	         let chkDate = new Date(rowData.chkDate);
	         
	         // Convert chkCycle to a number (assuming it's a string right now)
	         let chkCycle = parseInt(rowData.chkCycle);
	         
	         // Check if chkCycle is a valid number
	         if (isNaN(chkCycle)) {
	             return; // Exit if chkCycle is not a valid number
	         }
	         
	         // Calculate chkNextDate by adding chkCycle days to chkDate
	         let chkNextDate = new Date(chkDate.getTime() + chkCycle * 24 * 60 * 60 * 1000);
	         
	         // Update chkNextDate column if chkDate and chkCycle are both not null
	         if (change.columnName == 'chkDate' || change.columnName == 'chkCycle') {
	             if (rowData.chkDate != null) {
	                 // Convert chkNextDate to a string in the desired format (YYYY-MM-DD)
	                 let formattedChkNextDate = chkNextDate.toISOString().split('T')[0];
	                 grid.setValue(change.rowKey, 'chkNextDate', formattedChkNextDate);
	             }
	         }
	     });

	</script>
</body>
</html>	
