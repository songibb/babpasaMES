package co.yedam.app.prcs.prod.service;

import lombok.Data;

@Data
public class PrcsProdVO {
	
	//제품별 공정
	private String prcsProdCode;
	private String prodCode;
	private String prcsCode;
	private int prcsSeq;
	
	//제품 목록 조회
	private String prodName;
	
	//Join
	private String prcsName;

}
