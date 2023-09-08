package co.yedam.app.prcs.prod.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import co.yedam.app.prcs.plan.service.PrcsSearchVO;
import co.yedam.app.prcs.prod.service.PrcsProdReqVO;
import co.yedam.app.prcs.prod.service.PrcsProdService;
import co.yedam.app.prcs.prod.service.PrcsProdVO;
//20230821 백송이 제품별 공정
@Controller
public class PrcsProdController {
	
	@Autowired
	PrcsProdService prcsProdService;
	
	//제품별공정 조회 - 호출
	@GetMapping("prcsProdList")
	public String getPrcsProdAllList(Model model, PrcsSearchVO prcsSearchVO){

		//제품 목록 조회
		model.addAttribute("prodList", prcsProdService.selectProdList(prcsSearchVO));
		
		return "process/prcsProdList";
	}
	
	//제품별공정 조회 - 리스트
	@GetMapping("selectPrcsProdList")
	@ResponseBody
	public List<PrcsProdVO> getPrcsProdList(@RequestParam String prodCode){
		List<PrcsProdVO> list = prcsProdService.selectPrcsProdList(prodCode);
		return list;
	}
	
	//제품별공정 등록, 수정, 삭제
	@PostMapping("updatePrcsProd")
	@ResponseBody
	public int updatePrcsProd(@RequestBody PrcsProdReqVO prcsProdReqVO) {		
		return prcsProdService.updatePrcsProd(prcsProdReqVO);
	}
	
	//제품 목록 조회
	@GetMapping("selectProdList")
	@ResponseBody
	public List<PrcsProdVO> selectProdList(PrcsSearchVO prcsSearchVO){
		List<PrcsProdVO> list = prcsProdService.selectProdList(prcsSearchVO);
		return list;
	}
	
	

}
