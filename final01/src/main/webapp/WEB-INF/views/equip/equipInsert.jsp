<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<style>
   #actModal { 
     cursor:pointer;
   }
   
   .modal { 
     position:absolute; width:100%; height:100%; background: rgba(0,0,0,0.8); top:0; left:0; display:none;
   }
   
   .modal_content {
     width:400px; height:200px;
     background:#fff; 
     position:relative; top:50%; left:50%;
     margin-top:-100px; margin-left:-200px;
     text-align:center;
     box-sizing:border-box; padding:74px 0;
     line-height:23px; cursor:pointer;
   }
</style>
<meta charset="EUC-KR">
<title>설비 등록 페이지</title>
</head>

<h2>설비 관리</h2>
<body>
<hr>
<form name="insertForm" action="equipInsert" method="post">
   <table>
   <button type="button" id="selectModal">설비조회</button>
      <tr>
         <th>설비코드</th>
         <td><input type="text" name="eqCode"></td>
         <th>거래처</th>
         <td><input type="text" name="actCode"></td>
      </tr>
      <tr>
         <th>설비구분 <i class="bi bi-search" id="actModal"></i></th>
         <td><input type="text" name="eqType"></td>
         <th>설비명</th>
         <td><input type="text" name="eqName"></td>
      </tr>
      <tr>
         <th>모델명</th>
         <td><input type="text" name="modelName"></td>
         <th>제작일자</th>
         <td><input type="text" name="makeDate"></td>
      </tr>
      <tr>
         <th>구매일자</th>
         <td><input type="text" name="buyDate"></td>
         <th>점검주기</th>
         <td><input type="text" name="chkCycle"></td>
      </tr>
      <tr>
         <th>가동여부</th>
         <td><input type="text" name="eqSts"></td>
         <th>공정코드</th>
         <td><input type="text" name="prcsType"></td>
      </tr>
      <tr>
         <th>최고온도</th>
         <td><input type="text" name="highTemp"></td>
         <th>최저온도</th>
         <td><input type="text" name="lowTemp"></td>
      </tr>
      <tr>
         <th>설비이미지</th>
         <td><input type="text" name="eqImg"></td>
      </tr>
   </table>
   <br>
   <button type="submit">등록</button>
   <button type="submit">삭제</button>
   <button type="button" onclick="location.href='EquipList'">목록</button>
   
   
   <div class="modal">
      <div class="modal_content" title="클릭하면 창이 닫힙니다.">
         <ul id="equipmentList"></ul>
      </div>
   </div>
   
</form>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(function(){ 
    $("#actModal").click(function(){
        loadEquipmentList("insert"); // 모달 열릴 때 리스트 로드
        $(".modal").fadeIn();
    });

    $(".modal_content").click(function(){
        $(".modal").fadeOut();
    });

    // "설비조회" 버튼 클릭 이벤트
    $("#selectModal").click(function(){
        loadEquipmentList("select"); // 모달 열릴 때 리스트 로드
        $(".modal").fadeIn();
    });

    // 설비구분 리스트 항목 클릭 이벤트
    $("#equipmentList").on("click", "li", function() {
        const selectedValue = $(this).text();
        const [eqType, eqName, eqCode] = selectedValue.split(" | ");
        
        // 선택한 값을 각각의 입력 필드에 넣기
        $("input[name='eqCode']").val(eqCode);
        $("input[name='eqName']").val(eqName);
        $("input[name='eqType']").val(eqType);
        
        $(".modal").fadeOut();
    });
});

// 설비구분과 설비명 리스트를 동적으로 생성하고 표시하는 함수
function loadEquipmentList(purpose) {
    $.ajax({
        url: "selectEquipAllList", 
        method: "GET",
        success: function(equipmentList) {
            const listContainer = $("#equipmentList");
            listContainer.empty(); // 기존 리스트 초기화

            // 각 항목을 동적으로 생성하여 리스트에 추가
            equipmentList.forEach(function(item) {
                let listItem;
                if (purpose === "insert") {
                    listItem = $("<li>").text(item.eqType + "|" + item.eqName);
                } else if (purpose === "select") {
                    listItem = $("<li>").text(item.eqType + " | " + item.eqName + " | " + item.eqCode);
                }
                listContainer.append(listItem);
            });
        }
    });
}
</script>
</body>
</html>
