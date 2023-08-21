package co.yedam.app.quality.semi.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.common.grid.service.GridVO;
import co.yedam.app.quality.semi.mapper.SemiChkMapper;
import co.yedam.app.quality.semi.service.SemiChkService;
import co.yedam.app.quality.semi.service.SemiChkVO;

@Service
public class SemiChkServiceImpl implements SemiChkService {

	@Autowired
	SemiChkMapper semiChkMapper;
	
	@Override
	public List<SemiChkVO> selectPrcsIng() {
		// TODO Auto-generated method stub
		return semiChkMapper.selectPrcsIng();
	}
	
	@Override
	public List<SemiChkVO> selectSemiChkList(String testNum){
		return semiChkMapper.selectSemiChkList(testNum);
	}
	
	@Override
	public int SemiChkUpdate(GridVO<SemiChkVO> data) {
		int result = 0;
		
		if(data.getUpdatedRows() != null && data.getUpdatedRows().size() >0) {
			for(SemiChkVO vo : data.getUpdatedRows()) {
				
				result += semiChkMapper.SemiChkUpdate(vo);
				}
			}
		return result;
			
		}
	}
	 

