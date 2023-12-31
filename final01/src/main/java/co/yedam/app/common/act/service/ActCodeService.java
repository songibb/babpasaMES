package co.yedam.app.common.act.service;

import java.util.List;
import java.util.Map;

public interface ActCodeService {
	
		//거래처전체조회
		public List<ActCodeVO> selectActCodeList();
		
		//검색조회
		public List<ActCodeVO> searchSelectActCode(ActCodeVO actCodeVO);
		
		//거래처 등록
		public Map<String, String> insertActInfo(ActCodeVO actCodeVO);
		
		//거래처 수정
		public Map<String, String> updateActInfo(ActCodeVO actCodeVO);
		
		//거래처 삭제
		public List<String> deleteActInfo(List<ActCodeVO> checkedAct);

}
