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

        table {
            width: 80%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
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
            background-color: #4CAF50;
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
    </style>

</head>

<h2>설비 관리</h2>
<body>
<hr>
<form name="insertForm" action="equipInsert" method="post">
   <table>
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
         <td><input type="text" name="actCode" id="actCode"></td>
      
      </tr>
      <tr>
         <th>모델명</th>
         <td><input type="text" name="modelName" id="modelName"></td>
         <th>제작일자</th>
         <td><input type="text" name="makeDate" id="makeDate"></td>
      </tr>
      <tr>
         <th>구매일자</th>
         <td><input type="text" name="buyDate" id="buyDate"></td>
         <th>점검주기</th>
         <td><input type="text" name="chkCycle" id="chkCycle">일</td>
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
      <tr>
         <th>설비이미지</th>
         <td><input type="file" name="eqImg" id="eqImg" multiple></td>
         		<c:choose>
					<c:when test="${not empty equipInsert.eqImg }">
						<td><img src='<c:url value="/resources/${equipInsert.eqImg}" />'></td>
					</c:when>
					<c:otherwise>
						<td>파일 없음</td>
					</c:otherwise>
				</c:choose>
      </tr>
   </table>
   <br>
   <!-- submit이 한페이지에 2개라 value값으로 지정을 해놓음  -->
   <button type="submit" id="insert">등록</button>
   <button type="button" id="update">수정</button>
   <button type="button" id="deleteEq">삭제</button>
   <button type="button" onclick="location.href='EquipList'">목록</button>
</form>   
   
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
        <div class="m_footer">
            <div class="modal_btn save" id="save_btn">SAVE</div>
    </div>
  </div>
</div>

 <div>
		<jsp:include page="../comFn/dateFormat.jsp"></jsp:include>
	</div>


<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
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
						$('#makeDate').val(data.makeDate);
						$('#buyDate').val(data.buyDate);
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

	$("#close_btn").click(function(){
	  $(".modal").fadeOut(); 
		Grid.destroy();
	});
	
	$("#save_btn").click(function(){
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
			alert("수정완료");
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
					alert('삭제가 완료되었습니다.');
				    },
				error : function(reject){
		 			console.log(reject);
		 		}	
			})
		});

		
	/* 	//설비타입 모달
		var Grid;
		$("#actModal2").click(function(){
		  $(".modal").fadeIn();
		  Grid = createeqTypeGrid();
		  Grid.on('click', () => {
				let rowKey = Grid.getFocusedCell().rowKey;
				let eqType = Grid.getValue(rowKey, 'eqType');
		
				$.ajax({
					url : 'getEquipType',
					method : 'GET',
					data : { eqType : eqType },
					success : function(data){
							$('#eqType').val(data.eqType);

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

		$("#close_btn").click(function(){
		  $(".modal").fadeOut(); 
			Grid.destroy();
		});

		
		function createeqTypeGrid(){
			   var eqTypeGrid = new tui.Grid({
				      el: document.getElementById('eqTypeGrid'),
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
					 	        header: '설비구분',
					 	        name: 'eqType'
					 	      }
					    ]
				    })
			   
			   
			   
			   return eqTypeGrid;
		} */
		
</script>
</body>
</html>