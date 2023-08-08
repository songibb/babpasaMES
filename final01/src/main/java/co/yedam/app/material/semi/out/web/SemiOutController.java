package co.yedam.app.material.semi.out.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import co.yedam.app.material.semi.out.service.SemiOutService;

@Controller
public class SemiOutController {
	
	@Autowired
	SemiOutService sos;
	
	@GetMapping("semiOutList")
	public String getSemiOutList(@RequestParam(value="productCode", required=false) String productCode, @RequestParam(value="startDate", required=false) String startDate, @RequestParam(value="endDate", required=false) String endDate, Model model) {
		model.addAttribute("outList", sos.selectSemiOutList(productCode, startDate, endDate));
		return "material/semiOutList";
	}
}
