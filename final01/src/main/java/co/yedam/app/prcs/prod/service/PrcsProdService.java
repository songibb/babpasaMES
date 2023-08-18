package co.yedam.app.prcs.prod.service;

import java.util.List;


public interface PrcsProdService {
	//제품별공정 조회
	public List<PrcsProdVO> selectPrcsProdList(String prodCode);
	
	//제품 목록 조회
	public List<PrcsProdVO> selectProdList();
	
	//제품별공정 등록
	//제품별공정 수정
	//제품별공정 삭제
}
