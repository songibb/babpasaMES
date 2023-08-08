package co.yedam.app.material.semi.in.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import co.yedam.app.material.semi.in.service.SemiInVO;

public interface SemiInMapper {
	public List<SemiInVO> selectSemiInList(@Param("productCode")String productCode, @Param("startDate")String startDate, @Param("endDate")String endDate);
}
