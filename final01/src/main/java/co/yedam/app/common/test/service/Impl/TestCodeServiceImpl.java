package co.yedam.app.common.test.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.common.test.mapper.TestCodeMapper;
import co.yedam.app.common.test.service.TestCodeService;
import co.yedam.app.common.test.service.TestCodeVO;

@Service
public class TestCodeServiceImpl implements TestCodeService {

	@Autowired
	TestCodeMapper testCodeMapper;
	
	@Override
	public List<TestCodeVO> selectTestCodeList() {
		
		return testCodeMapper.selectTestCodeList();
	}

	@Override
	public List<TestCodeVO> searchSelectTestCode(String testName) {
		
		return testCodeMapper.searchSelectTestCode(testName);
	}

}
