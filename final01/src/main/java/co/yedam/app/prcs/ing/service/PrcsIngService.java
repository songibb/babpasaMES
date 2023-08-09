package co.yedam.app.prcs.ing.service;

import java.util.List;


public interface PrcsIngService {
	//진행 공정 조회
	public List<PrcsIngVO> getPrcsIngList(String prcsIngCode);
}
