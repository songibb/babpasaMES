package co.yedam.app.sales.err.service;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class ErrVO {

	private String salesDpCode;
	private String testNum;
	private String prodCode;
	private int salesDpAmt;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date salesDpDate;
	private String empCode;
	
	private String prodName;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date startDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date endDate;
	
	private Date testDate;
	private int testAmt;
	private int passAmt;
	private int nonPassAmt;
	private String empName;
	private String prodLot;
}
