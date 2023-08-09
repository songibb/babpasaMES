package co.yedam.app.common.act.service;

import lombok.Data;

@Data
public class ActCodeVO {

	private String  actCode;
	private String actName;
	private String actNum;
	private String actTel;
	private String actSts;
	private String actKind;
	private String empCode;
	
	//조인
	private String commdeName;
	private String empName;
}
