package co.yedam.app.material.out.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import co.yedam.app.material.out.service.MatOutService;
import co.yedam.app.material.out.service.MatOutVO;
import co.yedam.app.sales.order.service.OrderService;

@Controller
public class MatOutController {
	//전체조회
	@Autowired
	MatOutService mos;
	
	//거래처 모달
	@Autowired
	OrderService orderService;
		
	//전체조회
	@GetMapping("matOutList")
	public String getMatOutList(@RequestParam(value="materialCode", required=false) String materialCode, @RequestParam(value="accountCode", required=false) String accountCode, @RequestParam(value="startDate", required=false) String startDate, @RequestParam(value="endDate", required=false) String endDate, Model model) {
		model.addAttribute("outList", mos.selectMatOutList(materialCode, accountCode, startDate, endDate));
		model.addAttribute("actList", orderService.actAllList());
		return "material/matOutList";
	}
	//검색 ajax
	@GetMapping("getMatOutFilter")
	@ResponseBody
	public List<MatOutVO> getMatOutFilter(@RequestParam(value="materialCode", required=false) String materialCode, @RequestParam(value="accountCode", required=false) String accountCode, @RequestParam(value="startDate", required=false) String startDate, @RequestParam(value="endDate", required=false) String endDate, Model model) {
		List<MatOutVO> vo = mos.selectMatOutList(materialCode, accountCode, startDate, endDate);
		return vo;
	}
}
