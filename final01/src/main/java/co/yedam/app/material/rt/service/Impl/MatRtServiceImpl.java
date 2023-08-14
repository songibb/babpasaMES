package co.yedam.app.material.rt.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.material.rt.mapper.MatRtMapper;
import co.yedam.app.material.rt.service.MatRtService;
import co.yedam.app.material.rt.service.MatRtVO;
import co.yedam.app.material.rt.service.MatTestVO;

@Service
public class MatRtServiceImpl implements MatRtService {
	//전체조회
	@Autowired
	MatRtMapper mrm;
	//전체조회
	@Override
	public List<MatRtVO> selectMatRtList() {
		
		return mrm.selectMatRtList();
	}
	@Override
	public List<MatRtVO> selectMatRtSearch(String materialCode, String accountCode, String startDate, String endDate) {
		
		return mrm.selectMatRtSearch(materialCode, accountCode, startDate, endDate);
	}
	
	//검수완료목록
	@Override
	public List<MatTestVO> selectMatTestFinishList() {
		
		return mrm.selectMatTestFinishList();
	}
	
	//등록
	@Override
	public int insertMatRtList(List<MatRtVO> rtList) {
		
		return mrm.insertMatRtList(rtList);
	}
	
	//수정
	@Override
	public int updateMatRtList(List<MatRtVO> rtList) {
		
		return mrm.updateMatRtList(rtList);
	}
	
	//삭제
	@Override
	public int deleteMatRtList(List<MatRtVO> rtList) {
		
		return mrm.deleteMatRtList(rtList);
	}

}
