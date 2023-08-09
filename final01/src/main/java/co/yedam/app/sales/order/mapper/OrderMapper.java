package co.yedam.app.sales.order.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import co.yedam.app.sales.order.service.OrderVO;

public interface OrderMapper {
	//전체조회
	public List<OrderVO> selectOrderAllList();
	//검색
	public List<OrderVO> selectAllOrder(@Param("actCode")String actCode, @Param("prodName")String prodName, @Param("ordDate")String ordDate);
	//거래처 목록
	public List<OrderVO> selectActAllList();
	//제품목록
	public List<OrderVO> selectProdAllList();
}
