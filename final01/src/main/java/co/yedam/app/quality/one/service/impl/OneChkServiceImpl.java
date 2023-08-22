package co.yedam.app.quality.one.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.common.grid.service.GridVO;
import co.yedam.app.quality.one.mapper.OneChkMapper;
import co.yedam.app.quality.one.service.OneChkService;
import co.yedam.app.quality.one.service.OneChkVO;
import co.yedam.app.quality.semi.service.SemiChkVO;

@Service
public class OneChkServiceImpl implements OneChkService {

	@Autowired
	OneChkMapper oneChkMapper;
	
	@Override
	public List<OneChkVO> selectLastPrcs() {
		// TODO Auto-generated method stub
		return oneChkMapper.selectLastPrcs();
	}

	@Override
	public List<OneChkVO> selectOneChkList(String testNum) {
		// TODO Auto-generated method stub
		return oneChkMapper.selectOneChkList(testNum);
	}

	@Override
	public int OneChkUpdate(GridVO<OneChkVO> data) {
		int result = 0;
		
		if(data.getUpdatedRows() != null && data.getUpdatedRows().size() >0) {
			for(OneChkVO vo : data.getUpdatedRows()) {
				
				result += oneChkMapper.OneChkUpdate(vo);
				}
			}
		return result;
	}

}
