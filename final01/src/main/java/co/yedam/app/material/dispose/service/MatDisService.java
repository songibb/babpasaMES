package co.yedam.app.material.dispose.service;

import java.util.List;

import co.yedam.app.common.grid.service.GridVO;
import co.yedam.app.material.in.service.MatInVO;
import co.yedam.app.material.rt.service.MatRtVO;
import co.yedam.app.material.search.service.SearchVO;

public interface MatDisService {
		//전체조회
		public List<MatDisVO> getMatDisList();
		//검색
		public List<MatDisVO> getMatDisSearch(SearchVO vo);
		
		
		//관리페이지
		//유통기한 만료 자재
		public List<MatInVO> getOverDateList();
		//반품실패한 자재
		public List<MatRtVO> getRtFailList();
		
		
		
		//등록, 수정, 삭제
		public int modifyMatDis(GridVO<MatDisVO> data);
		
}
