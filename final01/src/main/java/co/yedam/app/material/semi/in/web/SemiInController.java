package co.yedam.app.material.semi.in.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import co.yedam.app.material.semi.in.service.SemiInService;

@Controller
public class SemiInController {
	//전체조회
	@Autowired
	SemiInService sis;
	//전체조회
	@GetMapping("semiInList")
	public String getSemiInList(@RequestParam(value="productCode", required=false) String productCode, @RequestParam(value="startDate", required=false) String startDate, @RequestParam(value="endDate", required=false) String endDate, Model model) {
		model.addAttribute("inList", sis.selectSemiInList(productCode, startDate, endDate));
		return "material/semiInList";
	}
}
