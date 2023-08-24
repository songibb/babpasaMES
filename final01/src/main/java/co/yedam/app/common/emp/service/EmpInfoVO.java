package co.yedam.app.common.emp.service;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class EmpInfoVO {
	private String empCode;
	private String empName;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date empDate;
	private String empPw;
	private String empRole;
	private String deptCode;
	private String empTel;
	
	//조인(공통코드:부서코드와)
	private String commdeName;
	
	private String deptcodeName;
	private String empRoleName;
	
	
	
	//검색 조회
	private String inputDeptList;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private String startDate;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private String endDate;
	

}
