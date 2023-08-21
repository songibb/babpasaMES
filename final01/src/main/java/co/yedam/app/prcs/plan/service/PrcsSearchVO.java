package co.yedam.app.prcs.plan.service;

import lombok.Data;

@Data
public class PrcsSearchVO {
	//검색용 VO
	
	private String searchPlanName;			//계획명
	
	private String searchProdCode; 			//제품코드
	
	
	private String startDate;				
	private String endDate;
}	
