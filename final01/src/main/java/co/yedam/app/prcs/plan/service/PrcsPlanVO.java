package co.yedam.app.prcs.plan.service;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class PrcsPlanVO {

	//생산계획
	private String prcsPlanCode;
	private String prcsPlanName;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date prcsPlanDate;
	private String empCode;
	private String prcsDirYn;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date prcsStartDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date prcsEndDate;

	//상세 생산계획
	private String prcsPlanDeCode;
	private String prodCode;
	private int ordTotalAmt;
	private int prcsPlanAmt;
	private int prcsPrio;
	private int prcsDirAmt;
	private String prcsDirSts;
	private String prcsAmt;
}
