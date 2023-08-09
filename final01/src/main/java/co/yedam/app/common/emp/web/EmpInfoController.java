package co.yedam.app.common.emp.web;



import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
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
		model.addAttribute("list", empInfoService.getEmpInfoAll());
		return "common/empInfo";
	}
	
	@GetMapping("/empList")
	@ResponseBody
	public List<EmpInfoVO> getEmpList(){
		List<EmpInfoVO> list = empInfoService.getEmpInfoAll();
		return list;
	}
	
	
//	@GetMapping("empInfo")
//	public String empList(Model model,
//			@RequestParam(value="searchType") String searchType,
//			@RequestParam(value="keyword") String keyword){
//			
//		SearchVO searchVO = new SearchVO();
//		List<EmpInfoVO> list = empInfoService.getEmpInfoAll(searchVO);
//		
//			model.addAttribute("list", list);
//			model.addAttribute("search", searchVO);
//				return "common/empInfo";
//			}
//	
//	

	
}
