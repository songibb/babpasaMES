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
	private String deptName;
	private String empTel;
	

}
