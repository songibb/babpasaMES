package co.yedam.app.material.in.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.material.in.mapper.MatInMapper;
import co.yedam.app.material.in.service.MatInService;
import co.yedam.app.material.in.service.MatInVO;
import co.yedam.app.material.rt.service.MatTestVO;

@Service
public class MatInServiceImpl implements MatInService {
	//조회
	@Autowired
	MatInMapper mim;
	
	//조회
	@Override
	public List<MatInVO> selectMatInList() {
		
		return mim.selectMatInList();
	}
	
	//조회페이지에서 검색
	@Override
	public List<MatInVO> selectMatInSearch(String materialCode, String accountCode, String startDate, String endDate) {
		// TODO Auto-generated method stub
		return mim.selectMatInSearch(materialCode, accountCode, startDate, endDate);
	}
	
	//검수됐지만 입고안 된 자재들 목록
	@Override
	public List<MatTestVO> selectMatTestFinishList() {
		// TODO Auto-generated method stub
		return mim.selectMatTestFinishList();
	}

	@Override
	public int insertMatIn(List<MatInVO> inList) {
		// TODO Auto-generated method stub
		return mim.insertMatIn(inList);
	}

	@Override
	public int updateMatIn(List<MatInVO> inList) {
		// TODO Auto-generated method stub
		return mim.updateMatIn(inList);
	}

	@Override
	public int deleteMatIn(List<MatInVO> inList) {
		// TODO Auto-generated method stub
		return mim.deleteMatIn(inList);
	}

}
