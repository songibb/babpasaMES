package co.yedam.app.material.in.service;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class MatInVO {
	//조회
	private String matLot;
	private String matCode;
	private String matName;
	private Integer matInAmt;
	private Date matExd;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date matInd;
	//private String empCode;
	private String empName;
	private String actCode;
	private String actName;
	
	private String matTestCode;
	
	
}
