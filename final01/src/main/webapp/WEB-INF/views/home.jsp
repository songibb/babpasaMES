<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="false" %>

<!DOCTYPE html>
<html>
<head>
    <title>Home</title>
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
    .col-lg-12 stretch-card{
       margin-top : 30px;
    }
    
    #customtemplateSearchAndButton{
       margin-bottom : 80px;
       float : left;   
    }
    
    #customtemplateSearchAndButton input, #modalTitle input{
       border : 1px solid black; 
       display : inline-block;
    }
    
    #customtemplateSearchAndButton p, #modalTitle p{
       display : inline-block;
       padding-bottom: 10px;
       padding-right : 10px;
    }
    
    #customtemplateSearchAndButton .blackcolorInputBox{
       background-color : #868e96;
    }
    
    .btn-icon-text{
       margin : 5px;
       padding : 7px;
       border-radius : 9px;
       height : 33px;
    }
    
    .excelDownload{
       margin-top : 120px;
       float : right;
    }
    
  

#actModal{ 
  cursor:pointer;
}

.modal{ 
  position:absolute; width:100%; height:100%; background: rgba(0,0,0,0.8); top:0; left:0; display:none;
}

.modal_content{
  width:400px; height:200px;
  background:#fff; border-radius:10px;
  position:relative; top:50%; left:50%;
  margin-top:-100px; margin-left:-200px;
  text-align:center;
  box-sizing:border-box; padding:74px 0;
  line-height:23px; cursor:pointer;
}

    
</style>
</head>
<body>
   <div class="black_bg"></div>
   <h1>페이지 제목</h1>
   <div class="col-lg-12 stretch-card">
       <div class="card">
           <div class="card-body">
               <div class="table-responsive pt-3">
                   <button type="button" class="btn btn-info btn-icon-text excelDownload">
                       Excel
                      <i class="bi bi-printer"></i>                                                                              
                   </button>
                  <div id="customtemplateSearchAndButton">
                  <p>검색조건</p>
                  <input type="text" placeholder="검색어를 입력하세요">
                    <i class="bi bi-search" id="actModal"></i>
                  <input type="text" class="blackcolorInputBox" readonly>
                  <br>
                  <p>검색조건</p>
                  <input type="text" placeholder="검색어를 입력하세요">
                  <i class="bi bi-search"></i> <!-- 돋보기 아이콘 -->
                  <input type="text" class="blackcolorInputBox" readonly>
                  <button type="button" class="btn btn-info btn-icon-text">
                     <i class="fas fa-search"></i>
                     검색
                  </button>
                  <button type="button" class="btn btn-info btn-icon-text">
                     초기화
                  </button>
               </div>
               <div id="grid"></div>
                </div>
         </div>
      </div>
   </div> 
   
   

<div class="modal">
  <div class="modal_content" 
       title="클릭하면 창이 닫힙니다.">
    여기에 모달창 내용을 적어줍니다.<br>
    이미지여도 좋고 글이어도 좋습니다.
  </div>
</div>
   
   


   
   
   
<script>

$(function(){ 

     $("#actModal").click(function(){
       $(".modal").fadeIn();
     });
     
     $(".modal_content").click(function(){
       $(".modal").fadeOut();
     });
     
   });

   
   const excelDownload = document.querySelector('.excelDownload');
   
   document.addEventListener('DOMContentLoaded', ()=>{
      excelDownload.addEventListener('click', function(e){
         grid.export('xlsx');
      })
   })

  
  const grid = new tui.Grid({
       el: document.getElementById('grid'),
       data: [
        // api: {
        //   readData: { url: '/api/readData', method: 'GET' }
        // }
              //column의 name속성을 필드명으로 사용해야 함
              { name: "2023001", artist: "고객1", type: "제품A", release: 10, genre: "배송중" },
              { name: "2023001", artist: "고객1", type: "제품A", release: 10, genre: "배송중" },
              { name: "2023001", artist: "고객1", type: "제품A", release: 10, genre: "배송중" },
              { name: "2023001", artist: "고객1", type: "제품A", release: 10, genre: "배송중" },
              { name: "2023001", artist: "고객1", type: "제품A", release: 10, genre: "배송중" },
              { name: "2023001", artist: "고객1", type: "제품A", release: 10, genre: "배송중" },
              { name: "2023001", artist: "고객1", type: "제품A", release: 10, genre: "배송중" },
              { name: "2023001", artist: "고객1", type: "제품A", release: 10, genre: "배송중" },
              { name: "2023001", artist: "고객1", type: "제품A", release: 10, genre: "배송중" },
              { name: "2023001", artist: "고객1", type: "제품A", release: 10, genre: "배송중" },
              { name: "2023001", artist: "고객1", type: "제품A", release: 10, genre: "배송중" },
              { name: "2023001", artist: "고객1", type: "제품A", release: 10, genre: "배송중" },
              { name: "2023001", artist: "고객1", type: "제품A", release: 10, genre: "배송중" },
              
        
       ],
       scrollX: false,
       scrollY: false,
       minBodyHeight: 30,
       rowHeaders: ['rowNum'],
       pagination: true,
       pageOptions: {
       //백엔드와 연동 없이 페이지 네이션 사용가능하게 만듦
         useClient: true,
         perPage: 10
       },
       columns: [
         {
           header: 'Name',
           name: 'name',
           filter: 'select'
         },
         {
           header: 'Artist',
           name: 'artist'
         },
         {
           header: 'Type',
           name: 'type'
         },
         {
           header: 'Release',
           name: 'release'
         },
         {
           header: 'Genre',
           name: 'genre'
         }
       ]
     });
  
     
   const options = {
           includeHiddenColumns: true,
           onlySelected: true,
           fileName: 'myExport',
         };
   

</script>
</body>
</html>