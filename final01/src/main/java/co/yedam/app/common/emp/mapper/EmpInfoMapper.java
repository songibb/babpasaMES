package co.yedam.app.common.emp.mapper;

import java.util.List;

import co.yedam.app.common.emp.service.EmpInfoVO;

public interface EmpInfoMapper {
	
	//전체사원조회
	public List<EmpInfoVO> selectEmpInfoList();
	
	//검색조회
	public List<EmpInfoVO> searchSelectEmp(String empName);
	
	//사원코드 단건조회
	public EmpInfoVO getEmpInfoOne(EmpInfoVO empInfoVO);
	
	//사원등록(+)
	public int insertNewEmp(EmpInfoVO empInfoVO);
	

}
