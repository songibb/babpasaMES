package co.yedam.app.material.in.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.common.grid.service.GridVO;
import co.yedam.app.material.in.mapper.MatInMapper;
import co.yedam.app.material.in.service.MatInService;
import co.yedam.app.material.in.service.MatInVO;
import co.yedam.app.material.rt.service.MatTestVO;

@Service
public class MatInServiceImpl implements MatInService {
	//조회
	@Autowired
	MatInMapper mim;
	
	//조회
	@Override
	public List<MatInVO> selectMatInList() {
		
		return mim.selectMatInList();
	}
	
	//조회페이지에서 검색
	@Override
	public List<MatInVO> selectMatInSearch(String materialCode, String accountCode, String startDate, String endDate) {
		// TODO Auto-generated method stub
		return mim.selectMatInSearch(materialCode, accountCode, startDate, endDate);
	}
	
	//검수됐지만 입고안 된 자재들 목록
	@Override
	public List<MatTestVO> selectMatTestFinishList() {
		// TODO Auto-generated method stub
		return mim.selectMatTestFinishList();
	}
	
	//등록, 수정, 삭제
	@Override
	public int modifyMatIn(GridVO<MatInVO> data) {
		int result = 0;
		// TODO Auto-generated method stub
		if(data.getDeletedRows() != null && data.getDeletedRows().size() > 0) {
			for(MatInVO vo : data.getDeletedRows()) {
				result += mim.deleteMatIn(vo);				
			}
		}
		if(data.getUpdatedRows() != null && data.getUpdatedRows().size() > 0) {
			for(MatInVO vo : data.getUpdatedRows()) {
				result += mim.updateMatIn(vo);				
			}
		}
		if(data.getCreatedRows() != null && data.getCreatedRows().size() > 0) {
			for(MatInVO vo : data.getCreatedRows()) {
				result += mim.insertMatIn(vo);				
			}
		}
		
		return result;
		
	}


}
