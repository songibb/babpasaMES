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

     <div id="chart-area" style="width: 50%; height: 40%; min-width: 20%; min-height: 20%;">
</div>
</body>

<script>
	const el = document.getElementById('chart-area');
	const data = {
	  categories: [
		  			<c:forEach items="${amtList}" var="n">
		  			'${n.bomCode}',
		  			</c:forEach>
		  			],
	  series: [
	    {
	      name: '삽입량',
	      data: [
	    	  <c:forEach items="${amtList}" var="l">
	    	  	${l.bomAmt},
	    	  	</c:forEach>
	    	  ],
	    	  colorByCategories: true
	    }
	  ],
	};
	const options = {
	   chart: { title: 'BOMCode에 따른 삽입량', width: 'auto', height: 'auto' }, 

	  legend: {
		    visible: false,
		  },
/* 	   plot: {
			    visible: false
			  }, */
	  theme: {
		    series: {
		    	barWidth: 30
		    	}
	  		}
	};
		
	
	const chart = toastui.Chart.columnChart({ el, data, options });
				
</script>
</html>