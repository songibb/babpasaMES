package co.yedam.app.emp.service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import co.yedam.app.emp.mapper.EmpMapper;

public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {
	
	
	@Autowired
	EmpMapper em;
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		
		String name = authentication.getName();
		
		EmpVO empVO = em.getEmp(name);
		
		request.getSession().setAttribute("user", empVO);
		request.getSession().setMaxInactiveInterval(3600);
		
		//사용자
		response.sendRedirect(request.getContextPath());
	}

}
