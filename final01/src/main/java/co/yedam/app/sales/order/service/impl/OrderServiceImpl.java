package co.yedam.app.sales.order.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.sales.order.mapper.OrderMapper;
import co.yedam.app.sales.order.service.OrderService;
import co.yedam.app.sales.order.service.OrderVO;

@Service
public class OrderServiceImpl implements OrderService {

	@Autowired
	OrderMapper orderMapper;

	@Override
	public List<OrderVO> getOrderList() {
		return orderMapper.selectOrderAllList();
	}

	@Override
	public List<OrderVO> searchOrderList(String actCode, String prodCode, String startDate, String endDate) {
		return orderMapper.selectAllOrder(actCode, prodCode, startDate, endDate);
	}

	@Override
	public List<OrderVO> actAllList() {
		return orderMapper.selectActAllList();
	}

	@Override
	public List<OrderVO> prodAllList() {
		return orderMapper.selectProdAllList();
	}

	@Override
	public int insertOrder(OrderVO orderVO) {
		int result = orderMapper.insertOrder(orderVO);
		if(result > 0) {
			return result;
		}else {
			return -1;
		}
	}

	@Override
	public List<OrderVO> getNoPlan() {
		return orderMapper.selectAllNoPlanList();
	}

}
