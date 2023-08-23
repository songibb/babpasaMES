package co.yedam.app.prcs.manage.service;

import lombok.Data;

@Data
public class PrcsManageVO {
	//공정관리
	private String prcsCode;
	private String prcsType;
	private String prcsName;
	private String semiYn;
	
	//검색
	private String prcsSearch;
	
	//select
	private String prcsTypeKr;
	private String semiYnKr;
	

}
