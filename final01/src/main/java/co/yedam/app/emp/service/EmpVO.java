package co.yedam.app.emp.service;

import java.io.Serializable;
import java.sql.Date;

import lombok.Data;
@Data
public class EmpVO implements Serializable{
	private String id;
	private String empName;
	private Date empDate;
	private String pwd;
	private String empTel;
	private String role;
	private String deptCode;
	private String deptName;
}
