package co.yedam.app.material.semi.in.service;

import java.util.List;

public interface SemiInService {
	public List<SemiInVO> selectSemiInList(String productCode, String startDate, String endDate);
}
