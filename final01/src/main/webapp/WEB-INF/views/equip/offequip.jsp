<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="false" %>

<!DOCTYPE html>
<html>

<head>
	<!-- alert창 꾸미기 -->
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	
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

		h1{
			font-weight : 800;
			margin-left : 15px;
		}
		
		h2{
			font-weight : 800;
		}
		
		label {
		  display: inline-block;
		  margin-bottom: 7px;
		  margin-top: 2px;
		  width:110px;
		}
	
		#input-container {
			margin-left: 5px;
		}
		#input-container input[type="text"],
		select {
		  width: 50%;
		  padding: 8px;
		  margin-bottom: 10px;
		  border: 1px solid #ccc;
		  border-radius: 4px;
		}
		
		#customtemplateSearchAndButton input[type="text"],
		select {
		  width: 200px;
		  padding: 6px;
		  margin-bottom: 15px;
		  border: 1px solid #ccc;
		  border-radius: 4px;
		}
		
		#customtemplateSearchAndButton input[type="date"],
		select {
		  width: 200px;
		  padding: 5px;
		  margin-bottom: 30px;
		  border: 1px solid #ccc;
		  border-radius: 4px;
		}
		
		#customtemplateSearchAndButton p{
			width : 115px;
			font-size: 20px;
		}
		
		#offStime{
			width:200px;
		}
		
		.selected-cell{background-color: #ffd09e;}
		
		.my-styled-cell {background-color: rgb(255, 229, 229)}
		
		#actModal{
			margin-right: 10px;
		}
		
		#customtemplateSearchAndButton{
			margin-bottom: 60px;
		}
		
		#grid tbody td{
			cursor : pointer;
		}
    </style>
    
</head>

<body>

	<div class="black_bg"></div>
	<h1>비가동 설비 관리</h1>
	<div style="display: flex;">
		<div  style="width: 30%;">
            	<div class="col-lg-12 stretch-card">
                	<div class="card">
		        		<div class="card-body" id="offcontainer">
		            		<div class="table-responsive pt-3">
									<div style="display: flex; justify-content: space-between;" >
										<h2>비가동 등록</h2>
										<button class="btn btn-info btn-icon-text" id="actModal">설비조회</button>
									</div>
								<form id="insertForm"> 
							     	<br>
								    <div id="input-container">
									      
								      		<label>비가동코드</label>
								        	 <input type="text" name="offNo" id="offNo" readonly style="background-color: #d3d3d3;"> 
												<br>
									         <label>설비코드</label>
									        	<input type="text" name="eqCode" id="eqCode">
									        	 <br>
									         <label>설비명</label>
									        	 <input type="text" name="eqName" id="eqName">
												<br>
									         <label>비가동사유</label>
									         	<input type="text" name="offType" id="offType">
												<br>
									         <label>작업내용</label>
									         	<input type="text" name="offInfo" id="offInfo">
												<br>

									         <label>비가동시작시간</label>
									         	<input type="text" name="offStime" id="offStime">
									         	 <input type="button" class="btn btn-info btn-icon-text" value="시작" onclick="setCurrentTime()" />
									         	<br>
									         <label>비가동종료시간</label>
									         	<input type="text" name="offEtime" id="offEtime">
									         	 <input type="button" class="btn btn-info btn-icon-text"  value="종료" onclick="setCurrentTime2()" />   
									      
								   </div>
						  
									<button type="submit" class="btn btn-info btn-icon-text">저장</button>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
	

		<div  style="width: 70%">
			<div class="col-lg-12 stretch-card">
		    	<div class="card">
		        	<div class="card-body" id="offcontainer">
		            	<div class="table-responsive pt-3">
		            		<div id="customtemplateSearchAndButton">		
							
									<p>설비명</p>
		  							<input type="text" placeholder="검색어를 입력하세요" id="offequipSearch">
									<button type="button" class="btn btn-info btn-icon-text" id="searchBtn">
										<i class="fas fa-search"></i> 검색
									</button>
									<button type="reset" class="btn btn-info btn-icon-text" id="resetBtn">초기화</button>
				            	</div>
		        
							<div id="grid"></div>
		
		                </div>
		             </div>
		               
		    		</div> 
		    	</div>	
	    	</div> 
	    	 
                <hr>
                
            
       </div>

	<script>
		function setCurrentTime() { //시작시간
		  var currentTime = new Date().toLocaleString(); // 현재시각, 날짜 생성
		  document.getElementById('offStime').value = currentTime; // 생성된 걸 값 뿌리기
		}
		
		
		function setCurrentTime2() { //종료시간
			  var currentTime = new Date().toLocaleString(); // 현재시각, 날짜 생성
			  document.getElementById('offEtime').value = currentTime; // 생성된 걸 값 뿌리기
			}			
	</script>
	
<div class="modal">  
  <div class="modal_content" 
       title="클릭하면 창이 닫힙니다.">
          <div class="m_head">
            <div class="modal_title"><h3>설비 목록</h3></div>
            <div class="close_btn" id="close_btn">X</div>
       </div>
       <div class="m_body">
            <div id="actGrid"></div>
       </div>
  </div>
</div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
	
	//비활성화
	function setDisabled(){
		$.each(grid.getData(), function(idx, obj){
			
			if(obj['offEtime'] != '' && obj['offEtime'] != null ){
				grid.disableRow(obj['rowKey']);

			}
		})
	}
	//설비명 검색
    $('#searchBtn').on('click', searchProdIn);
    function searchProdIn(e){
 	   let content = $('#offequipSearch').val();
 	   let search = { eqName : content };
 	   $.ajax({
 		   url : 'offsearchEquip',
 		   method : 'GET',
 		   data : search ,
 		   success : function(data){
 			   grid.resetData(data);
 			  setDisabled();
 		   },
 		   error : function(reject){
 			   console.log(reject);
 		   }
 	   })
    }

	
			//전체 비가동 설비 조회 그리드창
		    var grid = new tui.Grid({
		        el: document.getElementById('grid'),
		        data :[
		        	<c:forEach items="${offequip}" var="off"  varStatus="status">
		        	{
		        		offNo : "${off.offNo}",
		        		eqCode : "${off.eqCode}",
		        		eqName : "${off.eqName}",
		        		offType : "${off.offType}",
		        		offInfo : "${off.offInfo}",
		        		offStime : "${off.offStime}",
		        		offEtime : "${off.offEtime}",
		        	}<c:if test="${not status.last}">,</c:if>
		        	 </c:forEach>
		        ],
		        scrollX: false,
		        scrollY: false,
		        minBodyHeight: 30,
				rowHeaders: ['rowNum'],
				pagination: true,
				pageOptions: {
				useClient: true,
				perPage: 5,
				},
		        columns:  [
	 	      {
		 	        header: '비가동코드',
		 	        name: 'offNo',
			 	    align: 'center'
		 	    
		 	      },
		 	      {
		 	        header: '설비코드',
		 	        name: 'eqCode',
			 	    align: 'center'
		 	      },
		 	      {
			 	    header: '설비명',
			 	    name: 'eqName',
			 	    align: 'center'
			 	  },
		 	      {
		 	        header: '비가동사유',
		 	        name: 'offType'
		 	      },
		 	      {
			 	     header: '작업내용',
			 	     name: 'offInfo'
			 	  },
			 	 {
				 	 header: '시작시간',
				 	 name: 'offStime',
			 	  	 className: 'yellow-background',
		             width: 'auto'
				 	 
				 },
				 {
			 	     header: '종료시간',
			 	     name: 'offEtime',
			 	  	 className: 'yellow-background',
		             width: 'auto'
			 	  }
		 	      
  
		 	    ]
		      });
		    setDisabled();

		    
	    
		    
		    var Grid;
		    $("#actModal").click(function(){
		      $(".modal").fadeIn();
		      Grid = createActGrid();
		      Grid.on('click', () => {
		        let rowKey = Grid.getFocusedCell().rowKey;
		        let eqCode = Grid.getValue(rowKey, 'eqCode');
		        let eqName = Grid.getValue(rowKey, 'eqName');
		        let eqSts = Grid.getValue(rowKey, 'eqSts');
		        
		        if(rowKey != null){
		        $(".modal").fadeOut();
	              Grid.destroy();
		        // 설비 정보 가져오는 부분 추가
		        $.ajax({
		          url: "getOffEquipInfo",  // 설비 정보를 가져올 API 엔드포인트
		          method: "GET",
		          data: { eqCode: eqCode },
		          success: function(result) {
		            // result는 가져온 설비 정보를 담고 있음
		            let eqName = result.eqName;

		            
		            $('#eqCode').val(eqCode);
		            $('#eqName').val(eqName);
		            
		           

		          },
		          error: function(reject){
		            console.log(reject);
		          }
		        });
		        
		        }
		      });
		    });
  

	$("#close_btn").click(function(){
		  $(".modal").fadeOut(); 
			Grid.destroy();
		});







function createActGrid(){
	   var actGrid = new tui.Grid({
		      el: document.getElementById('actGrid'),
			  scrollX: false,
		      scrollY: false,
		      minBodyHeight: 30,
		      rowHeaders: ['rowNum'],
		      selectionUnit: 'row',
		      pagination: true,
		      pageOptions: {
		      useClient: true,
		      perPage: 10
		      },
		      columns: [
		    	      {
			 	        header: '설비코드',
			 	        name: 'eqCode',
				        align: 'center'
			 	      
			 	      },
			 	      {
			 	        header: '설비명',
			 	        name: 'eqName',
				        align: 'center'
			 	      },
			 	      {
			 	    	  header : '설비상태',
			 	    	  name : 'eqSts',
				          align: 'center'		 	    	  
			 	      },
			    ]
		    })   
	   
	   
	   $.ajax({
	       url : "selectOffEq",
	       method :"GET",
	       success : function(result){
	    	   actGrid.resetData(result);
	       },
	       error : function(reject){
				console.log(reject);
			}
		});
	   
	   return actGrid;
}



//거래처 등록/수정 한개버튼으로 같이하기

	//비가동 설비 기반으로 수정하기 
	$("#insertForm").on('submit', function(e){
		  
		  let offequipInfo = getoffequipInfo(); 
		  
		  if(offequipInfo.offStime != "" && offequipInfo.offStime != null){
			  e.preventDefault();
			  if(offequipInfo.offEtime == '' || offequipInfo.offEtime == null){
					offequipInsert(offequipInfo);
			  }else{

				  	swal("경고","종료시간이 입력되지 않았습니다","warning");
			//수정 ajax
					offequipUpdate(offequipInfo);
				}
		  }else{
			  e.preventDefault();
			  if(offequipInfo.offType =='' ||offequipInfo.offInfo == '' || offequipInfo.offStime == '' ){
 				  swal("경고","모든 값이 입력되지 않았습니다","warning");
 			  }else{
		  
			  //등록 ajax 
					offequipInsert(offequipInfo);
				}	 
		  }
	});
		  

	//form에 입력된 값들가져오기
	function getoffequipInfo(){
	let inputList = $('form').serializeArray();
	
	let offequipInfo = {};
	$.each(inputList, function(idx, obj){
		offequipInfo[obj.name] = obj.value;
	})
	
	return offequipInfo;
	};


	//등록 ajax 함수
	function offequipInsert(offequipInfo){
		offequipInfo = getoffequipInfo();
	  $.ajax({
			url : 'insertOffEquip',
			type : 'post',
			contentType : 'application/json',
			data :  JSON.stringify(offequipInfo)
		})
		.done(data => { 
			if(data != null){   //데이터의 key가 한글이라면 반드시 대괄호[''] 사용해야함
				swal('등록 성공!', '설비가 비가동 되었습니다.', 'success' )
				
				selectAjax();
				
				//form 비우기
				 $('form')[0].reset();
				
			} else{
				alert('등록 처리가 실패되었습니다.');
			}   	
			
		})
		.fail(reject => console.log(reject));
	  	
	}

	//리스트 리셋
	function selectAjax(){
		$.ajax({
		       url : "selectoffequip",
		       method :"GET",
		       success : function(result){
		           grid.resetData(result);
		           setDisabled();
		       },
		       error : function(reject){
					console.log(reject);
				}
			});
	}
	
	//수정 ajax 함수
	function offequipUpdate(offequipInfo){
		offequipInfo = getoffequipInfo();
	let etime = $('#offEtime').val();
	let ec = $('#eqCode').val();
	let etime2 = { offEtime : etime, eqCode : ec};
	$.ajax({
			url : 'updateOffEquip',
			method : 'post',
			data :  etime2
		})
		.done(data => { 
			console.log(data);
			   //데이터의 key가 한글이라면 반드시 대괄호[''] 사용해야함
				swal('저장 성공!', '비가동 종료되었습니다.', 'success' )
			
				//밑에 조회 ajax 새로 처리 필요
				selectAjax();
			
				
				//form 비우기
				 $('form')[0].reset();
			  	
		})
		.fail(reject => console.log(reject));
	}
	
	//조회 그리드 행 클릭시 해당 행 정보 input박스에 채우기 
	grid.on('click', () => {
		
		let selectKey = grid.getFocusedCell().rowKey;
		grid.addRowClassName(selectKey, 'selected-cell');
		//다른 행 선택시 기존에 클릭했던 행은 class제거
		grid.on('focusChange', () => {
			grid.removeRowClassName(selectKey, 'selected-cell');
		})
		
		let rowKey = grid.getFocusedCell().rowKey;
		let offNo = grid.getValue(rowKey, 'offNo');
		let offCode = grid.getValue(rowKey, 'offCode');
		let eqCode = grid.getValue(rowKey, 'eqCode');
		let eqName = grid.getValue(rowKey, 'eqName');
		let offType = grid.getValue(rowKey, 'offType');
		let offInfo = grid.getValue(rowKey, 'offInfo');
		let offStime = grid.getValue(rowKey, 'offStime');
		let offEtime = grid.getValue(rowKey, 'offEtime');

		
		if(offEtime == '' || offEtime == null){
		$("#offNo").val(offNo);
		$("#offCode").val(offCode);
		$("#eqCode").val(eqCode);
		$("#eqName").val(eqName);
		$("#offType").val(offType);
		$("#offInfo").val(offInfo);
		$("#offStime").val(offStime);
		$("#offEtime").val(offEtime);
		
		}
		
	});

	
	</script>
</body>
</html>	
