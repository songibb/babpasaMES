package co.yedam.app.quality.mat.service;

import java.util.List;

import co.yedam.app.common.grid.service.GridVO;

public interface MatChkService {

	//전체조회
	public List<MatChkVO> selectMatChkList();
	
	//자재 상세 검수 조회 (모달)
	public List<MatChkVO> selectNotChkMatList();
	
	//등록,수정,삭제
	public int modifyMatChk(GridVO<MatChkVO> data);
}
