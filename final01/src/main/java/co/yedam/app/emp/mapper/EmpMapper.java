package co.yedam.app.emp.mapper;

import co.yedam.app.emp.service.EmpVO;

public interface EmpMapper {
	//유저 정보 가져오기
	public EmpVO getEmp(String username);
}
