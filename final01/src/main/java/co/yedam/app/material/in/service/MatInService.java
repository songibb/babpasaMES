package co.yedam.app.material.in.service;

import java.util.List;


import co.yedam.app.material.order.de.service.MatOrderDeVO;

public interface MatInService {
	public List<MatOrderDeVO> selectMatInList(String materialCode, String accountCode, String startDate, String endDate);
}
