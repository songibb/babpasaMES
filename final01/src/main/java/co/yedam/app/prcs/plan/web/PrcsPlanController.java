package co.yedam.app.prcs.plan.web;


import java.util.ArrayList;
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
	public String getPrcsPlanAllList(@RequestParam(required=false) String searchPlanName, 
									 @RequestParam(required=false) String startDate, 
									 @RequestParam(required=false) String endDate, 
									 Model model){
		model.addAttribute("planList", prcsPlanService.getPrcsPlanList(searchPlanName, startDate, endDate));	
		return "process/prcsPlanList";
	}
	
	//생산계획 조회 - 생산계획 관리 (검색)
	@GetMapping("searchPlanList")
	@ResponseBody
	public List<PrcsPlanVO> getPrcsPlanAllList(@RequestParam(required=false) String searchPlanName, 
											   @RequestParam(required=false) String startDate, 
											   @RequestParam(required=false) String endDate){
		System.out.println(searchPlanName);
		List<PrcsPlanVO> list = prcsPlanService.getPrcsPlanList(searchPlanName, startDate, endDate);	
		System.out.println(list);
		return list;
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
	public int prcsPlanDeInsert(@RequestBody List<PrcsPlanVO> prcsPlanList) {	
		int result = 0;
		for(PrcsPlanVO vo : prcsPlanList) {
			prcsPlanService.insertPrcsPlanDe(vo);
			
			//생산계획 등록시 주문서 (미계획 -> 계획) 수정
			prcsPlanService.updateNotPlanOrderList(vo);
			result++;
		}

		
		return result;
	}
	
	
	//생산계획 + 상세생산계획 등록
//	@PostMapping("prcsPlanInsert")
//	@ResponseBody
//	public int PrcsPlanInsert(@RequestBody List<PrcsPlanVO> prcsPlanList) {
//		int result = prcsPlanService.prcsPlanInsert(prcsPlanList);
//		return result;
//	}

	//생산계획 수정
	@PostMapping("prcsPlanUpdate")
	@ResponseBody
	public int prcsPlanUpdate(@RequestBody List<PrcsPlanVO> list) { 
		int result = 0;
		for(PrcsPlanVO vo : list) {
			prcsPlanService.updatePrcsPlan(vo);
			result++;
		}
		return result;
	}
	
	//상세생산계획 수정
	@PostMapping("prcsPlanDeUpdate")
	@ResponseBody
	public int prcsPlanUpdateDe(@RequestBody List<PrcsPlanVO> list) { 
		int result = 0;
		for(PrcsPlanVO vo : list) {
			prcsPlanService.updatePrcsPlanDe(vo);
			result++;
		}
		return result;
	}
	
	//생산계획 삭제
	@PostMapping("prcsPlanDelete")
	@ResponseBody
	public int prcsPlanDelete(@RequestBody List<String> list) { 
		int result = 0;
		for(String code : list) {
			prcsPlanService.deletePrcsPlan(code);
			result++;
		}
		return result;
	}
	
	
	
	//미계획 주문서 조회 	
	@GetMapping("notPlanOrderList")
	@ResponseBody
	public List<OrderVO> getNotPlanOrderList(){
		List<OrderVO> list = prcsPlanService.getNotPlanOrderList();
		return list;
	}
	
	//미계획 상세주문서 조회 
	@PostMapping("notPlanOrderDeList")
	@ResponseBody	
	public List<OrderVO> getPlanOrderList(@RequestBody List<OrderVO> ordList){

		List<OrderVO> deList = new ArrayList<>();
		
		for(OrderVO vo : ordList) {
			String ordCode = vo.getOrdCode();

			deList.addAll(prcsPlanService.getNotPlanOrderDeList(ordCode));
		}
		System.out.println(deList);
		return deList;
	}
		

	

}
