package co.yedam.app.sales.order.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import co.yedam.app.sales.order.service.OrderService;

@Controller
public class OrderController {

	@Autowired
	OrderService orderService;
	
	//전체조회
	@GetMapping("/orderList")
	public String orderList(Model model) {
		model.addAttribute("orderList", orderService.getOrderList());
		return "sales/orderList";
	}
}
