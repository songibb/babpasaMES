package co.yedam.app.material.rt.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import co.yedam.app.material.rt.service.MatRtService;

@Controller
public class MatRtController {
	//전체조회
	@Autowired
	MatRtService mrs;
	//전체조회
	@GetMapping("matRtList")
	public String getMatRtList(@RequestParam(value="materialCode", required=false) String materialCode, @RequestParam(value="accountCode", required=false) String accountCode, @RequestParam(value="startDate", required=false) String startDate, @RequestParam(value="endDate", required=false) String endDate, Model model) {
		model.addAttribute("rtList", mrs.selectMatRtList(materialCode, accountCode, startDate, endDate));
		
		return "material/matRtList";
	}
}
