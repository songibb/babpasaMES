package co.yedam.app.prcs.dir.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import co.yedam.app.common.bom.service.BomCodeVO;
import co.yedam.app.prcs.dir.service.PrcsDirVO;
import co.yedam.app.prcs.plan.service.PrcsPlanVO;
import co.yedam.app.prcs.plan.service.PrcsSearchVO;

public interface PrcsDirMapper {
	//생산지시 조회
	public List<PrcsDirVO> selectPrcsDirList(PrcsSearchVO prcsSearchVO);
	
	//상세생산지시 조회
	public List<PrcsDirVO> selectPrcsDirDeList(@Param("prcsDirCode") String prcsDirCode);
	
	//생산지시 등록
	public int insertPrcsDir(PrcsDirVO prcsDirVO);
	
	//상세생산지시 등록
	public int insertPrcsDirDe(PrcsDirVO prcsDirVO);
	
	
	//미지시 계획 조회
	public List<PrcsPlanVO> selectNotDirPlanList();
	
	//미지시 상세 계획 조회
	public List<PrcsPlanVO> selectNotDirPlanDeList(@Param("prcsPlanCode") String prcsPlanCode);
	
	
	//생산지시 등록시 상세생산계획 (미지시 -> 지시완료) 수정 
	public int updateNotDirPlanList(PrcsDirVO prcsDirVO);
	
	//생산지시 등록시 자재 출고 (프로시저)
	//public int insertMatOut(@Param("prcsDirDeCode") String prcsDirDeCode,  @Param("empCode") String empCode);
	public int insertMatOut(Map<String, String> map);
	
	//BOM 조회
	public List<BomCodeVO> selectBomList(@Param("prodCode") String prodCode, @Param("prcsDirAmt") Integer prcsDirAmt);
	
	
	//진행공정 모두 공정완료시 생산지시 수정
	public int updateDirPrcsSts(@Param("prcsDirCode") String prcsDirCode);
}
