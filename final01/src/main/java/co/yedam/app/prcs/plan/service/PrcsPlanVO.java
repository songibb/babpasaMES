package co.yedam.app.prcs.plan.service;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class PrcsPlanVO {

	//생산계획
	private String prcsPlanCode;					//계획코드
	private String prcsPlanName;					//계획명
	@DateTimeFormat(pattern = "yyyy-MM-dd")			
	private Date prcsPlanDate;						//계획일자
	private String empCode;							//담당자
	private String prcsDirYn;						//생산지시여부
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date prcsStartDate;						//예상생산시작일
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date prcsEndDate;						//예상생산종료일

	//상세 생산계획
	private String prcsPlanDeCode;					//상세계획코드
	private String prodCode;						//제품코드
	private int prcsRqAmt;							//주문수량
	private int prcsPlanAmt;						//생산계획량
	private String prcsPrio;						//우선순위
	private int prcsDirAmt;							//지시수량
	private String prcsDirSts;						//지시상태
	private String prcsAmt;							//생산량
	
	//주문서 조회용
	private String devDate;							//납기일자
	//주문서 수정용
	private String ordCode;
	
	//검색용
	private String searchPlanName;
	
	//출력용
	private String prodName;						//제품명
	private String empName;							//담당자이름
	private String prcsPrioKr;						
	
	
	
}
