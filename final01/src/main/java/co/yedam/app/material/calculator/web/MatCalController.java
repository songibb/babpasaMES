package co.yedam.app.material.calculator.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import co.yedam.app.material.calculator.service.MatCalService;
import co.yedam.app.material.calculator.service.MatCalVO;

@Controller
public class MatCalController {
	
	@Autowired
	MatCalService mcs;
	
	@GetMapping("matCalculateList")
	public String getMatCalListPage(Model model) {
		model.addAttribute("calList", mcs.getMatCalList());
		
		return "material/matCalculateList";
	}
	
	//검색 ajax
	@GetMapping("matCalFilterList")
	@ResponseBody
	public List<MatCalVO> getMatCalFilterList(@RequestParam(value="materialCode", required=false) String materialCode, @RequestParam(value="calIn", required=false) String calIn, @RequestParam(value="calOut", required=false) String calOut, @RequestParam(value="startDate", required=false) String startDate, @RequestParam(value="endDate", required=false) String endDate){
		
		return mcs.getMatCalSearch(materialCode, calIn, calOut, startDate, endDate);
	}
}
