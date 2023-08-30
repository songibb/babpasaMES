package co.yedam.app.sales.order.web;

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
import co.yedam.app.sales.order.service.OrderService;
import co.yedam.app.sales.order.service.OrderVO;
import co.yedam.app.sales.out.service.OutVO;

@Controller
public class OrderController {

	@Autowired
	OrderService orderService;

	// 조회
	@GetMapping("/orderList")
	public String orderList(Model model) {
		model.addAttribute("orderNList", orderService.getNoPlan());
		model.addAttribute("actList", orderService.actAllList());
		model.addAttribute("prodList", orderService.prodAllList());
		model.addAttribute("ordHeaderList", orderService.ordHeaderList());
		return "sales/orderList";
	}
	
	//조회페이지 ajax 목록조회 -> 주문header
	@GetMapping("/ajaxOrdHeaderList")
	@ResponseBody
	public List<OrderVO> ajaxOrdHeaderList(){
		List<OrderVO> ordHeaderList = orderService.ordHeaderList();
		return ordHeaderList;
	}
	
	//조회페이지 ajax 목록조회 -> 주문detail
	@GetMapping("/ajaxOrdDetailList")
	@ResponseBody
	public List<OrderVO> ajaxOrdDetailList(@RequestParam(value = "ordCode", required = false) String ordCode){
		List<OrderVO> ordDetailList = orderService.ordDetailList(ordCode);
		return ordDetailList;
	}

	// 검색 ajax
	@GetMapping("/orderListFilter")
	@ResponseBody
	public List<OrderVO> orderListFilter(@RequestParam(value = "actCode", required = false) String actCode,
			@RequestParam(value = "prodCode", required = false) String prodCode,
			@RequestParam(value = "ordDate", required = false) String ordDate,
			@RequestParam(value="startDate", required=false) String startDate, 
			@RequestParam(value="endDate", required=false) String endDate,
			@RequestParam(value="before", required=false) String before, 
			@RequestParam(value="comple", required=false) String comple){
		List<OrderVO> vo = orderService.searchOrderList(actCode, prodCode, startDate, endDate, before, comple);
		return vo;
	}
	
	// 주문 관리 조회들
	@GetMapping("/orderMng")
	public String orderMngList(Model model) {
		//전체 주문서 목록
		model.addAttribute("orderNList", orderService.getNoPlan());
		//거래처 목록 -> 모달
		model.addAttribute("actList", orderService.actAllList());
		//제품 목록 - 완제품만 -> 모달
		model.addAttribute("prodList", orderService.prodAllList());	
		return "sales/orderMng";
	}
	
	
	//등록, 수정, 삭제
	@PostMapping("orderSave")
	@ResponseBody
	public int orderSave(@RequestBody GridVO<OrderVO> data) {
		return orderService.modifyOrder(data);
	}
	
	//거래처 목록 모달 ajax(검색용)
	@GetMapping("getActModalSearch")
	@ResponseBody
	public List<OutVO> getActModalSearch(String actName){
		return orderService.actSearchList(actName);
	}
	
}
