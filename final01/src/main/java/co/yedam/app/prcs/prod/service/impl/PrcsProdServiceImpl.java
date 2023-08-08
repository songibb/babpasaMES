package co.yedam.app.prcs.prod.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.prcs.prod.mapper.PrcsProdMapper;
import co.yedam.app.prcs.prod.service.PrcsProdService;
import co.yedam.app.prcs.prod.service.PrcsProdVO;

@Service
public class PrcsProdServiceImpl implements PrcsProdService {

	@Autowired
	PrcsProdMapper prcsProdMapper;
	
	//제품별공정 조회
	@Override
	public List<PrcsProdVO> getPrcsProdList() {
		return prcsProdMapper.selectPrcsProdList();
	}


}
