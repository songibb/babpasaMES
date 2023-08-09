package co.yedam.app.material.semi.out.service;

import java.util.List;



public interface SemiOutService {
	//전체조회
	public List<SemiOutVO> selectSemiOutList(String productCode, String startDate, String endDate);
}	
