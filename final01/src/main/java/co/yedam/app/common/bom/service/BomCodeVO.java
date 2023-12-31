package co.yedam.app.common.bom.service;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class BomCodeVO {
	
	//bom관리 기능
	private String bomNo;
	private String prodCode;
	
	private Date bomWdate;
	
	private Date bomUdate;
	private String bomYn;
	private String bomPrcsYn;
	
	//조인을 위함
	private String prodName;
	private String prcsName;
	private String matName;
	private String bomPrcsYnName;
	

	//bom상세 관리 기능
	private String bomCode;
	private String prcsCode;
	private String mpKind;
	private String mpCode;
	private String bomUnit;
	private int bomAmt;
	
	
	//생산관리에 사용
	private String prcsSeq;
	
	
	//BOM상세
	private String mpName;
	
	
	private String bomYnName;
	private String kindName;
	
	

}
