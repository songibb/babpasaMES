package co.yedam.app.emp.service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

public class CustomUser implements UserDetails {
	private EmpVO emp;
	
	public CustomUser(EmpVO emp) {
		this.emp = emp;
	}
	
	public EmpVO getMemberInfo() {
		return this.emp;
	}

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		List<GrantedAuthority> auth = new ArrayList<>();
		auth.add(new SimpleGrantedAuthority(emp.getRole()));
		return auth;
	}

	@Override
	public String getPassword() {
		// TODO Auto-generated method stub
		return this.emp.getPwd();
	}

	@Override
	public String getUsername() {
		// TODO Auto-generated method stub
		return this.emp.getId();
	}

	@Override
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isEnabled() {
		// TODO Auto-generated method stub
		return true;
	}

}
