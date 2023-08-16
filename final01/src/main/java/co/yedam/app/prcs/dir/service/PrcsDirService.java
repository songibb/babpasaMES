package co.yedam.app.prcs.dir.service;

import java.util.List;


import co.yedam.app.common.bom.service.BomCodeVO;
import co.yedam.app.prcs.plan.service.PrcsPlanVO;



public interface PrcsDirService {
	//생산지시 조회
	public List<PrcsDirVO> getPrcsDirList();
	
	//상세생산지시 조회
	public List<PrcsDirVO> getPrcsDirDeList(String prcsDirCode);
	
	//생산지시 등록
	public String insertPrcsDir(PrcsDirVO prcsDirVo);
	
	//상세생산지시 등록
	public int insertPrcsDirDe(PrcsDirVO prcsDirVO);
	
	//생산지시 + 상세생산지시 등록
//	public int insertPrcsDir(List<PrcsDirVO> prcsDirList);
	
	
	//미지시 생산계획 목록 조회 
	public List<PrcsPlanVO> getNotDirPlanList();
	
	
	//BOM 조회
	public List<BomCodeVO> getBomList(String prodCode);
		
	
	
}
