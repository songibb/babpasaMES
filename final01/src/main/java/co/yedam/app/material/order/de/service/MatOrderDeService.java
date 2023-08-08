package co.yedam.app.material.order.de.service;

import java.util.List;

public interface MatOrderDeService {
	
	public List<MatOrderDeVO> selectMatOrderList(String startDate, String endDate);
}
