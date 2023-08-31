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
	  margin-bottom: 7px;
	  margin-top: 2px;
	  font-weight: bold;
	}
	input[type="text"],
	input[type="password"],
	select {
	  width: 21%;
	  padding: 6px;
	  margin-bottom: 15px;
	  border: 1px solid #ccc;
	  border-radius: 4px;
	}
	input[type="date"],
	
	select {
	  width: 21%;
	  padding: 5px;
	  margin-bottom: 15px;
	  border: 1px solid #ccc;
	  border-radius: 4px;
	}
	select {
	  background-color: white; 
	}
	form p{
		width: 80px;
		display: inline-block;
		font-size: 20px;
	}
	h1{
		margin-left: 15px;
	}
	h1, h2{
		font-weight: 800;
	}
	#userInsertForm input,
	#userInsertForm input[type="password"] ,
	#userInsertForm select
	{
		width: 100%;
		 padding: 8px;
		
	}
	#userInsertForm label {
		margin-top: 8px;
		margin-bottom : 10px;
		font-size: 20px;
		font-weight: 400;
	}

	h2{
		display: inline-block;
	}
	
	.yellow-background {
        background-color: rgb(255,253,235);
	}
	
	.selected-cell{
   		background-color: #ffd09e;
	}
</style>
</head>
<body>
<div class="black_bg"></div>
   	<h1>사원 관리</h1>
   	<div style="display: flex; ">
   	<div style="width: 25%;">
			<div class="col-lg-12 stretch-card">
			<div class="card" >
				<div class="card-body">
					<div class="table-responsive pt-3">
						<form id="userInsertForm" method="post">
						<div>
						<h2 style="border: 1px">등록/수정</h2>
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
							<label id="empDateLa">입사일</label>
							<input id="empDate"  name="empDate" type="date">
							<label style="display: none;" id="empLeaveDateLa">퇴사일</label>
							<input id="empLeaveDate"  name="empLeaveDate" type="date" style="display: none;">
							<div style="text-align: center; margin-bottom: 5px;">
							<button type="submit" class="btn btn-info btn-icon-text" id="userInsertBtn">저장</button>
							<button type="button" class="btn btn-info btn-icon-text" id="resetDate">취소</button>
							</div>
						</form>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div style="width: 75%;">
		     <div class="col-lg-12 stretch-card">
       <div class="card">
           <div class="card-body">
               <div class="table-responsive pt-3">
                   <form action="" method="get" name="formInfo">
                  			
                  		<p>부서명</p>
                  			<select id="inputDeptSearch" name="deptCode">
								<option value="">선택</option>
								<c:forEach items="${inputDeptList}" var="d">
									<option value="${d.commdeCode }">${d.commdeName }</option>
								</c:forEach>
							</select>
							<br>	
							
						<p>사원명</p>
						 <input type="text" placeholder="검색어를 입력하세요" id="empSearch" >
							<br>
						<p>재직구분</p>
                 			<select id="selectEmpIngSearch" name="selectEmpIngSearch">
							<option value="">선택</option>
							<option value="재직">재직자</option>
							<option value="퇴사">퇴사자</option>
						</select>
							<br>
						<p>입사일자</p> 
						<input id="startDate" type="date">&nbsp;&nbsp;-&nbsp;&nbsp;<input id="endDate" type="date" style="margin-bottom: 35px">
							<button type="button" style="margin-top: 0px" class="btn btn-info btn-icon-text" id="searchBtn">
							
								<i class="fas fa-search"></i>검색
							</button>
							<button type="reset"  style="margin-top: 0px" class="btn btn-info btn-icon-text">초기화</button>
							
						
               </form>
               <h2>사원 목록</h2>
               <div id="grid"></div>
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

/* 	$('#empDate').val(new Date().toISOString().substring(0, 10)); */


//사원명검색조회
	
	$('#searchBtn').on('click', searchEmpIn);
	function searchEmpIn(e){
		let inputDeptList = $('#inputDeptSearch').val();
		   let empName = $('#empSearch').val();
		   let startDate = $('#startDate').val();
		   let endDate = $('#endDate').val();
		   let selectEmpIngSearch = $('#selectEmpIngSearch').val();
		   let search = { inputDeptList : inputDeptList, empName : empName, startDate : startDate, endDate : endDate, selectEmpIngSearch :selectEmpIngSearch };
		   $.ajax({
			   url : 'ajaxEmpList',
			   method : 'GET',
			   data : search,
			   success : function(data){
				   $.each(data, function(i, objDe){
						let empDate = data[i]['empDate'];
						data[i]['empDate'] = getDate(empDate);
						
						let empLeaveDate = data[i]['empLeaveDate'];
						if(empLeaveDate==null){
							data[i]['empLeaveDate'] = "-";
						}else{
						data[i]['empLeaveDate'] = getDate(empLeaveDate);
						}
						})
				   grid.resetData(data);
				   $('#userInsertForm')[0].reset();
				   empDate.style.display = '';
					empDateLa.style.display = '';
					empLeaveDateLa.style.display='none';
					empLeaveDate.style.display='none';
			   },
			   error : function(reject){
				   console.log(reject);
			   }
		   })
	}
	//ajax 전체조회
		   let inputDeptList = $('#inputDeptSearch').val();
		   let empName = $('#empSearch').val();
		   let startDate = $('#startDate').val();
		   let endDate = $('#endDate').val();
		   let selectEmpIngSearch = $('#selectEmpIngSearch').val();
		   let search = { inputDeptList : inputDeptList, empName : empName, startDate : startDate, endDate : endDate, selectEmpIngSearch :selectEmpIngSearch };
	   $.ajax({
		   url : 'ajaxEmpList',
		   method : 'GET',
		   data : search,
		   success : function(data){
			   $.each(data, function(i, objDe){
					let empDate = data[i]['empDate'];
					data[i]['empDate'] = getDate(empDate);
					
					let empLeaveDate = data[i]['empLeaveDate'];
					if(empLeaveDate==null){
						data[i]['empLeaveDate'] = "-";
					}else{
					data[i]['empLeaveDate'] = getDate(empLeaveDate);
					}
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
	       minBodyHeight: 400,
	       rowHeaders: ['rowNum'],
	       pagination: true,
	       pageOptions: {
	         useClient: true,
	         perPage: 10,
	       },
	       columns: [
	         {
	           header: '사원번호',
	           name: 'empCode',
	           align: 'center'
	         },
	         {
	           header: '사원명',
	           name: 'empName',
	           align: 'center'
	         },
	         {
	           header: '입사일',
	           name: 'empDate',
	           align: 'center',
	           sortable: true,
	           sortingType: 'asc',
	           className: 'yellow-background'
	         },
	         {
	           header: '퇴사일',
	           name: 'empLeaveDate',
	           align: 'center',
	           sortable: true,
	           sortingType: 'asc',
	           className: 'yellow-background'
			 },
	         {
	           header: '직급정보',
	           name: 'empRole',
	           hidden: true
		      },
	         {
	           header: '직급정보',
	           name: 'empRoleName',
	           align: 'center'
	         },
	         {
	           header: '부서명',
	           name: 'deptCode',
	           hidden: true
	         },
	         {
	           header: '부서명',
	           name: 'deptcodeName',
	           align: 'center'
	         },
	         {
	           header: '연락처',
	           name: 'empTel',
	           align: 'center'
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
				swal("경고", "모든값이 입력되지 않았습니다", "warning")
			}else{
				if(userObj.empPw !='' || userObj.empBeforePw !=''){
					if(userObj.empPw == userObj.empBeforePw){
						requestUpdateUser(userObj);
					}else{
						swal("경고", "비밀번호를 동일하게 입력해 주세요", "warning")
					}
				}else{
					requestUpdateUser(userObj);
				}
				
			}
		}else{
			e.preventDefault();
			if(userObj.empName == '' || userObj.empTel == '' || userObj.empPw == '' || userObj.empDate == ''){
				swal("경고", "필요정보를 모두 입력해 주세요", "warning")
			}else{
				if(userObj.empPw == userObj.empBeforePw){
					requestInsertUser(userObj);
				}else{
					swal("경고", "비밀번호를 동일하게 입력해 주세요", "warning")
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
				swal("성공", "사원 정보등록이 정상적으로 처리되었습니다", "success")
				$('#userInsertForm')[0].reset();
				$('form')[1].reset();
				 let content = $('#empSearch').val();
				  let search = { empName : content};
				 $.ajax({
				   url : 'ajaxEmpList',
				   method : 'GET',
				   data : search,
				   success : function(data){
					   $.each(data, function(i, objDe){
							let empDate = data[i]['empDate'];
							data[i]['empDate'] = getDate(empDate);
							
							let empLeaveDate = data[i]['empLeaveDate'];
							if(empLeaveDate==null){
								data[i]['empLeaveDate'] = "-";
							}else{
							data[i]['empLeaveDate'] = getDate(empLeaveDate);
							}
							})
						
						  grid.resetData(data);
					   
				   },
				   error : function(reject){
					   console.log(reject);
				   }
			   })
			},
			error : function(reject){
				swal("실패", "등록처리가 실패되었습니다", "error")
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
				swal("성공", "사원 정보수정이 정상적으로 처리되었습니다", "success");
				empDate.style.display = '';
				empDateLa.style.display = '';
				empLeaveDateLa.style.display='none';
				empLeaveDate.style.display='none';
				$('#userInsertForm')[0].reset();
				$('form')[1].reset();
				 let content = $('#empSearch').val();
				  let search = { empName : content};
				 $.ajax({
				   url : 'ajaxEmpList',
				   method : 'GET',
				   data : search,
				   success : function(data){
					   $.each(data, function(i, objDe){
							let empDate = data[i]['empDate'];
							data[i]['empDate'] = getDate(empDate);
							
							let empLeaveDate = data[i]['empLeaveDate'];
							if(empLeaveDate==null){
								data[i]['empLeaveDate'] = "-";
							}else{
							data[i]['empLeaveDate'] = getDate(empLeaveDate);
							}
							})
						grid.resetData(data);
				   },
				   error : function(reject){
					   console.log(reject);
				   }
			   })
				
			}else{
				swal("실패", "수정처리가 실패되었습니다", "error")
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
		
		//선택한 행 색깔 바꾸기
		let selectKey = grid.getFocusedCell().rowKey;
		grid.addRowClassName(selectKey, 'selected-cell');
		//다른 행 선택시 기존에 클릭했던 행은 class제거
		grid.on('focusChange', () => {
			grid.removeRowClassName(selectKey, 'selected-cell');
		})
		if(rowKey>0){
		empDate.style.display = 'none';
		empDateLa.style.display = 'none';
		empLeaveDateLa.style.display='';
		empLeaveDate.style.display='';
		}else{
			empDate.style.display = '';
			empDateLa.style.display = '';
			empLeaveDateLa.style.display='none';
			empLeaveDate.style.display='none';
		}
	})
	
	
/* 	function dateUpdate(){
		
		empDate.style.display = '';
		empDateLa.style.display = '';
		empLeaveDateLa.style.display='none';
		empLeaveDate.style.display='none';
		
	} */
	
	$('#resetDate').on("click", function (){
		$('form')[0].reset();
		empDate.style.display = '';
		empDateLa.style.display = '';
		empLeaveDateLa.style.display='none';
		empLeaveDate.style.display='none';
	})
</script>
</body>
</html>