package co.yedam.app.common.main.service;

import lombok.Data;

@Data
public class MainVO {
	private String prodCode;
	private String prodCodeName;
	
	//제품 재고량
	private int prodSaveAmt;
	
	//제품 판매량
	private int salesOutAmt;
	
	//제품 생산량
	private Integer passAmt;
	
	//제품불량량
	private Integer nonPassAmt;
	
	//제품 판매량 totla
	private Integer salesOutTotalAmt;
}
