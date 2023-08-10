package co.yedam.app.material.order.de.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import co.yedam.app.material.order.de.service.MatOrderDeVO;

public interface MatOrderDeMapper {
	//전체조회
	public List<MatOrderDeVO> selectMatOrderList();
	public List<MatOrderDeVO> selectMatOrderSearch(@Param("materialCode")String materialCode, @Param("accountCode")String accountCode, @Param("startDate")String startDate, @Param("endDate")String endDate);
}
