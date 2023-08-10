package co.yedam.app.common.err.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.common.err.mapper.ErrCodeMapper;
import co.yedam.app.common.err.service.ErrCodeService;
import co.yedam.app.common.err.service.ErrCodeVO;

@Service
public class ErrCodeServiceImpl implements ErrCodeService {
	
	@Autowired
	ErrCodeMapper errCodeMapper;
	
	@Override
	public List<ErrCodeVO> selectErrCodeList() {
		
		return errCodeMapper.selectErrCodeList();
	}

	@Override
	public List<ErrCodeVO> searchSelectErrCode(String errName) {
		
		return errCodeMapper.searchSelectErrCode(errName);
	}

}
