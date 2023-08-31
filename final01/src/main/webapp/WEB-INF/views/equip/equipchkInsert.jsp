<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>설비 점검 등록</title>
   <!-- 토스트 페이지 네이션 -->
    <script type="text/javascript" src="https://uicdn.toast.com/tui.code-snippet/latest/tui-code-snippet.js"></script>
    <link rel="stylesheet" href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css" />
    <script src="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.js"></script>
    <!-- 페이지 네이션 끝 -->
    <link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
    <script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>   
    
    <style>
    	h1{
    		font-weight : 800;
    		margin-left : 15px;
    	}
    
    	h2{
    		font-weight : 800;
    	}
    	
    	.selected-cell{background-color: #ffd09e;}
    </style>
</head>
<body>
   <div class="black_bg"></div>
   <h1>설비 점검 등록</h1>
   <div class="col-lg-12 stretch-card">
      <div class="card">
         <div class="card-body">
            <div class="table-responsive pt-3">
         	</div> 
         	
               <div id="container" style="display: flex; justify-content: center;">
                       <div id="grid" style="width: 700px; margin-right: 50px"><h2>당일 점검 설비 </h2></div>
               <div>
                  	<div style="display: flex; justify-content: space-between;">
                  	<h2>점검 내역</h2>
                  	<div>
					<button id="commAdd" class="btn btn-info btn-icon-text">추가</button>
                     <button id="save" class="btn btn-info btn-icon-text">저장</button>
                     </div>
                  </div>
                     <div id="grid2" style="width: 800px;"></div>
              	 </div>
               </div>
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
   
   <div>
		<jsp:include page="../comFn/dateFormat.jsp"></jsp:include>
	</div>
	
   <script>
   //저장버튼
   document.getElementById('save').addEventListener('click', commSave);
 	//행추가
	document.getElementById('commAdd').addEventListener('click', addCommRow);
   
      //공통코드 조회 ajax
      $.ajax({
         url : 'letChkEquip',
         method : 'GET',
         success : function(result){
        	 
       	 $.each(result, function(i, objDe){
				let td = result[i]['chkDate'];
				let td2 = result[i]['chkNextDate'];
				
				result[i]['chkDate'] = getDate(td);
				result[i]['chkNextDate'] = getDate(td2);

			})
			
          grid.resetData(result);
         },
         error : function(reject){
            console.log(reject);
         }
      });
               
      
      var grid = new tui.Grid({
         el: document.getElementById('grid'),
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
      			name :'eqCode'
      			
      		},
            {
               header: '설비명',
               name: 'eqName'
            },
            
            {
               header: '설비상태',
               name: 'eqSts2'
            },
            {
               header: '최근점검일',
               name: 'chkDate'
            },
            {
            	header: '차기점검일',
            	name : 'chkNextDate'
            }
            
         ]
         
      })
      

      //상세공통코드 가져오기
      var grid2 = new tui.Grid({
         el: document.getElementById('grid2'),
         scrollX: false,
         scrollY: false,
          minBodyHeight: 300,
          rowHeaders: [{type: 'rowNum'}],
         pagination: true,
         pageOptions: {
            useClient: true,
            perPage: 10,
         },
         columns: [
            {
               header: '설비점검코드',
               name: 'eqChkCode',
               width: 'auto'
            },
            {
               header: '설비코드',
               name: 'eqCode'
            },
            {
               header: '점검일',
               name: 'chkDate',
               editor: {
	 	  		      type: 'datePicker',
	 	  		      options: {
	 	  		    	  language: 'ko'
	 	  		      }
            }
            },
            {
               header: '차기점검일',
               name: 'chkNextDate',
               formatter: function(props) {
                   const rowData = props.row;
                   const chkDate = new Date(rowData.chkDate);
                   const chkCycle = parseInt(rowData.chkCycle);
                   
                   if (!isNaN(chkCycle)) {
                       const chkNextDate = new Date(chkDate.getTime() + chkCycle * 24 * 60 * 60 * 1000);
                       const formattedChkNextDate = chkNextDate.toISOString().split('T')[0];
                       return formattedChkNextDate;
                   }
                   
                   return ''; // Return empty string if chkCycle is not a valid number
               }
            },
            {
            	header: '점검주기',
            	name : 'chkCycle'
            	
            },
            {
	 			header: '점검판정',
	             name: 'eqChkYn',
	             formatter: 'listItemText',
					editor: {
		                type: 'select',
		                options: {
		                  listItems: [
		                	<c:forEach items="${equipPassType}" var="u">
		                	 {
		                         text: '${u.commdeName }',
		                         value: '${u.commdeCode }'
		                       }, 
							</c:forEach>
		                  ]
		                }
		              }
	           },   
      		{
            	header:'담당자',
            	name: 'empCode',
                editor: 'text',
            	hidden: true
      		},
      		{
            	header:'담당자',
            	name: 'empName',
                editor: 'text'
      		},
      		
            {
               header: '비고',
               name: 'chkNote',
               editor: 'text'
            }
         ]
         
      });
		var cycle;
      grid.on('click', () => {
    	  
    	let selectKey = grid.getFocusedCell().rowKey;
  		grid.addRowClassName(selectKey, 'selected-cell');
  		//다른 행 선택시 기존에 클릭했던 행은 class제거
  		grid.on('focusChange', () => {
  			grid.removeRowClassName(selectKey, 'selected-cell');
  		})
  		
         let rowKey = grid.getFocusedCell().rowKey;
          let eqCode = grid.getValue(rowKey, 'eqCode');
        
          
          $.ajax({
             url : 'ajaxletChkInfoEquip',
            method : 'GET',
            data : { eqCode : eqCode },
            success : function(data){
 
                $.each(data, function(i, objDe){
    				let td3 = data[i]['chkDate'];
    				let td4 = data[i]['chkNextDate'];
    				cycle = data[0]['chkCycle'];
    				data[i]['chkDate'] = getDate(td3);
    				data[i]['chkNextDate'] = getDate(td4);

    			})
    			
    			grid2.resetData(data);
                
                $.each(grid2.getData(), function(idx, obj){
        			
        			if(obj['eqChkCode'] != null){
        				grid2.disableRow(obj['rowKey']);

        			}
        		})
		
              },
            error : function(reject){
                console.log(reject);
             }
          })
          
          $("#eqCode").val(eqCode);
          
      });

      //행추가
      function addCommRow(){
    	  
   	  let rowKey = grid.getFocusedCell().rowKey;
      let eqCode = grid.getValue(rowKey, 'eqCode');
	  let chkCycle = grid.getValue(rowKey, 'chkCycle');
	  
		grid2.appendRow({'empCode' : ${user.id}, 'empName' : `${user.empName}`,
						'eqCode' : eqCode, 'chkCycle' : cycle }, { at: 0 }
						);

		};
	
	
	//저장버튼
     function commSave(){
        grid2.blur();
        let modifyGridInfo = grid2.getModifiedRows();

        //변경사항없으면 빠져나감
        if(!grid2.isModified()){
           swal("변경사항이 없습니다","","warning");
           return false;
        }
        
        
       //입력 빠뜨린곳 없으면 true
       let flag = true;
       
       if(grid2.getModifiedRows().updatedRows.length > 0 ){

          $.each(grid2.getModifiedRows().updatedRows, function(idx2, obj2){
             if(obj2['commdeCode'] == "" ||obj2['commdeName'] =="" || obj2['commdeInfo'] == "" || obj2['commdeUse'] == ""){
                flag = false;
                return false;
             }
          })
          
    	}
        
    
       if(flag){

          $.ajax({
             url : 'insertChkEquip',
             method : 'POST',
             data : JSON.stringify(grid2.getModifiedRows()),
             contentType : 'application/json',
             success : function(data){
            	 
                swal("성공", data+"건이 처리되었습니다","success");
                
             },
             error : function(reject){
                console.log(reject);
             }
          })

           
     } else {
        alert("값이 입력되지 않았습니다.");
     }

  }
	
   //행 클릭 모달
     var Grid;
     grid2.on('click', () => {
    	let rowKey = grid2.getFocusedCell().rowKey;
    	let columnName = grid2.getFocusedCell().columnName;
    	if(columnName == "empCode"){
    		$(".modal").fadeIn();
    	       Grid = createProdGrid();
    	       
    	       Grid.on('click', () => {
    	       		let rowKey2 = Grid.getFocusedCell().rowKey;
    	        	let empCode = Grid.getValue(rowKey2, 'empCode');
    	        	let empName = Grid.getValue(rowKey2, 'empName');
    	        	
    	        	console.log(empCode);
    	        	console.log(empName);

    	        	grid2.setValue(rowKey, 'empCode', empCode);
    	        	grid2.setValue(rowKey, 'empName', empName);
    	    		//선택시 모달창 닫기
    	    		if(rowKey != null){
    	    			$(".modal").fadeOut();
    	        		Grid.destroy();
    	    		}

    	       });
    	}

  	});
	
	//모달창 닫기
	$("#close_btn").click(function(){
        $(".modal").fadeOut();
         
  		Grid.destroy();
     });
	
	 
     //사원 목록모달 그리드
     function createProdGrid(){
        var prodGrid = new tui.Grid({
            el: document.getElementById('modal_label'),
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
                    header: '사원번호',
                    name: 'empCode',
                  },                  
                  {
                    header: '사원명',
                    name: 'empName'
                  }
             ]
           
          });
        
        
        $.ajax({
		    url : 'empCodeList',
		    method : 'GET',
		    success : function(data){
		    	prodGrid.resetData(data);
		    },
		    error : function(reject){
		        console.log(reject);
		    }	
		})		 
        return prodGrid;
     }
   
     grid2.on('afterChange', (ev) => {
         let change = ev.changes[0];
         let rowData = grid2.getRow(change.rowKey);

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
                 grid2.setValue(change.rowKey, 'chkNextDate', formattedChkNextDate);
             }
         }
     });
   </script>
</body>
</html>