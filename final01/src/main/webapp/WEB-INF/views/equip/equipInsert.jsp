<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

<meta charset="EUC-KR">
<title>설비 등록 페이지</title>
<style>
		
		#actModal{
			 margin-left: 13px;
		}
		
		h1{
			font-weight : 800;
		}
		
        body {
            font-family: 'Nanum Gothic', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
        }

        h2 {
            text-align: left;
            padding: 20px;
        }

        .container {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            background-color: #ffffff;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }

        #equipTable{
            width: 1200px;
            height: 400px;
            border-collapse: collapse; 
            margin-left: 10px;
    		margin-top: 30px;         
            
        }

        #equipTable th, td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        #equipTable th {
            background-color: #f2f2f2;
        }

        input[type="text"], select {
            width: 50;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        button {
            margin-right: 10px;
            padding: 8px 16px;
            background-color: #267bdb;
            border: none;
            border-radius: 4px;
            color: white;
            cursor: pointer;
        }

        button:hover {
            background-color: #45a049;
        }

        img {
            max-width: 100px;
            max-height: 100px;
        }
       
       .card-body{
       		height : 600px;
       }
       
       .card{
       		width : 1300px;
       }
		
		form .buttons{
			margin-top: 30px;
	   	 	margin-left: 900px
		}
		
		.footer{
			padding-top: 50px;
    		border-top-width: 0px;
		}
		
    </style>

</head>

<h1>설비 관리</h1>
<body>
<hr>
<div class="card">
<div class="card-body">
<form name="insertForm" action="equipInsert" method="post" id="insertForm">
   <table id="equipTable">
   <button type="button" id="actModal">설비조회</button>
      <tr>
         <th>설비코드</th>
         <td><input type="text" name="eqCode" id="eqCode" style="background-color: #d3d3d3;" readonly></td>
         <th>설비명</th>
         <td> <input type="text" name="eqName" id="eqName"></td>
      </tr>
      <tr>
         <th>설비구분</th>
         <td>
	         <select id="EquipTypeList" name="eqType">
				<c:forEach items="${EquipTypeList}" var="p">
					<option value="${p.commdeCode }">${p.commdeName }</option>
				</c:forEach>
			</select>
         </td>
         <th>거래처</th>
         <td><input type="text" name="actCode" id="actCode">
         <button type="button" id="actModal2" style="margin-left: 10px;">거래처조회</button>
         </td>
      
      </tr>
      <tr>
         <th>모델명</th>
         <td><input type="text" name="modelName" id="modelName"></td>
         <th>점검주기</th>
         <td><input type="text" name="chkCycle" id="chkCycle"> 일</td>
         
      </tr>
      <tr>
         <th>구매일자</th>
         <td><input type="date" name="buyDate" id="buyDate"></td>
         <th>제작일자</th>
         <td><input type="date" name="makeDate" id="makeDate"></td>
      </tr>
      <tr>
         <th>가동여부</th>
         <td>
         <select id="EquipStsList" name="eqSts">
			<c:forEach items="${EquipStsList}" var="s">
				<option value="${s.commdeCode }">${s.commdeName }</option>
			</c:forEach>
		</select>
			</td>
      </tr>
      <tr>
         <th>최저온도</th>
         <td><input type="text" name="lowTemp" id="lowTemp"> ℃ </td> 
         <th>최고온도</th>
         <td><input type="text" name="highTemp" id="highTemp"> ℃  </td>
      </tr>
   </table>
   <br>
   <!-- submit이 한페이지에 2개라 value값으로 지정을 해놓음  -->
   
   <div class="buttons">
   <div>
   <button type="submit" id="insert">등록</button>
   <button type="button" id="update">수정</button>
   <button type="button" id="deleteEq">삭제</button>
   <button type="button" onclick="location.href='EquipList'">목록</button>
   </div>
   </div>
</form>   
</div>
</div>

   
<div class="modal">
  <div class="modal_content" 
       title="클릭하면 창이 닫힙니다.">
          <div class="m_head">
            <div class="modal_title"><h3>설비목록</h3></div>
            <div class="close_btn" id="close_btn">X</div>
       </div>
       <div class="m_body">
            <div id="actGrid"></div>
             <div id="modal_label"></div>
       </div>
        <div class="m_footer">
            <div class="modal_btn save" id="save_btn">SAVE</div>
    </div>
  </div>
</div>


 <div>
		<jsp:include page="../comFn/dateFormat.jsp"></jsp:include>
	</div>



<script>
		
	var Grid;
	$("#actModal").click(function(){
	  $(".modal").fadeIn();
	  Grid = createActGrid();
	  Grid.on('click', () => {
			let rowKey = Grid.getFocusedCell().rowKey;
			let eqCode = Grid.getValue(rowKey, 'eqCode');
			let eqType = Grid.getValue(rowKey, 'eqType');
			let eqSts = Grid.getValue(rowKey, 'eqSts');
	
			$.ajax({
				url : 'getEquip',
				method : 'GET',
				data : { eqCode : eqCode },
				success : function(data){

						$('#eqCode').val(data.eqCode);
						$('#actCode').val(data.actCode);
						$('#eqName').val(data.eqName);
						$('#modelName').val(data.modelName);
						 let date = new Date(data.makeDate);  //매개변수값으로 숫자를 넘겨주면 날짜로 변환
						    
						    let year = date.getFullYear();
						    let month = ('0' + (date.getMonth() + 1)).substr(-2);   //month 0부터 시작하기때문에 1을 더함, '0'을 앞에 붙여서 두자리로 표현
						    let day = ('0' + date.getDate()).substr(-2);    //'0'을 앞에 붙여서 두자리로 표현
						    //substr(음수) : 오른쪽 부터 잘라냄 -> 원래 두자리 숫자는 0을 제외하고 잘라와서 그대로 표현 			   
						$('#makeDate').val(year + '-' + month + '-' + day);
						$('#buyDate').val(year + '-' + month + '-' + day);
						$('#chkCycle').val(data.chkCycle);
						$("#EquipStsList option[value='" + eqSts + "']").prop("selected", true);
						$('#eqImg').val(data.eqImg);
						$("#EquipTypeList option[value='" + eqType + "']").prop("selected", true);
						$('#highTemp').val(data.highTemp);
						$('#lowTemp').val(data.lowTemp);	
						
						 if(rowKey != null){
				             $(".modal").fadeOut();
				              Grid.destroy();
				          }
						/* $(".modal").fadeOut();
	     		       	Grid.destroy(); // 항목 선택하면 모달창 닫힘 */
	     		       	 
						console.log(data);
	     		       	
				    },
				error : function(reject){
		 			console.log(reject);
		 		}	
			})
		});

		  
	  $.ajax({
		    url : "selectEquipAllList",
		    method :"GET",
		    success : function(result){
		        Grid.resetData(result);
		    },
		    error : function(reject){
					console.log(reject);
				}
		});
	});
	
	//거래처 모달 시작

	 $("#actModal2").click(function(){
       $(".modal").fadeIn();
       Grid = createActGrid2();
       
       Grid.on('click', () => {
           let rowKey = Grid.getFocusedCell().rowKey;
           let actCode = Grid.getValue(rowKey, 'actCode');
           let actName = Grid.getValue(rowKey, 'actName');
           
          $("#actCode").val(actCode);
          $("#actName").val(actName);
          //모달창 닫기
          console.log(rowKey);
          if(rowKey != null){
             $(".modal").fadeOut();
              Grid.destroy();
          }

          });
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
			      //백엔드와 연동 없이 페이지 네이션 사용가능하게 만듦
			        useClient: true,
			        perPage: 10
			      },
			      columns: [
			    	      {
				 	        header: '설비코드',
				 	        name: 'eqCode'
				 	      
				 	      },
				 	      {
				 	    	  header : '설비구분',
				 	    	  name : 'eqType2'		 	    	  
				 	      },
				 	      {
				 	        header: '설비명',
				 	        name: 'eqName'
				 	      }
				    ]
			    })

		   return actGrid;
	}
	
	$("#close_btn").click(function(){
	  $(".modal").fadeOut(); 
		Grid.destroy();
	});
	
	$("#save_btn").click(function(){
        $(".modal").fadeOut();
         
  		Grid.destroy();
     });



	
	 //거래처 리스트 모달 그리드
	   function createActGrid2(){
	      var actGrid = new tui.Grid({
	          el: document.getElementById('modal_label'),
	          data: [
	             <c:forEach items="${actList}" var="a" varStatus="status">
	                {
	                   actCode : "${a.actCode}",
	                   actName :"${a.actName}"
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
	                }
	           ]
	         
	        });
	      
	      return actGrid;
	   }
	
	//$('#insert').on('click', alertInsert);
	//function alertInsert(){
		let msg = `${result}`;
		console.log(msg);
		if(msg == '등록성공'){
			swal('등록 성공!', '설비 정보가 등록되었습니다.', 'success' );
		}
		
	//}
	
	//수정
	 $('#update').on('click',ajaxEquipUpdate);

	// 2) form 태그 내의 정보를 가져옴
	function serializeObject(){
		let formData=$('form').serializeArray();// 객체 배열: 객체 하나 -> input태그 하나
		
		let objectData={};//변수선언
		$.each(formData,function(idx,obj){
			objectData[obj.name]=obj.value;
		});
		return objectData;
	}
	
		function ajaxEquipUpdate(e){
			
			let obj=serializeObject();
			
			
			$.ajax({				
			url: 'equipUpdate',
			type:'post',
			contentType:'application/json',
			data:JSON.stringify(obj)
		})
		.done(data => {
			console.log(data);
			$('input').val("");
			swal('수정 성공!', '설비 정보가 수정되었습니다.', 'success' )
		})
		.fail(reject =>console.log(reject));
		}; 
		
		
		
		
		//삭제
		$('#deleteEq').click(function(){
			var eqCode = $('#eqCode').val();
			console.log(eqCode);
			$.ajax({
				url : 'equipDelete',
				method : 'GET',
				data : { eqCode : eqCode },
				success : function(data){
					//삭제 후 <input> 태그 칸 값 비우기
					$('input').val("");
					swal('삭제 성공!', '설비가 삭제되었습니다.', 'success' )
				    },
				error : function(reject){
		 			console.log(reject);
		 		}	
			})
		});
		
</script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
</body>
</html>