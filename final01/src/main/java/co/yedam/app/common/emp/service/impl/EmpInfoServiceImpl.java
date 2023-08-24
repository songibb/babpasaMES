package co.yedam.app.common.emp.service.impl;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.yedam.app.common.emp.mapper.EmpInfoMapper;
import co.yedam.app.common.emp.service.EmpInfoService;
import co.yedam.app.common.emp.service.EmpInfoVO;


@Service
public class EmpInfoServiceImpl implements EmpInfoService {

	@Autowired
	EmpInfoMapper empInfoMapper;
	
	@Override
	public List<EmpInfoVO> selectEmpInfoList() {
		
		return empInfoMapper.selectEmpInfoList();
	}

	@Override
	public List<EmpInfoVO> searchSelectEmp(String empName) {
		
		return empInfoMapper.searchSelectEmp(empName);
	}

	@Override
	public EmpInfoVO getEmpInfoOne(EmpInfoVO empInfoVO) {
		
		return empInfoMapper.getEmpInfoOne(empInfoVO);
	}
	
	//사원등록(+)
	@Override
	public int insertNewEmp(EmpInfoVO empInfoVO) {
		
		return empInfoMapper.insertNewEmp(empInfoVO);
	}

	@Override
	public List<EmpInfoVO> empSelect(EmpInfoVO empInfoVO) {
		
		return empInfoMapper.empSelect(empInfoVO);
	}

	@Override
	public int updateEmpInfo(EmpInfoVO empInfoVO) {
		
		return empInfoMapper.updateEmpInfo(empInfoVO);
	}



	
}
