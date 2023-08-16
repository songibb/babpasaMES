package co.yedam.app.common.mat.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.common.mat.mapper.MatCodeMapper;
import co.yedam.app.common.mat.service.MatCodeService;
import co.yedam.app.common.mat.service.MatCodeVO;

@Service
public class MatCodeServiceImpl implements MatCodeService {

	
	@Autowired
	MatCodeMapper matCodeMapper;
	@Override
	public List<MatCodeVO> selectMatCodeList() {
		
		return matCodeMapper.selectMatCodeList();
	}
	@Override
	public int matCodeInsert(List<MatCodeVO> list) {
		
		return matCodeMapper.matCodeInsert(list);

	}
	@Override
	public int matCodeUpdate(List<MatCodeVO> list2) {
		
		return matCodeMapper.matCodeUpdate(list2);
	}
	@Override
	public int matCodeDelete(List<MatCodeVO> list3) {
		
		return matCodeMapper.matCodeDelete(list3);
	}

}
