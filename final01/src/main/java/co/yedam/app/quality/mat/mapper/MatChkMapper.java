package co.yedam.app.quality.mat.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import co.yedam.app.quality.mat.service.MatChkVO;

public interface MatChkMapper {
	
	//전체조회
	public List<MatChkVO> selectMatChkLIst();
	
	//자재 발주 조회(모달)
	public List<MatChkVO> selectNotChkMatList();
	
	//등록
	public int insertMatChk(MatChkVO vo);
	
	//수정
	public int updateMatChk(MatChkVO vo);
	
	//삭제
	public int deleteMatChk(MatChkVO vo);
}
