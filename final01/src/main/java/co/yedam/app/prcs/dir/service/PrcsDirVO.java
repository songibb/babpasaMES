package co.yedam.app.prcs.dir.service;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class PrcsDirVO {
	
	//생산지시
	private String prcsDirCode;
	private String prcsPlanCode;
	private String prcsDirName;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date prcsDirDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date prcsStartDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date prcsEndDate;
	private String prcsDirSts;
	private String empCode;
	
	//상세 생산지시
	private String prcsDirDeCode;
	private String prodCode;
	private int prcsPlanAmt;
	private int prcsDirAmt;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date prcsStartDeDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date prcsEndDeDate;
	private String prcsIngSts;
	
	//생산계획 수정용
	private String prcsPlanDeCode;
	
	
	//프로시저 결과 담는용
	private int ingResult;
	
	//출력용
	private String empName;
	
}
