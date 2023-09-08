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
		h1{
			font-weight : 800;
			margin-left : 15px;
		}
		
		input[type="text"],
		select {
		  width: 200px;
		  padding: 6px;
		  margin-bottom: 15px;
		  border: 1px solid #ccc;
		  border-radius: 4px;
		}
		
		#customtemplateSearchAndButton p{
			width : 100px;
			font-size: 20px;
		}
		
		#customtemplateSearchAndButton input, #modalTitle input {
		    border: 1px solid #ccc;
		    display: inline-block;
		}
		
		#customtemplateSearchAndButton {
			margin-bottom: 30px;
		}
		
		#eqTypeSearch{
			cursor : pointer;
		}
		
		#eqStsSearch{
			cursor : pointer;
		}
		
		.tui-grid-table>tr{
			cursor : pointer;
		}
	</style>

</head>
<body>

	<div class="black_bg"></div>
	<h1>설비 조회 </h1>
	<div class="col-lg-12 stretch-card">
    	<div class="card">
        	<div class="card-body">
            	<div class="table-responsive pt-3">
            		<form>
	            		<div id="customtemplateSearchAndButton">
							<p>설비명</p>
	  							<input type="text" placeholder="검색어를 입력하세요" id="equipSearch">
								<br>
								<p>설비구분</p>
									<select id="eqTypeSearch" name="eqType" style="margin-bottom: 10px">
										<option value="">선택</option>
										<c:forEach items="${EquipTypeList}" var="p">
										<option value="${p.commdeCode }">${p.commdeName }</option>
											</c:forEach>
									</select><br>
									<p>설비상태</p>
                						<select id="eqStsSearch" name="eqSts" style="margin-bottom: 10px">
										<option value="">선택</option>
										<c:forEach items="${EquipStsList}" var="p">
										<option value="${p.commdeCode }">${p.commdeName }</option>
											</c:forEach>
									</select>
									<button type="button" class="btn btn-info btn-icon-text" id="searchBtn">
									<i class="fas fa-search"></i> 검색
								</button>
							<button type="reset" class="btn btn-info btn-icon-text">초기화</button>					
						</div>
					</form>
					<div id="grid"></div>
                </div>
			</div>
		</div>
	</div> 

	<script>
		
		    var grid = new tui.Grid({
		        el: document.getElementById('grid'),
		        data :[
		        	<c:forEach items="${EquipList}" var="equip"  varStatus="status">
		        	{
		        		eqCode : "${equip.eqCode}",
		        		actName : "${equip.actName}",
		        		eqName :"${equip.eqName}", 
		        		modelName : "${equip.modelName}",
		        		makeDate : "<fmt:formatDate value='${equip.makeDate}' pattern='yyyy-MM-dd'/>",		        		
		        		buyDate : "<fmt:formatDate value='${equip.buyDate}' pattern='yyyy-MM-dd'/>",
		        		chkCycle : "${equip.chkCycle}",
		        		eqSts2 : "${equip.eqSts2}",
		        		eqType2 : "${equip.eqType2}",
		        		highTemp : "${equip.highTemp}",
		        		lowTemp : "${equip.lowTemp}",   		
		        	}<c:if test="${not status.last}">,</c:if>
		        	 </c:forEach>
		        ],
		        scrollX: false,
		        scrollY: false,
		        minBodyHeight: 400,
				rowHeaders: ['rowNum'],
				pagination: true,
				pageOptions: {
				useClient: true,
				perPage: 10,
				},
			        columns:  [
		 	      	  {
			 	        header: '설비코드',
			 	        name: 'eqCode',
			 	        align: 'center'
			 	      },
			 	      {
			 	    	header : '설비업체코드',
			 	    	name : 'actName',
			 	    	hidden : true 
			 	      },
			 	      {
			 	    	header : '설비업체명',
			 	    	name : 'actName',
				        align: 'center'  
			 	      },
			 	      {
			 	        header: '설비명',
			 	        name: 'eqName',
			 	        filter: 'text',
			 	        align: 'center'
			 	      },
			 	      {
			 	        header: '모델명',
			 	        name: 'modelName',
			 	        align: 'center'
			 	      },
			 	      {
			 	    	header :'제작일자',
			 	    	name : 'makeDate',
				 	    align: 'center'
			 	      },
			 	      {
			 	    	header :'구입일자',
			 	    	name : 'buyDate',
				 	    align: 'center'
			 	      },
			 	      {
			 	    	header : '점검주기',
			 	    	name : 'chkCycle',
				 	    align: 'right'
			 	      },
			 	      
			 	      {
			 	        header: '설비상태',
			 	        name: 'eqSts2',
				 	    align: 'center'
			 	      },
			 	      {
			 	        header: '설비구분',
			 	        name: 'eqType2',
				 	    align: 'left'
			 	      },
			 	      {
			 	    	header : '최저온도',
			 	    	name : 'lowTemp',
				 	    align: 'right'
			 	      },
			 	      {
			 	    	header :'최고온도',
			 	    	name : 'highTemp',
					 	align: 'right'
			 	      }
			 	     
			 	    ]
		      })  
			
		    //검색
		    $('#searchBtn').on('click', searchProdIn);
		    function searchProdIn(e){
		 	   let content = $('#equipSearch').val();
		 	   let eqType = $('#eqTypeSearch').val();
		 	   let eqSts = $('#eqStsSearch').val();
		 	   
		 	   let search = { eqName : content, eqType : eqType, eqSts : eqSts };
		 	   $.ajax({
		 		   url : 'searchEquip',
		 		   method : 'GET',
		 		   data : search ,
		 		   success : function(data){
		 			   
	 			  $.each(data, function(i, objDe){
	 					let td = data[i]['makeDate'];
	 					let td2 = data[i]['buyDate'];
	 					
	 					data[i]['makeDate'] = getDate(td);
	 					data[i]['buyDate'] = getDate(td2);

	 				})
		 				
		 			   grid.resetData(data);
		 		   },
		 		   error : function(reject){
		 			   console.log(reject);
		 		   }
		 	   })
		    }

		

	</script>
	    <div>
		<jsp:include page="../comFn/dateFormat.jsp"></jsp:include>
	</div>
</body>
</html>	
