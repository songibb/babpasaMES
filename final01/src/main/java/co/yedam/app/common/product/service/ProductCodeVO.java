package co.yedam.app.common.product.service;

import lombok.Data;

@Data
public class ProductCodeVO {
	
	private String prodCode;
	private String prodKind;
	private String prodName;
	private String prodUnit;
	private String prodStd;
	
	private String kindName;
	
	
	//등록 수정 시 제품명 중복 확인용
	private String prodNameUse;
}
