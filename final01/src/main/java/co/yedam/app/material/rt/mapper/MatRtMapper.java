package co.yedam.app.material.rt.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import co.yedam.app.material.rt.service.MatRtVO;
import co.yedam.app.material.rt.service.MatTestVO;

public interface MatRtMapper {
	//전체조회
	public List<MatRtVO> selectMatRtList();
	
	public List<MatRtVO> selectMatRtSearch(@Param("materialCode")String materialCode, @Param("accountCode")String accountCode, @Param("startDate")String startDate, @Param("endDate")String endDate);
	
	//검수완료 목록
	public List<MatTestVO> selectMatTestFinishList();
	
	//등록
	public int insertMatRtList(@Param("data") List<MatRtVO> data);
	
	//수정
	public int updateMatRtList(@Param("data") List<MatRtVO> data);
	
	//삭제
	public int deleteMatRtList(@Param("data") List<MatRtVO> data);
}
