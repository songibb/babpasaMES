<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
						<button type="button" class="btn btn-info btn-icon-text">
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
                <h3>비가동 등록</h3>
			    <table>
				      <tr>
				         <th>설비코드</th>
				        	 <td><input type="text" name="eqCode"></td>
				        	 <i class="fas fa-search"></i> 
				        	 <!--설비코드 모달 리스트로 검색해서 데이터 갖고오기  -->
				         <th>설비명</th>
				        	 <td><input type="text" name="eqName"></td>
				         <th>비가동코드</th>
				        	 <td><input type="text" name="modelName"></td>  
				      </tr>
				      <tr>
				         <th>비가동구분</th>
				         	<td><input type="text" name="eqSts"></td>
				         	<!--select box식으로 구분 선택하도록  -->
				         <th>작업내용</th>
				         	<td><input type="text" name="eqSts"></td>
				         	<!--작업 내용은 입력 가능 -->
				      </tr>
				       <tr>
				         <th>비가동시작시간</th>
				         	<td><input type="text" name="prcsType"></td> <!--최초에는 시작 버튼만 활성화..  -->
				         <th>비가동종료시간</th>
				         	<td><input type="text" name="highTemp"></td>    
				      </tr>
			   </table>
			   <button type="submit">비가동 등록/해제</button>
			   </div>
			</div>
		</div>
	</div> 

	<script>
		
		    var grid = new tui.Grid({
		        el: document.getElementById('grid'),
		        //전체설비랑 join을해서 갖고와야되나..
		        data :[
		        	<c:forEach items="${offequip}" var="off"  varStatus="status">
		        	{
		        		offNo : "${off.offNo}",
		        		eqCode : "${off.eqCode}",
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
			 	    name: ''
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
			 	  },
		 	      
  
		 	    ]
		      })  
		    
		    /* 설비코드 join해서 가져오기? */
			
			

	</script>
</body>
</html>	
