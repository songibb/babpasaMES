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

import co.yedam.app.common.emp.service.EmpInfoService;
import co.yedam.app.common.emp.service.EmpInfoVO;
import co.yedam.app.prcs.plan.service.PrcsPlanReqVO;
import co.yedam.app.prcs.plan.service.PrcsPlanService;
import co.yedam.app.prcs.plan.service.PrcsPlanVO;
import co.yedam.app.prcs.plan.service.PrcsSearchVO;
import co.yedam.app.sales.order.service.OrderVO;
//20230821 백송이 - 생산 계획
@Controller
public class PrcsPlanController {
	
	@Autowired
	PrcsPlanService prcsPlanService;
	
	@Autowired
	EmpInfoService empInfoService;
	
	//생산계획 조회
	@GetMapping("prcsPlanList")
	public String getPrcsPlanAllList(PrcsSearchVO prcsSearchVO, Model model){
		model.addAttribute("planList", prcsPlanService.selectPrcsPlanList(prcsSearchVO));	
		return "process/prcsPlanList";
	}
	
	//생산계획 조회 - 생산계획 관리 (검색)
//	@GetMapping("searchPlanList")
//	@ResponseBody
//	public List<PrcsPlanVO> getPrcsPlanAllList(@RequestParam(required=false) String searchPlanName, 
//											   @RequestParam(required=false) String startDate, 
//											   @RequestParam(required=false) String endDate){
//		List<PrcsPlanVO> list = prcsPlanService.selectPrcsPlanList(searchPlanName, startDate, endDate);	
//		return list;
//	}
	
	//생산계획 조회 - 검색 VO 따로 만들어서 사용
	@GetMapping("searchPlanList")
	@ResponseBody
	public List<PrcsPlanVO> getPrcsPlanAllList(PrcsSearchVO prcsSearchVO){
		List<PrcsPlanVO> list = prcsPlanService.selectPrcsPlanList(prcsSearchVO);	
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
	public int prcsPlanInsert(@RequestBody PrcsPlanReqVO prcsPlanReqVO) { 
		return prcsPlanService.insertPrcsPlan(prcsPlanReqVO);
	}
	
	//상세생산계획 등록
//	@PostMapping("prcsPlanDeInsert")
//	@ResponseBody
//	public int prcsPlanDeInsert(@RequestBody List<PrcsPlanVO> list) {			
//		return prcsPlanService.insertPrcsPlanDe(list);
//	}


	//생산계획 수정
	@PostMapping("prcsPlanUpdate")
	@ResponseBody
	public int prcsPlanUpdate(@RequestBody PrcsPlanReqVO prcsPlanReqVO) { 		
		return prcsPlanService.updatePrcsPlan(prcsPlanReqVO);
	}
	
	//상세생산계획 수정
//	@PostMapping("prcsPlanDeUpdate")
//	@ResponseBody
//	public int prcsPlanUpdateDe(@RequestBody List<PrcsPlanVO> list) { 
//		return prcsPlanService.updatePrcsPlanDe(list);
//	}
	
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
		

	
	//사원 전체 조회 (모달)
	@GetMapping("ajaxEmpCodeList")
	@ResponseBody
	public List<EmpInfoVO> getEmpCodeList(){
		return empInfoService.selectEmpInfoList();
	}
	
	
	//조회할때마다 생산지시여부 수정
	@PostMapping("updatePlanDirSts")
	@ResponseBody
	public int updatePlanDirSts(@RequestBody List<PrcsPlanVO> planList) {
		return prcsPlanService.updatePlanDirSts(planList);
	}

}
