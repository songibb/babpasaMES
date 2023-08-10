package co.yedam.app.sales.out.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import co.yedam.app.sales.order.service.OrderVO;
import co.yedam.app.sales.out.service.OutVO;

public interface OutMapper {
	//전체조회
	public List<OutVO> selectOutAllList();
	//거래처 목록
	public List<OutVO> selectActAllList();
	//제품 목록
	public List<OutVO> selectProdAllList();
	//검색
	public List<OutVO> selectAllOut(@Param("actCode")String actCode
			, @Param("prodCode")String prodCode
			, @Param("startDate")String startDate
			, @Param("endDate")String endDate);
}
