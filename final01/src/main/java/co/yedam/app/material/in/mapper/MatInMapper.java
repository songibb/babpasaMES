package co.yedam.app.material.in.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import co.yedam.app.material.in.service.MatInVO;
import co.yedam.app.material.rt.service.MatTestVO;

public interface MatInMapper {
	//자재 입고 조회
	public List<MatInVO> selectMatInList();
	public List<MatInVO> selectMatInSearch(@Param("materialCode")String materialCode, @Param("accountCode")String accountCode, @Param("startDate")String startDate, @Param("endDate")String endDate);
	
	//검수됐지만 입고안 된 자재들 목록
	public List<MatTestVO> selectMatTestFinishList();
	
	//등록
	public int insertMatIn(MatInVO vo);
	
	//수정
	public int updateMatIn(MatInVO vo);
	
	//삭제
	public int deleteMatIn(MatInVO vo);
}
