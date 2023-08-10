package co.yedam.app.material.rt.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import co.yedam.app.material.rt.service.MatRtVO;

public interface MatRtMapper {
	//전체조회
	public List<MatRtVO> selectMatRtList();
	
	public List<MatRtVO> selectMatRtSearch(@Param("materialCode")String materialCode, @Param("accountCode")String accountCode, @Param("startDate")String startDate, @Param("endDate")String endDate);
}