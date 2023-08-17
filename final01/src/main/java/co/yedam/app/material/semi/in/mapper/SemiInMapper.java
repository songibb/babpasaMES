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
	
	//등록
	public int insertSemiIn(@Param("inList") List<SemiInVO> inList);
	
	//수정
	public int updateSemiIn(@Param("inList") List<SemiInVO> inList);
	
	//삭제
	public int deleteSemiIn(@Param("inList") List<SemiInVO> inList);
}
