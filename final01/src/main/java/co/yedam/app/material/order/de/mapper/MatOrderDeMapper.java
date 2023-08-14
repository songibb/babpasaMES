package co.yedam.app.material.order.de.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import co.yedam.app.material.in.service.MatInVO;
import co.yedam.app.material.order.de.service.MatOrderDeVO;

public interface MatOrderDeMapper {
	//전체조회
	public List<MatOrderDeVO> selectMatOrderList();
	public List<MatOrderDeVO> selectMatOrderSearch(@Param("materialCode")String materialCode, @Param("accountCode")String accountCode, @Param("startDate")String startDate, @Param("endDate")String endDate);
	
	//등록
	public int insertMatOrderList(@Param("orderList") List<MatOrderDeVO> orderList);
	//거래처목록, 구매품목 필요함
	//구매품목 select
	public List<MatInVO> selectBuyMatList(String actCode); 
	
	//수정
	public int updateMatOrderList(@Param("orderList") List<MatOrderDeVO> orderList);
	
	//삭제
	public int deleteMatOrderList(@Param("orderList") List<MatOrderDeVO> orderList);	
}
