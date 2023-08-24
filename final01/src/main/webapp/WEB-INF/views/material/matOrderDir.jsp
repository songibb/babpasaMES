<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자재 발주 관리</title>
<!-- 토스트 페이지 네이션 -->
<script type="text/javascript" src="https://uicdn.toast.com/tui.code-snippet/latest/tui-code-snippet.js"></script>
<link rel="stylesheet" href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css" />
<script src="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.js"></script>
<!-- 페이지 네이션 끝 -->
<link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
<style>
   #newPrcsPlanView, #save, #delete, #dirAdd{
		margin-top : 120px;
		float : right;
	}

	h1{
		font-weight : 700;
	}

	h2{
		clear : both;
		font-weight : 700;
	}
	
	.yellow-background {
        background-color: rgb(255,253,235);
	}
	
	#grid{
		height: 700px;
		
	}
	
	.modal_content{
	  /*모달창 크기 조절*/
	  width:600px; height:700px;
	  background:#fff; border-radius:10px;
	  /*모달창 위치 조절*/
	  position:relative; top:28%; left:45%;
	  margin-top:-100px; margin-left:-200px;
	  text-align:center;
	  box-sizing:border-box;
	  line-height:23px;
	}
	
	.m_body > p{
		display : inline-block;
	}
	
	.m_body > input{
		border : 1px solid black;
	}
	
	/* 2번째 모달 */
	.modal2{ 
		position:fixed; width:100%; height:100%; background: rgba(0,0,0,0.8); top:0; left:0; bottom: 0; right: 0;display:none;
	}
	  
	.modal_content2{
		  /*모달창 크기 조절*/
		  width:1000px; height:750px;
		  background:#fff; border-radius:10px;
		  /*모달창 위치 조절*/
		  position:relative; top:26%; left:32%;
		  margin-top:-100px; margin-left:-200px;
		  text-align:center;
		  box-sizing:border-box;
		  line-height:23px;
	}
	
	
	     
	.close_btn2{
		font-size: 20px;
		color: black;
		font-weight: 900;
		cursor: pointer;
	}
	
	.modal_btn2{
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
	.m_head2{
		height: 7%;
		margin : 0;
		/*제목 높낮이 조절*/
		padding: 17px;
		display: flex;
		justify-content: space-between;
		background-color:rgb(232, 143, 33);
		border-top-left-radius: 10px;
		border-top-right-radius: 10px;
	}
	
	.m_body2{
		height: 80%;
		padding: 20px;
	}
	
	
	
	
/*모달끝*/
	
</style>    
       
</head>
<body>
   <h1>자재 발주 관리</h1>
   <div class="col-lg-12 stretch-card">
       <div class="card">
           <div class="card-body">
               <div class="table-responsive pt-3">
               		<button type="button" class="btn btn-info btn-icon-text excelDownload">
                      	 Excel
                      	<i class="bi bi-printer"></i>                                                                              
                   	</button>
                   	<button class="btn btn-info btn-icon-text" id="save">저장</button>
                	<button class="btn btn-info btn-icon-text" id="delete">삭제</button>
                	<button class="btn btn-info btn-icon-text" id="dirAdd">행추가</button>
                	<button type="button" class="btn btn-info btn-icon-text" id="newPrcsPlanView">
                    	신규생산계획
                	</button>
                  	<div id="customtemplateSearchAndButton">
        				<div style="display: flex; justify-content: space-between;">
            				<div style="flex: 1;">
                				<p>자재명</p>
                				<input type="text" id="matCodeInput">
                				<i class="bi bi-search" id="matModal"></i> <!-- 돋보기 아이콘 -->
                				<input type="text" class="blackcolorInputBox" id="matNameFix" readonly>
                				<br>
                				<p>업체명</p>
                				<input type="text" id="actCodeInput">
                				<i class="bi bi-search" id="actModal"></i>
                				<input type="text" class="blackcolorInputBox" id="actNameFix" readonly>
                				<br>
                				<p>발주일자</p>
                				<input id="startDate" type="date">&nbsp;&nbsp;-&nbsp;&nbsp;<input id="endDate" type="date">
                				<br>
                				<p>검수상태</p>
                				<label for="before"><input type="checkbox" id="before" value="before">검수전</label>
                				<label for="comple"><input type="checkbox" id="comple" value="comple">검수완료</label>
                				<button type="button" class="btn btn-info btn-icon-text" id="searchBtn">
                    				<i class="fas fa-search"></i>
                    					검색
                				</button>
                				<button type="button" class="btn btn-info btn-icon-text" id="searchResetBtn">
                    				초기화
                				</button>
                				
                				<br>
                				<p>등록 업체명</p>
                  				<input type="text" id="selectActCodeInput">
                    			<i class="bi bi-search" id="selectActModal"></i>
                    		
                  				<input type="text" class="blackcolorInputBox" id="selectActNameFix" readonly>
                			
            				</div>
        				</div>
	    			</div>
		            <h2>발주 목록</h2>
		            <br>
		            <div id="grid"></div>
				</div>
			</div>
		</div>
	</div> 
	<div class="modal" id="modal">
   		<div class="modal_content">
        	<div class="m_head">
            	<div class="modal_title"><h3>목록</h3></div>
            	<div class="close_btn" id="close_btn">X</div>
       		</div>
       		<div class="m_body">
       			<p>이름</p>
                <input type="text" id="modalSearch">
                <button type="button" class="btn btn-info btn-icon-text" id="modalSearchBtn">검색</button>
            	<div id="modal_label"></div>
       		</div>
       		<div class="m_footer">
            	<div class="modal_btn cancle close_btn">CANCLE</div>
    		</div>
  		</div>
	</div>
	<div class="modal modal2" id="modal2">
   		<div class="modal_content modal_content2">
        	<div class="m_head2">
            	<div class="modal_title2"><h3>신규 생산계획 목록</h3></div>
            	<div class="close_btn2" id="close_btn2">X</div>
       		</div>
       		<div class="m_body2">
       			<h3>신규 생산 계획</h3>
            	<div id="modal_label2"></div>
            	<h3>해당 생산 계획 자재 소모량</h3>
            	<div id="modal_label3"></div>
       		</div>
  		</div>
	</div>


	<script>
		
	
	
	
	
	//삭제버튼
	$('#delete').on("click",function(){
		//그리드에서 행 지움
		orderGrid.removeCheckedRows(false);
		//마우스 커서 없앰
		orderGrid.blur();
	});
	
	
	//저장버튼
	document.getElementById('save').addEventListener('click', saveServer);
	//행추가
	document.getElementById('dirAdd').addEventListener('click', addDirRow);
	
	

	//행추가 버튼
	
	function addDirRow(){
		//등록 거래처명
		actName = $('#selectActNameFix').val();
		actCode = $('#selectActCodeInput').val();
		
		
		//등록 거래처가 없으면 행추가를 못함
		if($('#selectActNameFix').val().length === 0){
			swal("","업체를 먼저 등록해주세요.", "warning");
		} else {
			//거래처가 등록되어 있을 경우 행추가 허용
			let now = new Date();	// 현재 날짜 및 시간
			let year = now.getFullYear();
			let month = ('0' + (now.getMonth() + 1)).substr(-2);
			let day = ('0' + now.getDate()).substr(-2);
			let matOdRq = year + "-" + month + "-" + day;
		    orderGrid.appendRow( {'actName' : actName, 'actCode' : actCode, 'matOdRq' : matOdRq, 'empCode' : `${user.id}`, 'empName' : `${user.empName}`}, { at: 0 });	
			
		}
	}
	
	

		//발주 form
		var orderGrid = new tui.Grid({
		        el: document.getElementById('grid'),
		        data: [
		        	<c:forEach items="${matOrderList}" var="mat" varStatus="status">
		           	{
		           	matOdCd : "${mat.matOdCd}",
		           	matOdDeCd : "${mat.matOdDeCd}",
		           	matName :"${mat.matName}",
		           	matCode : "${mat.matCode}",
		           	matUnit : "${mat.matUnit}",
		           	matStd : "${mat.matStd}",
		           	matPrice :"${mat.matPrice}",
		           	matAmt :"${mat.matAmt}",
		           	matTotalPrice : "${mat.matPrice * mat.matAmt}",
		           	actName :"${mat.actName}",
		           	actCode : "${mat.actCode}",
		           	empName : "${mat.empName}",
		           	empCode : "${mat.empCode}",
		           	matTestYn : "${mat.matTestYn}",
		           	matOdRq : `<fmt:formatDate value="${mat.matOdRq}" pattern="yyyy-MM-dd"/>`,
		           	matOdAcp :`<fmt:formatDate value="${mat.matOdAcp}" pattern="yyyy-MM-dd"/>`
		           	}<c:if test="${not status.last}">,</c:if>
		           </c:forEach>
			          ],
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
		 	 	        header: '발주코드',
		 	 	        name: 'matOdCd',
				 	 	width: 150
		 	 	      },
		 	 	      {
				 			header: '자재명',
				 		 	name: 'matName',
				 	 	    editor : 'text'
				 	  },
				 	  {
		                    header: '자재코드',            // [필수] 컬럼 이름
		                    name: 'matCode',                 // [필수] 컬럼 매핑 이름 값
		                    hidden : true                // [선택] 숨김 여부
		              },
		              {
		            	  	header: '단위',
				 		 	name: 'matUnit' 
		              },
		              {
		            	  	header: '규격',
				 		 	name: 'matStd'
		              },
		              {
			 	 	        header: '단가(원)',
			 	 	        name: 'matPrice',
			 	 	        editor : 'text',
				 	       	formatter(e) { 
			 	 	        	if(e['value'] != null){
				 	        	val = e['value'].toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
				 	           	return val +"원";	
			 	 	        	}
				 	        },
				 	        width: 120,
				 	 	  	validation: {
					 	         dataType: 'number',
					 	         required: true
					 	    }
			 	 	  },
			 	 	  {
			 	 	        header: '발주량',
			 	 	        name: 'matAmt',
				 	 	    editor : 'text',
				 	       	formatter(e) { 
				 	 	    	if(e['value'] != null){
					 	        	val = e['value'].toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
				 	           	return val;
				 	        	}
				 	 	    },
				 	 	  	validation: {
				 	         dataType: 'number',
				 	         required: true
				 	       }
			 	 	  },
			 	 	  {
			 	 	        header: '총액',
			 	 	        name: 'matTotalPrice',
				 	 	    value : '${mat.matPrice * mat.matAmt}',
				 	       	formatter(e) { 
				 	 	    	if(e['value'] != null){
					 	        	val = e['value'].toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
					 	           	return val +"원";	
				 	 	        	}
				 	        },
				 	        width: 120
			 	 	  },
		        	  {
		 	 	        header: '업체명',
		 	 	        name: 'actName'
		 	 	      },
		 	 	      {
		                header: '업체코드',            // [필수] 컬럼 이름
		                name: 'actCode',                 // [필수] 컬럼 매핑 이름 값
		                hidden : true                // [선택] 숨김 여부
		              },
		 	 	      
		 	 	      {
		 	 	        header: '발주일자',
		 	 	        name: 'matOdRq',
		 	  		 	className: 'yellow-background'
		 	 	      },
		              {
				 	 	    header: '납기요청일',
				 	 	    name: 'matOdAcp',
				 	 	  	editor: {
				  		      type: 'datePicker',
				  		      options: {
				  		    	  language: 'ko'
				  		      }
				  		    },
				  		  	className: 'yellow-background'
				 	  },
				 	  {
				 		  header: '발주상세코드',
				 		  name: 'matOdDeCd',
				 		  hidden: true
				 	  },
				 	  {
		                    header: '담당자코드',            // [필수] 컬럼 이름
		                    name: 'empCode',
		                    hidden :true
		              },
		              {
		            	  header: '검수여부',
		            	  name: 'matTestYn',
		            	  formatter: function (e) {
		      					if(e.value == 'Y'){
		      						return "검수완료";
		      					} else if(e.value == 'N'){
		      						return "검수전";
		      					}
		                  }   
		      		      
		              },
		 	 	      {
		                    header: '담당자명',            // [필수] 컬럼 이름
		                    name: 'empName'             // [필수] 컬럼 매핑 이름 값                   // [선택] 숨김 여부
		              },
		        ]
		      });
		
		setDisabled();
   
	
	

		orderGrid.on('afterChange', (ev) => {
			
			let change = ev.changes[0];
			let rowData = orderGrid.getRow(change.rowKey);
			let totalPrice = rowData.matPrice * rowData.matAmt;
			
			if(change.columnName == 'matAmt' || change.columnName == 'matPrice'){
				if(rowData.matAmt != null && rowData.matPrice != null){
					orderGrid.setValue(change.rowKey, 'matTotalPrice', totalPrice);
				}
			}
		});
	
	
	
	
		function saveServer() {	
			orderGrid.blur();
			let modifyGridInfo = orderGrid.getModifiedRows();
			
			// 수정된게 없으면 바로 빠져나감
			
			if(!orderGrid.isModified()){
				swal("", "변경사항이 없습니다", "warning");
				return false;
			}
			
			//flag가 true = 입력폼이나 수정폼에 빠뜨린 데이터가 없다
			var flag = true;
			//create, modify, delete 포함하는 전체 배열을 도는 each문			
				
			if(orderGrid.getModifiedRows().createdRows.length > 0 ){
					
					$.each(orderGrid.getModifiedRows().createdRows, function(idx2, obj2){
						if(obj2['actCode'] == "" ||obj2['matAmt']  =="" || obj2['matCode'] == "" || obj2['matOdAcp'] == "" || obj2['matPrice']=="" || obj2['matOdRq'] == ""){
							flag = false;
							return false;
						}
					})
			}
			
			if(orderGrid.getModifiedRows().updatedRows.length > 0 ){
				$.each(orderGrid.getModifiedRows().updatedRows, function(idx2, obj2){
						if(obj2['matOdDeCd'] == "" ||obj2['actCode'] == "" ||obj2['matAmt'] == "" || obj2['matCode'] == "" || obj2['matOdAcp']== "" || obj2['matPrice'] == ""){
							flag = false;
							return false;
						}
					
				})
			}
					
			
			
			if(flag){
					$.ajax({
						url : 'matOrderDirSave',
						method : 'POST',
						data : JSON.stringify(orderGrid.getModifiedRows()),
						contentType : 'application/json',
						success : function(data){
							swal("성공", data +"건이 처리되었습니다.", "success");
							selectAjax();
						},
						error : function(reject){
							console.log(reject);
							swal("실패", "", "error");
						}
					})
			} else {
				swal("", "값이 입력되지 않았습니다", "warning");
			}
	
		}
	
		//검색
		function selectAjax(){
			let mat = $('#matCodeInput').val();
			let act = $('#actCodeInput').val();
			let sd = $('#startDate').val();
			let ed = $('#endDate').val();
			let comple = '1';
			let before = '1';
			   let beforeCheck = document.getElementById('before');
			   let compleCheck = document.getElementById('comple');
			   if(beforeCheck.checked && !compleCheck.checked){
				   comple = '2';
			   } else if(!beforeCheck.checked && compleCheck.checked){
				   before = '2';
			   }
				  
			   let search = { materialCode : mat , accountCode : act , startDate : sd , endDate : ed, before : before, comple : comple};
			$.ajax({
				url : 'getMatOrderFilter',
				method : 'GET',
				data : search,
				success : function(data2){
					
					$.each(data2, function(idx, obj){
						obj['matTotalPrice'] = obj['matPrice'] * obj['matAmt'];
						let date = new Date(obj['matOdRq']);
						let year = date.getFullYear();    //0000년 가져오기
						let month = date.getMonth() + 1;  //월은 0부터 시작하니 +1하기
						let day = date.getDate();        //일자 가져오기
						obj['matOdRq'] = year + "-" + (("00"+month.toString()).slice(-2)) + "-" + (("00"+day.toString()).slice(-2));
						
						date = new Date(obj['matOdAcp']);
						year = date.getFullYear();    //0000년 가져오기
						month = date.getMonth() + 1;  //월은 0부터 시작하니 +1하기
						day = date.getDate();        //일자 가져오기
						obj['matOdAcp'] = year + "-" + (("00"+month.toString()).slice(-2)) + "-" + (("00"+day.toString()).slice(-2));
						
						
					})
					orderGrid.resetData(data2);
					setDisabled();
				}
			})
		}
		
		function findColumns(){
			var rows = orderGrid.findRows({
				matOdCd : null
			});
			return rows;
		}
		
	//거래처명, 자재명, 담당자명 클릭하면 모달창 나온 후 선택할 수 있음. 선택 시 hidden cell에 데이터 넘어감
		var Grid;
		$("#actModal, #selectActModal").on('click', event =>{
			
		       $("#modal").fadeIn();
		       preventScroll();
		       Grid = createActGrid();
		       $('.modal_title h3').text('거래처 목록');
		       Grid.on('dblclick', event2 => {
		        	let rowKey = Grid.getFocusedCell().rowKey;
		        	if(rowKey != null){
		        		let actCode = Grid.getValue(rowKey, 'actCode');
			        	let actName = Grid.getValue(rowKey, 'actName');
			    		$(event.currentTarget).prev().val(actCode);
			    		$(event.currentTarget).next().val(actName);
			    		if(event.currentTarget.id == 'selectActModal'){
			    			var rows = findColumns();
			    			$.each(rows, function(idx, obj){
			    				obj.actCode = actCode;
			    				obj.actName = actName;
			    			})
			    		}
		        	}

		    		//모달창 닫기
		    		if(rowKey != null){
		    			$("#modal").fadeOut();
		    			activeScroll();
		    			let inputContent = $('#modalSearch').val('');
		    			if(Grid != null && Grid.el != null){
		 	    			Grid.destroy();	
		 	    		}
		    		}

		    	});
		});
			
		     
		$("#matModal").click(function(){
		       $("#modal").fadeIn();
		       preventScroll();
		       Grid = createMatGrid();
		       $('.modal_title h3').text('자재 목록');
		       Grid.on('dblclick', () => {
		       	let rowKey = Grid.getFocusedCell().rowKey;
		       	if(rowKey != null){
		       		let matCode = Grid.getValue(rowKey, 'matCode');
			    	let matName = Grid.getValue(rowKey, 'matName');
					$("#matNameFix").val(matName);
			       
			   		$("#matCodeInput").val(matCode);
		       	}
		       	
		   		//모달창 닫기
		   		if(rowKey != null){
					$("#modal").fadeOut();
					activeScroll();
					let inputContent = $('#modalSearch').val('');
					if(Grid != null && Grid.el != null){
	 	    			Grid.destroy();	
	 	    		}

		   		}
		     })
		});
	
		
		orderGrid.on('dblclick', ev => {
	    	let rowKey = orderGrid.getFocusedCell().rowKey;
	    	let columnName = orderGrid.getFocusedCell().columnName;
	    	let value = orderGrid.getFocusedCell().value;
	    	
	    	
	 	   	let matOdCd = orderGrid.getValue(rowKey, 'matOdCd');
	 	   	let matTestYn = orderGrid.getValue(rowKey, 'matTestYn');
	 	   	if(matOdCd != null){
	 		   if(matTestYn == 'Y'){
	 			   ev.stop();
	 			   return false;
	 		   }
	 	   	}
	    	
	    	if(columnName == 'matName'){
	    		$("#modal").fadeIn();
	    		preventScroll();
	 	       	Grid = createMatGrid();
	 	      $('.modal_title h3').text('자재 목록');
	 	       Grid.on('dblclick', () => {
	 	       		let rowKey2 = Grid.getFocusedCell().rowKey;
	 	       		if(rowKey2 != null){
		 	       		let matCode = Grid.getValue(rowKey2, 'matCode');
		 	        	let matName = Grid.getValue(rowKey2, 'matName');
		 	        	let matUnit = Grid.getValue(rowKey2, 'matUnit');
		 	        	let matStd = Grid.getValue(rowKey2, 'matStd');
		 	        	orderGrid.finishEditing(rowKey, columnName);
		
		 	    		if(matCode != null){
		 	    			orderGrid.setValue(rowKey, 'matCode', matCode);
		 	    		}
		 	    		if(matName != null){
		 	    			orderGrid.setValue(rowKey, 'matName', matName);
		 	    		}
		 	    		if(matUnit != null){
		 	    			orderGrid.setValue(rowKey, 'matUnit', matUnit);
		 	    		}
		 	    		if(matStd != null){
		 	    			orderGrid.setValue(rowKey, 'matStd', matStd);
		 	    		}
	 	       		}
	 	        	
	 	    		
	 	    		
	 	    		//선택시 모달창 닫기
	 	    		if(rowKey2 != null){
	 	    			$("#modal").fadeOut();
	 	    			activeScroll();
	 	    			let inputContent = $('#modalSearch').val('');
	 	    			if(Grid != null && Grid.el != null){
		 	    			Grid.destroy();	
		 	    		}
	 	    		}
	
	 	       });
	    	} 
    	

  	});
		
		//모달 검색
		$('#modalSearchBtn').on('click', function(e){
			let title = $('.modal_title h3').text();
			let inputContent = $('#modalSearch').val();
			
			if(title == '자재 목록'){
				let modalSearchData = {matName : inputContent}
				$.ajax({
					url : 'getMatModalSearch',
					method : 'GET',
					data : modalSearchData,
					success : function(data){
						
						Grid.resetData(data);
					},
					error : function(reject){
						console.log(reject);
					}
				})
			} else if(title == '거래처 목록'){
				let modalSearchData = {actName : inputContent}
				$.ajax({
					url : 'getActModalSearch',
					method : 'GET',
					data : modalSearchData,
					success : function(data){
						
						Grid.resetData(data);
					},
					error : function(reject){
						console.log(reject);
					}
				})
			}
		})
		
		
	//비활성화
	function setDisabled(){
		$.each(orderGrid.getData(), function(idx, obj){
			
			if(obj['matOdCd'] != null && obj['matTestYn'] == 'Y'){
				orderGrid.disableRow(obj['rowKey']);
			}
		})
	}
	
		
	
	//모달창 닫기
	$(".close_btn").click(function(){
        $("#modal").fadeOut();
        activeScroll();
        let inputContent = $('#modalSearch').val('');
        if(Grid != null && Grid.el != null){
 			Grid.destroy();	
 		}
     });
	
	//거래처 모달 그리드
     function createActGrid(){
  	   var actGrid = new tui.Grid({
  	       el: document.getElementById('modal_label'),
  	       data: [
  	    	   <c:forEach items="${actList}" var="a" varStatus="status">
  	          	{
  	          		actCode : "${a.actCode}",
  	          		actName :"${a.actName}",
  	          		actSts :"${a.actSts}",
  	          		actKind :"${a.actKind}"
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
  	               header: '거래처코드',
  	               name: 'actCode',
  	             },
  	             {
  	               header: '거래처명',
  	               name: 'actName'
  	             },
  	             {
  	               header: '거래상태',
  	               name: 'actSts'
  	             },
  	             {
  	               header: '거래처구분',
  	               name: 'actKind'
  	             }
  	 	    ]
  	      
  	     });
  	   
  	   return actGrid;
     }
	
   //자재 모달 그리드
     function createMatGrid(){
	   var matGrid = new tui.Grid({
	       el: document.getElementById('modal_label'),
	       data: [
	    	   <c:forEach items="${matList}" var="m" varStatus="status">
	          	{
	          		matCode : "${m.matCode}",
	          		matName :"${m.matName}",
	          		matUnit : "${m.matUnit}",
	          		matStd :"${m.matStd}"
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
	               header: '자재명',
	               name: 'matName'
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
	   
	   return matGrid;
  }
   
   //이전 날짜 선택불가
     $( '#startDate' ).on( 'change', function() {
       $( '#endDate' ).attr( 'min',  $( '#startDate' ).val() );
     } );
    //이후날짜 선택불가
     $( '#endDate' ).on( 'change', function() {
          $( '#startDate' ).attr( 'max',  $( '#endDate' ).val() );
        } );
    
    
   //검색
     $('#searchBtn').on('click', searchMatIn);
    function searchMatIn(e){
 	   let mat = $('#matCodeInput').val();
 	   let act = $('#actCodeInput').val();
 	   let sd = $('#startDate').val();
 	   let ed = $('#endDate').val();	   
 		  
 	   let search = { materialCode : mat , accountCode : act , startDate : sd , endDate : ed };
 	   selectAjax();
    }
    
  //초기화
    $('#searchResetBtn').on('click', resetInput);
    function resetInput(e){
 	   $('input').each(function(idx, obj){
 		   obj.value = '';
 	   })
    }
    
 	//스크롤 막기
  	function preventScroll(){
	   $('html, body').css({'overflow': 'hidden', 'height': '100%'}); // 모달팝업 중 html,body의 scroll을 hidden시킴
		   $('#element').on('scroll touchmove mousewheel', function(event) { // 터치무브와 마우스휠 스크롤 방지
			   event.preventDefault();
			   event.stopPropagation();
			
			   return false;
	   });
  	}

  //스크롤 활성화
  	function activeScroll(){
      	$('html, body').css({'overflow': 'visible', 'height': '100%'}); //scroll hidden 해제
  		$('#element').off('scroll touchmove mousewheel'); // 터치무브 및 마우스휠 스크롤 가능
 	 }
    
    //엑셀 다운로드
    const excelDownload = document.querySelector('.excelDownload');
    
    document.addEventListener('DOMContentLoaded', ()=>{
       excelDownload.addEventListener('click', function(e){
          orderGrid.export('xlsx');
       })
    })
    
    //2번째 모달창
		var Grid2;
		$("#newPrcsPlanView").click(function(){
			$("#modal2").fadeIn();
			preventScroll();
			Grid2 = createPrcsNewPlanGrid();
			
			//첫번째 그리드 클릭시 두번째 그리드 생성
			Grid2.on('dblclick', () => {
		    	
		    	
		    	//클릭한 계획의 계획코드 가져오기
		    	let rowKey = Grid2.getFocusedCell().rowKey;
		    	let prodCode = Grid2.getValue(rowKey, 'prodCode');
		    	let planAmt = Grid2.getValue(rowKey, 'prcsPlanAmt');
				if(rowKey >= 0){
					
					if(Grid3 != null && Grid3.el != null){
						
						Grid3.destroy();
					}
					
			    		
				}
				$.ajax({
					url : 'getNewPrcsPlanUseAmt',
					method : 'GET',
					data : { prodCode : prodCode },
					success : function(data){
							
						Grid3 = createPrcsNewPlanAmtGrid(planAmt);
						Grid3.resetData(data);
			 		},
					error : function(reject){
				 		console.log(reject);
				 	}	
				
		    	
				})
		  	
		    })
		});
		
		
		//신규 생산계획 그리드
		function createPrcsNewPlanGrid(){
	  	   	var prcsNewPlanGrid = new tui.Grid({
	  	       el: document.getElementById('modal_label2'),
	  	       data: [
	  	    	   <c:forEach items="${planList}" var="plan" varStatus="status">
	  	          	{
	  	          		prcsPlanName : "${plan.prcsPlanName}",
	  	          		prodName :"${plan.prodName}",
	  	          		prcsPlanAmt :"${plan.prcsPlanAmt}",
	  	          		prodCode : "${plan.prodCode}",
	  	          		prcsPlanDate : `<fmt:formatDate value="${plan.prcsPlanDate}" pattern="yyyy-MM-dd"/>`
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
	  	         perPage: 4
	  	       },
	  	       columns: [
	  	    	   	{
	  	               header: '계획명',
	  	               name: 'prcsPlanName',
	  	             },
	  	             {
	  	               header: '제품명',
	  	               name: 'prodName'
	  	             },
	  	             {
	  	               header: '제품코드',
	  	               name : 'prodCode',
	  	               hidden : true
	  	             },
	  	             {
	  	               header: '계획량',
	  	               name: 'prcsPlanAmt',
	  			 	   formatter(e) { 
			 	        	val = e['value'].toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
			 	           	return val;
			 	        }
	  	             },
	  	             {
	  	               header : '계획날짜',
	  	               name: 'prcsPlanDate',
			 	  	   className: 'yellow-background'
	  	             }
	  	 	    ]
	  	      
	  	     });
	  	   
	  	   	return prcsNewPlanGrid;
	     }
		
		
		
		
		//두번째 그리드 내용
		var Grid3;
		function createPrcsNewPlanAmtGrid(planAmt){
	    	var prcsNewPlanAmtGrid = new tui.Grid({
	            el: document.getElementById('modal_label3'),
	            scrollX: true,
	            scrollY: true,
	            minBodyHeight: 30,
	    		rowHeaders: ['rowNum'],
	    		pagination: true,
	    		
	            columns: [
	              {
	                header: '자재명',
	                name: 'matName'
	              },
	              {
	                header: '자재 소모량',
	                name: 'bomAmt',
		 	       	formatter(e) {
	                	value = e['value'] * planAmt
		 	        	val = value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		 	           	return val;
		 	        }
	              },
	              {
	                header: '현재고량',
	                name: 'matStock'
	              }
	            ]
	          });
	    	
	    	return prcsNewPlanAmtGrid;
		}

		
		//2번째 모달창 닫기
		$(".close_btn2").click(function(){
	        $("#modal2").fadeOut();
	        activeScroll();
	        if(Grid2 != null && Grid2.el != null){
	    			Grid2.destroy();	
	    		}
	  		if(Grid3 != null && Grid3.el != null){
				
				Grid3.destroy();
			}
	    });
	

    </script>
</body>
</html>