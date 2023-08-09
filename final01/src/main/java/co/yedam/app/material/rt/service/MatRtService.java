package co.yedam.app.material.rt.service;

import java.util.List;


public interface MatRtService {
	//전체조회
	public List<MatRtVO> selectMatRtList(String materialCode, String accountCode, String startDate, String endDate);
	
}
