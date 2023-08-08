package co.yedam.app.sales.out.service;

import java.util.Date;

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
	private Date salesOutDate;
	private int salesOutAmt;
	private String empCode;
	private String prcsRqCode;
	private String prodName;
	private String actName;
	private Date salesInExd;
}
