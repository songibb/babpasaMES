package co.yedam.app.prcs.prod.service;

import lombok.Data;

@Data
public class PrcsProdVO {
	
	//제품별공정
	private String prcsProdCode;
	private String prodCode;
	private String prcsCode;
	private int prcsSeq;
	
	private String prodName;	
	private String prcsName;

}
