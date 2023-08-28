 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<script src="${pageContext.request.contextPath}/resources/js/template.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/off-canvas.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/hoverable-collapse.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/vendor.bundle.base.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/settings.js"></script>

<nav class="sidebar sidebar-offcanvas" id="sidebar">
<security:authorize access="hasAnyAuthority('A','C','S','P','M','Q','E')">  
	<ul class="nav">
    	<li class="nav-item">
            <a class="nav-link" href="">
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
              		<security:authorize access="hasAnyAuthority('A','C','S','P','M','Q','E')">
                		<li class="nav-item"> <a class="nav-link" href="empinfo">사원 조회</a></li>
                	</security:authorize>
                	<security:authorize access="hasAnyAuthority('A','C')">
                		<li class="nav-item"> <a class="nav-link" href="empDir">사원 관리</a></li>
                	</security:authorize>
                	<security:authorize access="hasAnyAuthority('A','C','S','P','M','Q','E')">
                		<li class="nav-item"> <a class="nav-link" href="commCodeList">공통 코드 조회</a></li>
                	</security:authorize>
                	<security:authorize access="hasAnyAuthority('A','C')">
                		<li class="nav-item"> <a class="nav-link" href="commCodeAdmin">공통 코드 관리</a></li>
                	</security:authorize>
                	<security:authorize access="hasAnyAuthority('A','C','S','P','M','Q','E')">
                		<li class="nav-item"> <a class="nav-link" href="prodCodeList">제품 조회</a></li>
                	</security:authorize>
                	<security:authorize access="hasAnyAuthority('A','C')">
                		<li class="nav-item"> <a class="nav-link" href="prodCodeAdmin">제품 관리</a></li>
                	</security:authorize>
                	<security:authorize access="hasAnyAuthority('A','C','S','P','M','Q','E')">
                		<li class="nav-item"> <a class="nav-link" href="matCodeList">자재 조회</a></li>
                	</security:authorize>
                	<security:authorize access="hasAnyAuthority('A','C')">
                		<li class="nav-item"> <a class="nav-link" href="matCodeAdmin">자재 관리</a></li>
                	</security:authorize>
                	<security:authorize access="hasAnyAuthority('A','C','S','P','M','Q','E')">
                		<li class="nav-item"> <a class="nav-link" href="ActCodeList">거래처 조회</a></li>
                	</security:authorize>
                	<security:authorize access="hasAnyAuthority('A','C')">
                		<li class="nav-item"> <a class="nav-link" href="actCodeAdmin">거래처 관리</a></li>
                	</security:authorize>
                	<security:authorize access="hasAnyAuthority('A','C','S','P','M','Q','E')">
                		<li class="nav-item"> <a class="nav-link" href="bomCodeList">BOM 조회</a></li>
                	</security:authorize>
                	<security:authorize access="hasAnyAuthority('A','C')">
                		<li class="nav-item"> <a class="nav-link" href="bomCodeAdmin">BOM 관리</a></li>
                	</security:authorize>
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
              		<security:authorize access="hasAnyAuthority('A','C','S','P','M','Q','E')">
              		<li class="nav-item"><a class="nav-link" href="orderList">주문 조회</a></li>
              		</security:authorize>
              		<security:authorize access="hasAnyAuthority('A','S')">
                	<li class="nav-item"><a class="nav-link" href="orderMng">주문 관리</a></li>
                	</security:authorize>
                	<security:authorize access="hasAnyAuthority('A','C','S','P','M','Q','E')">
                	<li class="nav-item"><a class="nav-link" href="inList">완제품 재고 조회</a></li>
                	</security:authorize>
                	<security:authorize access="hasAnyAuthority('A','S')">
                	<li class="nav-item"><a class="nav-link" href="inMng">완제품 재고 관리</a></li>
                	<security:authorize access="hasAnyAuthority('A','C','S','P','M','Q','E')">
                	<li class="nav-item"><a class="nav-link" href="outList">완제품 출고 조회</a></li>
                	</security:authorize>
                	<security:authorize access="hasAnyAuthority('A','S')">
                	<li class="nav-item"><a class="nav-link" href="outMng">완제품 출고 관리</a></li>
                	</security:authorize>
                	<security:authorize access="hasAnyAuthority('A','C','S','P','M','Q','E')">
                	<li class="nav-item"><a class="nav-link" href="rtList">완제품 반품 조회</a></li>
                	</security:authorize>
                	<security:authorize access="hasAnyAuthority('A','S')">
                	<li class="nav-item"><a class="nav-link" href="rtMng">완제품 반품 관리</a></li>
                	</security:authorize>
                	</security:authorize>
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
              		<security:authorize access="hasAnyAuthority('A','C','S','P','M','Q','E')">
                		<li class="nav-item"> <a class="nav-link" href="${pageContext.request.contextPath}/matOrderList">자재 발주 조회</a></li>
                	</security:authorize>
                	<security:authorize access="hasAnyAuthority('A','M')">
                		<li class="nav-item"> <a class="nav-link" href="${pageContext.request.contextPath}/matOrderDir">자재 발주 관리</a></li>
                	</security:authorize>
                	<security:authorize access="hasAnyAuthority('A','C','S','P','M','Q','E')">
                		<li class="nav-item"> <a class="nav-link" href="${pageContext.request.contextPath}/matInList">자재 입고 조회</a></li>
                	</security:authorize>
                	<security:authorize access="hasAnyAuthority('A','M')">
                		<li class="nav-item"> <a class="nav-link" href="${pageContext.request.contextPath}/matInDir">자재 입고 관리</a></li>
                	</security:authorize>
                	<security:authorize access="hasAnyAuthority('A','C','S','P','M','Q','E')">
                		<li class="nav-item"> <a class="nav-link" href="${pageContext.request.contextPath}/matOutList">자재 출고 조회</a></li>
                	</security:authorize>
                	<security:authorize access="hasAnyAuthority('A','C','S','P','M','Q','E')">
                		<li class="nav-item"> <a class="nav-link" href="${pageContext.request.contextPath}/matRtList">자재 반품 조회</a></li>
                	</security:authorize>
                	<security:authorize access="hasAnyAuthority('A','M')">
                		<li class="nav-item"> <a class="nav-link" href="${pageContext.request.contextPath}/matRtDir">자재 반품 관리</a></li>
                	</security:authorize>
                	<security:authorize access="hasAnyAuthority('A','C','S','P','M','Q','E')">
               	 		<li class="nav-item"> <a class="nav-link" href="${pageContext.request.contextPath}/semiInList">반제품 입고 조회</a></li>
               	 	</security:authorize>
               	 	<security:authorize access="hasAnyAuthority('A','M')">
                		<li class="nav-item"> <a class="nav-link" href="${pageContext.request.contextPath}/semiInDir">반제품 입고 관리</a></li>
                	</security:authorize>
                	<security:authorize access="hasAnyAuthority('A','C','S','P','M','Q','E')">
                		<li class="nav-item"> <a class="nav-link" href="${pageContext.request.contextPath}/semiOutList">반제품 출고 조회</a></li>
                	</security:authorize>
                	<security:authorize access="hasAnyAuthority('A','C','S','P','M','Q','E')">
                		<li class="nav-item"> <a class="nav-link" href="${pageContext.request.contextPath}/matStockList">자재 재고 조회</a></li>
                	</security:authorize>
                	<security:authorize access="hasAnyAuthority('A','C','S','P','M','Q','E')">
                		<li class="nav-item"> <a class="nav-link" href="${pageContext.request.contextPath}/matCalculateList">자재 LOT 정산 조회</a></li>
                	</security:authorize>
                	<security:authorize access="hasAnyAuthority('A','M')">
                		<li class="nav-item"> <a class="nav-link" href="${pageContext.request.contextPath}/matCalculateDir">자재 LOT 정산 등록</a></li>
                	</security:authorize>
                	<security:authorize access="hasAnyAuthority('A','C','S','P','M','Q','E')">
                		<li class="nav-item"> <a class="nav-link" href="${pageContext.request.contextPath}/matDisList">자재 폐기 조회</a></li>
                	</security:authorize>
                	<security:authorize access="hasAnyAuthority('A','M')">
                		<li class="nav-item"> <a class="nav-link" href="${pageContext.request.contextPath}/matDisDir">자재 폐기 관리</a></li>
                	</security:authorize>
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
              		<security:authorize access="hasAnyAuthority('A','C','S','P','M','Q','E')">
                		<li class="nav-item"> <a class="nav-link" href="${pageContext.request.contextPath}/prcsPlanList">생산 계획 조회</a></li>
                	</security:authorize>
                	<security:authorize access="hasAnyAuthority('A','P')">
                		<li class="nav-item"> <a class="nav-link" href="${pageContext.request.contextPath}/prcsPlanInsert">생산 계획 관리</a></li>
                	</security:authorize>
                	<security:authorize access="hasAnyAuthority('A','P')">
                		<li class="nav-item"> <a class="nav-link" href="${pageContext.request.contextPath}/prcsDirInsert">생산 지시</a></li>
                	</security:authorize>
                	<security:authorize access="hasAnyAuthority('A','P')">
                		<li class="nav-item"> <a class="nav-link" href="${pageContext.request.contextPath}/prcsDirList">생산 관리</a></li>
                	</security:authorize>
                	<security:authorize access="hasAnyAuthority('A','C','S','P','M','Q','E')">
                		<li class="nav-item"> <a class="nav-link" href="${pageContext.request.contextPath}/prcsResultList">공정 실적 조회</a></li>
                	</security:authorize>
                	<security:authorize access="hasAnyAuthority('A','P')">
                		<li class="nav-item"> <a class="nav-link" href="${pageContext.request.contextPath}/prcsManageList">공정 관리</a></li>
                	</security:authorize>
                	<security:authorize access="hasAnyAuthority('A','C','S','P','M','Q','E')">
                		<li class="nav-item"> <a class="nav-link" href="${pageContext.request.contextPath}/prcsProdList">제품 공정 흐름도</a></li>
                	</security:authorize>
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
              		<security:authorize access="hasAnyAuthority('A','Q')">
                		<li class="nav-item"> <a class="nav-link" href="MatQualChk">자재 검수 관리</a></li>
                  </security:authorize>
                  <security:authorize access="hasAnyAuthority('A','C','S','P','M','Q','E')">
                		<li class="nav-item"> <a class="nav-link" href="semiQualChkList">반제품 품질 조회</a></li>
                  </security:authorize>
                  <security:authorize access="hasAnyAuthority('A','Q')">
                		<li class="nav-item"> <a class="nav-link" href="semiQualChk">반제품 품질 검사</a></li>
                  </security:authorize>
                  <security:authorize access="hasAnyAuthority('A','C','S','P','M','Q','E')">
                		<li class="nav-item"> <a class="nav-link" href="oneQualChkList">완제품 품질 조회</a></li>
                  </security:authorize>
                  <security:authorize access="hasAnyAuthority('A','Q')">
                		<li class="nav-item"> <a class="nav-link" href="onequalChk">완제품 품질 검사</a></li>
                	</security:authorize>
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
              		<security:authorize access="hasAnyAuthority('A','C','S','P','M','Q','E')">
                		<li class="nav-item"> <a class="nav-link" href="EquipList">설비조회</a></li>
                	</security:authorize>
                	<security:authorize access="hasAnyAuthority('A','E')">
                		<li class="nav-item"> <a class="nav-link" href="equipInsert">설비관리</a></li>
                	</security:authorize>
                	<security:authorize access="hasAnyAuthority('A','E')">
                		<li class="nav-item"> <a class="nav-link" href="offequip">비가동 설비 관리</a></li>
                	</security:authorize>
                	<security:authorize access="hasAnyAuthority('A','E')">
                		<li class="nav-item"> <a class="nav-link" href="equipchkList">설비 점검 조회</a></li>
                		<li class="nav-item"> <a class="nav-link" href="equipchkInsert">설비 점검 관리</a></li>
                	</security:authorize>
              	</ul>
            </div>
		</li>
	</ul>
</security:authorize>
</nav>