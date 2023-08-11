package co.yedam.app.equip.service;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class OffEquipVO {
	private String offNo;
	private String eqCode;
	private String offType;
	private String offInfo;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date offStime;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date offEtime;
	private String offNote;
	private String empCode;
	
	private String eqName;
	private String eqType;
	private String eqSts;
	
}
