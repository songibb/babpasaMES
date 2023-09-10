package co.yedam.app.prcs.prod.service;

import java.util.List;

import co.yedam.app.prcs.plan.service.PrcsSearchVO;


public interface PrcsProdService {
	//제품별공정 조회
	public List<PrcsProdVO> selectPrcsProdList(String prodCode);
	
	//제품 목록 조회
	public List<PrcsProdVO> selectProdList(PrcsSearchVO prcsSearchVO);
	
	//제품별공정 등록, 수정, 삭제
	public int updatePrcsProd(PrcsProdReqVO prcsProdReqVO);
}
