package co.yedam.app.prcs.plan.service;

import lombok.Data;

@Data
public class PrcsSearchVO {
	//검색용 VO
	
	//날짜
	private String startDate;				
	private String endDate;

	//생산계획 검색
	private String searchPlanName;			//계획명
	
	//공정실적 검색
	private String searchProdCode; 			//제품코드
	private String searchPrcsCode;			//공정코드
	private String searchPrcsDirCode;		//생산지시코드
	
	//공정관리 검색
	private String searchPrcsType;			//공정구분
	private String semiYes;					//반제품생산 유
	private String semiNo;					//반제품생산 무
	
	//제품 검색
	private String searchProdName;			//제품명
}	
