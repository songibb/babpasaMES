<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://uicdn.toast.com/chart/latest/toastui-chart.min.css" />
<script src="https://uicdn.toast.com/chart/latest/toastui-chart.min.js"></script>
<script src="https://kit.fontawesome.com/d148130f5e.js" crossorigin="anonymous"></script>

<style type="text/css">

   .my-box {  
         padding:30px;
         background-color: #cbf1a8; 
         border-radius : 30px;
         
         }
   
   
   .my-box .title{
      font-size : 30px;
      font-weight: 600;
      padding-bottom : 30px;
      display : inline-block;
      
   }
   
   .yesterday{
      display : inline;
      width: 100px;
      color : gray;
   }
   
   .fa-arrow-up-right-dots, .fa-cart-shopping, .fa-circle-xmark{
         width : 100px;
         height : 100px;
         font-size: 60px;
         background-color : #ffda6a;
         border-radius: 70%;
         padding-top : 18px;
         text-align: center;

   }
   
    #my-box-content{
       display : inline-block;
       font-size :   50px;
       font-weight : 700;
    }
    
    
   
</style>
</head>
<body>
   <div style="height: 30%; display: flex; justify-content: space-between; margin-bottom: 2% ;">
      <div class="my-box" style="width: 31%; height: 100%; min-width: 20%; min-height: 10%;">
      <p class="title">총 판매량</p>
      <p class="yesterday">| Yesterday</p>
      <br>
      <div style="display: flex;">
	      <i class="fa-solid fa-cart-shopping"></i>
	      <div id="my-box-content"style="display: flex; margin-top: 30px; margin-left: 10px;">
	      	<fmt:formatNumber type="number" maxFractionDigits="3" value="${totalSaleAmt}"/>
	      	<h3 style="margin-top: 20px; margin-left: 5px; font-weight: 1000">BOX</h3>
	      </div>
      </div>
      </div>
       <div class="my-box" style="width: 31%; height: 100%; min-width: 20%; min-height: 10%;">
	       <p class="title">총 생산량</p><p class="yesterday">| Yesterday</p>
	       <br>
	        <div style="display: flex;">
		       <i class="fa-solid fa-arrow-up-right-dots"></i>
		       <div id="my-box-content" style="display: flex; margin-top: 30px; margin-left: 10px;">
		       		<fmt:formatNumber type="number" maxFractionDigits="3" value="${totalpassAmt}"/>
		     		<h3 style="margin-top: 20px; margin-left: 5px; font-weight: 1000">KG</h3>
		       </div>
	        </div>
       </div>
       <div class="my-box" style="width: 31%; height: 100%; min-width: 20%; min-height: 10%;">
	       <p class="title">총 불량량</p><p class="yesterday">| Yesterday</p>
	       <br>
	       <div style="display: flex;">
		       <i class="fa-regular fa-circle-xmark"></i>
		       <div id="my-box-content" style="display: flex; margin-top: 30px; margin-left: 10px;"><fmt:formatNumber type="number" maxFractionDigits="3" value="${totalNonPassAmt}"/>
		      	 <h3 style="margin-top: 20px; margin-left: 5px; font-weight: 1000">KG</h3>
		       </div>
		   </div>
       </div>
   </div>
   <div style="height: 110%; display: flex; justify-content: space-between;">
     <div id="chart-area" style="width: 31%; height: 60%; min-width: 20%; min-height: 20%;"></div>
      <div id="chart-prcs" style="width: 31%; height: 60%; min-width: 20%; min-height: 20%;"></div>
     <div id="chart-prodList" style="width: 31%; height: 60%; min-width: 20%; min-height: 20%;"></div> 
   </div>
 
	
<script>


   saleChart();
   saveChart();
   PrcsAmtChart();
   

   function saleChart(){
    const el = document.getElementById('chart-area');
   const data = {
     categories: [
                 <c:forEach items="${salesList}" var="p">
                 '${p.prodCodeName}',
                 </c:forEach>
                 ],
     series: [
       {
         name: '판매량',
         data: [
            <c:forEach items="${salesList}" var="a">
               ${a.salesOutAmt},
               </c:forEach>
            ],
            colorByCategories: true
       }
     ],
   };
   const options = {
      chart: { title: '제품별 판매량 TOP5 (전일)', width:'auto',height: 'auto' }, 
      yAxis: {
  	    title: '판매량(BOX)'
  	  },
  	  xAxis: {
  	    title: '제품명'
  	  },

     legend: {
          visible: false,
        },
     theme: {
          series: {
             barWidth: 30
             },
             title: {
                 fontSize: 20,
                 fontWeight: 700,
                 color: 'gray'
               }
           }
   };
      
   const chart = toastui.Chart.columnChart({ el, data, options });          
   
   }

   function saveChart(){
    const el = document.getElementById('chart-prodList');
    const data = {
            categories: [
                        <c:forEach items="${prodAmtList}" var="p">
                        '${p.prodCodeName}',
                        </c:forEach>
                        ],
            series: [
              {
                name: '재고량',
                data: [
                   <c:forEach items="${prodAmtList}" var="a">
                      <fmt:parseNumber value="${a.prodSaveAmt}" integerOnly="true"/>,
                     
                      </c:forEach>
                   ],
                   colorByCategories: true
              }
            ],
          };
   const options = {
      chart: { title: '제품별 재고량 TOP5 (현재)', width:'auto',height: 'auto' }, 
      yAxis: {
    	    title: '재고량(BOX)'
    	  },
    	  xAxis: {
    	    title: '제품명'
    	  },

     legend: {
          visible: false,
        },
     theme: {
          series: {
             barWidth: 30
             },
             title: {
                 fontSize: 20,
                 fontWeight: 700,
                 color: 'gray'
               }
           }
   };
       

   const chart = toastui.Chart.columnChart({ el, data, options });
   
   
   }
   
   function PrcsAmtChart(){
       const el = document.getElementById('chart-prcs');
       const data = {
               categories: [
                           <c:forEach items="${prcsAmtList}" var="p">
                           '${p.prodCodeName}',
                           </c:forEach>
                           ],
               series: [
                 {
                   name: '생산량',
                   data: [
                      <c:forEach items="${prcsAmtList}" var="p">
                         ${p.passAmt},
                         </c:forEach>
                      ],
                      colorByCategories: true
                 }
               ],
             };
      const options = {
         chart: { title: '제품별 생산량 TOP5 (전일)', width:'auto',height: 'auto' }, 
         yAxis: {
     	    title: '생산량(KG)'
     	  },
     	  xAxis: {
     	    title: '제품명'
     	  },

        legend: {
             visible: false,
           },
        theme: {
             series: {
                barWidth: 30
                },
                title: {
                    fontSize: 20,
                    fontWeight: 700,
                    color: 'gray'
                  }
              }
      };
          


      const chart = toastui.Chart.columnChart({ el, data, options });
      
      
      }
   
   
   
   

</script>
</body>
</html>