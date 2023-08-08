package co.yedam.app.sales.rt.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import co.yedam.app.sales.rt.service.RtService;

@Controller
public class RtController {
	
	@Autowired
	RtService rtService;
	
	@GetMapping("/rtList")
	public String rtList(Model model) {
		model.addAttribute("rtList", rtService.getRtList());
		return "sales/rtList";
	}
	
}
