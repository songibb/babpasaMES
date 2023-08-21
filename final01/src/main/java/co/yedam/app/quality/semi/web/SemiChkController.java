package co.yedam.app.quality.semi.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import co.yedam.app.common.grid.service.GridVO;
import co.yedam.app.quality.semi.service.SemiChkService;
import co.yedam.app.quality.semi.service.SemiChkVO;

//2023-08-21 장서영 - 반제품 품질 관리

@Controller
public class SemiChkController {

	@Autowired
	SemiChkService semiChkService;
	
	//공정 진행 조회
	@GetMapping("/semiQualChk")
	public String selectPrcsIngList(Model model) {
		model.addAttribute("semiQualChk", semiChkService.selectPrcsIng());
		return "quality/semiQualChk";
		
	}
	
	//ajax 조회
	@GetMapping("/ajaxPrcsIngChkList")
	@ResponseBody
	public List<SemiChkVO> ajaxPrcsIngChkList(){
		List<SemiChkVO> prcsIngChkList = semiChkService.selectPrcsIng();
		return prcsIngChkList;
	}
	
	//해당 공정 진행 별 검사항목(상세 그리드)
	@GetMapping("/ajaxSemiChkList")
	@ResponseBody
	public List<SemiChkVO> ajaxSemiChkList(@RequestParam String testNum){
		List<SemiChkVO> vo = semiChkService.selectSemiChkList(testNum);
		return vo;
	}
	
	//상세 품질 검사 수정(저장버튼)
	@PostMapping("/updateSemiChk")
	@ResponseBody
	public int SemiChkUpdate(@RequestBody GridVO<SemiChkVO> data) {
		return semiChkService.SemiChkUpdate(data);
	}
	
}
