package co.yedam.app.sales.order.mapper;

import java.util.List;

import co.yedam.app.sales.order.service.OrderVO;

public interface OrderMapper {
	//전체조회
	public List<OrderVO> selectOrderAllList();
}
