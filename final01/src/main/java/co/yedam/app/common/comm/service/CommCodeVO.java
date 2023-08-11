package co.yedam.app.common.comm.service;

import lombok.Data;

@Data
public class CommCodeVO {

	//공통코드 
	private String commCode;
	private String commName;
	private String commInfo;
	
	//공통상세코드
	private String commdeCode;
	private String commdeName;
	private String commdeInfo;
	private String commdeUse;
}
