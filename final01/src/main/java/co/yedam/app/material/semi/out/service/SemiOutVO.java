package co.yedam.app.material.semi.out.service;

import java.util.Date;

import lombok.Data;

@Data
public class SemiOutVO {
	//조회
	private String semiLot;
	private String prodCode;
	private String prodName;
	private Integer semiOutAmt;
	private String prcsListCode;
	private String empName;
	private Date semiOutDate;
	private Date semiExd;
}
