package co.yedam.app.material.rt.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import co.yedam.app.material.in.service.MatModalService;
import co.yedam.app.material.rt.service.MatRtService;
import co.yedam.app.material.rt.service.MatRtVO;
import co.yedam.app.sales.order.service.OrderService;

@Controller
public class MatRtController {
	//전체조회
	@Autowired
	MatRtService mrs;
	
	//거래처 모달
	@Autowired
	OrderService orderService;
		
	//자재목록 모달
	@Autowired
	MatModalService mms;
	
	//전체조회
	@GetMapping("matRtList")
	public String getMatRtList(Model model){
		model.addAttribute("rtList", mrs.selectMatRtList());
		model.addAttribute("actList", orderService.actAllList());
		model.addAttribute("matList", mms.getMetList());
		
		return "material/matRtList";
	}
	
	//검색 ajax
	@GetMapping("getMatRtFilter")
	@ResponseBody
	public List<MatRtVO> getMatRtFilter(@RequestParam(value="materialCode", required=false) String materialCode, @RequestParam(value="accountCode", required=false) String accountCode, @RequestParam(value="startDate", required=false) String startDate, @RequestParam(value="endDate", required=false) String endDate) {
		List<MatRtVO> vo = mrs.selectMatRtSearch(materialCode, accountCode, startDate, endDate);
		return vo;
	}
}
