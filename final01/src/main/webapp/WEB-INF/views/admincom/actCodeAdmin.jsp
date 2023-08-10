<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>거래처관리</title>
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

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>

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

.col-lg-12 stretch-card {
	margin-top: 30px;
}

#customtemplateSearchAndButton {
	margin-bottom: 80px;
	float: left;
}

#customtemplateSearchAndButton input, #modalTitle input {
	border: 1px solid black;
	display: inline-block;
}

#customtemplateSearchAndButton p, #modalTitle p {
	display: inline-block;
	padding-bottom: 10px;
	padding-right: 10px;
}

#customtemplateSearchAndButton .blackcolorInputBox {
	background-color: #868e96;
}

.btn-icon-text {
	margin: 5px;
	padding: 7px;
	border-radius: 9px;
	height: 33px;
}

.excelDownload {
	margin-top: 120px;
	float: right;
}

/*모달시작*/
#actModal {
	cursor: pointer;
}

.modal {
	position: absolute;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.8);
	top: 0;
	left: 0;
	display: none;
}

.modal_content {
	/*모달창 크기 조절*/
	width: 600px;
	height: 600px;
	background: #fff;
	border-radius: 10px;
	/*모달창 위치 조절*/
	position: relative;
	top: 33%;
	left: 45%;
	margin-top: -100px;
	margin-left: -200px;
	text-align: center;
	box-sizing: border-box;
	line-height: 23px;
}

.m_head {
	height: 10%;
	margin: 0;
	/*제목 높낮이 조절*/
	padding: 17px;
	display: flex;
	justify-content: space-between;
	background-color: rgb(232, 143, 33);
	border-top-left-radius: 10px;
	border-top-right-radius: 10px;
}

.close_btn {
	font-size: 20px;
	color: black;
	font-weight: 900;
	cursor: pointer;
}

.modal_btn {
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

.m_head {
	height: 10%;
	padding: 20px;
	display: flex;
	justify-content: space-between;
	border-top-left-radius: 10px;
	border-top-right-radius: 10px;
	font-family: sans-serif;
}

.m_body {
	height: 80%;
	padding: 20px;
}

.m_footer {
	height: 10%;
	padding: 15px;
	border-bottom-left-radius: 10px;
	border-bottom-right-radius: 10px;
	display: flex;
	justify-content: end;
}

.cancle {
	background-color: black;
	color: white;
}

.save {
	background-color: black;
	color: white;
}
/*모달끝*/

/*날짜 input 크기*/
input[type="date"] {
	width: 221px;
}
</style>
</head>
<body>
	<div class="black_bg"></div>
	<h3>거래처관리</h3>
	<div>
		<form method="post" name="actInsertForm">
			<table>
				<tr>
					<th>거래처명</th>
					<td><input type="text" name="actName"></td>
				</tr>
				<tr>
					<th>사업자번호</th>
					<td><input type="text" name="actNum"></td>
				</tr>
				<tr>
					<th>연락처</th>
					<td><input type="text" name="actTel"></td>
				</tr>
				<tr>
					<th>거래처구분</th>
					<td><input type="text" name="commdeName"></td>
				</tr>
				<tr>
					<th>담당자</th>
					<td><input type="text" name="empCode" id="empCode"></td>
					<td><button type="button" id="actModal">사원조회</button></td>
				</tr>
			</table>
			<button type="submit">등록</button>
			<button type="reset">취소</button>
		</form>
	</div>
	<div class="col-lg-12 stretch-card">
		<div class="card">
			<div class="card-body">
				<div class="table-responsive pt-3">
					<form>
						거래처명: <input type="text" placeholder="검색어를 입력하세요" id="actSearch">
						<button type="button" class="btn btn-info btn-icon-text"
							id="searchBtn">
							<i class="fas fa-search"></i>검색
						</button>
						<button type="reset" class="btn btn-info btn-icon-text">초기화</button>
					</form>
				</div>
				<div id="grid"></div>
			</div>
		</div>
	</div>

	<div class="modal">
		<div class="modal_content" title="클릭하면 창이 닫힙니다.">
			<div class="m_head">
				<div class="modal_title">
					<h3>목록</h3>
				</div>
				<div class="close_btn" id="close_btn">X</div>
			</div>
			<div class="m_body">
				<div id="modal_label"></div>
			</div>
			<div class="m_footer">
				<div class="modal_btn cancle" id="close_btn">CANCLE</div>
				<div class="modal_btn save" id="save_btn">SAVE</div>
			</div>
		</div>
	</div>


	<script>
	//거래처 리스트 조회
	$.ajax({
        url : "ajaxActCodeList",
        method :"GET",
        success : function(result){
            grid.resetData(result);
        },
        error : function(reject){
 			console.log(reject);
 		}
	});
	
	//거래처명 검색조회
	
	$('#searchBtn').on('click', searchActIn);
   function searchActIn(e){
	   let content = $('#actSearch').val();
	   let search = { actName : content };
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
   
   //거래처 등록
   //사원 모달창
   $("#actModal").click(function(){
  $(".modal").fadeIn();
  Grid = createActGrid();
  Grid.on('click', () => {
		
		let rowKey = Grid.getFocusedCell().rowKey;
		let empCode = Grid.getValue(rowKey, 'empCode');

		$.ajax({
			url : 'getComEmpCode',
			method : 'GET',
			data : { empCode : empCode },
			success : function(data){
					//console.log(data);
					$('#empCode').val(data.empName);
			    },
			error : function(reject){
	 			console.log(reject);
	 		}	
		})
		});
  $.ajax({
	    url : "empinfo",
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

/*    document.querySelector('form[name="actInsertForm"]')
   					.addEventListener("submit" , function(e){
					e.preventDefault();
				
					let actName = document.getElementsByName('actName')[0];
					let actNum = document.getElementsByName('actNum')[0];
					let actTel = document.getElementsByName('actTel')[0];
					let actKind = document.getElementsByName('actKind')[0];
					let empCode = document.getElementsByName('empCode')[0];
					
					if(actCode.value == '' || actName.value == ''|| actNum.value  == '' || actTel.value == '' || empCode.value == ''){
						alert('입력되지 않은 정보가 있습니다.');
						return;
					}
					
					actInsertForm.submit();
   					}); */
   					
/*    //거래처 등록
   $('form').on('submit',function(e){
  let objData = serializeObject();
	  
	  $ajax({
		  url : 'actCodeInsert',
		  method : 'post',
		  data : objData
	  })
	  
	  .done(data => {
		  if(data.result){
			  let message = "등록이 되었습니다";
			  alert(message);
		  }else{
			  alert("등록되지 않았습니다.")
		  }
	  })
	  
	  .fail(reject => console.log(reject));
	  
	  return false;
	  
   }); */
   
   function serializeObject(){
	   let formData = $('form').serializeArray();
	   let formObject = {};
	   $.each(formData, function(idx,obj){
			let field = obj.name;
			let val = obj.value;
			
			formObject[field] = val;
		});
			return formObject;
   }

    var grid = new tui.Grid({
        el: document.getElementById('grid'),
        scrollX: false,
        scrollY: false,
        minBodyHeight: 30,
		rowHeaders: ['rowNum'],
		pagination: true,
		pageOptions: {
			useClient: true,
			perPage: 5,
		},
        columns: [
          {
            header: '거래처코드',
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
            name: 'actSts'
          },
          {
              header: '거래처구분',
              name: 'commdeName',
              filter: 'select'
            },
          {
              header: '담당자',
              name: 'empName'
            }
        ]
      })  

	
	</script>
</body>
</html>