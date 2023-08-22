package co.yedam.app.sales.out.web;

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
import co.yedam.app.sales.out.service.OutService;
import co.yedam.app.sales.out.service.OutVO;

@Controller
public class OutController {

	@Autowired
	OutService outService;

	@GetMapping("/outList")
	public String outList(Model model) {
		model.addAttribute("outList", outService.getOutList());
		model.addAttribute("actList", outService.actAllList());
		model.addAttribute("prodList", outService.prodAllList());
		return "sales/outList";
	}

	// 검색 ajax
	@GetMapping("/outListFilter")
	@ResponseBody
	public List<OutVO> outListFilter(@RequestParam(value = "actCode", required = false) String actCode,
			@RequestParam(value = "prodCode", required = false) String prodCode,
			@RequestParam(value = "startDate", required = false) String startDate,
			@RequestParam(value = "endDate", required = false) String endDate) {
		List<OutVO> vo = outService.searchOutList(prodCode, actCode, startDate, endDate);
		return vo;
	}

	// 출고 관리 페이지
	@GetMapping("outMng")
	public String outMngList(Model model) {
		// 출고완료된 품목만 보여주는 출고 리스트
		model.addAttribute("outNList", outService.getOutNList());
		// 거래처 목록 -> 모달
		model.addAttribute("actList", outService.actAllList());
		// 제품 목록 -> 모달
		model.addAttribute("prodList", outService.prodAllList());
		return "sales/outMng";
	}

	//등록, 수정, 삭제
	@PostMapping("outSave")
	@ResponseBody
	public int outSave(@RequestBody GridVO<OutVO> data) {
		return outService.modifyOut(data);
	}
}
