package co.yedam.app.material.out.service;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class MatOutVO {

	//조회에 사용
	private String matLot;
	private String matCode;
	private String matName;
	private String actName;
	private Integer matOutAmt;
	private String prcsDirDeCode;
	private String empName;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date matOutd;
	private Date matExd;
	
	private String matUnit;
	private String matStd;
}
