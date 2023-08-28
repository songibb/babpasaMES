<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>거래처 조회</title>
	<!-- 토스트 페이지 네이션 -->
    <script type="text/javascript" src="https://uicdn.toast.com/tui.code-snippet/latest/tui-code-snippet.js"></script>
    <link rel="stylesheet" href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css" />
    <script src="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.js"></script>
    <!-- 페이지 네이션 끝 -->
    <link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
    <script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>    
<style>
	label {
	  display: block;
	  margin-bottom: 7px;
	  margin-top: 2px;
	  font-weight: bold;
	}
	

	input[type="text"],
	select {
	  width: 15%;
	  padding: 6px;
	  margin-bottom: 15px;
	  border: 1px solid #ccc;
	  border-radius: 4px;
	}
	
	select {
	  width: 15%;
	  padding: 6px;
	  margin-bottom: 15px;
	  border: 1px solid #ccc;
	  border-radius: 4px;
	}
	
	select {
	  background-color: white; 
	}
	form p{
		width: 100px;
		display: inline-block;
		font-size: 20px;
	}
	h1{
		margin-left: 15px;
	}
	h1, h2{
		font-weight: 800;
	}

	
</style>
</head>
<body>
	<div class="black_bg"></div>
	<h1>거래처 조회</h1>
	<div class="col-lg-12 stretch-card">
		<div class="card">
			<div class="card-body">
				<div class="table-responsive pt-3">
					<form>
								
							<p>거래처명</p>
							<input type="text" placeholder="검색어를 입력하세요" id="actSearch">
							<br>
							<p>거래처 구분 </p>
							<select id="kindSearch" name="kindSearch" >
								<option value="">선택</option>
								<c:forEach items="${actTypeList}" var="a">
									<option value="${a.commdeCode }">${a.commdeName }</option>
								</c:forEach>
							</select>
							<br>
							<p>거래상태 </p>
							<select id="stsSearch" name="stsSearch" style="margin-bottom: 35px">
								<option value="">선택</option>
								<c:forEach items="${actStsList}" var="s">
									<option value="${s.commdeCode }">${s.commdeName }</option>
								</c:forEach>
							</select>
							<button type="button" class="btn btn-info btn-icon-text" id="searchBtn" style="margin-top: 0">
								<i class="fas fa-search"></i>검색
							</button>
							<button type="reset" class="btn btn-info btn-icon-text"  style="margin-top: 0">초기화</button>
		            	
	            	</form>
	            	<h2>거래처 목록</h2>
	           		<div id="grid"></div>
				</div>
	   		</div>
		</div>
	</div> 

    
	<script>
	
	//제품검색조회
	
	$('#searchBtn').on('click', searchActIn);
   function searchActIn(e){
	   let actName = $('#actSearch').val();
	   let actKind = $('#kindSearch').val();
	   let actSts = $('#stsSearch').val();
	   let search = { actName : actName, actKind : actKind, actSts : actSts };
	   $.ajax({
		   url : 'ActCodeSearch',
		   method : 'GET',
		   data : search ,
		   success : function(data){
			   grid.resetData(data);
		   },
		   error : function(reject){
			   console.log(reject);
		   }
	   })
   }

    var grid = new tui.Grid({
        el: document.getElementById('grid'),
        data: [
	           <c:forEach items="${actList}" var="a" varStatus="status">
	           	{
	           		actCode : "${a.actCode}",
	           		actName :"${a.actName}",
	           		actNum :"${a.actNum}",
	           		actTel :"${a.actTel}",
	           		sts : "${a.sts}",
	           		kind : "${a.kind}",
	           	} <c:if test="${not status.last}">,</c:if>
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
        columns: [
          {
            header: '거래처',
            name: 'actCode',
            filter: 'text'
          },
          {
            header: '거래처명',
            name: 'actName',
            filter: 'text'
          },
          {
            header: '사업자번호',
            name: 'actNum'
          },
          {
            header: '연락처',
            name: 'actTel'
          },
          {
            header: '거래여부',
            name: 'sts'
          },
          {
              header: '거래처구분',
              name: 'kind',
              filter: 'select'
            },
        ]
      })  

	
	</script>
</body>
</html>