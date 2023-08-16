package co.yedam.app.common.product.web;



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

import co.yedam.app.common.comm.service.CommCodeService;
import co.yedam.app.common.emp.service.EmpInfoService;
import co.yedam.app.common.product.service.ProductCodeService;
import co.yedam.app.common.product.service.ProductCodeVO;



@Controller
public class ProductCodeController {
	@Autowired
	ProductCodeService productCodeService;
	
	@Autowired
	CommCodeService commCodeService;
	
	//전체조회
	@GetMapping("/prodCodeList")
	public String getProdAllList(Model model) {
		model.addAttribute("prodList", productCodeService.getProductCodeAll());
		return "common/prodCodeList";
	}
	
	
	//검색조회
	@GetMapping("/getProdCodeFilter")
	@ResponseBody
	public List<ProductCodeVO> getProdCodeFilter(@RequestParam String prodName) {
		List<ProductCodeVO> vo = productCodeService.searchSelectProdCode(prodName);
		return vo;
				
	}
	
	
	//제품 관리 페이지
	@GetMapping("/prodCodeAdmin")
	public String prodCodeAdmin(Model model) {
		model.addAttribute("prodList", productCodeService.getProductCodeAll());
		model.addAttribute("prodTypeList", commCodeService.selectProdTypeInfo());
		return "admincom/prodCodeAdmin";
	}
	
	//ajax조회
	@GetMapping("/ajaxProdCodeList")
	@ResponseBody
	public List<ProductCodeVO> ajaxProdCodeList(){
		List<ProductCodeVO> prodList = productCodeService.getProductCodeAll();
		return prodList;
	}
	
	// 제품 등록
	@PostMapping("/prodCodeInsert")
	@ResponseBody
	public Map<String, String> prodCodeInsert(@RequestBody ProductCodeVO productCodeVO){
		return productCodeService.insertProdInfo(productCodeVO);
	}
	
	//제품 수정
	@PostMapping("/prodCodeUpdate") 
	@ResponseBody
	public Map<String, String> prodCodeUpdate(@RequestBody ProductCodeVO productCodeVO){
		return productCodeService.updateProdInfo(productCodeVO);
	}
	
	//제품 삭제
	@PostMapping("/prodCheckedDelete")
	@ResponseBody
	public int prodCheckedDelete(@RequestBody List<ProductCodeVO> checkedProd){
		int result = 0;
		for(ProductCodeVO vo : checkedProd) {
			result += productCodeService.deleteProdInfo(vo);
		}
	return result;
	}
	
	
}
