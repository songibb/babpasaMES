package co.yedam.app.material.calculator.service;

import java.util.Date;

import lombok.Data;

@Data
public class MatCalVO {
	
    private String calCode;
	private String matCode;
	private String matLot;
	private String calCategory;
	private Integer calAmt;
	private Date calDate;
	private Integer calBamt;
	private String empCode;
	
	//join
	private String matName;
	private String matStd;
	private String matUnit;
	private String empName;
	
	private String actCode;
	private Date matExd;
	
}
