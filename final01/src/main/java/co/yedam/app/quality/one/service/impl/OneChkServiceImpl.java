package co.yedam.app.quality.one.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.common.grid.service.GridVO;
import co.yedam.app.quality.one.mapper.OneChkMapper;
import co.yedam.app.quality.one.service.OneChkReqVO;
import co.yedam.app.quality.one.service.OneChkService;
import co.yedam.app.quality.one.service.OneChkVO;
import co.yedam.app.quality.semi.service.SemiChkVO;

@Service
public class OneChkServiceImpl implements OneChkService {

	@Autowired
	OneChkMapper oneChkMapper;
	
	//검사 페이지 - 마지막 공정 조회
	@Override
	public List<OneChkVO> selectLastPrcs() {
		// TODO Auto-generated method stub
		return oneChkMapper.selectLastPrcs();
	}

	//조회페이지 - 모든 마지막 공정 조회
	@Override
	public List<OneChkVO> selectAllLastPrcs(){
		return oneChkMapper.selectAllLastPrcs();
	}
	
	// testNum 클릭 시 상세 그리드 넘어가기
	@Override
	public List<OneChkVO> selectOneChkList(String testNum) {
		// TODO Auto-generated method stub
		return oneChkMapper.selectOneChkList(testNum);
	}
	
	
	//검사페이지 - 등록(수정)
	@Override
	public int OneChkUpdate(OneChkReqVO oneChkReqVO) {
		int result = 0;
		
		System.out.println(oneChkReqVO);
		
		for(OneChkVO vo : oneChkReqVO.getOneList()) {
			result += oneChkMapper.OneChkUpdate(vo);
		}
		
		oneChkMapper.OneChkUpdatePr(oneChkReqVO.getOneChkVO());
		
		return result;
	}

}
