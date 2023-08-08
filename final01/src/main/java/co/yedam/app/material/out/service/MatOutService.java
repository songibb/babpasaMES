package co.yedam.app.material.out.service;

import java.util.List;



public interface MatOutService {
	public List<MatOutVO> selectMatOutList(String materialCode, String accountCode, String startDate,String endDate);
}
