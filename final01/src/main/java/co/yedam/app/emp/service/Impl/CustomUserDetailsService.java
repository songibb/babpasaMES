package co.yedam.app.emp.service.Impl;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import co.yedam.app.emp.mapper.EmpMapper;
import co.yedam.app.emp.service.CustomUser;
import co.yedam.app.emp.service.EmpVO;




public class CustomUserDetailsService implements UserDetailsService {
	
	@Autowired
	EmpMapper empMapper;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		EmpVO vo = empMapper.getEmp(username);
		
		return vo == null ? null : new CustomUser(vo);
	}

}
