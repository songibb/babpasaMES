<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>반제품 품질 검사</title>
   <!-- 토스트 페이지 네이션 -->
    <script type="text/javascript" src="https://uicdn.toast.com/tui.code-snippet/latest/tui-code-snippet.js"></script>
    <link rel="stylesheet" href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css" />
    <script src="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.js"></script>
    <!-- 페이지 네이션 끝 -->
    <link rel="stylesheet" href="https://uicdn.toast.com/grid/latest/tui-grid.css" />
    <script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>   
</head>
<body>
   <div class="black_bg"></div>
   <h3>반제품 품질 검사</h3>
   <div class="col-lg-12 stretch-card">
      <div class="card">
         <div class="card-body">
            <div class="table-responsive pt-3">
                  
                  <div style="display: flex; justify-content: flex-end;">

                     <button id="save" class="btn btn-info btn-icon-text">저장</button>
                  </div>
               </div>
               <div id="container" style="display: flex; justify-content: center;">
                       <div id="grid" style="width: 600px; margin-right: 50px"></div>
                       <div id="grid2" style="width: 1000px;"></div>
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
   
   <script>
   //저장버튼
   document.getElementById('save').addEventListener('click', commSave);
   
      //공통코드 조회 ajax
      $.ajax({
         url : 'ajaxPrcsIngChkList',
         method : 'GET',
         success : function(result){
            console.log(result);
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
          minBodyHeight: 30,
          rowHeaders: ['rowNum'],
         pagination: true,
         pageOptions: {
            useClient: true,
            perPage: 10,
         },
         columns: [
            {
               header: '검사번호',
               name: 'testNum'
            },
            {
               header: '생산진행코드',
               name: 'prcsIngCode'
            },
            {
               header: '생산코드',
               name: 'prcsCode'
            },
            {
               header: '생산량',
               name: 'prcsAmt'
            },
            {
               header: '합격량',
               name: 'passAmt'
            },
            {
               header: '불합격량',
               name: 'nonPassAmt'
            },
            {
               header : '검사날짜',
               name :'testDate'
            }
            
         ]
         
      })
      

      //상세공통코드 가져오기
      var grid2 = new tui.Grid({
         el: document.getElementById('grid2'),
         scrollX: false,
         scrollY: false,
          minBodyHeight: 30,
          rowHeaders: [{type: 'rowNum'},{type: 'checkbox'}],
         pagination: true,
         pageOptions: {
            useClient: true,
            perPage: 10,
         },
         columns: [
            {
               header: '검사번호',
               name: 'testNum'
            },
            {
               header: '공정진행코드',
               name: 'prcsIngCode'
            },
            {
               header: '상세검사번호',
               name: 'testNumInfo'
            },
            {
               header: '검사코드',
               name: 'testCode',
               hidden: true
            },
            {
               header: '검사명',
               name: 'testName'
            },
            {
               header: '검사기준값',
               name: 'passValue'
            },
            {
               header: '검사값',
               name: 'testResult',
               editor: 'text'
            },
            {
               header: '적합여부',
               name :'passYn'
            },
            {
               header: '담당자',
               name: 'empCode',
               editor: 'text'
               
            }
         ]
         
      })
      
      //자동 계산
      grid2.on('afterChange', (ev) => {
      
      let change = ev.changes[0];
      let rowData = grid2.getRow(change.rowKey);
      
      
      
      if(change.columnName == 'testResult'){
         if(rowData.testResult != null && rowData.testResult != ""){
            let passYn;
            if(rowData.testResult < rowData.passValue){
               passYn = 'Y';
            } else if(rowData.testResult >= rowData.passValue){
               passYn = 'N';
            }
            grid2.setValue(change.rowKey, 'passYn', passYn);
         }
      }
      });
      //끝
      
      grid.on('click', () => {
         let rowKey = grid.getFocusedCell().rowKey;
          let testNum = grid.getValue(rowKey, 'testNum');
          console.log(testNum);
          $.ajax({
             url : 'ajaxSemiChkList',
            method : 'GET',
            data : { testNum : testNum },
            success : function(data){
                grid2.resetData(data);
              },
            error : function(reject){
                console.log(reject);
             }
          })
          
          $("#testNum").val(testNum);
      });
      
      
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
         
         if(grid2.getModifiedRows().createdRows.length > 0 ){
                     
                     $.each(grid2.getModifiedRows().createdRows, function(idx2, obj2){
                        if(obj2['testResult'] == null ){
                           flag = false;
                           return false;
                        }
                        
                     })
                     
                     
               }
         
         
         if(grid2.getModifiedRows().updatedRows.length > 0 ){

            $.each(grid2.getModifiedRows().updatedRows, function(idx2, obj2){
               if(obj2['commdeCode'] == "" ||obj2['commdeName'] =="" || obj2['commdeInfo'] == "" || obj2['commdeUse'] == ""){
                  flag = false;
                  return false;
               }
            })
            
      }
         
         
         if(flag){
            let data = grid2.getModifiedRows();
            $.ajax({
               url : 'updateSemiChk',
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

   </script>
</body>
</html>