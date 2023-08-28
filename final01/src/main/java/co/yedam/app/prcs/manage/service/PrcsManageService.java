package co.yedam.app.prcs.manage.service;

import java.util.List;

import co.yedam.app.common.grid.service.GridVO;
import co.yedam.app.prcs.plan.service.PrcsSearchVO;

public interface PrcsManageService {
	
	//공정관리 조회
	public List<PrcsManageVO> selectPrcsManageList();
	
	//공정관리 조회 (검색 포함)
	public List<PrcsManageVO> selectPrcsManageList(PrcsSearchVO prcsSearchVO);

	//공정관리 등록, 수정, 삭제
	public int updatePrcsManage(GridVO<PrcsManageVO> data);


}
