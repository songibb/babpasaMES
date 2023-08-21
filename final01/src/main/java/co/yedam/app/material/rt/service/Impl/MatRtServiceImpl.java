package co.yedam.app.material.rt.service.Impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.common.grid.service.GridVO;
import co.yedam.app.material.rt.mapper.MatRtMapper;
import co.yedam.app.material.rt.service.MatRtService;
import co.yedam.app.material.rt.service.MatRtVO;
import co.yedam.app.material.rt.service.MatTestVO;

@Service
public class MatRtServiceImpl implements MatRtService {
	//전체조회
	@Autowired
	MatRtMapper mrm;
	//전체조회
	@Override
	public List<MatRtVO> selectMatRtList() {
		
		return mrm.selectMatRtList();
	}
	@Override
	public List<MatRtVO> selectMatRtSearch(String materialCode, String accountCode, String startDate, String endDate) {
		
		return mrm.selectMatRtSearch(materialCode, accountCode, startDate, endDate);
	}
	
	//검수완료목록
	@Override
	public List<MatTestVO> selectMatTestFinishList() {
		
		return mrm.selectMatTestFinishList();
	}
	
	//등록
	@Override
	public int modifyMatRt(GridVO<MatRtVO> data) {
		int result = 0;
		// TODO Auto-generated method stub
		if(data.getDeletedRows() != null && data.getDeletedRows().size() > 0) {
			for(MatRtVO vo : data.getDeletedRows()) {
				result += mrm.deleteMatRtList(vo);		
				mrm.updateMatTestStsN(vo);
			}
			
		}
		if(data.getUpdatedRows() != null && data.getUpdatedRows().size() > 0) {
			for(MatRtVO vo : data.getUpdatedRows()) {
				result += mrm.updateMatRtList(vo);		
			}
		}
		if(data.getCreatedRows() != null && data.getCreatedRows().size() > 0) {
			for(MatRtVO vo : data.getCreatedRows()) {
				result += mrm.insertMatRtList(vo);
				mrm.updateMatTestStsY(vo);
			}
		}
		
		return result;
		
	}
	
	//삭제 행 정보
	@Override
	public List<MatTestVO> getDeletedRowsInfo(List<MatRtVO> list) {
		List<MatTestVO> testList = new ArrayList<>();
		if(list != null && list.size() > 0) {
			for(MatRtVO vo : list) {
				MatTestVO testVO = mrm.selectDeletedRowsInfo(vo);
				testList.add(testVO);
			}
		}

		return testList;
	}
	

}
