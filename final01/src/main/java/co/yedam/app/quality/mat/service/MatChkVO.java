package co.yedam.app.quality.mat.service;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class MatChkVO {
	
	//자재 검수 조회
	private String matTestCode;
	private int matInputAmt;
	private int matYamt;
	private int matNamt;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date matTestDate;
	private String errCode;
	private String empCode;
	private String matOdDeCd;
	private String errRtSts;
	
	//자재 상세 발주 조회
	private String matOdCd;
	private int matAmt;
	private String matCode;
	private String matTestYn;
	private int matPrice;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date matOdAcp;
	
	
	
	
}
