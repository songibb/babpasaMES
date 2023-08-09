package co.yedam.app.common.act.service;

import java.util.List;

public interface ActCodeService {
	
		//전체조회
		public List<ActCodeVO> selectActCodeList();
		
		//검색조회
		public List<ActCodeVO> searchSelectActCode(String actName);

}
