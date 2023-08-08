package co.yedam.app.prcs.manage.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.prcs.manage.mapper.PrcsManageMapper;
import co.yedam.app.prcs.manage.service.PrcsManageService;
import co.yedam.app.prcs.manage.service.PrcsManageVO;

@Service
public class PrcsManageServiceImpl implements PrcsManageService {

	@Autowired
	PrcsManageMapper prcsManageMapper;
	
	//공정관리 조회
	@Override
	public List<PrcsManageVO> getPrcsManageList() {
		return prcsManageMapper.selectPrcsManageList();
	}

	//공정관리 조회 - 검색
	@Override
	public List<PrcsManageVO> getPrcsManageSearch(PrcsManageVO prcsManageVO) {
		return prcsManageMapper.selectPrcsManageSearch(prcsManageVO);
	}
	

	

}
