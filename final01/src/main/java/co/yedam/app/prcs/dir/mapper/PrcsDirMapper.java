package co.yedam.app.prcs.dir.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import co.yedam.app.common.bom.service.BomCodeVO;
import co.yedam.app.prcs.dir.service.PrcsDirVO;
import co.yedam.app.prcs.plan.service.PrcsPlanVO;
import co.yedam.app.prcs.plan.service.PrcsSearchVO;

public interface PrcsDirMapper {
	//생산지시 조회 (아직 생산 완료 되지 않은 지시)
	public List<PrcsDirVO> selectPrcsDirList(PrcsSearchVO prcsSearchVO);
	
	//생산지시 조회  (생산 완료된 지시)
	public List<PrcsDirVO> selectPrcsEndDirList(PrcsSearchVO prcsSearchVO);
	
	//상세생산지시 조회
	public List<PrcsDirVO> selectPrcsDirDeList(@Param("prcsDirCode") String prcsDirCode);
	
	//생산지시 등록
	public int insertPrcsDir(PrcsDirVO prcsDirVO);
	
	//상세생산지시 등록
	public int insertPrcsDirDe(PrcsDirVO prcsDirVO);
	
	
	//미지시 생산계획 조회
	public List<PrcsPlanVO> selectNotDirPlanList(PrcsSearchVO prcsSearchVO);
	
	//미지시 상세생산계획 조회
	public List<PrcsPlanVO> selectNotDirPlanDeList(@Param("prcsPlanCode") String prcsPlanCode);
	
	
	//생산지시 등록시 상세생산계획 (미지시 -> 지시완료) 수정 
	public int updateNotDirPlanList(PrcsDirVO prcsDirVO);
	
	//생산지시 등록시 자재 출고 (프로시저)
	//public int insertMatOut(@Param("prcsDirDeCode") String prcsDirDeCode,  @Param("empCode") String empCode);
	public int insertMatOut(Map<String, String> map);
	
	//BOM 조회
	public List<BomCodeVO> selectBomList(@Param("prodCode") String prodCode, @Param("prcsDirAmt") Integer prcsDirAmt);
	
	
	//진행공정 모두 공정완료시 생산지시 수정
	//public int updateDirPrcsSts(@Param("prcsDirCode") String prcsDirCode);
	public int updateDirPrcsSts(PrcsDirVO prcsDirVO);
	
	
	//재지시 등록 (상세생산지시) 
	public int insertReDirDe(PrcsDirVO prcsDirVO);
	
	//재지시 등록시 해당 상세생산지시 재지시여부 'Y'로 수정
	public int updateReDirDe(PrcsDirVO prcsDirVO);
	
	//재지시 등록 - 반제품 (상세생산지시)
	public int insertReDirDeSemi(@Param("newDirDeCode") String newDirDeCode, 
								 @Param("empCode") String empCode, 
								 @Param("originDirDeCode") String originDirDeCode);
}
