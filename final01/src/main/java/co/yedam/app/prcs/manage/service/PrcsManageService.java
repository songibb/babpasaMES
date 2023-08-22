package co.yedam.app.prcs.manage.service;

import java.util.List;

public interface PrcsManageService {
	
		//공정관리 조회
		public List<PrcsManageVO> selectPrcsManageList();
	
		//공정관리 등록
		public int insertPrcsManage(PrcsManageVO prcsManageVO);
		
		//공정관리 수정
		public int updatePrcsManage(PrcsManageVO prcsManageVO);
		
		//공정관리 삭제
		public int deletePrcsManage(String prcsCode);
		
		


}
