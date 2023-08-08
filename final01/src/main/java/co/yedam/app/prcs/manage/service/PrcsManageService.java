package co.yedam.app.prcs.manage.service;

import java.util.List;

public interface PrcsManageService {
	
		//공정관리 조회
		public List<PrcsManageVO> getPrcsManageList();
		
		//공정관리 조회 - 검색
		public List<PrcsManageVO> getPrcsManageSearch(PrcsManageVO prcsManageVO);
		
		//공정관리 등록
		//공정관리 수정
		//공정관리 삭제
		
		
		


}
