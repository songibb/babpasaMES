package co.yedam.app.quality.semi.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.common.grid.service.GridVO;
import co.yedam.app.quality.semi.mapper.SemiChkMapper;
import co.yedam.app.quality.semi.service.SemiChkReqVO;
import co.yedam.app.quality.semi.service.SemiChkService;
import co.yedam.app.quality.semi.service.SemiChkVO;

@Service
public class SemiChkServiceImpl implements SemiChkService {

	@Autowired
	SemiChkMapper semiChkMapper;
	
	//검사 페이지 - 공정 조회
	@Override
	public List<SemiChkVO> selectPrcsIng() {
		// TODO Auto-generated method stub
		return semiChkMapper.selectPrcsIng();
	}
	
	// 조회 페이지 - 모든 공정 조회
	@Override
	public List<SemiChkVO> selectAllPrcsIng() {
		// TODO Auto-generated method stub
		return semiChkMapper.selectAllPrcsIng();
	}
	
	//testNum 클릭 시 상세 그리드 넘어가기
	@Override
	public List<SemiChkVO> selectSemiChkList(String testNum){
		return semiChkMapper.selectSemiChkList(testNum);
	}
	
	@Override
	public int SemiChkUpdate(SemiChkReqVO semiChkReqVO) {
		int result = 0;
		System.out.println(semiChkReqVO);
//		if(data.getUpdatedRows() != null && data.getUpdatedRows().size() >0) {
//			for(SemiChkVO vo : data.getUpdatedRows()) {
//				
//				result += semiChkMapper.SemiChkUpdate(vo);
//				}
//			semiChkMapper.SemiChkUpdatePr(vo);
//			}
		
		for(SemiChkVO vo : semiChkReqVO.getSemiList()) {
			result += semiChkMapper.SemiChkUpdate(vo);
		}
		
		semiChkMapper.SemiChkUpdatePr(semiChkReqVO.getSemiChkVO());
		
		return result;
			
		}
	}
	 

