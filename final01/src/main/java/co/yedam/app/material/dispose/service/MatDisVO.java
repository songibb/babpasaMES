package co.yedam.app.material.dispose.service;

import java.util.Date;

import lombok.Data;

@Data
public class MatDisVO {
	
	private String matDpCode;
	private String matIdentiCode;
	private String matCode;
	private Integer matDpAmt;
	private Date matDpDate;
	private String empCode;
	private String matDpInfo;
	
	private String matStd;
	private String matUnit;
	private String empName;
	private String matName;
	private String matStock;
	private Date matInd;
	private Date matExd;
	
	//계산용
	private Integer matChangeAmt;
	private Integer dpMaxAmt;
}
