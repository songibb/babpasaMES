package co.yedam.app.common.emp.web;



import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import co.yedam.app.common.emp.service.EmpInfoService;
import co.yedam.app.common.emp.service.EmpInfoVO;




@Controller
public class EmpInfoController {
	@Autowired
	EmpInfoService empInfoService;
	
	//사원전체조회
	@GetMapping("/empinfo")
	public String getEmpInfoAllLIst(Model model) {
		model.addAttribute("empList", empInfoService.getEmpInfoAll());
		return "common/empInfo";
	}
	
	//검색조회
	@GetMapping("/getempFilter")
	@ResponseBody
	public List<EmpInfoVO> getempFilter(@RequestParam String empName){
		List<EmpInfoVO> vo = empInfoService.searchSelectEmp(empName);
		return vo;
	}

	
}