package co.yedam.app.prcs.dir.service;

import java.util.List;
import co.yedam.app.common.bom.service.BomCodeVO;
import co.yedam.app.prcs.plan.service.PrcsPlanVO;
import co.yedam.app.prcs.plan.service.PrcsSearchVO;



public interface PrcsDirService {
	//생산지시 조회 (아직 생산 완료 되지 않은 지시)
	public List<PrcsDirVO> selectPrcsDirList(PrcsSearchVO prcsSearchVO);
	
	//생산지시 조회 (생산 완료된 지시)
	public List<PrcsDirVO> selectPrcsEndDirList(PrcsSearchVO prcsSearchVO);
	
	//상세생산지시 조회
	public List<PrcsDirVO> selectPrcsDirDeList(String prcsDirCode);
	
	//생산지시 등록
	//public String insertPrcsDir(PrcsDirVO prcsDirVo);
	public int insertPrcsDir(PrcsDirReqVO prcsDirReqVo);
	
	//상세생산지시 등록
	//public int insertPrcsDirDe(List<PrcsDirVO> list);
	
	
	//미지시 생산계획 조회 
	public List<PrcsPlanVO> selectNotDirPlanList(PrcsSearchVO prcsSearchVO);
	
	//미지시 상세생산계획 조회
	public List<PrcsPlanVO> selectNotDirPlanDeList(String prcsPlanCode);
	
	//생산지시 등록시 상세생산계획 (미지시 -> 지시완료) 수정 
	//public int updateNotDirPlanList(PrcsDirVO prcsDirVO);
	
	//BOM 조회
	public List<BomCodeVO> selectBomList(String prodCode, Integer prcsDirAmt);
		
	
	//진행공정 모두 공정완료시 생산지시 수정
	public int updateDirPrcsSts(List<PrcsDirVO> dirList);
	
	
	//재지시 등록 - 완제품 (상세생산지시)
	public int insertReDirDe(List<PrcsDirVO> reDirList);
	
	//재지시 등록 - 반제품 (상세생산지시)
	public int insertReDirDeSemi(PrcsDirVO prcsDirVO);
	
}
