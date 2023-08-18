package co.yedam.app.prcs.dir.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.common.bom.service.BomCodeVO;
import co.yedam.app.prcs.dir.mapper.PrcsDirMapper;
import co.yedam.app.prcs.dir.service.PrcsDirService;
import co.yedam.app.prcs.dir.service.PrcsDirVO;
import co.yedam.app.prcs.ing.mapper.PrcsIngMapper;
import co.yedam.app.prcs.plan.service.PrcsPlanVO;

@Service
public class PrcsDirServiceImpl implements PrcsDirService {

	@Autowired
	PrcsDirMapper prcsDirMapper;
	
	@Autowired
	PrcsIngMapper prcsIngMapper;
	
	//생산지시 조회
	@Override
	public List<PrcsDirVO> getPrcsDirList() {
		return prcsDirMapper.selectPrcsDirList();
	}
	
	//상세생산지시 조회
	@Override
	public List<PrcsDirVO> getPrcsDirDeList(String prcsDirCode) {
		return prcsDirMapper.selectPrcsDirDeList(prcsDirCode);
	}
	
	//생산지시 등록
	@Override
	public String insertPrcsDir(PrcsDirVO prcsDirVO) {
		//selectKey 값 가져오기
		int result = prcsDirMapper.insertPrcsDir(prcsDirVO);
		String prcsDirCode = String.valueOf(prcsDirVO.getPrcsDirCode());
		if(result > 0) {
			return prcsDirCode;
		} else {
			return "실패";
		}
	}
	
	//상세생산지시 등록
	@Override
	public int insertPrcsDirDe(List<PrcsDirVO> list) {
		int result = 0;
		for(PrcsDirVO vo : list) {
			prcsDirMapper.insertPrcsDirDe(vo);
			
			//생산지시 등록시 상세생산계획 (미지시 -> 지시완료) 수정 
			prcsDirMapper.updateNotDirPlanList(vo);

			String prcsDirDeCode = vo.getPrcsDirDeCode();	
			
			//진행 공정 등록
			prcsIngMapper.insertPrcsIng(prcsDirDeCode);
			
			//생산지시 등록시 자재 출고
			prcsDirMapper.insertMatOut(prcsDirDeCode);
			
			result++;
		}
				
		return result;
	}
	

	//미지시 생산계획 목록 조회 
	@Override
	public List<PrcsPlanVO> getNotDirPlanList() {
		return prcsDirMapper.selectNotDirPlanList();
	}
	
	
	//BOM 조회
	@Override
	public List<BomCodeVO> getBomList(String prodCode, Integer prcsDirAmt) {
		return prcsDirMapper.selectBomList(prodCode, prcsDirAmt);
	}
	

}
