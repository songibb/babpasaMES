package co.yedam.app.common.mat.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import co.yedam.app.common.mat.service.MatCodeVO;

public interface MatCodeMapper {
	
	//전체 자재코드 조회
	public List<MatCodeVO> selectMatCodeList();
	
	//자재코드 추가
	public int matCodeInsert(MatCodeVO vo);
	
	//자재코드 수정
	public int matCodeUpdate(MatCodeVO vo);
	
	//자재코드 삭제
	public int matCodeDelete(MatCodeVO vo);
	
	

}
