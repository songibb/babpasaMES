package co.yedam.app.prcs.prod.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.common.grid.service.GridVO;
import co.yedam.app.prcs.plan.service.PrcsSearchVO;
import co.yedam.app.prcs.prod.mapper.PrcsProdMapper;
import co.yedam.app.prcs.prod.service.PrcsProdReqVO;
import co.yedam.app.prcs.prod.service.PrcsProdService;
import co.yedam.app.prcs.prod.service.PrcsProdVO;

@Service
public class PrcsProdServiceImpl implements PrcsProdService {

	@Autowired
	PrcsProdMapper prcsProdMapper;
	
	//제품별공정 조회
	@Override
	public List<PrcsProdVO> selectPrcsProdList(String prodCode) {
		return prcsProdMapper.selectPrcsProdList(prodCode);
	}
	
	//제품 목록 조회
	@Override
	public List<PrcsProdVO> selectProdList(PrcsSearchVO prcsSearchVO) {
		return prcsProdMapper.selectProdList(prcsSearchVO);
	}
	
	//제품별공정 등록, 수정, 삭제
	@Override
	public int updatePrcsProd(PrcsProdReqVO prcsProdReqVO) {
		int result = 0;
		
		GridVO<PrcsProdVO> data = prcsProdReqVO.getGridVO();

		if(data.getCreatedRows() != null && data.getCreatedRows().size()>0) {
			for(PrcsProdVO vo : data.getCreatedRows()) {
				//prodCode는 한 그리드에서 담아올 수 없어서 PrcsProdReqVO에 따로 담아서 가져옴
				String prodCode = prcsProdReqVO.getProdCode();
				vo.setProdCode(prodCode);
				result += prcsProdMapper.insertPrcsProd(vo);
			}
		}	
			
		if(data.getUpdatedRows() != null && data.getUpdatedRows().size() >0) {
			for(PrcsProdVO vo : data.getUpdatedRows()) {			
				result += prcsProdMapper.updatePrcsProd(vo);
			}
		}	
		
		if(data.getDeletedRows()!= null && data.getDeletedRows().size()>0) {
			for(PrcsProdVO vo : data.getDeletedRows()){						
				result += prcsProdMapper.deletePrcsProd(vo);
			}
		}

		return result;
	}


}
