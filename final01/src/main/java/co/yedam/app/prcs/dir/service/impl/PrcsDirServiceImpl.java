package co.yedam.app.prcs.dir.service.impl;

import java.util.List;

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

}
