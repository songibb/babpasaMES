package co.yedam.app.common.product.web;



import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import co.yedam.app.common.product.service.ProductCodeService;
import co.yedam.app.common.product.service.ProductCodeVO;



@Controller
public class ProductCodeController {
	@Autowired
	ProductCodeService productCodeService;
	
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
	
}
