package co.yedam.app.material.semi.in.service;

import java.util.List;

public interface SemiInService {
	//전체조회
	public List<SemiInVO> selectSemiInList();
	public List<SemiInVO> selectSemiInSearch(String productCode, String startDate, String endDate);
	
	//반제품목록 모달
	public List<SemiInVO> getSemiModal();
}
