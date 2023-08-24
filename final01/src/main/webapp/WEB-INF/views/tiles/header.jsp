<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<script src="${pageContext.request.contextPath}/resources/js/template.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/off-canvas.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/hoverable-collapse.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/vendor.bundle.base.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/settings.js"></script>

  
    
<nav class="navbar col-lg-12 col-12 p-0 fixed-top d-flex flex-row">
	<div class="text-center navbar-brand-wrapper d-flex align-items-center justify-content-center">
        <a class="navbar-brand brand-logo mr-5" href="index.html"><img src="${pageContext.request.contextPath}/resources/img/babpasa_logo_01.png" class="mr-2" alt="logo"/></a>
        <a class="navbar-brand brand-logo-mini" href="index.html"><img src="${pageContext.request.contextPath}/resources/img/babpasa_logo_02.png" alt="logo"/></a>
    </div>
    <div class="navbar-menu-wrapper d-flex align-items-center justify-content-end">
    	<button class="navbar-toggler align-self-center" type="button" data-toggle="minimize">
        	<span class="bi bi-list icon-menu"></span>
       	</button>
        
		<ul class="navbar-nav navbar-nav-right">
    		<li class="nav-item dropdown">
    			  <a class="nav-link count-indicator dropdown-toggle" id="notificationDropdown" href="#" data-toggle="dropdown">
            		<i class="fa-regular fa-bell icon-bell mx-0"></i>
              		<span class="count"></span>
            	</a>
            	<div class="dropdown-menu dropdown-menu-right navbar-dropdown preview-list" aria-labelledby="notificationDropdown">
              		<p class="mb-0 font-weight-normal float-left dropdown-header">Notifications</p>
              		<a class="dropdown-item preview-item">
                		<div class="preview-thumbnail">
                			<div class="preview-icon bg-success">
                    			<i class="ti-info-alt mx-0"></i>
                  			</div>
                		</div>
                		<div class="preview-item-content">
                  			<h6 class="preview-subject font-weight-normal">Application Error</h6>
                  			<p class="font-weight-light small-text mb-0 text-muted">
                    			Just now
                  			</p>
                		</div>
              		</a>
              		<a class="dropdown-item preview-item">
                		<div class="preview-thumbnail">
                  			<div class="preview-icon bg-warning">
                    			<i class="ti-settings mx-0"></i>
                  			</div>
                		</div>
                		<div class="preview-item-content">
                  			<h6 class="preview-subject font-weight-normal">Settings</h6>
                  			<p class="font-weight-light small-text mb-0 text-muted">
                    			Private message
                  			</p>
                		</div>
              		</a>
              		<a class="dropdown-item preview-item">
                		<div class="preview-thumbnail">
                  			<div class="preview-icon bg-info">
                    			<i class="ti-user mx-0"></i>
                  			</div>
                		</div>
                		<div class="preview-item-content">
                  			<h6 class="preview-subject font-weight-normal">New user registration</h6>
                  			<p class="font-weight-light small-text mb-0 text-muted">
                    			2 days ago
                  			</p>
                		</div>
              		</a>
				</div>
			</li>
			
        	<li class="nav-item nav-profile dropdown">
        		<a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown" id="profileDropdown">
              	${user.empName}
            	</a>
            	<div class="dropdown-menu dropdown-menu-right navbar-dropdown" aria-labelledby="profileDropdown">
              		
              			<sec:authorize access="!isAuthenticated()">
              		<a class="dropdown-item" href="loginForm">
							
							
	                			<i class="bi bi-power text-primary" ></i>
	                			login
	                			</a>
                			
							
						</sec:authorize>
              			<sec:authorize access="isAuthenticated()">
							<a class="dropdown-item" href="logout">
							<sec:csrfInput/>
                			<i class="bi bi-power text-primary"></i>
                				Logout
							</a>
						</sec:authorize>

            	</div>
			</li>
          
		</ul>
    	<button class="navbar-toggler navbar-toggler-right d-lg-none align-self-center" type="button" data-toggle="offcanvas">
    		<span class="icon-menu"></span>
    	</button>
	</div>
</nav>
