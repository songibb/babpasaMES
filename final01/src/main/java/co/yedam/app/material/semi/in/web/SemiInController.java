package co.yedam.app.material.semi.in.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import co.yedam.app.material.semi.in.service.SemiInService;
import co.yedam.app.material.semi.in.service.SemiInVO;

@Controller
public class SemiInController {
	//전체조회
	@Autowired
	SemiInService sis;
	
	//전체조회
	@GetMapping("semiInList")
	public String getSemiInList(Model model) {
		model.addAttribute("inList", sis.selectSemiInList());
		model.addAttribute("prodList", sis.getSemiModal());
		return "material/semiInList";
	}
	
	//전체조회 중 검색
	@GetMapping("getSemiInFilter")
	@ResponseBody
	public List<SemiInVO> getSemiInFilter(@RequestParam(value="productCode", required=false) String productCode, @RequestParam(value="startDate", required=false) String startDate, @RequestParam(value="endDate", required=false) String endDate) {
		List<SemiInVO> vo = sis.selectSemiInSearch(productCode, startDate, endDate);
		return vo;
	}
	
}
