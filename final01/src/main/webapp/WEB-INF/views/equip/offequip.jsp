<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="false" %>

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
	 body {
      font-family: 'Nanum Gothic', sans-serif;
      font-family: 'Noto Sans KR', sans-serif;
    }
    .search-container {
      display: flex;
      align-items: center;
      background-color: #fff;
      border-radius: 8px;
      padding: 5px 10px;
      margin-bottom: 10px;
    }

    .search-icon {
      margin-right: 10px;
      color: #888;
    }

    .search-input {
      border: none;
      outline: none;
      font-size: 16px;
      width: 100%;
      padding: 5px;
    }
    .col-lg-12 stretch-card{
       margin-top : 30px;
    }
    
    #customtemplateSearchAndButton{
       margin-bottom : 80px;
       float : left;   
    }
    
    #customtemplateSearchAndButton input, #modalTitle input{
       border : 1px solid black; 
       display : inline-block;
    }
    
    #customtemplateSearchAndButton p, #modalTitle p{
       display : inline-block;
       padding-bottom: 10px;
       padding-right : 10px;
    }
    
    #customtemplateSearchAndButton .blackcolorInputBox{
       background-color : #868e96;
    }
    
    .btn-icon-text{
       margin : 5px;
       padding : 7px;
       border-radius : 9px;
       height : 33px;
    }
    
    .excelDownload{
       margin-top : 120px;
       float : right;
    }
    
  
   /*모달시작*/
   #actModal, #matModal{ 
     cursor:pointer;
   }
   
   .modal{ 
     position:absolute; width:100%; height:100%; background: rgba(0,0,0,0.8); top:0; left:0; display:none;
   }
   
   .modal_content{
     /*모달창 크기 조절*/
     width:600px; height:600px;
     background:#fff; border-radius:10px;
     /*모달창 위치 조절*/
     position:relative; top:33%; left:45%;
     margin-top:-100px; margin-left:-200px;
     text-align:center;
     box-sizing:border-box;
     line-height:23px; cursor:pointer;
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

    
</style>
</head>
<body>
	<div class="black_bg"></div>
	<h1>비가동 설비 조회</h1>
	<div class="col-lg-12 stretch-card">
    	<div class="card">
        	<div class="card-body">
            	<div class="table-responsive pt-3">
            		<div id="customtemplateSearchAndButton">
					
						<p>비가동시작일</p>
						<input type="date">
						~
						<input type="date">
						<button type="button" class="btn btn-info btn-icon-text" >
							<i class="fas fa-search"></i>
							<!-- 돋보기 누르면 설비코드 설비명 가동여부 3개 컬럼 리스트로 출력됨(eq_equip table) -->
							검색
						</button>
						<button type="button" class="btn btn-info btn-icon-text">
							초기화
						</button>					
					</div>
					<div id="grid"></div>
                </div>
                <div><hr>
                
       
<form id="insertForm"> 
     	<h3>비가동 등록</h3>
		    <table>
			      <tr>
			         <th>설비코드</th>
			        	 <td><input type="text" name="eqCode" id="eqCode"></td>
			        	 <i class="fas fa-search" id="actModal">설비조회</i> 
			        	 <!--설비코드 모달 리스트로 검색해서 데이터 갖고오기  -->
			         <th>설비명</th>
			        	 <td><input type="text" name="eqName" id="eqName"></td>
			         <th>비가동코드</th>
			        	 <td><input type="text" name="offNo" id="offNo"></td>  
			      </tr>
			      <tr>
			         <th>비가동구분</th>
			         	<td><input type="text" name="offType" id="offType"></td>
			         	<!--select box식으로 구분 선택하도록  -->
			         <th>작업내용</th>
			         	<td><input type="text" name="offInfo" id="offInfo"></td>
			         	<!--작업 내용은 입력 가능 -->
			      </tr>
			       <tr>
			         <th>비가동시작시간</th>
			         	<td><input type="text" name="offStime" id="offStime">
			         	 <input type="button" value="시작" onclick="setCurrentTime()" /></td>
			         	 <!--최초에는 시작 버튼만 활성화..  -->
			         <th>비가동종료시간</th>
			         	<td><input type="text" name="offEtime" id="offEtime">
			         	 <input type="button" value="종료" onclick="setCurrentTime2()" /></td>    
			      </tr>
		   </table>
	  
			   <button type="submit" class="btn btn-info btn-icon-text">저장</button>
			   </div>
			</div>
		</div>
	</div> 
</form>

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
				perPage: 10,
				},
		        columns:  [
	 	      {
		 	        header: '비가동코드',
		 	        name: 'offNo'
		 	    
		 	      },
		 	      {
		 	        header: '설비코드',
		 	        name: 'eqCode'
		 	      },
		 	      {
			 	    header: '설비명',
			 	    name: 'eqName'
			 	  },
		 	      {
		 	        header: '비가동구분',
		 	        name: 'offType'
		 	      },
		 	      {
			 	     header: '작업내용',
			 	     name: 'offInfo'
			 	  },
			 	 {
				 	 header: '시작시간',
				 	 name: 'offStime'
				 },
				 {
			 	     header: '종료시간',
			 	     name: 'offEtime'
			 	  }
		 	      
  
		 	    ]
		      })  
		    
			
		    var Grid;
		    $("#actModal").click(function(){
		      $(".modal").fadeIn();
		      Grid = createActGrid();
		      Grid.on('click', () => {
		        let rowKey = Grid.getFocusedCell().rowKey;
		        let eqCode = Grid.getValue(rowKey, 'eqCode');
		        let eqName = Grid.getValue(rowKey, 'eqName');
		        let eqSts = Grid.getValue(rowKey, 'eqSts');
		        
		        // 설비 정보 가져오는 부분 추가
		        $.ajax({
		          url: "getOffEquipInfo",  // 설비 정보를 가져올 API 엔드포인트
		          method: "GET",
		          data: { eqCode: eqCode },
		          
		          success: function(result) {
		            // result는 가져온 설비 정보를 담고 있음
		            let eqName = result.eqName;
		            let offNo = result.offNo;
		            let offType = result.offType;
		            let offInfo = result.offInfo;
		            let offStime = result.offStime;
		            let offEtime = result.offEtime;
		            
		            $('#eqCode').val(eqCode);
		            $('#eqName').val(eqName);
		            $('#offNo').val(offNo);
		            $('#offType').val(offType);
		            $('#offInfo').val(offInfo);
		            $('#offStime').val(offStime);
		            $('#offEtime').val(offEtime);
		          },
		          error: function(reject){
		            console.log(reject);
		          }
		        });
		        
		        $(".modal").fadeOut();
		        Grid.destroy();
		      });
		    });
  
  $.ajax({
	    url : "selectOffEquipAllList",
	    method :"GET",
	    success : function(result){
	        Grid.resetData(result);
	    },
	    error : function(reject){
				console.log(reject);
			}
	});
 
$("#close_btn").click(function(){
	  $(".modal").fadeOut(); 
		Grid.destroy();
	});







function createActGrid(){
	   var actGrid = new tui.Grid({
		      el: document.getElementById('actGrid'),
		      data : [
		    	  <c:forEach items="${allequip}" var="ap" varStatus="status">
		          	{
		          		eqCode : "${ap.eqCode}",
		          		eqName :"${ap.eqName}",
		          		eqSts :"${ap.eqSts}",
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
		      useClient: true,
		      perPage: 10
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
			 	    	  header : '설비상태',
			 	    	  name : 'eqSts'		 	    	  
			 	      },
			    ]
		    })   
	   return actGrid;
}


//거래처 등록/수정 한개버튼으로 같이하기


$("#insertForm").on('submit', function(e){
	  e.preventDefault();
	  let offequipInfo = getoffequipInfo(); 
	  
	  
	  if(offequipInfo.offStime != '' && offequipInfo.offStime != null){
		  
		if(offequipInfo.eqName =='' || offequipInfo.offType =='' || offequipInfo.offInfo==''){
			
			alert('모든 정보를 입력해 주세요.');
			}else{ 

		//수정 ajax
		offequipUpdate(offequipInfo);
			}
		
	  }else{
		  
		  if(offequipInfo.eqName =='' || offequipInfo.offType =='' || offequipInfo.offInfo=='' || offequipInfo.offStime ==''){
				alert('모든 정보를 입력해 주세요.');
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

  $.ajax({
		url : 'insertOffEquip',
		type : 'post',
		contentType : 'application/json',
		data :  JSON.stringify(offequipInfo)
	})
	.done(data => { 
		if(data != null && data['결과'] == 'Success'){   //데이터의 key가 한글이라면 반드시 대괄호[''] 사용해야함
			alert( '등록이 정상적으로 처리되었습니다.');
			selectAjax();
			
			
			//form 비우기
			 $('form')[0].reset();
		} else{
			alert('등록처리가 실패되었습니다.');
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
	       },
	       error : function(reject){
				console.log(reject);
			}
		});
}
//수정 ajax 함수
function offequipUpdate(offequipInfo){
	
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
			alert( '정보수정이 정상적으로 처리되었습니다.');
		
			//밑에 조회 ajax 새로 처리 필요
			selectAjax();
		
			
			//form 비우기
			 $('form')[0].reset();
		  	
	})
	.fail(reject => console.log(reject));
}
	
	

	</script>
</body>
</html>	
