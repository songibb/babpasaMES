package co.yedam.app.material.semi.in.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import co.yedam.app.material.semi.in.service.SemiInVO;

public interface SemiInMapper {
	//전체조회
	public List<SemiInVO> selectSemiInList();
	public List<SemiInVO> selectSemiInSearch(@Param("productCode")String productCode, @Param("startDate")String startDate, @Param("endDate")String endDate);
	
	//반제품 목록 모달창
	public List<SemiInVO> getSemiModal(); 
	
	//생산완료된 반제품 목록
	public List<SemiInVO> selectTestFinishList();
	
	//삭제된 행 정보
	public SemiInVO selectDeleteRowsInfo(SemiInVO vo);
	
	//등록
	public int insertSemiIn(SemiInVO vo);
	
	//수정
	public int updateSemiIn(SemiInVO vo);
	
	//삭제
	public int deleteSemiIn(SemiInVO vo);
	
	public int prcsIngStsUpdateAtSemiIn(SemiInVO vo);
}
