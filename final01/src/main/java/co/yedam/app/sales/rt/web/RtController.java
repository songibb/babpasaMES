package co.yedam.app.sales.rt.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import co.yedam.app.common.grid.service.GridVO;
import co.yedam.app.sales.order.service.OrderVO;
import co.yedam.app.sales.out.service.OutVO;
import co.yedam.app.sales.rt.service.RtService;
import co.yedam.app.sales.rt.service.RtVO;

@Controller
public class RtController {
	
	@Autowired
	RtService rtService;
	
	@GetMapping("/rtList")
	public String rtList(Model model) {
		model.addAttribute("rtList", rtService.getAlreadyOutList());
		model.addAttribute("prodList", rtService.prodAllList());
		return "sales/rtList";
	}
	// 검색 ajax
		@GetMapping("/rtListFilter")
		@ResponseBody
	public List<RtVO> RtListFilter(@RequestParam(value = "prodCode", required = false) String prodCode,
			@RequestParam(value = "startDate", required = false) String startDate,
			@RequestParam(value = "endDate", required = false) String endDate){
		List<RtVO> vo = rtService.searchRtList(prodCode, startDate, endDate);
		return vo;
		
	}
		
	// 반품 관리 조회들
	@GetMapping("/rtMng")
	public String rtMng(Model model) {
		model.addAttribute("rtList", rtService.getAlreadyOutList());
		model.addAttribute("prodList", rtService.prodAllList());
		model.addAttribute("outList", rtService.getOutList());
		return "sales/rtMng";
	}
	
	
	//등록, 수정, 삭제
	@PostMapping("rtSave")
	@ResponseBody
	public int rtSave(@RequestBody GridVO<RtVO> data) {
		return rtService.modifyRt(data);
	}	
	
	//모달 ajax(검색용) - 제품
	@GetMapping("getProdModalSearch")
	@ResponseBody
	public List<OrderVO> getProdModalSearch(String prodName){
		return rtService.prodSearchList(prodName);
	}
	
	//모달 ajax(검색용) - 출고
		@GetMapping("getOutModalSearch")
		@ResponseBody
		public List<RtVO> getOutModalSearch(String prodName){
			return rtService.outSearchList(prodName);
		}
}
