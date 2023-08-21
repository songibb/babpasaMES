package co.yedam.app.prcs.ing.service;

import java.util.List;

import co.yedam.app.common.bom.service.BomCodeVO;
import co.yedam.app.equip.service.EquipVO;
import co.yedam.app.prcs.plan.service.PrcsSearchVO;



public interface PrcsIngService {
	//진행공정 조회
	public List<PrcsIngVO> selectPrcsIngList(String prcsDirDeCode, String prodCode);

	
	//작업 시작 전 사용 가능한 설비 조회 (진행공정 모달)
	public List<EquipVO> selectWaitEquipList(PrcsIngVO prcsIngVO);
	
	//작업 시작 후 선택된 설비 조회 (진행공정 모달)
	public List<EquipVO> selectEquip(String prcsDirDeCode, String prcsCode);
	
	//투입 자재별 소모량 조회 (진행공정 모달)
	public List<BomCodeVO> selectMatBomList(PrcsIngVO prcsIngVO);
	
	//작업시작 => 공정상태&설비 수정, 공정실적관리 등록 (진행공정 모달)
	public int callPrcsStart(PrcsIngVO prcsIngVO);
	
	//작업종료 => 공정상태&설비 수정, 공정실적관리 수정 (진행공정 모달)
	public int callPrcsEnd(PrcsIngVO prcsIngVO);
	
	//데이터 입력된 경우, 공정 실적 관리 조회 (진행공정 모달)
	public PrcsIngVO selectPrcsInfoList(String prcsDirDeCode, String prcsCode);
	
	
	//공정 실적 조회 (검색)
	public List<PrcsIngVO> selectPrcsResultList(PrcsSearchVO prcsSearchVO);
}
