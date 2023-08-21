package co.yedam.app.material.rt.mapper;

import java.util.List;

import co.yedam.app.material.rt.service.MatRtVO;
import co.yedam.app.material.rt.service.MatTestVO;
import co.yedam.app.material.search.service.SearchVO;

public interface MatRtMapper {
	//전체조회
	public List<MatRtVO> selectMatRtList();
	
	public List<MatRtVO> selectMatRtSearch(SearchVO vo);
	
	//검수완료 목록
	public List<MatTestVO> selectMatTestFinishList();
	//삭제 행 정보
	public MatTestVO selectDeletedRowsInfo(MatRtVO vo);
	
	//등록
	public int insertMatRtList(MatRtVO vo);
	public int updateMatTestStsY(MatRtVO vo);
	
	//수정
	public int updateMatRtList(MatRtVO vo);
	
	//삭제
	public int deleteMatRtList(MatRtVO vo);
	public int updateMatTestStsN(MatRtVO vo);
}
