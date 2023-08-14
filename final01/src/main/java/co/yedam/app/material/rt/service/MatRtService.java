package co.yedam.app.material.rt.service;

import java.util.List;




public interface MatRtService {
	//전체조회
	public List<MatRtVO> selectMatRtList();
	public List<MatRtVO> selectMatRtSearch(String materialCode, String accountCode, String startDate, String endDate);
	
	
	//검수완료 목록
	public List<MatTestVO> selectMatTestFinishList();
		
	//등록
	public int insertMatRtList(List<MatRtVO> rtList);
		
	//수정
	public int updateMatRtList(List<MatRtVO> rtList);
		
	//삭제
	public int deleteMatRtList(List<MatRtVO> rtList);
}
