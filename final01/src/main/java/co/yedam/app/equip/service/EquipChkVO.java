package co.yedam.app.equip.service;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class EquipChkVO {
	private String eqCode;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date chkDate;
	private String eqChkYn;
	private String chkType;
	private String chkNote;
	private String empCode;

	private String eqName;
	private int chkCycle;
	private String eqType;
	
	
}
