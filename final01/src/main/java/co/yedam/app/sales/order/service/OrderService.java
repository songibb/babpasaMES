package co.yedam.app.sales.order.service;

import java.util.List;

public interface OrderService {
	//전체 조회
	public List<OrderVO> getOrderList();
	//검색
	public List<OrderVO> searchOrderList(String actCode, String prodName, String ordDate);
	//거래처목록
	public List<OrderVO> actAllList();
	//제품목록
	public List<OrderVO> prodAllList();
}
