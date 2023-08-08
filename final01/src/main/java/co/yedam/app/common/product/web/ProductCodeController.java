package co.yedam.app.common.product.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import co.yedam.app.common.product.service.ProductCodeService;

@Controller
public class ProductCodeController {
	@Autowired
	ProductCodeService productCodeService;
	
	
}
