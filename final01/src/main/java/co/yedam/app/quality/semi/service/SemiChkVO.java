package co.yedam.app.quality.semi.service;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class SemiChkVO {
	
	//prcs-ing 조회
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
	
	//품질 검사
	private String testNum;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date testDate;
	private int testAmt;
	private String totalTestYn;
	private String empCode;
	private String prcsListCode;
	private int passAmt;
	private int nonPassAmt;
	
	//품질 검사 상세
	private String testNumInfo;
	private String testResult;
	private String passYn;
	private String testCode;
	
	private String testName;
	private int passValue;
	
	private String empName;
	
	private String passYn2;
	
	private String prodName;
}
