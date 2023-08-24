<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://uicdn.toast.com/chart/latest/toastui-chart.min.css" />
<script src="https://uicdn.toast.com/chart/latest/toastui-chart.min.js"></script>

</head>
<body>
	<div style="height: 100%; display: flex; justify-content: space-between;">
     <div id="chart-area" style="width: 33%; height: 60%; min-width: 20%; min-height: 20%;"></div>
     <div id="chart-prodList" style="width: 33%; height: 60%; min-width: 20%; min-height: 20%;"></div>
	<div id="chart-prcs" style="width: 33%; height: 60%; min-width: 20%; min-height: 20%;"></div>
	</div>

<script>
	function chart1(){
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
	   chart: { title: '재품별 판매량', width:'auto',height: 'auto' }, 

	  legend: {
		    visible: false,
		  },
	  theme: {
		    series: {
		    	barWidth: 30
		    	}
	  		}
	};
		
	const chart = toastui.Chart.columnChart({ el, data, options });	  	  
	
	}

	function chart2(){
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
 			    	  	${a.prodSaveAmt},
 			    	  	</c:forEach>
 			    	  ],
 			    	  colorByCategories: true
 			    }
 			  ],
 			};
	const options = {
	   chart: { title: '제품별 재고량', width:'auto',height: 'auto' }, 

	  legend: {
		    visible: false,
		  },
	  theme: {
		    series: {
		    	barWidth: 30
		    	}
	  		}
	};
		 

	const chart = toastui.Chart.columnChart({ el, data, options });
	
	
	}
	
	chart1();
	chart2();
	
	
</script>
</body>
</html>