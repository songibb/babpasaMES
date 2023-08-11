package co.yedam.app.common.comm.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.common.comm.mapper.CommCodeMapper;
import co.yedam.app.common.comm.service.CommCodeService;
import co.yedam.app.common.comm.service.CommCodeVO;

@Service
public class CommCodeServiceImpl implements CommCodeService {

	@Autowired
	CommCodeMapper commCodeMapper;
	@Override
	public List<CommCodeVO> selectCommCodeList() {
		
		return commCodeMapper.selectCommCodeList();
	}

	@Override
	public List<CommCodeVO> selectCommDeCodeList() {
		
		return commCodeMapper.selectCommDeCodeList();
	}

	@Override
	public List<CommCodeVO> selectActTypeList() {
		
		return commCodeMapper.selectActTypeList();
	}

}
