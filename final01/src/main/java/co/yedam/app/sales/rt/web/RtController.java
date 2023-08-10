package co.yedam.app.sales.rt.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import co.yedam.app.sales.rt.service.RtService;
import co.yedam.app.sales.rt.service.RtVO;

@Controller
public class RtController {
	
	@Autowired
	RtService rtService;
	
	@GetMapping("/rtList")
	public String rtList(Model model) {
		model.addAttribute("rtList", rtService.getRtList());
		model.addAttribute("prodList", rtService.prodAllList());
		return "sales/rtList";
	}
	// 검색 ajax
		@GetMapping("/rtListFilter")
		@ResponseBody
	public List<RtVO> RtListFilter(@RequestParam(value = "prodCode", required = false) String prodCode){
		List<RtVO> vo = rtService.searchRtList(prodCode);
		return vo;
		
	}
}
