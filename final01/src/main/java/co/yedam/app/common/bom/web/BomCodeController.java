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
import co.yedam.app.common.bom.service.BomReqVO;
import co.yedam.app.common.comm.service.CommCodeService;
import co.yedam.app.common.mat.service.MatCodeService;
import co.yedam.app.common.product.service.ProductCodeService;
import co.yedam.app.prcs.manage.service.PrcsManageService;
//2023/08/21/김상희
//BOM관리

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
		model.addAttribute("bomUseInfoList", commCodeService.searchCommCodeUse("0A"));
		model.addAttribute("prodList", productCodeService.getProductCodeAll());
		model.addAttribute("prcsList", prcsManageService.selectPrcsManageList());
		model.addAttribute("matList", matCodeService.selectMatCodeList());
		model.addAttribute("semiProdList", productCodeService.selectSemiProdList());
		model.addAttribute("bomUnit", commCodeService.searchCommCodeUse("0C"));
		return "admincom/bomCodeAdmin";
	}
	
	
	 @PostMapping("/bomInsert")
	 @ResponseBody 
	 public int bomInsert(@RequestBody BomReqVO bomReqVO) {
		 int result = bomCodeService.bomCodeInsert(bomReqVO); 
		 return result; 
	 } 
	
	 @PostMapping("bomUpdate")
	 @ResponseBody
	 public int bomUpdate(@RequestBody BomReqVO bomReqVO) {
		 int result = bomCodeService.updateBom(bomReqVO);
				 return result;
	 }
	 
	
	
	@PostMapping("/bomDeDelete")
	@ResponseBody 
	public int bomDeDelete(@RequestBody List<BomCodeVO> list){
		return bomCodeService.deleteDeBom(list);
	}
	
	
	
	
}
