package co.yedam.app.material.search.service;

import java.util.List;

import lombok.Data;

@Data	
public class SearchVO {
	private String materialCode;
	private String accountCode;
	private String startDate;
	private String endDate;
	private String productCode;
	
	private List<String> checkList;
}
