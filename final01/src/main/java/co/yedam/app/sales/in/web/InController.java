package co.yedam.app.sales.in.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import co.yedam.app.sales.in.service.InService;

@Controller
public class InController {
	
	@Autowired
	InService inService;
	
	@GetMapping("/inList")
	public String inList(Model model) {
		model.addAttribute("inList", inService.getInList());
		return "sales/inList";
	}

}
