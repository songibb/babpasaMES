package co.yedam.app.sales.order.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import co.yedam.app.material.in.service.MatInVO;
import co.yedam.app.sales.order.service.OrderService;
import co.yedam.app.sales.order.service.OrderVO;

@Controller
public class OrderController {

	@Autowired
	OrderService orderService;
	
	//전체조회
	@GetMapping("/orderList")
	public String orderList(Model model) {
		model.addAttribute("orderList", orderService.getOrderList());
		model.addAttribute("actList", orderService.actAllList());
		model.addAttribute("prodList", orderService.prodAllList());
		return "sales/orderList";
	}
	
	//검색 ajax
		@GetMapping("/orderListFilter")
		@ResponseBody
		public List<OrderVO> orderListFilter(@RequestParam(value = "actCode", required = false) String actCode
											, @RequestParam(value = "prodName", required = false) String prodName
											, @RequestParam(value = "ordDate", required = false) String ordDate) {
			List<OrderVO> vo = orderService.searchOrderList(actCode, prodName, ordDate);
			return vo;
		}
	
}
