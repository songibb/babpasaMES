package co.yedam.app.material.rt.service;

import java.util.Date;

import lombok.Data;

@Data
public class MatTestVO {
	
	private String matTestCode;
	private Integer matInputAmt;
	private Integer matYamt;
	private Integer matNamt;
	private Date matTestDate;
	private String errCode;
	private String errInfo;
	private String empCode;
	private String matOdDeCd;
	private String errRtSts;
	private String matCode;
	private String matName;
	private String actCode;
	private String actName;
	
	private String matStd;
	private String matUnit;
}
