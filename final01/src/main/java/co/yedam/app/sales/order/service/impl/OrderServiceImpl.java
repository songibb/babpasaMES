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

}
