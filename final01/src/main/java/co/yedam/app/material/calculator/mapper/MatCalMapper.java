package co.yedam.app.material.calculator.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import co.yedam.app.material.calculator.service.MatCalVO;
import co.yedam.app.material.in.service.MatInVO;

public interface MatCalMapper {
	//전체조회
	public List<MatCalVO> selectMatCalList();
	
	//검색
	public List<MatCalVO> selectMatCalSearch(@Param("materialCode")String materialCode, 
											@Param("calIn" )String calIn, 
											@Param("calOut")String calOut, 
											@Param("startDate")String startDate, 
											@Param("endDate")String endDate);
	
	//insert
	public int insertMatCal(MatCalVO vo);
	
	public int insertMatInAtMatCal(MatCalVO vo);
	
	
	public int insertMatOutAtMatCal(MatCalVO vo);
	public int updateMatInAtMatCal(MatCalVO vo);
	
	
	public MatInVO findMatLotInfoAtMatCal(MatCalVO vo);
	
	
}
