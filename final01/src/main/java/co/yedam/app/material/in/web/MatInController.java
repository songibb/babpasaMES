package co.yedam.app.material.in.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import co.yedam.app.material.in.service.MatInService;

@Controller
public class MatInController {
	
	@Autowired
	MatInService mis;
	
	@GetMapping("MatInList")
	public String getMatInList(@RequestParam(value="materialCode", required=false) String materialCode, @RequestParam(value="accountCode", required=false) String accountCode, @RequestParam(value="startDate", required=false) String startDate, @RequestParam(value="endDate", required=false) String endDate, Model model) {
		model.addAttribute("inList", mis.selectMatInList(materialCode, accountCode, startDate, endDate));
		return "material/matInList";
	}
}
