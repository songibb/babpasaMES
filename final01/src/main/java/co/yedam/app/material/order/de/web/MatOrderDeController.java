package co.yedam.app.material.order.de.web;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import co.yedam.app.material.order.de.service.MatOrderDeService;
import co.yedam.app.material.order.de.service.MatOrderDeVO;


@Controller
public class MatOrderDeController {
	
	@Autowired
	MatOrderDeService mods;
	
	@GetMapping("MatOrderList")
	public String getMatOrderList(@RequestParam(value="startDate", required=false) String startDate,@RequestParam(value="endDate", required=false) String endDate, Model model) {
		List<MatOrderDeVO> mo = mods.selectMatOrderList(startDate, endDate);
		model.addAttribute("matOrderList", mo);
		
		return "material/matOrderList";
	}
}
