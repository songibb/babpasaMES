package co.yedam.app.prcs.prod.mapper;

import java.util.List;

import co.yedam.app.prcs.manage.service.PrcsManageVO;
import co.yedam.app.prcs.prod.service.PrcsProdVO;

public interface PrcsProdMapper {
	//제품별공정 조회
	public List<PrcsProdVO> selectPrcsProdList();
	
	//제품별공정 등록
	//제품별공정 수정
	//제품별공정 삭제
}
