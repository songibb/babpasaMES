package co.yedam.app.common.test.mapper;

import java.util.List;

import co.yedam.app.common.test.service.TestCodeVO;

public interface TestCodeMapper {
	
	//전체조회
	public List<TestCodeVO> selectTestCodeList();
	
	//테스트명 조회
	public List<TestCodeVO> searchSelectTestCode(String testName);

}
