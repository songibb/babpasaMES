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
<style>
	label {
	  display: block;
	  margin-bottom: 5px;
	  margin-top: 7.5px;
	  font-weight: bold;
	}
	
	input[type="text"],
	input[type="password"],
	select {
	  width: 100%;
	  padding: 5px;
	  margin-bottom: 10px;
	  border: 1px solid #ccc;
	  border-radius: 4px;
	}
	input[type="date"],
	select {
	  width: 25%;
	  padding: 5px;
	  margin-bottom: 10px;
	  border: 1px solid #ccc;
	  border-radius: 4px;
	}
	
	select {
	  background-color: white; 
	}
	
</style>
</head>
<body>
<div class="black_bg"></div>
   	<h3>사원관리</h3>
   	<div style="display: flex; ">
		<div style="width: 75%;">
		     <div class="col-lg-12 stretch-card">
       <div class="card">
           <div class="card-body">
               <div class="table-responsive pt-3">
                   <form action="" method="get" name="formInfo">
                  			
                  		부서명
                  			<select id="inputDeptList" name="deptCode">
								<option value="">선택</option>
								<c:forEach items="${inputDeptList}" var="d">
									<option value="${d.commdeCode }">${d.commdeName }</option>
								</c:forEach>
							</select>
							<br>	
							
						사원명 <input type="text" placeholder="검색어를 입력하세요" id="empSearch" style="width: 25%">
							<br>
							
						입사일자 <input id="startDate" type="date">&nbsp;&nbsp;-&nbsp;&nbsp;<input id="endDate" type="date">
							<button type="button" class="btn btn-info btn-icon-text" id="searchBtn">
							
								<i class="fas fa-search"></i>검색
							</button>
							<button type="reset" class="btn btn-info btn-icon-text">초기화</button>
               </form>
               <div id="grid"></div>
                </div>
         </div>
      </div>
   </div>  
	   </div>
	   <div style="width: 25%;">
			<div class="col-lg-12 stretch-card">
			<div class="card" >
				<div class="card-body">
					<div class="table-responsive pt-3">
						<form id="userInsertForm" method="post">
						<div>
						<h3 style="border: 1px">등록/수정</h3>
						<br>
						</div>
							<label>사원코드</label>
							<input type="text" name="empCode" id="empCode" readonly="readonly" style="background-color: skyblue;">
							<label>사원명</label>
							<input type="text" name="empName" id="empName" >
							<label>비밀번호</label>
							<input type="password" name="empBeforePw" id="empBeforePw">
							<label>비밀번호 확인</label>
							<input type="password" name="empPw" id="empPw">
							<label>부서명</label>
							<select id="inputDeptList" name="deptCode" style="width: 100%">
								<c:forEach items="${inputDeptList}" var="d">
									<option value="${d.commdeCode }">${d.commdeName }</option>
								</c:forEach>
							</select>
							<label>연락처</label>
							<input type="text" name="empTel" id="empTel">
							<label>직급</label>
							<select id="inputRoleList" name="empRole" style="width: 100%">
								<c:forEach items="${inputRoleList}" var="i">
									<option value="${i.commdeCode }">${i.commdeName }</option>
								</c:forEach>
							</select>
							<button type="submit" class="btn btn-info btn-icon-text" id="userInsertBtn">저장</button>
							<button type="reset" class="btn btn-info btn-icon-text">취소</button>
						</form>
						</div>
					</div>
				</div>
			</div>
		</div>
   </div>
   <div>
		<jsp:include page="../comFn/dateFormat.jsp"></jsp:include>
	</div>
<script>

//사원명검색조회
	$('#searchBtn').on('click', searchEmpIn);
	function searchEmpIn(e){
		let inputDeptList = $('#inputDeptList').val();
		   let empName = $('#empSearch').val();
		   let startDate = $('#startDate').val();
		   let endDate = $('#endDate').val();
		   let search = { inputDeptList : inputDeptList, empName : empName, startDate : startDate, endDate : endDate };
		   $.ajax({
			   url : 'ajaxEmpList',
			   method : 'GET',
			   data : search,
			   success : function(data){
				   $.each(data, function(i, objDe){
						let empDate = data[i]['empDate'];
						data[i]['empDate'] = getDate(empDate);
					})
				   grid.resetData(data);
				   $('#userInsertForm')[0].reset();
			   },
			   error : function(reject){
				   console.log(reject);
			   }
		   })
	}
	//ajax 전체조회
		   let inputDeptList = $('#inputDeptList').val();
		   let empName = $('#empSearch').val();
		   let startDate = $('#startDate').val();
		   let endDate = $('#endDate').val();
		   let search = { inputDeptList : inputDeptList, empName : empName, startDate : startDate, endDate : endDate };
	   $.ajax({
		   url : 'ajaxEmpList',
		   method : 'GET',
		   data : search,
		   success : function(data){
			   $.each(data, function(i, objDe){
					let empDate = data[i]['empDate'];
					data[i]['empDate'] = getDate(empDate);
				})
			   grid.resetData(data);
		   },
		   error : function(reject){
			   console.log(reject);
		   }
	   })
	   
	var grid = new tui.Grid({
	      
	       el: document.getElementById('grid'),
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
	           name: 'empRole',
	           hidden: true
		      },
	         {
	           header: '직급정보',
	           name: 'empRoleName'
	         },
	         {
	           header: '부서명',
	           name: 'deptCode',
	           hidden: true
	         },
	         {
	           header: '부서명',
	           name: 'deptcodeName'
	         },
	         {
	           header: '연락처',
	           name: 'empTel'
	         }
	       ]
	      
	     });
	
	
	//유저 insert 시작(+)
	//serialize로 form정보 가져옴(+)
	function getUserInfoObject(){
		let userArray = $('#userInsertForm').serializeArray();
		let userObj = {};
		$.each(userArray, function(idx, obj){
			userObj[obj.name] = obj.value;
		})
		
		return userObj;
	}
	
	$("form").on('submit', function(e){
		let userObj = getUserInfoObject();
		
		if(userObj.empCode != ''){
			e.preventDefault();
			if(userObj.empName == '' || userObj.empTel == ''){
				swal("정보입력필요", "필요정보를 모두 입력해 주세요", "warning")
			}else{
				if(userObj.empPw !='' || userObj.empBeforePw !=''){
					if(userObj.empPw == userObj.empBeforePw){
						requestUpdateUser(userObj);
					}else{
						swal("비밀번호확인필요", "비밀번호를 동일하게 입력해 주세요", "warning")
					}
				}else{
					requestUpdateUser(userObj);
				}
				
			}
		}else{
			e.preventDefault();
			if(userObj.empName == '' || userObj.empTel == '' || userObj.empPw == ''){
				swal("정보입력필요", "필요정보를 모두 입력해 주세요", "warning")
			}else{
				if(userObj.empPw == userObj.empBeforePw){
					requestInsertUser(userObj);
				}else{
					swal("비밀번호확인필요", "비밀번호를 동일하게 입력해 주세요", "warning")
				}
			
			}
		}
	})
	
	
	//form에서 가져온 정보로 ajax(+)
	function requestInsertUser(userObj){
		
		
		$.ajax({
			url : 'createNewAccount',
			method : 'post',
			data : userObj,
			success : function(result){
				swal("등록성공", "등록되었습니다", "success")
				$('#userInsertForm')[0].reset();
				 let content = $('#empSearch').val();
				  let search = { empName : content};
				 $.ajax({
				   url : 'ajaxEmpList',
				   method : 'GET',
				   data : search,
				   success : function(data){
					   grid.resetData(data);
					   
				   },
				   error : function(reject){
					   console.log(reject);
				   }
			   })
			},
			error : function(reject){
				swal("등록실패", "", "error")
			}
		})
	}
	
	/* //버튼에 이벤트 걺(+)
	$('#userInsertBtn').on('click', requestInsertUser); */

	//사원 정보 수정
	function requestUpdateUser(userObj){
		
		$.ajax({
			url : 'empInfoUpdate',
			type : 'POST',
			contentType : 'application/json',
			data : JSON.stringify(userObj),
		})
		.done(data => {
			if(data > 0){
				swal("수정성공", "수정되었습니다", "success");
				$('#userInsertForm')[0].reset();
				 let content = $('#empSearch').val();
				  let search = { empName : content};
				 $.ajax({
				   url : 'ajaxEmpList',
				   method : 'GET',
				   data : search,
				   success : function(data){
					   grid.resetData(data);
				   },
				   error : function(reject){
					   console.log(reject);
				   }
			   })
				
			}else{
				swal("수정실패", "", "error")
			}
		})
		.fail(reject => console.log(reject));
	}
	
	grid.on('click', ()=>{
		let rowKey = grid.getFocusedCell().rowKey;
		let empCode =  grid.getValue(rowKey, 'empCode');
		let empName = grid.getValue(rowKey, 'empName');
		let empRole = grid.getValue(rowKey, 'empRole');
		let deptCode = grid.getValue(rowKey, 'deptCode');
		let empTel = grid.getValue(rowKey, 'empTel');
		
		$("#empCode").val(empCode);
		$("#empName").val(empName);
		$("#empTel").val(empTel);
		$("#inputRoleList option[value='" + empRole + "']").prop("selected", true);
		$("#inputDeptList option[value='" + deptCode + "']").prop("selected", true);
	})
</script>
</body>
</html>