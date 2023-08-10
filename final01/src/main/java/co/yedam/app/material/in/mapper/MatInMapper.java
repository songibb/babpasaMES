package co.yedam.app.material.in.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import co.yedam.app.material.in.service.MatInVO;

public interface MatInMapper {
	//자재 입고 조회
	public List<MatInVO> selectMatInList();
	public List<MatInVO> selectMatInSearch(@Param("materialCode")String materialCode, @Param("accountCode")String accountCode, @Param("startDate")String startDate, @Param("endDate")String endDate);
}
