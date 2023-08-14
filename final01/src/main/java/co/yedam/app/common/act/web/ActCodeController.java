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
	@GetMapping("/actCodeAdmin")
	public String actCodeAdmin(Model model) {
		model.addAttribute("empList", empInfoService.selectEmpInfoList());
		model.addAttribute("actTypeList", commCodeService.selectActTypeList());
		model.addAttribute("actStsList", commCodeService.selectActStsList());
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
	
	
	
	//거래처 삭제 check
	/*
	 * @PostMapping("/actCheckedDelete")
	 * 
	 * @ResponseBody public Map<String, String> delete(@RequestBody List<ActCodeVO>
	 * checkedAct) {
	 * 
	 * 
	 * return actCodeService.deleteActInfo(checkedAct); }
	 */
	@PostMapping("/actCheckedDelete")
	@ResponseBody 
	public int delete(@RequestBody List<ActCodeVO> checkedAct) {
		int result = 0;
		for(ActCodeVO vo : checkedAct) {
			
			result += actCodeService.deleteActInfo(vo);
			
		}
		return result;
	}
	
}




