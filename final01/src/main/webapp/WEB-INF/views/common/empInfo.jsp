<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사원 조회</title>
<!-- 토스트 페이지 네이션 -->
<script type="text/javascript"
	src="https://uicdn.toast.com/tui.code-snippet/latest/tui-code-snippet.js"></script>
<link rel="stylesheet"
	href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css" />
<script
	src="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.js"></script>
<!-- 페이지 네이션 끝 -->
<link rel="stylesheet"
	href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@700&family=Noto+Sans+KR&display=swap"
	rel="stylesheet">
</head>
<body>
<div class="black_bg"></div>
   <h3>사원조회</h3>
   <div class="col-lg-12 stretch-card">
       <div class="card">
           <div class="card-body">
               <div class="table-responsive pt-3">
                   <button type="button" class="btn btn-info btn-icon-text excelDownload">
                       Excel
                      <i class="bi bi-printer"></i>                                                                              
                   </button>
                   <form action="" method="get" name="formInfo">
                  <div id="customtemplateSearchAndButton">		
							<p>사원명</p>
							<input type="text" placeholder="검색어를 입력하세요" id="empSearch">
							<button type="button" class="btn btn-info btn-icon-text" id="searchBtn">
								<i class="fas fa-search"></i>검색
							</button>
							<button type="button" class="btn btn-info btn-icon-text">초기화</button>
		            	</div>
               </form>
               <div id="grid"></div>
                </div>
         </div>
      </div>
   </div> 
<script>

//사원명검색조회
	$('#searchBtn').on('click', searchEmpIn);
	function searchEmpIn(e){
		   let content = $('#empSearch').val();
		   let search = { empName : content};
		   $.ajax({
			   url : 'getempFilter',
			   method : 'GET',
			   data : search,
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
		           <c:forEach items="${empList}" var="e" varStatus="status">
		           	{
		           		empCode : "${e.empCode}",
		           		empName : "${e.empName}",
		           		empDate : "<fmt:formatDate value='${e.empDate}' pattern='yyyy-MM-dd'/>",
		           		empRole : "${e.empRole}",
		           		commdeName : "${e.commdeName}",
		           		empTel : "${e.empTel}"
		           	} <c:if test="${not status.last}">,</c:if>
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
		       columns: [
		         {
		           header: '사원번호',
		           name: 'empCode'
		         },
		         {
		           header: '사원명',
		           name: 'empName'
		         },
		         {
		           header: '입사일',
		           name: 'empDate'
		         },
		         {
		           header: '직급정보',
		           name: 'empRole'
		         },
		         {
		           header: '부서명',
		           name: 'commdeName',
		           filter: 'select'
		         },
		         {
		           header: '연락처',
		           name: 'empTel'
		         }
		       ]
		      
		     });
	

</script>
</body>
</html>