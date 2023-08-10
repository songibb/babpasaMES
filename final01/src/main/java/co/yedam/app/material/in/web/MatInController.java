package co.yedam.app.material.in.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import co.yedam.app.material.in.service.MatInService;
import co.yedam.app.material.in.service.MatInVO;
import co.yedam.app.sales.order.service.OrderService;

@Controller
public class MatInController {
	//조회
	@Autowired
	MatInService mis;
	
	//거래처 모달
	@Autowired
	OrderService orderService;
	//조회
	@GetMapping("MatInList")
	public String getMatInList(@RequestParam(value="materialCode", required=false) String materialCode, @RequestParam(value="accountCode", required=false) String accountCode, @RequestParam(value="startDate", required=false) String startDate, @RequestParam(value="endDate", required=false) String endDate, Model model) {
		model.addAttribute("inList", mis.selectMatInList(materialCode, accountCode, startDate, endDate));
		model.addAttribute("actList", orderService.actAllList());
		return "material/matInList";
	}
	
	//검색 ajax
	@GetMapping("getMatInFilter")
	@ResponseBody
	public List<MatInVO> getMatInFilter(@RequestParam(value="materialCode", required=false) String materialCode, @RequestParam(value="accountCode", required=false) String accountCode, @RequestParam(value="startDate", required=false) String startDate, @RequestParam(value="endDate", required=false) String endDate) {
		List<MatInVO> vo = mis.selectMatInList(materialCode, accountCode, startDate, endDate);
		return vo;
	}
}
