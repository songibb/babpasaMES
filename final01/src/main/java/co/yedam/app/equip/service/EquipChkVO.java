package co.yedam.app.equip.service;

import java.util.Date;

import lombok.Data;

@Data
public class EquipChkVO {
	private String eqChkCode;
	private Date chkDate;
	private String eqCode;
	private String eqChkYn;
	private String chkRecord;
	private Date chkEtime;
	private String chkType;
	private Date chkNdate;
	private String chkNote;
	private String empCode;
}
