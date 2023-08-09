package co.yedam.app.material.semi.in.service;

import java.util.List;

public interface SemiInService {
	//전체조회
	public List<SemiInVO> selectSemiInList(String productCode, String startDate, String endDate);
}
