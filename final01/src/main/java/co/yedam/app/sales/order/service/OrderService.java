package co.yedam.app.sales.order.service;

import java.util.List;

import co.yedam.app.common.grid.service.GridVO;

public interface OrderService {
	//전체 조회
	public List<OrderVO> getOrderList();
	//검색
	public List<OrderVO> searchOrderList(String actCode, String prodCode, String startDate, String endDate, String before, String comple);
	//거래처목록
	public List<OrderVO> actAllList();
	//거래처목록 검색
	public List<OrderVO> actSearchList(String actName);
	//제품목록
	public List<OrderVO> prodAllList();
	//주문서 관리 - 미계획 주문서 목록
	public List<OrderVO> getNoPlan();
	//등록, 수정, 삭제
	public int modifyOrder(GridVO<OrderVO> data);

}
