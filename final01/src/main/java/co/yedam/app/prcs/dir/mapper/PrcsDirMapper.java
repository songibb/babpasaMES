package co.yedam.app.prcs.dir.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import co.yedam.app.common.bom.service.BomCodeVO;
import co.yedam.app.prcs.dir.service.PrcsDirVO;
import co.yedam.app.prcs.plan.service.PrcsPlanVO;

public interface PrcsDirMapper {
	//생산지시 조회
	public List<PrcsDirVO> selectPrcsDirList();
	
	//상세생산지시 조회
	public List<PrcsDirVO> selectPrcsDirDeList(@Param("prcsDirCode") String prcsDirCode);
	
	//생산지시 등록
	public int insertPrcsDir(PrcsDirVO prcsDirVO);
	
	//상세생산지시 등록
	public int insertPrcsDirDe(PrcsDirVO prcsDirVO);
	
	//생산지시 + 상세생산지시 등록
//	public int insertPrcsDir(@Param("prcsDirList") List<PrcsDirVO> prcsDirList);
	
	//생산지시 수정
	//public int updatePrcsDir(PrcsDirVO prcsDirVO);
	
	//생산지시 삭제
	
	
	//미지시 계획 조회
	public List<PrcsPlanVO> selectNotDirPlanList();
	
	//미지시 상세 계획 조회
	public List<PrcsPlanVO> selectNotDirPlanDeList(@Param("prcsPlanCode") String prcsPlanCode);
	
	
	//BOM 조회
	public List<BomCodeVO> selectBomList(@Param("prodCode") String prodCode);
	
	
}
