package co.yedam.app.common.comm.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import co.yedam.app.common.comm.service.CommCodeService;
import co.yedam.app.common.comm.service.CommCodeVO;
import co.yedam.app.common.grid.service.GridVO;

@Controller
public class CommCodeController {
	
	@Autowired
	CommCodeService commCodeService;
	
	//공통코드 전체 조회
	@GetMapping("/commCodeList")
	public String commCodeList(Model model) {
		model.addAttribute("commCodeList", commCodeService.selectCommCodeList());
		return "common/commCodeList";
	}
	
	//공통코드 관리페이지
	@GetMapping("/commCodeAdmin")
	public String commCodeAdmin(Model model){
		model.addAttribute("useList", commCodeService.selectCommUseInfo());
		return "admincom/commCodeAdmin";
	}
	
	
	//ajax 공통코드 조회
	@GetMapping("/ajaxCommCodeList")
	@ResponseBody
	public List<CommCodeVO> ajaxCommCodeList(){
		List<CommCodeVO> commList = commCodeService.selectCommCodeList();
		return commList;
	}
	
	//공통코드 검색 조회
	@GetMapping("/commCodeSearch")
	@ResponseBody
	public List<CommCodeVO> commCodeSearch(@RequestParam String commCode){
		List<CommCodeVO> vo = commCodeService.searchCommCode(commCode);
		return vo;
	}
	
	//공통코드 클릭시 상세코드 조회
	@GetMapping("/ajaxCommDeCodeList")
	@ResponseBody
	public List<CommCodeVO> ajaxCommDeCodeList(@RequestParam String commCode){
		List<CommCodeVO> vo = commCodeService.selectCommDeCodeList(commCode);
		return vo;
	}
	
	
	//상세코드 추가
	@PostMapping("/updateCommCode")
	@ResponseBody
	public int updateCommCode(@RequestBody GridVO<CommCodeVO> data) {
		return commCodeService.updateCommDeCode(data);
	}
	
}
