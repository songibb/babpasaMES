package co.yedam.app.common.main.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import co.yedam.app.common.bom.service.BomCodeService;

@Controller
public class MainController {

	@Autowired
	BomCodeService bomCodeService;
	
	@GetMapping("/mainPage")
	public String ActCodeList(Model model) {
		
		model.addAttribute("amtList", bomCodeService.chartTest());
		
		return "home";
	}
}
