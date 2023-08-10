package co.yedam.app.material.semi.out.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import co.yedam.app.material.semi.in.service.SemiInService;
import co.yedam.app.material.semi.out.service.SemiOutService;
import co.yedam.app.material.semi.out.service.SemiOutVO;

@Controller
public class SemiOutController {
	//전체조회
	@Autowired
	SemiOutService sos;
	//반제품 목록 모달창
	@Autowired
	SemiInService sis;
	//전체조회
	@GetMapping("semiOutList")
	public String getSemiOutList(Model model) {
		model.addAttribute("outList", sos.selectSemiOutList());
		model.addAttribute("prodList", sis.getSemiModal());
		return "material/semiOutList";
	}
	
	//전체조회 중 검색
	@GetMapping("getSemiOutFilter")
	@ResponseBody
	public List<SemiOutVO> getSemiOutFilter(@RequestParam(value="productCode", required=false) String productCode, @RequestParam(value="startDate", required=false) String startDate, @RequestParam(value="endDate", required=false) String endDate) {
		List<SemiOutVO> vo = sos.selectSemiOutSearch(productCode, startDate, endDate);
		return vo;
	}
}
