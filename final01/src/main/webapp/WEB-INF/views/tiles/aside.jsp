 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="${pageContext.request.contextPath}/resources/js/template.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/off-canvas.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/hoverable-collapse.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/vendor.bundle.base.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/settings.js"></script>

  
<nav class="sidebar sidebar-offcanvas" id="sidebar">
	<ul class="nav">
    	<li class="nav-item">
            <a class="nav-link" href="index.html">
            	<i class="mdi mdi-view-grid icon-grid menu-icon"></i>
              	<span class="menu-title">메인</span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" data-toggle="collapse" href="#ui-basic" aria-expanded="false" aria-controls="ui-basic">
              	<i class="mdi mdi-database icon-layout menu-icon"></i>
              	<span class="menu-title">공통</span>
              	<i class="menu-arrow fa-solid fa-chevron-right"></i>
            </a>
            <div class="collapse" id="ui-basic">
              	<ul class="nav flex-column sub-menu">
                	<li class="nav-item"> <a class="nav-link" href="pages/ui-features/buttons.html">사원 관리</a></li>
                	<li class="nav-item"> <a class="nav-link" href="pages/ui-features/dropdowns.html">공통 코드 관리</a></li>
                	<li class="nav-item"> <a class="nav-link" href="pages/ui-features/typography.html">품목 코드 관리</a></li>
                	<li class="nav-item"> <a class="nav-link" href="pages/ui-features/buttons.html">공정 코드 관리</a></li>
                	<li class="nav-item"> <a class="nav-link" href="pages/ui-features/buttons.html">자재 코드 관리</a></li>
                	<li class="nav-item"> <a class="nav-link" href="pages/ui-features/buttons.html">거래처 관리</a></li>
                	<li class="nav-item"> <a class="nav-link" href="pages/ui-features/buttons.html">불량 코드 관리</a></li>
                	<li class="nav-item"> <a class="nav-link" href="pages/ui-features/buttons.html">검사 코드 관리</a></li>
                	<li class="nav-item"> <a class="nav-link" href="pages/ui-features/buttons.html">BOM 관리</a></li>
              	</ul>
            </div>
		</li>
        <li class="nav-item">
        	<a class="nav-link" data-toggle="collapse" href="#form-elements" aria-expanded="false" aria-controls="form-elements">
              	<i class="mdi mdi-elevation-rise icon-columns menu-icon"></i>
              	<span class="menu-title">영업</span>
              	<i class="menu-arrow"></i>
            </a>
            <div class="collapse" id="form-elements">
              	<ul class="nav flex-column sub-menu">
              		<li class="nav-item"><a class="nav-link" href="orderList">주문 조회</a></li>
                	<li class="nav-item"><a class="nav-link" href="pages/forms/basic_elements.html">주문 관리</a></li>
                	<li class="nav-item"><a class="nav-link" href="outList">완제품 출고 조회</a></li>
                	<li class="nav-item"><a class="nav-link" href="pages/forms/basic_elements.html">완제품 출고 관리</a></li>
                	<li class="nav-item"><a class="nav-link" href="rtList">완제품 반품 조회</a></li>
                	<li class="nav-item"><a class="nav-link" href="pages/forms/basic_elements.html">완제품 반품 관리</a></li>
                	<li class="nav-item"><a class="nav-link" href="inList">완제품 재고 조회</a></li>
                	<li class="nav-item"><a class="nav-link" href="pages/forms/basic_elements.html">완제품 재고 관리</a></li>
              	</ul>
            </div>
		</li>
        <li class="nav-item">
        	<a class="nav-link" data-toggle="collapse" href="#charts" aria-expanded="false" aria-controls="charts">
              	<i class="mdi mdi-food-apple icon-bar-graph menu-icon"></i>
              	<span class="menu-title">자재</span>
              	<i class="menu-arrow"></i>
            </a>
            <div class="collapse" id="charts">
              	<ul class="nav flex-column sub-menu">
                	<li class="nav-item"> <a class="nav-link" href="pages/charts/chartjs.html">자재 발주 관리</a></li>
                	<li class="nav-item"> <a class="nav-link" href="pages/charts/chartjs.html">자재 입고 검수 관리</a></li>
                	<li class="nav-item"> <a class="nav-link" href="pages/charts/chartjs.html">자재 입/출고 조회</a></li>
                	<li class="nav-item"> <a class="nav-link" href="pages/charts/chartjs.html">자재 출고 등록</a></li>
                	<li class="nav-item"> <a class="nav-link" href="pages/charts/chartjs.html">자재 반품 관리</a></li>
                	<li class="nav-item"> <a class="nav-link" href="pages/charts/chartjs.html">자재 LOT 정산 관리</a></li>
                	<li class="nav-item"> <a class="nav-link" href="pages/charts/chartjs.html">자재 재고 조회</a></li>
               	 	<li class="nav-item"> <a class="nav-link" href="pages/charts/chartjs.html">반제품 입/출고 등록</a></li>
                	<li class="nav-item"> <a class="nav-link" href="pages/charts/chartjs.html">반제품 입/출고 조회</a></li>
                	<li class="nav-item"> <a class="nav-link" href="pages/charts/chartjs.html">반제품 재고 조회</a></li>
              	</ul>
            </div>
		</li>
        <li class="nav-item">
        	<a class="nav-link" data-toggle="collapse" href="#tables" aria-expanded="false" aria-controls="tables">
              	<i class="mdi mdi-factory icon-contract menu-icon"></i>
              	<span class="menu-title">생산</span>
              	<i class="menu-arrow"></i>
            </a>
            <div class="collapse" id="tables">
              	<ul class="nav flex-column sub-menu">
                	<li class="nav-item"> <a class="nav-link" href="${pageContext.request.contextPath}/">생산 계획 관리</a></li>
                	<li class="nav-item"> <a class="nav-link" href="${pageContext.request.contextPath}/">생산 지시</a></li>
                	<li class="nav-item"> <a class="nav-link" href="${pageContext.request.contextPath}/">생산 관리</a></li>
                	<li class="nav-item"> <a class="nav-link" href="${pageContext.request.contextPath}/">공정 실적 조회</a></li>
                	<li class="nav-item"> <a class="nav-link" href="${pageContext.request.contextPath}/prcsManageList">공정 관리</a></li>
                	<li class="nav-item"> <a class="nav-link" href="${pageContext.request.contextPath}/prcsProdList">제품 공정 흐름도</a></li>
              	</ul>
            </div>
		</li>
        <li class="nav-item">
        	<a class="nav-link" data-toggle="collapse" href="#icons" aria-expanded="false" aria-controls="icons">
              <!-- <i class="icon-grid-2 menu-icon"></i> -->
              	<i class="mdi mdi-flask-outline icon-contract menu-icon"></i>        
              	<span class="menu-title">품질</span>
              	<i class="menu-arrow"></i>
            </a>
            <div class="collapse" id="icons">
              	<ul class="nav flex-column sub-menu">
                	<li class="nav-item"> <a class="nav-link" href="pages/icons/mdi.html">품질 확인 목록</a></li>
                	<li class="nav-item"> <a class="nav-link" href="pages/icons/mdi.html">품질 불량 확인</a></li>
              	</ul>
            </div>
		</li>
        <li class="nav-item">
        	<a class="nav-link" data-toggle="collapse" href="#auth" aria-expanded="false" aria-controls="auth">
              	<i class="mdi mdi-wrench icon-head menu-icon"></i>
              	<span class="menu-title">설비</span>
              	<i class="menu-arrow"></i>
            </a>
            <div class="collapse" id="auth">
              	<ul class="nav flex-column sub-menu">
                	<li class="nav-item"> <a class="nav-link" href="pages/samples/login.html">설비관리</a></li>
                	<li class="nav-item"> <a class="nav-link" href="pages/samples/register.html">비가동 설비 관리</a></li>
                	<li class="nav-item"> <a class="nav-link" href="pages/samples/register.html">설비 점검 관리</a></li>
              	</ul>
            </div>
		</li>
	</ul>
</nav>
