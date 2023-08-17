package co.yedam.app.prcs.ing.service;

import java.util.List;



public interface PrcsIngService {
	//진행 공정 조회
	public List<PrcsIngVO> getPrcsIngList(String prcsDirDeCode, String prodCode);

	//진행공정 등록
	public int insertPrcsIng(String prcsDirDeCode);
	
	//공정 실적 조회
	
}
