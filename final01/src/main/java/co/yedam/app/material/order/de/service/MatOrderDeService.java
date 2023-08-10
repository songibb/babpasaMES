package co.yedam.app.material.order.de.service;

import java.util.List;

public interface MatOrderDeService {
	//전체조회
	public List<MatOrderDeVO> selectMatOrderList();
	public List<MatOrderDeVO> selectMatOrderSearch(String materialCode, String accountCode, String startDate, String endDate);
}
