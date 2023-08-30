package co.yedam.app.sales.order.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.common.grid.service.GridVO;
import co.yedam.app.sales.order.mapper.OrderMapper;
import co.yedam.app.sales.order.service.OrderService;
import co.yedam.app.sales.order.service.OrderVO;
import co.yedam.app.sales.out.service.OutVO;

@Service
public class OrderServiceImpl implements OrderService {

	@Autowired
	OrderMapper orderMapper;

	@Override
	public List<OrderVO> getOrderList() {
		return orderMapper.selectOrderAllList();
	}

	@Override
	public List<OrderVO> searchOrderList(String actCode, String prodCode, String startDate, String endDate, String before, String comple) {
		return orderMapper.selectAllOrder(actCode, prodCode, startDate, endDate, before, comple);
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

	@Override
	public List<OrderVO> prodSearchList(String prodName) {
		return orderMapper.selectProdSearchList(prodName);
	}

	@Override
	public List<OutVO> actSearchList(String actName) {
		return orderMapper.selectActSearchList(actName);
	}

	@Override
	public List<OrderVO> ordHeaderList() {
		return orderMapper.ordHeaderList();
	}

	@Override
	public List<OrderVO> ordDetailList(String ordCode) {
		return orderMapper.ordDetailList(ordCode);
	}

}


