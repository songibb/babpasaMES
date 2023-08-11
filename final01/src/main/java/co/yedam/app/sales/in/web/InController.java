package co.yedam.app.sales.in.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import co.yedam.app.sales.in.service.InService;
import co.yedam.app.sales.in.service.InVO;
import co.yedam.app.sales.order.service.OrderVO;

@Controller
public class InController {
	
	@Autowired
	InService inService;
	
	@GetMapping("/inList")
	public String inList(Model model) {
		model.addAttribute("inList", inService.getInList());
		model.addAttribute("prodList", inService.prodAllList());
		return "sales/inList";
	}
	// 검색 ajax
	@GetMapping("/inListFilter")
	@ResponseBody
	public List<InVO> inListFilter(@RequestParam(value = "prodCode", required = false) String prodCode,
			@RequestParam(value="startDate", required=false) String startDate, 
			@RequestParam(value="endDate", required=false) String endDate){
		List<InVO> vo = inService.searchInList(prodCode, startDate, endDate);
		return vo;
	}
}
