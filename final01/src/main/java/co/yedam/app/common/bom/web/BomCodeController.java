package co.yedam.app.common.bom.web;

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

import co.yedam.app.common.bom.service.BomCodeService;
import co.yedam.app.common.bom.service.BomCodeVO;
import co.yedam.app.common.comm.service.CommCodeService;
import co.yedam.app.common.mat.service.MatCodeService;
import co.yedam.app.common.product.service.ProductCodeService;
import co.yedam.app.prcs.manage.service.PrcsManageService;


@Controller
public class BomCodeController {

	@Autowired
	BomCodeService bomCodeService;
	
	@Autowired
	CommCodeService commCodeService;
	
	@Autowired
	ProductCodeService productCodeService;
	
	@Autowired
	PrcsManageService prcsManageService;
	
	@Autowired
	MatCodeService matCodeService;
	//전체조회
	@GetMapping("/bomCodeList")
	public String getBomAllList(Model model) {
		model.addAttribute("bomList", bomCodeService.getBomCodeAll());
		return "common/bomCodeList";
	}
	
	//검색조회
	@GetMapping("/bomSearch")
	@ResponseBody
	public List<BomCodeVO> bomSearch(@RequestParam String prodName){
		List<BomCodeVO> vo = bomCodeService.searchSelectBom(prodName);
		return vo;
	}
	
	//BOM 상세조회
	@GetMapping("/bomDecodeList")
	@ResponseBody
	public List<BomCodeVO> bomDecodeList(@RequestParam String bomNo){
		List<BomCodeVO> vo = bomCodeService.getBomDeCodeList(bomNo);
		return vo;
	}
	
	
	//bom관리페이지
	@GetMapping("/bomCodeAdmin")
	public String bomCodeAdmin(Model model) {
		model.addAttribute("bomList", bomCodeService.getBomCodeAll());
		model.addAttribute("bomUseInfoList", commCodeService.selectBomUseInfo());
		model.addAttribute("bomPrcsUseList", commCodeService.selectBomPrcsUseInfo());
		model.addAttribute("prodList", productCodeService.getProductCodeAll());
		model.addAttribute("prcsList", prcsManageService.getPrcsManageList());
		model.addAttribute("matList", matCodeService.selectMatCodeList());
		model.addAttribute("semiProdList", productCodeService.selectSemiProdList());
		model.addAttribute("bomUnit", commCodeService.selectBomUnit());
		return "admincom/bomCodeAdmin";
	}
	
	
	/*
	 * @PostMapping("/bomInsert")
	 * 
	 * @ResponseBody public int bomInsert(@RequestBody Map<String, Object>
	 * bomInsertList) { int result = 0;
	 * 
	 * return result; }
	 */
	
	 @PostMapping("/bomInsert")
	 @ResponseBody 
	 public String bomInsert(@RequestBody BomCodeVO bomCodeVO) {
	 String bomNo = bomCodeService.bomCodeInsert(bomCodeVO); return bomNo; 
	 } 
	  
	 @PostMapping("/bomDeInsert")
	 @ResponseBody 
	 public int bomDeInsert(@RequestBody List<BomCodeVO> list) {
	 return bomCodeService.bomDeCodeInsert(list); 
	 }
	 
	
	
	
	@PostMapping("/bomUpdate")
	@ResponseBody
	public int bomUpdate(@RequestBody List<BomCodeVO> list) {
		return bomCodeService.updateBom(list);
	}
	
	
	@PostMapping("/bomDeUpdate")
	@ResponseBody
	public int bomDeUpdate(@RequestBody List<BomCodeVO> list) {
		return bomCodeService.updateDeBom(list);
	}
	
	@PostMapping("/bomDeDelete")
	@ResponseBody 
	public int bomDeDelete(@RequestBody List<BomCodeVO> list){
		return bomCodeService.deleteDeBom(list);
	}
	
	
	
	
}
