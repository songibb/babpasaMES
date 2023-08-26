package co.yedam.app.prcs.dir.service.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.common.bom.service.BomCodeVO;
import co.yedam.app.prcs.dir.mapper.PrcsDirMapper;
import co.yedam.app.prcs.dir.service.PrcsDirService;
import co.yedam.app.prcs.dir.service.PrcsDirVO;
import co.yedam.app.prcs.ing.mapper.PrcsIngMapper;
import co.yedam.app.prcs.plan.service.PrcsPlanVO;
import co.yedam.app.prcs.plan.service.PrcsSearchVO;

@Service
public class PrcsDirServiceImpl implements PrcsDirService {

	@Autowired
	PrcsDirMapper prcsDirMapper;
	
	@Autowired
	PrcsIngMapper prcsIngMapper;
	
	//생산지시 조회
	@Override
	public List<PrcsDirVO> selectPrcsDirList(PrcsSearchVO prcsSearchVO) {
		return prcsDirMapper.selectPrcsDirList(prcsSearchVO);
	}
	
	//상세생산지시 조회
	@Override
	public List<PrcsDirVO> selectPrcsDirDeList(String prcsDirCode) {
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
			String empCode = vo.getEmpCode();
			
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("prcsDirDeCode", prcsDirDeCode);
			map.put("empCode", empCode);
			
			//진행공정 등록 (프로시저)
			prcsIngMapper.insertPrcsIng(prcsDirDeCode);
			
			//생산지시 등록시 자재 출고 (프로시저)
			prcsDirMapper.insertMatOut(map);
			
			result++;
		}
				
		return result;
	}


	//미지시 생산계획 목록 조회 
	@Override
	public List<PrcsPlanVO> selectNotDirPlanList() {
		return prcsDirMapper.selectNotDirPlanList();
	}
	
	
	//BOM 조회
	@Override
	public List<BomCodeVO> selectBomList(String prodCode, Integer prcsDirAmt) {
		return prcsDirMapper.selectBomList(prodCode, prcsDirAmt);
	}

	//진행공정 모두 공정완료시 생산지시 수정
	@Override
	public int updateDirPrcsSts(List<PrcsDirVO> dirList) {
		int result = 0;
		for(PrcsDirVO vo : dirList) {
			prcsDirMapper.updateDirPrcsSts(vo.getPrcsDirCode());
			result++;
		}
		return result;
	}

	
	//재지시 등록 (상세생산지시)
	@Override
	public int insertReDirDe(List<PrcsDirVO> reDirList) {
		int result = 0;
		for(PrcsDirVO vo : reDirList) {
			//insert할때는 prcsDirDeCode에 selectKey 사용하므로 
			//vo에 담겨져온 기존 prcsDirDeCode를 이용해서 update먼저 해야함

			//재지시 등록시 해당 상세생산지시 재지시여부 'Y'로 수정
			prcsDirMapper.updateReDirDe(vo);
			
			//재지시 등록
			prcsDirMapper.insertReDirDe(vo);
			
			String prcsDirDeCode = vo.getPrcsDirDeCode();
			String empCode = vo.getEmpCode();
			
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("prcsDirDeCode", prcsDirDeCode);
			map.put("empCode", empCode);
			
			//진행공정 등록 (프로시저)
			prcsIngMapper.insertPrcsIng(prcsDirDeCode);
			
			//생산지시 등록시 자재 출고 (프로시저)
			prcsDirMapper.insertMatOut(map);
			
			result++;		
		}
		return result;
	}
	

}
