<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
	.yellow-background {
	        background-color: rgb(255,253,235);
		}
		
	#save{
		margin-bottom : 20px;
		radius : 5px;
	}
	
	h1{
		margin-left : 15px;
		font-weight : 800;
	}
	
	#customtemplateSearchAndButton input[type="date"],
	select {
	  width: 200px;
	  padding: 5px;
	  margin-bottom: 30px;
	  border: 1px solid #ccc;
	  border-radius: 4px;
	}
	
	form p{
	width: 100px;
	display: inline-block;
	font-size: 20px;
	}
	
	#customtemplateSearchAndButton input[type="text"],
	select {
	  width: 15%;
	  padding: 6px;
	  margin-bottom: 15px;
	  border: 1px solid #ccc;
	  border-radius: 4px;
	}
</style>
</head>
<body>
	<div class="black_bg"></div>
	<h1>설비 점검 조회</h1>
	<div class="col-lg-12 stretch-card">
    	<div class="card">
        	<div class="card-body">
            	<div class="table-responsive pt-3">
	            	<form>
	            		<div id="customtemplateSearchAndButton">
	            			<!-- <p>설비구분</p>
	            			<select name="job">
							    <option value="">설비구분</option>
							    <option value="증숙">증숙</option>
							    <option value="혼합">혼합</option>
							    <option value="냉동">냉동</option>
							</select><br>
							
							<p>판정구분</p>
							<select name="job">
							    <option value="">판정구분</option>
							    <option value="합격">합격</option>
							    <option value="불합격">불합격</option>
							    <option value="기타">기타</option>
							</select> -->
						
							<br>
							<p>점검일자</p>
							 <input type="date"> ~ <input type="date">
							<button type="button" id="searchBtn" class="btn btn-info btn-icon-text">검색</button>
							</div>
							

			
						</div>	
					</form>
					<div id="grid"></div>	

                </div>
			</div>
		</div>
	
<div class="modal">
   
  <div class="modal_content" 
       title="클릭하면 창이 닫힙니다.">
          <div class="m_head">
            <div class="modal_title"><h3>목록</h3></div>
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
    
	   //점검 설비 grid
	     var grid = new tui.Grid({
	         el: document.getElementById('grid'),
	         data: [
		        	<c:forEach items="${equipchkList}" var="chk" varStatus="status">
		           	{
		           		eqCode : "${chk.eqCode}",
		           		eqName : "${chk.eqName}",
		           		eqType2 : "${chk.eqType2}",
		           		chkCycle : "${chk.chkCycle}",
		           		chkDate : "<fmt:formatDate value='${chk.chkDate}' pattern='yyyy-MM-dd'/>",
		           		chkNextDate : "<fmt:formatDate value='${chk.chkNextDate}' pattern='yyyy-MM-dd'/>",
		           		eqChkYn2 : "${chk.eqChkYn2}",
		           		empCode : "${chk.empCode}",
		           		empName2 : "${chk.empName2}",
		           		chkNote : "${chk.chkNote}"		   	        
		           	}<c:if test="${not status.last}">,</c:if>
		           </c:forEach>
			          ], 
	         scrollX: false,
	         scrollY: false,
	         minBodyHeight: 300,
	         rowHeaders: ['rowNum'],
	         pagination: true,
				pageOptions: {
				useClient: true,
				perPage: 10,
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
			     header: '설비구분',
			     name: 'eqType2'
			   },
	           {
		         header: '점검주기(일)',
		         name: 'chkCycle'
		       },
	           {
	             header: '점검일자',
	             name: 'chkDate',
	           	 className: 'yellow-background'
	           },
	           {
	               header: '차기점검일자',
	               name: 'chkNextDate'
	           },
	           {
	 			header: '점검판정',
	             name: 'eqChkYn2'
	           },
	           {
	        	  header: '담당자코드',
		 	      name: 'empCode',
		 	      hidden: true
			 	      
	           },	    
	           {
	        	  header: '담당자명',
		 	      name: 'empName2'
			 	      
	           },
	           {
	        	  header: '비고',
		 	      name: 'chkNote'
	           }
	         ]
	 	});

	     grid.on('afterChange', (ev) => {
	         let change = ev.changes[0];
	         let rowData = grid.getRow(change.rowKey);

	         // Convert chkDate string to a Date object
	         let chkDate = new Date(rowData.chkDate);
	         
	         // Convert chkCycle to a number (assuming it's a string right now)
	         let chkCycle = parseInt(rowData.chkCycle);
	         
	         // Check if chkCycle is a valid number
	         if (isNaN(chkCycle)) {
	             return; // Exit if chkCycle is not a valid number
	         }
	         
	         // Calculate chkNextDate by adding chkCycle days to chkDate
	         let chkNextDate = new Date(chkDate.getTime() + chkCycle * 24 * 60 * 60 * 1000);
	         
	         // Update chkNextDate column if chkDate and chkCycle are both not null
	         if (change.columnName == 'chkDate' || change.columnName == 'chkCycle') {
	             if (rowData.chkDate != null) {
	                 // Convert chkNextDate to a string in the desired format (YYYY-MM-DD)
	                 let formattedChkNextDate = chkNextDate.toISOString().split('T')[0];
	                 grid.setValue(change.rowKey, 'chkNextDate', formattedChkNextDate);
	             }
	         }
	     });

	     
	   //검색 버튼
	        $('#searchBtn').on('click', searchChkEquip);
	        function searchChkEquip(e) {
	            let sd = $('#startDate').val();
	            let ed = $('#endDate').val();

	            let search = {
	                startDate: sd,
	                endDate: ed
	            };
	            $.ajax({
	                url: 'searchChkEquip',
	                method: 'GET',
	                data: search,
	                success: function (data2) {

	                    $.each(data2, function (idx, obj) {
	                        let date = new Date(obj['chkDate']);
	                        let year = date.getFullYear(); //0000년 가져오기
	                        let month = date.getMonth() + 1; //월은 0부터 시작하니 +1하기
	                        let day = date.getDate(); //일자 가져오기
	                        obj['chkDate'] = year + "-" + (
	                            ("00" + month.toString()).slice(-2)
	                        ) + "-" + (
	                            ("00" + day.toString()).slice(-2)
	                        );

	                    })
	                    grid.resetData(data2);
	                },
	                error: function (reject) {
	                    console.log(reject);
	                }
	            });
	        }

	        
	        //이전 날짜 선택불가
	        $('#startDate').on('change', function () {
	            $('#endDate').attr('min', $('#startDate').val());
	        });
	        //이후날짜 선택불가
	        $('#endDate').on('change', function () {
	            $('#startDate').attr('max', $('#endDate').val());
	        });
	</script>
</body>
</html>	
