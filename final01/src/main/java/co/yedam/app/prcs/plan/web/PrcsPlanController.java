package co.yedam.app.prcs.plan.web;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import co.yedam.app.prcs.plan.service.PrcsPlanService;
import co.yedam.app.prcs.plan.service.PrcsPlanVO;
import co.yedam.app.sales.order.service.OrderVO;

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
	
	//상세생산계획 조회 - 리스트
	@GetMapping("prcsPlanDeList")
	@ResponseBody
	public List<PrcsPlanVO> getPrcsPlanDeList(@RequestParam String prcsPlanCode){
		List<PrcsPlanVO> list = prcsPlanService.getPrcsPlanDeList(prcsPlanCode);
		return list;
	}
	
	//생산계획 + 상세생산계획 등록 - 페이지 호출
	@GetMapping("prcsPlanInsert")
	public String prcsPlanInsertPage(){
		return "process/prcsPlanInsert";
	}
	
	//생산계획 + 상세생산계획 등록
	@PostMapping("prcsPlanInsert")
	@ResponseBody
	public int PrcsPlanInsert(@RequestBody PrcsPlanVO prcsPlanVO) {
		int result = prcsPlanService.prcsPlanInsert(prcsPlanVO);
		return result;
	}

	//미계획 주문서 조회 	
	@GetMapping("notPlanOrderList")
	@ResponseBody
	public List<OrderVO> getNotPlanOrderList(){
		List<OrderVO> list = prcsPlanService.getNotPlanOrderList();
		return list;
	}

}
