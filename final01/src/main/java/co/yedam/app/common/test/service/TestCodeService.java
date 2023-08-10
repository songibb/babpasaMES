package co.yedam.app.common.test.service;

import java.util.List;

public interface TestCodeService {
	
	//전체조회
	public List<TestCodeVO> selectTestCodeList();
		
	//테스트명 조회
	public List<TestCodeVO> searchSelectTestCode(String testName);

}
