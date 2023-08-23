package co.yedam.app.prcs.manage.service;

import java.util.List;

import co.yedam.app.common.grid.service.GridVO;

public interface PrcsManageService {
	
		//공정관리 조회
		public List<PrcsManageVO> selectPrcsManageList();
	
		//공정관리 등록, 수정, 삭제
		public int updatePrcsManage(GridVO<PrcsManageVO> data);


}
