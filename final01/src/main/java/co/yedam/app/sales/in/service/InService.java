package co.yedam.app.sales.in.service;

import java.util.List;

import co.yedam.app.common.grid.service.GridVO;
import co.yedam.app.sales.order.service.OrderVO;


public interface InService {
	//전체조회
	public List<InVO> getInList();
	//검색
	public List<InVO> searchInList(String prodCode, String startDate, String endDate, String before, String comple);
	//제품목록
	public List<InVO> prodAllList();
	//등록, 수정, 삭제
	public int modifyProdIn(GridVO<InVO> data);
	//검수까지 마친 생산품 목록
	public List<InVO> CProdList();
	//입고관리 페이지 그리드
	public List<InVO> inMngList();
	//모달 검색 - 제품
	public List<OrderVO> prodSearchList(String prodName);
}
