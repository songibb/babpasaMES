package co.yedam.app.prcs.dir.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import co.yedam.app.common.bom.service.BomCodeVO;
import co.yedam.app.prcs.dir.service.PrcsDirService;
import co.yedam.app.prcs.dir.service.PrcsDirVO;
import co.yedam.app.prcs.plan.service.PrcsPlanVO;

@Controller
public class PrcsDirController {
	
	@Autowired
	PrcsDirService prcsDirService;
	
	//생산지시 조회
	@GetMapping("prcsDirList")
	public String getPrcsDirAllList(Model model) {
		model.addAttribute("dirList", prcsDirService.getPrcsDirList());
		return "process/prcsDirList";
	}
	
	//생산지시 조회 - 리스트
	@GetMapping("selectPrcsDirList")
	@ResponseBody
	public List<PrcsDirVO> getPrcsDirAllList() {
		List<PrcsDirVO> list = prcsDirService.getPrcsDirList();
		return list;
	}
	
	//상세생산지시 조회
	@GetMapping("prcsDirDeList")
	@ResponseBody
	public List<PrcsDirVO> getPrcsDirDeList(@RequestParam String prcsDirCode){
		List<PrcsDirVO> list = prcsDirService.getPrcsDirDeList(prcsDirCode);
		return list;
	}
	
	
	//생산지시 + 상세생산지시 등록 - 페이지 호출
	@GetMapping("prcsDirInsert")
	public String getPrcsDirInsert() {	
		return "process/prcsDirInsert";
	}
	
	//생산지시 등록
	@PostMapping("prcsDirInsert")
	@ResponseBody
	public String prcsDirInsert(@RequestBody PrcsDirVO prcsDirVO) { 
		//selectKey값 가져오기
		String prcsDirCode = prcsDirService.insertPrcsDir(prcsDirVO);
		return prcsDirCode;
	}
	
	//상세생산지시 등록
	@PostMapping("prcsDirDeInsert")
	@ResponseBody
	public int prcsDirDeInsert(@RequestBody List<PrcsDirVO> list) {	
		int result = 0;
		for(PrcsDirVO vo : list) {
			prcsDirService.insertPrcsDirDe(vo);
			
			//생산지시 등록시 상세생산계획 (미지시 -> 지시완료) 수정 
			prcsDirService.updateNotDirPlanList(vo);
			
			result++;
		}
		return result;
	}
	
	
	//미지시 생산계획 목록 조회
	@GetMapping("notDirPlanList")
	@ResponseBody
	public List<PrcsPlanVO> getNotDirPlanList(){
		List<PrcsPlanVO> list = prcsDirService.getNotDirPlanList();
		return list;
	}
	

	//BOM 조회
	@GetMapping("bomList")
	@ResponseBody
	public List<BomCodeVO> getBomList(@RequestParam String prodCode){
		List<BomCodeVO> list = prcsDirService.getBomList(prodCode);
		return list;
	}
	
	
	
}
