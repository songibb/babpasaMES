package co.yedam.app.prcs.dir.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import co.yedam.app.prcs.dir.service.PrcsDirVO;

public interface PrcsDirMapper {
	//생산지시 조회
	public List<PrcsDirVO> selectPrcsDirList();
	
	
	//상세생산지시 조회
	public List<PrcsDirVO> selectPrcsDirDeList(@Param("prcsDirCode") String prcsDirCode);
}
