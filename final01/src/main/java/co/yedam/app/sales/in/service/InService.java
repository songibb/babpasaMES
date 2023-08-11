package co.yedam.app.sales.in.service;

import java.util.List;


public interface InService {
	//전체조회
	public List<InVO> getInList();
	//검색
	public List<InVO> searchInList(String prodCode, String startDate, String endDate);
	//제품목록
	public List<InVO> prodAllList();
}
