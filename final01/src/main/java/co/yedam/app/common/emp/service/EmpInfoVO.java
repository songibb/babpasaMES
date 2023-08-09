package co.yedam.app.common.emp.service;

import java.util.Date;

import lombok.Data;

@Data
public class EmpInfoVO {
	private String empCode;
	private String empName;
	private Date empDate;
	private String empPw;
	private String empRole;
	private String deptCode;
	private String empTel;
	
	//조인(공통코드:부서코드와)
	private String commdeName;
	

}
