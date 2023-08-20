package co.yedam.app.material.semi.in.service;

import java.util.Date;

import lombok.Data;

@Data
public class SemiInVO {
	//조회
	private String semiLot;
	private String prodCode;
	private String prodName;
	private Integer semiInAmt;
	private String empName;
	private Date semiInd;
	private Date semiExd;
	
	//관리페이지
	private String empCode;
	private String prcsListCode;
	
	//검수완료된 반제품 목록
	private String testAmt;
	private Date testDate;
	
	private String useYn;
	
}
