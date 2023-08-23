package co.yedam.app.common.emp.web;




import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import co.yedam.app.common.emp.service.EmpInfoService;
import co.yedam.app.common.emp.service.EmpInfoVO;
import co.yedam.app.emp.mapper.EmpMapper;





@Controller
public class EmpInfoController {
	@Autowired
	EmpInfoService empInfoService;
	
	//로그인용(+)
	EmpMapper empService;
	
	//암호화(+)
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	//사원전체조회
	@GetMapping("/empinfo")
	public String getEmpInfoAllLIst(Model model) {
		model.addAttribute("empList", empInfoService.selectEmpInfoList());
		return "common/empInfo";
	}
	
	//사원명 검색조회
	@GetMapping("/getempFilter")
	@ResponseBody
	public List<EmpInfoVO> getempFilter(@RequestParam String empName){
		List<EmpInfoVO> vo = empInfoService.searchSelectEmp(empName);
		return vo;
	}
	
	
	//사원코드 단건조회
	@GetMapping("getComEmpCode")
	@ResponseBody
	public EmpInfoVO getComEmpCode(@RequestParam String empCode) {
		EmpInfoVO vo = new EmpInfoVO();
		vo.setEmpCode(empCode);
		EmpInfoVO findVO = empInfoService.getEmpInfoOne(vo);
		return findVO;
	}
	
	//사원관리 페이지(+)
	@GetMapping("empDir")
	public String getEmpDirPage() {
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
	
	

	
}
