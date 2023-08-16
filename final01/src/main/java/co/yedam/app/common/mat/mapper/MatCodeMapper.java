package co.yedam.app.common.mat.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import co.yedam.app.common.mat.service.MatCodeVO;

public interface MatCodeMapper {
	
	//전체 자재코드 조회
	public List<MatCodeVO> selectMatCodeList();
	
	public int matCodeInsert(@Param("list") List<MatCodeVO> list);
	
	public int matCodeUpdate(@Param("list2") List<MatCodeVO> list2);
	
	public int matCodeDelete(@Param("list3") List<MatCodeVO> list3);
	
	

}
