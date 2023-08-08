package co.yedam.app.prcs.plan.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.prcs.plan.mapper.PrcsPlanMapper;
import co.yedam.app.prcs.plan.service.PrcsPlanService;
import co.yedam.app.prcs.plan.service.PrcsPlanVO;

@Service
public class PrcsPlanServiceImpl implements PrcsPlanService {
	
	@Autowired
	PrcsPlanMapper prcsPlanMapper;
	
	//생산계획 조회
	@Override
	public List<PrcsPlanVO> getPrcsPlanList() {
		return prcsPlanMapper.selectPrcsPlanList();
	}
	
	//상세생산계획 조회
	@Override
	public List<PrcsPlanVO> getPrcsPlanDeList() {
		return prcsPlanMapper.selectPrcsPlanDeList();
	}
	

}
