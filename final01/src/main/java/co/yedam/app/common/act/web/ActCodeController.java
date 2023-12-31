package co.yedam.app.common.act.web;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import co.yedam.app.common.act.service.ActCodeService;
import co.yedam.app.common.act.service.ActCodeVO;
import co.yedam.app.common.comm.service.CommCodeService;
import co.yedam.app.common.emp.service.EmpInfoService;
import co.yedam.app.prcs.dir.service.PrcsDirVO;
// 2023/08/21/김상희
// 거래처관리

@Controller
public class ActCodeController {
	
	@Autowired
	ActCodeService actCodeService;
	
	@Autowired
	EmpInfoService empInfoService;
	
	@Autowired
	CommCodeService commCodeService;
	
	// 거래처조회 페이지
	@GetMapping("/ActCodeList")
	public String ActCodeList(Model model) {
		model.addAttribute("actList", actCodeService.selectActCodeList());
		model.addAttribute("actTypeList", commCodeService.searchCommCodeUse("ACT-TYPE"));
		model.addAttribute("actStsList", commCodeService.searchCommCodeUse("0J"));
		
		return "common/actCodeList";
	}
	//검색조회
	@GetMapping("/ActCodeSearch")
	@ResponseBody
	public List<ActCodeVO>  ActCodeSearch(ActCodeVO actCodeVO){
		List<ActCodeVO> vo = actCodeService.searchSelectActCode(actCodeVO);
		return vo;
	}
	
	
	//거래처 관리페이지
	@GetMapping("/actCodeAdmin")
	public String actCodeAdmin(Model model) {
		model.addAttribute("actTypeList", commCodeService.searchCommCodeUse("ACT-TYPE"));
		model.addAttribute("actStsList", commCodeService.searchCommCodeUse("0J"));
		return "admincom/actCodeAdmin";
	}
	
	//ajax조회
	@GetMapping("/ajaxActCodeList")
	@ResponseBody
	public List<ActCodeVO> ajaxActCodeList(){
		List<ActCodeVO> actList = actCodeService.selectActCodeList();
		return actList;
	}
	
	
	//거래처 등록
	@PostMapping("/actCodeInsert")
	@ResponseBody
	public Map<String, String> actCodeInsert(@RequestBody ActCodeVO actCodeVO){
		return actCodeService.insertActInfo(actCodeVO);
	}
	
	
	//거래처 정보 수정
	@PostMapping("/actCodeUpdate")
	@ResponseBody 
	public Map<String, String> actCodeUpdate(@RequestBody ActCodeVO actCodeVO){
		return actCodeService.updateActInfo(actCodeVO);
	}
	
	
	@PostMapping("/actCheckedDelete")
	@ResponseBody 
	public List<String> actCheckedDelete(@RequestBody List<ActCodeVO> checkedAct) {
		return actCodeService.deleteActInfo(checkedAct);
		
	}
	
}




