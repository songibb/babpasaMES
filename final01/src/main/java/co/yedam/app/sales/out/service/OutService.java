package co.yedam.app.sales.out.service;

import java.util.List;

import co.yedam.app.common.grid.service.GridVO;

public interface OutService {
	//전체조회
	public List<OutVO> getOutList();
	//거래처 목록
	public List<OutVO> actAllList();
	//제품목록
	public List<OutVO> prodAllList();
	//검색
	public List<OutVO> searchOutList(String prodCode, String actCode, String startDate, String outDate, String before, String comple);
	//출고완료된 품목만 보여주는 출고 리스트
	public List<OutVO> getOutNList();
	//등록, 수정, 삭제
	public int modifyOut(GridVO<OutVO> data);
	//lot list
	public List<OutVO> LotList();
	//order detail list
	public List<OutVO> OrderDeList();
}
