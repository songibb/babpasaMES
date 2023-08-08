package co.yedam.app.sales.out.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import co.yedam.app.sales.out.service.OutService;

@Controller
public class OutController {
	
	@Autowired
	OutService outService;
	
	@GetMapping("/outList")
	public String outList(Model model) {
		model.addAttribute("outList", outService.getOutList());
		return "sales/outList";
	}
}
