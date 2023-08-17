package co.yedam.app.prcs.ing.service;

import java.util.List;
import java.util.Map;


public interface PrcsIngService {
	//진행 공정 조회
	public List<PrcsIngVO> getPrcsIngList(String prcsDirDeCode, String prodCode);

	//진행공정 등록
	public Map<String, Object> insertPrcsIng(Map<String, Object> param);
	
	//공정 실적 조회
}
