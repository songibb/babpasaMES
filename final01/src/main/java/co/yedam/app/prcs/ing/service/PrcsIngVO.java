package co.yedam.app.prcs.ing.service;


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
	
	//진행 공정 관리 모달창 - 투입 자재별 소모량에 필요
	private int prcsDirAmt;
	private String mpCode;
	private String matName;
	private int bomAmt;
	
	//공정 실적 관리
	private String eqCode;
	private String prcsStartTime;
	private String prcsEndTime;
	private String empCode;
	
	//이름 가져오기
	private String prodName;
	private String prcsName;
	private String empName;
	
	
	
}


