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
//20230821 백송이 - 생산 계획
@Controller
public class PrcsPlanController {
	
	@Autowired
	PrcsPlanService prcsPlanService;
	
	//생산계획 조회
	@GetMapping("prcsPlanList")
	public String getPrcsPlanAllList(@RequestParam(required=false) String searchPlanName, 
									 @RequestParam(required=false) String startDate, 
									 @RequestParam(required=false) String endDate, 
									 Model model){
		model.addAttribute("planList", prcsPlanService.selectPrcsPlanList(searchPlanName, startDate, endDate));	
		return "process/prcsPlanList";
	}
	
	//생산계획 조회 - 생산계획 관리 (검색)
	//검색VO따로 만들기
	@GetMapping("searchPlanList")
	@ResponseBody
	public List<PrcsPlanVO> getPrcsPlanAllList(@RequestParam(required=false) String searchPlanName, 
											   @RequestParam(required=false) String startDate, 
											   @RequestParam(required=false) String endDate){
		List<PrcsPlanVO> list = prcsPlanService.selectPrcsPlanList(searchPlanName, startDate, endDate);	
		return list;
	}
	
	//상세생산계획 조회 - 리스트
	@GetMapping("prcsPlanDeList")
	@ResponseBody
	public List<PrcsPlanVO> getPrcsPlanDeList(@RequestParam String prcsPlanCode){
		List<PrcsPlanVO> list = prcsPlanService.selectPrcsPlanDeList(prcsPlanCode);
		return list;
	}
	
	//생산계획 + 상세생산계획 등록 - 페이지 호출
	@GetMapping("prcsPlanInsert")
	public String getPrcsPlanInsert(){
		return "process/prcsPlanInsert";
	}
	
	//생산계획 등록
	@PostMapping("prcsPlanInsert")
	@ResponseBody
	public String prcsPlanInsert(@RequestBody PrcsPlanVO prcsPlanVO) { 
		//selectKey값 가져오기
		String prcsPlanCode = prcsPlanService.insertPrcsPlan(prcsPlanVO);
		return prcsPlanCode;
	}
	
	//상세생산계획 등록
	@PostMapping("prcsPlanDeInsert")
	@ResponseBody
	public int prcsPlanDeInsert(@RequestBody List<PrcsPlanVO> list) {			
		return prcsPlanService.insertPrcsPlanDe(list);
	}
	

	//생산계획 수정
	@PostMapping("prcsPlanUpdate")
	@ResponseBody
	public int prcsPlanUpdate(@RequestBody List<PrcsPlanVO> list) { 		
		return prcsPlanService.updatePrcsPlan(list);
	}
	
	//상세생산계획 수정
	@PostMapping("prcsPlanDeUpdate")
	@ResponseBody
	public int prcsPlanUpdateDe(@RequestBody List<PrcsPlanVO> list) { 
		return prcsPlanService.updatePrcsPlanDe(list);
	}
	
	//생산계획 삭제
	@PostMapping("prcsPlanDelete")
	@ResponseBody
	public int prcsPlanDelete(@RequestBody List<String> list) { 	
		return prcsPlanService.deletePrcsPlan(list);
	}
	
	
	
	//미계획 주문서 조회 	
	@GetMapping("notPlanOrderList")
	@ResponseBody
	public List<OrderVO> getNotPlanOrderList(){
		List<OrderVO> list = prcsPlanService.selectNotPlanOrderList();
		return list;
	}
	
	//미계획 상세주문서 조회 
	@PostMapping("notPlanOrderDeList")
	@ResponseBody	
	public List<OrderVO> getPlanOrderList(@RequestBody List<OrderVO> ordList){
		return prcsPlanService.selectNotPlanOrderDeList(ordList);
	}
		

	

}
