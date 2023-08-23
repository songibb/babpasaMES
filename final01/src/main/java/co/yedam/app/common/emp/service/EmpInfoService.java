package co.yedam.app.common.emp.service;

import java.util.List;

public interface EmpInfoService {
	
	//전체사원조회
	public List<EmpInfoVO> selectEmpInfoList();
	
	//검색조회
	public List<EmpInfoVO> searchSelectEmp(String empName);
	
	//사원코드 단건조회
	public EmpInfoVO getEmpInfoOne(EmpInfoVO empInfoVO);
	
	//사원등록(+)
	public int insertNewEmp(EmpInfoVO empInfoVO);
	
	//사원수정
	public int updateEmpInfo(EmpInfoVO empInfoVO);
	
	
	//조회+검색
	public List<EmpInfoVO> empSelect(String empName);

}
