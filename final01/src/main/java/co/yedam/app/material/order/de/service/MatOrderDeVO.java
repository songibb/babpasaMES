package co.yedam.app.material.order.de.service;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class MatOrderDeVO {
	//전체조회에 사용
	private String matOdCd;
	private Integer matAmt;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date matOdAcp;
	private String matName;
	private Integer matPrice;
	private String actName;
	private String empName;

	//private String matOdDeCd;
	//private String matCode;
	//private String matTestYn;
	//private String empCode;
	//private Date matOdRq;
	//private String actCode;
	
	
	
}
