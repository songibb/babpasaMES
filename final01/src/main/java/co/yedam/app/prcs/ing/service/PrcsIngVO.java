package co.yedam.app.prcs.ing.service;

import java.util.Date;

import lombok.Data;

@Data
public class PrcsIngVO {
	//진행 공정 관리
	private String prcsIngCode;					//진행공정관리코드
	private String prcsDirDeCode;   			//상세지시코드    
	private String prodCode;					//제품코드			
	private String prcsCode;					//공정코드			
	private int prcsSeq;						//공정순서			
	private int inputAmt;						//투입량
	private int errAmt;							//불량량
	private int prcsAmt;						//생산량
	private String prcsDirIngSts;				//공정상태
	
	//공정 실적 관리
	private String eqCode;
	private Date prcsStartTime;
	private Date prcsEndTime;
	private String empCode;
		
}


