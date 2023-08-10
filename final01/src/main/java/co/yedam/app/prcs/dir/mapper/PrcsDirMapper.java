package co.yedam.app.prcs.dir.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import co.yedam.app.prcs.dir.service.PrcsDirVO;

public interface PrcsDirMapper {
	//생산지시 조회
	public List<PrcsDirVO> selectPrcsDirList();
	
	//상세생산지시 조회
	public List<PrcsDirVO> selectPrcsDirDeList(@Param("prcsDirCode") String prcsDirCode);
	
	//생산지시 등록
	public int insertPrcsDir(PrcsDirVO prcsDirVO);
	
	//상세생산지시 등록
	public int insertPrcsDirDe(PrcsDirVO prcsDirVO);
	
	//생산지시 수정
	public int updatePrcsDir(PrcsDirVO prcsDirVO);
	
	//생산지시 삭제

}
