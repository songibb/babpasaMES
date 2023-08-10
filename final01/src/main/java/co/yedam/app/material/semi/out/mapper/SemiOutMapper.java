package co.yedam.app.material.semi.out.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import co.yedam.app.material.semi.out.service.SemiOutVO;

public interface SemiOutMapper {
	//전체조회
	public List<SemiOutVO> selectSemiOutList();
	public List<SemiOutVO> selectSemiOutSearch(@Param("productCode")String productCode, @Param("startDate")String startDate, @Param("endDate")String endDate);
}
