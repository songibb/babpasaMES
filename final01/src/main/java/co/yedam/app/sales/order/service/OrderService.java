package co.yedam.app.sales.order.service;

import java.util.List;

public interface OrderService {
	//전체 조회
	public List<OrderVO> getOrderList();
	//검색
	public List<OrderVO> searchOrderList(String actCode, String prodCode, String startDate, String endDate);
	//거래처목록
	public List<OrderVO> actAllList();
	//제품목록
	public List<OrderVO> prodAllList();
	//주문등록
	public String insertOrder(OrderVO orderVO);
}
