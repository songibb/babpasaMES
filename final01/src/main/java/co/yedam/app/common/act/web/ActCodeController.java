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

@Controller
public class ActCodeController {
	
	@Autowired
	ActCodeService actCodeService;
	
	@Autowired
	EmpInfoService empInfoService;
	
	@Autowired
	CommCodeService commCodeService;
	
	//전체조회
	@GetMapping("/ActCodeList")
	public String ActCodeList(Model model) {
		model.addAttribute("actList", actCodeService.selectActCodeList());
		
		return "common/actCodeList";
	}
	//검색조회
	@GetMapping("/ActCodeSearch")
	@ResponseBody
	public List<ActCodeVO>  ActCodeSearch(@RequestParam String actName){
		List<ActCodeVO> vo = actCodeService.searchSelectActCode(actName);
		return vo;
	}
	
	
	//거래처 관리페이지
	@GetMapping("actCodeAdmin")
	public String actCodeAdmin(Model model) {
		model.addAttribute("empList", empInfoService.selectEmpInfoList());
		model.addAttribute("actTypeList", commCodeService.selectActTypeList());
		return "admincom/actCodeAdmin";
	}
	
	//ajax조회
	@GetMapping("ajaxActCodeList")
	@ResponseBody
	public List<ActCodeVO> ajaxActCodeList(){
		List<ActCodeVO> actList = actCodeService.selectActCodeList();
		return actList;
	}
	
	
	//거래처 등록
	@PostMapping("actCodeInsert")
	@ResponseBody
	public Map<String, String> actCodeInsert(@RequestBody ActCodeVO actCodeVO){
		return actCodeService.insertActInfo(actCodeVO);
	}
	
}




