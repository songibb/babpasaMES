package co.yedam.app.material.in.service;

import java.util.List;




public interface MatInService {
	//조회
	public List<MatInVO> selectMatInList(String materialCode, String accountCode, String startDate, String endDate);
}
