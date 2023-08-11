package co.yedam.app.prcs.dir.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.prcs.dir.mapper.PrcsDirMapper;
import co.yedam.app.prcs.dir.service.PrcsDirService;
import co.yedam.app.prcs.dir.service.PrcsDirVO;

@Service
public class PrcsDirServiceImpl implements PrcsDirService {

	@Autowired
	PrcsDirMapper prcsDirMapper;
	
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
	public int insertPrcsDirDe(PrcsDirVO prcsDirVO) {
		int result = prcsDirMapper.insertPrcsDirDe(prcsDirVO);
		if(result > 0) {
			return 1;
		} else {
			return -1;
		}
		
	}

}
