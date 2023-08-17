package co.yedam.app.material.rt.service;

import java.util.Date;


import lombok.Data;

@Data
public class MatRtVO {
	
	//조회
	private String matOdDeCd;
	private String matCode;
	private String matName;
	private String actName;
	private Date matTestDate;
	private String errInfo;
	private Integer matRtAmt;
	private String empName;
	private Date matRtDate;
	private String matRtSts;
	
	//등록,수정,삭제
	private String matRtCode;
	private String matTestCode;
	private String actCode;
	private String empCode;
	
	private String matUnit;
	private String matStd;

}
