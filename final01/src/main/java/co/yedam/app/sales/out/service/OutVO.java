package co.yedam.app.sales.out.service;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class OutVO {
	/*
	 *SALES_OUT_CODE NOT NULL VARCHAR2(30) 
	PROD_CODE      NOT NULL VARCHAR2(30) 
	ACT_CODE       NOT NULL VARCHAR2(30) 
	SALES_OUT_DATE NOT NULL DATE         
	SALES_OUT_AMT  NOT NULL NUMBER(10)   
	EMP_CODE       NOT NULL VARCHAR2(30) 
	PRCS_RQ_CODE   NOT NULL VARCHAR2(30)  
	 */
	private String salesOutCode;
	private String prodCode;
	private String actCode;
	@DateTimeFormat(pattern = "yyyy년 MM월 dd일")
	private Date salesOutDate;
	private int salesOutAmt;
	private String empCode;
	private String salesOrdDeCode;
	private String prodName;
	private String actName;
	@DateTimeFormat(pattern = "yyyy년 MM월 dd일")
	private Date salesInExd;
	
	private String prodUnit;
	private String prodStd;
	
	@DateTimeFormat(pattern = "yyyy년 MM월 dd일")
	private Date startDate;
	@DateTimeFormat(pattern = "yyyy년 MM월 dd일")
	private Date endDate;
	
	private String prodLot;
	@DateTimeFormat(pattern = "yyyy년 MM월 dd일")
	private Date salesInDate;
	private int salesInAmt;
	private int prodSaveAmt;
	private String testNum;
	
	@DateTimeFormat(pattern = "yyyy년 MM월 dd일")
	private Date ordDate;
	private String ordSts;
	private int prcsRqAmt;
	@DateTimeFormat(pattern = "yyyy년 MM월 dd일")
	private Date devDate;
	private String devYn;
}
