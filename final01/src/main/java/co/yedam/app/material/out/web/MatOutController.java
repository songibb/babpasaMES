package co.yedam.app.material.out.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import co.yedam.app.material.out.service.MatOutService;

@Controller
public class MatOutController {
	//전체조회
	@Autowired
	MatOutService mos;
	//전체조회
	@GetMapping("matOutList")
	public String getMatOutList(@RequestParam(value="materialCode", required=false) String materialCode, @RequestParam(value="accountCode", required=false) String accountCode, @RequestParam(value="startDate", required=false) String startDate, @RequestParam(value="endDate", required=false) String endDate, Model model) {
		model.addAttribute("outList", mos.selectMatOutList(materialCode, accountCode, startDate, endDate));
		return "material/matOutList";
	}
}
