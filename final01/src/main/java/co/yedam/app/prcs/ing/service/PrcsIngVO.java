package co.yedam.app.prcs.ing.service;

import java.util.Date;

import lombok.Data;

@Data
public class PrcsIngVO {
	//진행 공정 관리
	private String prcsIngCode;
	private String prcsDirDeCode;
	private String prodCode;
	private String prcsCode;
	private int prcsSeq;
	private int inputAmt;
	private int errAmt;
	private int prcsAmt;
	private String prcsDirIngSts;
	
	//공정 실적 관리
	private String eqCode;
	private Date prcsStartTime;
	private Date prcsEndTime;
	private String empCode;
}
