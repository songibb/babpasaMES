package co.yedam.app.prcs.ing.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import co.yedam.app.prcs.ing.service.PrcsIngVO;

public interface PrcsIngMapper {
	//진행공정 조회
	public List<PrcsIngVO> selectPrcsIngList(@Param("prcsDirDeCode") String prcsDirDeCode, 
											 @Param("prodCode") String prodCode);

	
	//진행공정 등록
	public Map<String, Object> insertPrcsIng(Map<String, Object> param);

}
