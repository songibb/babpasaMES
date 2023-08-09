package co.yedam.app.prcs.ing.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import co.yedam.app.prcs.ing.service.PrcsIngVO;

public interface PrcsIngMapper {
	//진행공정 조회
	public List<PrcsIngVO> selectPrcsIngList(@Param("prcsIngCode") String prcsIngCode);
}
