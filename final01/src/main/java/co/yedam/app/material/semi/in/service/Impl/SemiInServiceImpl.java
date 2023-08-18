package co.yedam.app.material.semi.in.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.common.grid.service.GridVO;
import co.yedam.app.material.semi.in.mapper.SemiInMapper;
import co.yedam.app.material.semi.in.service.SemiInService;
import co.yedam.app.material.semi.in.service.SemiInVO;

@Service
public class SemiInServiceImpl implements SemiInService {
	//전체조회
	@Autowired
	SemiInMapper sim;
	//전체조회
	@Override
	public List<SemiInVO> selectSemiInList() {
		
		return sim.selectSemiInList();
	}
	
	//전체조회 중 검색
	@Override
	public List<SemiInVO> selectSemiInSearch(String productCode, String startDate, String endDate) {
		
		return sim.selectSemiInSearch(productCode, startDate, endDate);
	}
	
	//반제품목록 모달창
	@Override
	public List<SemiInVO> getSemiModal() {
		
		return sim.getSemiModal();
	}
	
	//생산완료된 반제품목록
	@Override
	public List<SemiInVO> selectTestFinishList() {
		
		return sim.selectTestFinishList();
	}
	
	
	//등록, 수정, 삭제
	@Override
	public int modifySemiIn(GridVO<SemiInVO> data) {
		int result = 0;
		
		if(data.getDeletedRows() != null && data.getDeletedRows().size() > 0) {
			for(SemiInVO vo : data.getDeletedRows()) {
				result += sim.deleteSemiIn(vo);				
			}
		}
		if(data.getUpdatedRows() != null && data.getUpdatedRows().size() > 0) {
			for(SemiInVO vo : data.getUpdatedRows()) {
				result += sim.updateSemiIn(vo);
			}
		}
		if(data.getCreatedRows() != null && data.getCreatedRows().size() > 0) {
			for(SemiInVO vo : data.getCreatedRows()) {
				result += sim.insertSemiIn(vo);
			}
		}
		
		return result;
	}

	

}
