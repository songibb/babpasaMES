package co.yedam.app.prcs.plan.service;

import lombok.Data;

@Data
public class PrcsSearchVO {
	//검색용 VO
	
	//생산계획 검색
	private String searchPlanName;			//계획명
	
	private String searchProdCode; 			//제품코드
	
	private String startDate;				
	private String endDate;
	
	//공정관리 검색
	private String searchPrcsType;			//공정구분
	private String semiYes;					//반제품생산 유
	private String semiNo;					//반제품생산 무
}	
