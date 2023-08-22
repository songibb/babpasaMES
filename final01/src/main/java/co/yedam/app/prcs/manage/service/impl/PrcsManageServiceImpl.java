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
	public List<PrcsManageVO> selectPrcsManageList() {
		return prcsManageMapper.selectPrcsManageList();
	}

	//공정관리 등록
	@Override
	public int insertPrcsManage(PrcsManageVO prcsManageVO) {
		return prcsManageMapper.insertPrcsManage(prcsManageVO);
	}

	//공정관리 수정
	@Override
	public int updatePrcsManage(PrcsManageVO prcsManageVO) {
		return prcsManageMapper.updatePrcsManage(prcsManageVO);
	}

	//공정관리 삭제
	@Override
	public int deletePrcsManage(String prcsCode) {
		return prcsManageMapper.deletePrcsManage(prcsCode);
	}
	

	

}
