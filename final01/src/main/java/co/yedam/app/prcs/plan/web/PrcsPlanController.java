package co.yedam.app.prcs.plan.web;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import co.yedam.app.prcs.plan.service.PrcsPlanService;
import co.yedam.app.prcs.plan.service.PrcsPlanVO;

@Controller
public class PrcsPlanController {
	
	@Autowired
	PrcsPlanService prcsPlanService;
	
	//생산계획 조회
	@GetMapping("prcsPlanList")
	public String getPrcsPlanAllList(Model model){
		model.addAttribute("planList", prcsPlanService.getPrcsPlanList());	
		return "process/prcsPlanList";
	}

	
//	//상세생산계획 조회
//	@GetMapping("prcsPlanDeList")
//	public List<PrcsPlanVO> getPrcsPlanDeList(Model model) {
//		model.addAttribute("planDeList", prcsPlanService.getPrcsPlanDeList());
//		return "process/prcsPlanList";
//	}
	
	//상세생산계획 조회 - 리스트
	@GetMapping("prcsPlanDeList")
	@ResponseBody
	public List<PrcsPlanVO> getPrcsPlanDeList(@RequestParam String prcsPlanCode){
		List<PrcsPlanVO> list = prcsPlanService.getPrcsPlanDeList(prcsPlanCode);
		return list;
	}
	

    	

}
