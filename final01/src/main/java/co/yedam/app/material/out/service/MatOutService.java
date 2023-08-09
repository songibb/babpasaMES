package co.yedam.app.material.out.service;

import java.util.List;



public interface MatOutService {
	//전체조회
	public List<MatOutVO> selectMatOutList(String materialCode, String accountCode, String startDate,String endDate);
}
