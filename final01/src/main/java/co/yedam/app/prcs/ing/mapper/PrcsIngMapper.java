package co.yedam.app.prcs.ing.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import co.yedam.app.common.bom.service.BomCodeVO;
import co.yedam.app.equip.service.EquipVO;
import co.yedam.app.prcs.ing.service.PrcsIngVO;
import co.yedam.app.prcs.plan.service.PrcsSearchVO;

public interface PrcsIngMapper {
	//진행 공정 조회
	public List<PrcsIngVO> selectPrcsIngList(@Param("prcsDirDeCode") String prcsDirDeCode, 
											 @Param("prodCode") String prodCode);

	
	//진행 공정 등록 (프로시저)
	public int insertPrcsIng(String prcsDirDeCode);

	//작업 시작 전 사용 가능한 설비 조회 (진행공정 모달)
	public List<EquipVO> selectWaitEquipList(PrcsIngVO prcsIngVO);
	
	//작업 시작 후 선택된 설비 조회 (진행공정 모달)
	public List<EquipVO> selectEquip(@Param("prcsDirDeCode") String prcsDirDeCode, 
							   		 @Param("prcsCode") String prcsCode);
	
	//투입 자재별 소모량 조회 (진행공정 모달)
	public List<BomCodeVO> selectMatBomList(PrcsIngVO prcsIngVO);
		
	//작업시작 => 공정상태&설비 수정, 공정실적관리 등록 (진행공정 모달)
	public int callPrcsStart(Map<String, Object> map);
	
	//작업종료 => 공정상태&설비 수정, 공정실적관리 수정 (진행공정 모달)
	public int callPrcsEnd(Map<String, Object> map);
	
	//데이터 입력된 경우, 공정 실적 관리 조회 (진행공정 모달)
	public PrcsIngVO selectPrcsInfoList(@Param("prcsDirDeCode") String prcsDirDeCode, 
			 							@Param("prcsCode") String prcsCode);
	
	//작업시작 => 진행 공정 조회 (이전 공정 미완료 확인용 -> 미완료시 작업버튼 실행X) (진행공정 모달)
//	public List<PrcsIngVO> selectPrcsIngSts(@Param("prcsDirDeCode") String prcsDirDeCode, 
//											@Param("prodCode") String prodCode);
	
	//작업시작 => 이전 공정 미완료 확인용 -> 미완료시 작업버튼 실행X (프로시저) (진행공정 모달)
	public Integer selectPrcsIngSts(PrcsIngVO prcsIngVO);
		

	//공정 실적 조회
	public List<PrcsIngVO> selectPrcsResultList(PrcsSearchVO prcsSearchVO);
	
	
	
}
