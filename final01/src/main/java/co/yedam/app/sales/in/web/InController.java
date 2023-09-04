package co.yedam.app.sales.in.web;

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
import co.yedam.app.material.in.service.MatInVO;
import co.yedam.app.material.in.service.MatModalVO;
import co.yedam.app.sales.in.service.InService;
import co.yedam.app.sales.in.service.InVO;
import co.yedam.app.sales.order.service.OrderVO;

@Controller
public class InController {
	
	@Autowired
	InService inService;
	
	@GetMapping("/inList")
	public String inList(Model model) {
		model.addAttribute("inMngList", inService.inMngList());
		model.addAttribute("prodList", inService.prodAllList());
		return "sales/inList";
	}
	// 검색 ajax
	@GetMapping("/inListFilter")
	@ResponseBody
	public List<InVO> inListFilter(@RequestParam(value = "prodCode", required = false) String prodCode,
			@RequestParam(value="startDate", required=false) String startDate, 
			@RequestParam(value="endDate", required=false) String endDate,
			@RequestParam(value="before", required=false) String before, 
			@RequestParam(value="comple", required=false) String comple){
		List<InVO> vo = inService.searchInList(prodCode, startDate, endDate, before, comple);
		return vo;
	}
	
	//관리페이지
		@GetMapping("inMng")
		public String inProductList(Model model) {
			//제품목록검색 모달창
			model.addAttribute("prodList", inService.prodAllList());
			//검수완료된 완제품 목록
			model.addAttribute("CProdList", inService.CProdList());
			//입고관리페이지 입고그리드
			model.addAttribute("inMngList", inService.inMngList());
			return "sales/inMng";
		}
		
		//등록, 수정, 삭제
		@PostMapping("modifyProdIn")
		@ResponseBody
		public int modifyProdIn(@RequestBody GridVO<InVO> data) {
			return inService.modifyProdIn(data);
		}
}
