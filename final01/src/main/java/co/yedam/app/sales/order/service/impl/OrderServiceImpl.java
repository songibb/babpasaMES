package co.yedam.app.sales.order.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.common.grid.service.GridVO;
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
	public List<OrderVO> getNoPlan() {
		return orderMapper.selectAllNoPlanList();
	}

	//등록, 수정, 삭제
	@Override
	public int modifyOrder(GridVO<OrderVO> data) {
		int result = 0;
		if(data.getDeletedRows() != null && data.getDeletedRows().size() > 0) {
			for(OrderVO vo : data.getDeletedRows()) {
				result += orderMapper.deleteOrderDe(vo);
			}
			orderMapper.deleteOrder();
		}
		if(data.getUpdatedRows() != null && data.getUpdatedRows().size() > 0) {
			for(OrderVO vo : data.getUpdatedRows()) {
				result += orderMapper.updateOrder(vo);
			}
		}
		if(data.getCreatedRows() != null && data.getCreatedRows().size() > 0) {
			orderMapper.insertOrder(data.getCreatedRows().get(0));
			for(OrderVO vo : data.getCreatedRows()) {
				result += orderMapper.insertOrderDe(vo);
			}
		}
		return result;
	}
	
	//거래처 목록 검색
	@Override
	public List<OrderVO> actSearchList(String actName) {
		
		return orderMapper.selectActSearchList(actName);
	}
}


