package co.yedam.app.prcs.ing.service;

import java.util.List;

import co.yedam.app.common.bom.service.BomCodeVO;
import co.yedam.app.equip.service.EquipVO;



public interface PrcsIngService {
	//진행 공정 조회
	public List<PrcsIngVO> selectPrcsIngList(String prcsDirDeCode, String prodCode);

	//진행공정 등록
	public int insertPrcsIng(String prcsDirDeCode);
	
	//사용 가능한 설비 조회 (진행공정 모달)
	public List<EquipVO> selectWaitEquipList(PrcsIngVO prcsIngVO);
	
	//투입 자재별 소모량 조회 (진행공정 모달)
	public List<BomCodeVO> selectMatBomList(PrcsIngVO prcsIngVO);
	
}
