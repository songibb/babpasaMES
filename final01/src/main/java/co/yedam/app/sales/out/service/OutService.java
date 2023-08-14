package co.yedam.app.sales.out.service;

import java.util.List;

public interface OutService {
	//전체조회
	public List<OutVO> getOutList();
	//거래처 목록
	public List<OutVO> actAllList();
	//제품목록
	public List<OutVO> prodAllList();
	//검색
	public List<OutVO> searchOutList(String prodCode, String actCode, String startDate, String outDate);
	//출고 등록
	public int insertOutList(List<OutVO> outList);
}
