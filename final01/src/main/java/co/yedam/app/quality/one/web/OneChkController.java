package co.yedam.app.quality.one.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import co.yedam.app.quality.one.service.OneChkReqVO;
import co.yedam.app.quality.one.service.OneChkService;
import co.yedam.app.quality.one.service.OneChkVO;

//2023-08-22 장서영 - 완제품 품질 관리

@Controller
public class OneChkController {

	@Autowired
	OneChkService oneChkService;
	
	//검사 페이지 - 마지막 공정 조회
	@GetMapping("/onequalChk")
	public String selectListPrcs(Model model) {
		model.addAttribute("onequalChk", oneChkService.selectLastPrcs());
		return "quality/onequalChk";
	}
	
	//검사 페이지 - ajax 조회
	@GetMapping("/ajaxLastPrcsList")
	@ResponseBody
	public List<OneChkVO> ajaxLastPrcsList(){
		List<OneChkVO> LastPrcsList = oneChkService.selectLastPrcs();
		return LastPrcsList;
	}
	
	//조회 페이지 - 마지막 공정 조회
	@GetMapping("/oneQualChkList")
	public String selectAllLastPrcs(Model model) {
		model.addAttribute("oneQualChkList", oneChkService.selectAllLastPrcs());
		return "quality/oneQualChkList";
	}

	//조회 페이지 - ajax 조회
	@GetMapping("/ajaxAllLastPrcsList")
	@ResponseBody
	public List<OneChkVO> ajaxAllLastPrcsList(){
		List<OneChkVO> AllLastPrcsList = oneChkService.selectAllLastPrcs();
		return AllLastPrcsList;
	}
	
	//완제품 품질 검사 (상세)
	@GetMapping("/ajaxOneChkList")
	@ResponseBody
	public List<OneChkVO> ajaxOneChkList(@RequestParam String testNum){
		List<OneChkVO> vo = oneChkService.selectOneChkList(testNum);
		return vo;
	}
	
	//상세 품질 검사(저장버튼)
	@PostMapping("/updateOneChk")
	@ResponseBody
	public int OneChkUpdate(@RequestBody OneChkReqVO oneChkReqVO) {
		return oneChkService.OneChkUpdate(oneChkReqVO);
	}
	
}
