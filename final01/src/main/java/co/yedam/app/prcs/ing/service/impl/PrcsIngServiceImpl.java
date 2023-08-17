package co.yedam.app.prcs.ing.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.prcs.ing.mapper.PrcsIngMapper;
import co.yedam.app.prcs.ing.service.PrcsIngService;
import co.yedam.app.prcs.ing.service.PrcsIngVO;

@Service
public class PrcsIngServiceImpl implements PrcsIngService {
	
	@Autowired
	PrcsIngMapper prcsIngMapper;

	//진행 공정 조회
	@Override
	public List<PrcsIngVO> getPrcsIngList(String prcsDirDeCode, String prodCode) {
		return prcsIngMapper.selectPrcsIngList(prcsDirDeCode, prodCode);
	}
	
	
	//진행 공정 등록
	@Override
	public Map<String, Object> insertPrcsIng(Map<String, Object> param) {
		prcsIngMapper.insertPrcsIng(param);
        return param;
	}
}
