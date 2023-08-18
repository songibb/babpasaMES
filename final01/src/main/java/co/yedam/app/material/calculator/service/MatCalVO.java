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
	
	//join
	private String matName;
	private String matStd;
	private String matUnit;
}
