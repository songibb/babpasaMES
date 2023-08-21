package co.yedam.app.sales.order.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import co.yedam.app.material.order.de.service.MatOrderDeVO;
import co.yedam.app.sales.order.service.OrderVO;

public interface OrderMapper {
	//전체조회
	public List<OrderVO> selectOrderAllList();
	//검색
	public List<OrderVO> selectAllOrder(@Param("actCode")String actCode
			, @Param("prodCode")String prodCode
			, @Param("startDate")String startDate
			, @Param("endDate")String endDate);
	//거래처 목록
	public List<OrderVO> selectActAllList();
	//제품목록
	public List<OrderVO> selectProdAllList();
	//주문 관리 - 미계획 주문 목록
	public List<OrderVO> selectAllNoPlanList();
	//등록
	public int insertOrder(OrderVO vo);
	public int insertOrderDe(OrderVO vo);
	
	//수정
	public int updateOrder(OrderVO vo);
	
	//삭제
	public int deleteOrder(OrderVO vo);
	public int deleteOrderDe(OrderVO vo);
}
