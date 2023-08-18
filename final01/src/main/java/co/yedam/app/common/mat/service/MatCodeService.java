package co.yedam.app.common.mat.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import co.yedam.app.common.grid.service.GridVO;

public interface MatCodeService {

	//전체 자재코드 조회
	public List<MatCodeVO> selectMatCodeList();
	
	
	//자재코드 추가 수정 삭제
	public int updateMatCode(GridVO<MatCodeVO> data);
	
}
