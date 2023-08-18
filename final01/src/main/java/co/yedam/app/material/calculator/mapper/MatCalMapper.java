package co.yedam.app.material.calculator.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import co.yedam.app.material.calculator.service.MatCalVO;

public interface MatCalMapper {
	//전체조회
	public List<MatCalVO> selectMatCalList();
	
	//검색
	public List<MatCalVO> selectMatCalSearch(@Param("materialCode")String materialCode, 
											@Param("calIn" )String calIn, 
											@Param("calOut")String calOut, 
											@Param("startDate")String startDate, 
											@Param("endDate")String endDate);
}
