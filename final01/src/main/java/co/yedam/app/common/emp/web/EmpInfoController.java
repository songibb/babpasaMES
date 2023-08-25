package co.yedam.app.common.emp.web;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import co.yedam.app.common.comm.service.CommCodeService;
import co.yedam.app.common.emp.service.EmpInfoService;
import co.yedam.app.common.emp.service.EmpInfoVO;
import co.yedam.app.emp.mapper.EmpMapper;

//2023/08/21/김상희
//사원관리

@Controller
public class EmpInfoController {
	@Autowired
	EmpInfoService empInfoService;
	
	@Autowired
	CommCodeService commCodeService;
	
	//로그인용(+)
	EmpMapper empService;
	
	//암호화(+)
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	//사원전체조회
		@GetMapping("/empinfo")
		public String getEmpInfoAllLIst(Model model) {
			
			model.addAttribute("inputDeptList", commCodeService.searchCommCodeUse("DEPT-TYPE"));
			return "common/empInfo";
		}
	
	//사원코드 단건조회
	@GetMapping("/getComEmpCode")
	@ResponseBody
	public EmpInfoVO getComEmpCode(@RequestParam String empCode) {
		EmpInfoVO vo = new EmpInfoVO();
		vo.setEmpCode(empCode);
		EmpInfoVO findVO = empInfoService.getEmpInfoOne(vo);
		return findVO;
	}
	
	//사원관리 페이지(+)
	@GetMapping("empDir")
	public String getEmpDirPage(Model model) {
		model.addAttribute("inputDeptList", commCodeService.searchCommCodeUse("DEPT-TYPE"));
		model.addAttribute("inputRoleList", commCodeService.searchCommCodeUse("0B"));
		return "admincom/empCodeAdmin";
	}
	
	//사원등록 post(+)
	@PostMapping("/createNewAccount")
	@ResponseBody
	public int createNewAccout(EmpInfoVO vo) {
		BCryptPasswordEncoder enco = new BCryptPasswordEncoder();
		String pw = vo.getEmpPw();
		vo.setEmpPw(enco.encode(pw));
		
		int result = empInfoService.insertNewEmp(vo);
		return result;
	}
	
	//사원 ajax 조회
	@GetMapping("/ajaxEmpList")
	@ResponseBody
	public List<EmpInfoVO> ajaxEmpList(EmpInfoVO empInfoVO){
		List<EmpInfoVO>  vo= empInfoService.empSelect(empInfoVO);
		return vo;
	}
	
	
	//사원 정보 수정
	@PostMapping("/empInfoUpdate")
	@ResponseBody
	public int empInfoUpdate(@RequestBody EmpInfoVO vo) {
		if(vo.getEmpPw()==null || vo.getEmpPw().equals("")) {
			return empInfoService.updateEmpInfo(vo);
		}else {
			BCryptPasswordEncoder enco = new BCryptPasswordEncoder();
			String pw = vo.getEmpPw();
			vo.setEmpPw(enco.encode(pw));
			
			return empInfoService.updateEmpInfo(vo);
		}
		
	}

	
}
