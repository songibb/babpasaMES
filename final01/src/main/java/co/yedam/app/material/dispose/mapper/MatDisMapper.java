package co.yedam.app.material.dispose.mapper;

import java.util.List;

import co.yedam.app.material.dispose.service.MatDisVO;
import co.yedam.app.material.in.service.MatInVO;
import co.yedam.app.material.rt.service.MatRtVO;
import co.yedam.app.material.search.service.SearchVO;

public interface MatDisMapper {
	//전체조회
	public List<MatDisVO> selectMatDisList();
	//검색
	public List<MatDisVO> selectMatDisSearch(SearchVO vo);
	
	
	//관리페이지
	//유통기한 만료 자재
	public List<MatInVO> selectOverDateList();
	//반품실패한 자재
	public List<MatRtVO> selectRtFailList();
	
	//등록
	public int insertMatDis(MatDisVO vo);
	//자재 재고 -
	public int updateMatStockAtMatDisIn(MatDisVO vo);
	
	//수정
	public int updateMatDis(MatDisVO vo);
	//자재 재고 수정
	public int updateMatStockAtMatDisUp(MatDisVO vo);
	
	//삭제
	public int deleteMatDis(MatDisVO vo);
	//자재 재고 +
	public int updateMatStockAtMatDisDe(MatDisVO vo);
	
	//삭제한 행 정보(rt)
	public MatRtVO deletedRtInfo(MatDisVO vo);
	
	//삭제한 행 정보(exd)
	public MatInVO deletedExdInfo(MatDisVO vo);
}
