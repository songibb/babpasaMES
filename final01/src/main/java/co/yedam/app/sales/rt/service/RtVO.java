package co.yedam.app.sales.rt.service;

import java.util.Date;

import lombok.Data;

@Data
public class RtVO {
	/*
	SALES_RT_CODE  NOT NULL VARCHAR2(30)  
	PROD_CODE      NOT NULL VARCHAR2(30)  
	SALES_OUT_CODE NOT NULL VARCHAR2(30)  
	SALES_RT_AMT   NOT NULL NUMBER(10)    
	SALES_RT_DATE  NOT NULL DATE          
	SALES_RT_WHY            VARCHAR2(100) 
	EMP_CODE       NOT NULL VARCHAR2(30)  
	*/
	private String salesRtCode;
	private String prodCode;
	private String salesOutCode;
	private int salesRtAmt;
	private Date salesRtDate;
	private String salesRtWhy;
	private String empCode;
	private String prodName;
	private String actName;
	private int salesOutAmt;
	private int total;
	
	private String prodUnit;
	private String prodStd;
}
