package co.yedam.app.prcs.manage.mapper;

import java.util.List;

import co.yedam.app.prcs.manage.service.PrcsManageVO;

public interface PrcsManageMapper {
	
	//공정관리 조회
	public List<PrcsManageVO> selectPrcsManageList();
	
	//공정관리 조회 - 검색
	public List<PrcsManageVO> selectPrcsManageSearch(PrcsManageVO prcsManageVO);
	
	//공정관리 등록
	public int insertPrcsManage(PrcsManageVO prcsManageVO);
	
	//공정관리 수정
	public int updatePrcsManage(PrcsManageVO prcsManageVO);
	
	//공정관리 삭제
	
	
	
	
	

}
