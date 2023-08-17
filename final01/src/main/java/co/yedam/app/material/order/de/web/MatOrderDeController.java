package co.yedam.app.material.order.de.web;


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
import co.yedam.app.material.in.service.MatModalService;
import co.yedam.app.material.order.de.service.MatOrderDeService;
import co.yedam.app.material.order.de.service.MatOrderDeVO;
import co.yedam.app.sales.order.service.OrderService;


@Controller
public class MatOrderDeController {
	//전체조회
	@Autowired
	MatOrderDeService mods;
	
	//거래처 모달
	@Autowired
	OrderService orderService;
	
	//자재목록 모달
	@Autowired
	MatModalService mms;
	//전체조회
	@GetMapping("matOrderList")
	public String getMatOrderList(Model model) {
		List<MatOrderDeVO> mo = mods.selectMatOrderList();
		model.addAttribute("matOrderList", mo);
		model.addAttribute("actList", orderService.actAllList());
		model.addAttribute("matList", mms.getMetList());
		return "material/matOrderList";
	}
	
	//검색 ajax
	@GetMapping("getMatOrderFilter")
	@ResponseBody
	public List<MatOrderDeVO> getMatOrderFilter(@RequestParam(value="materialCode", required=false) String materialCode, @RequestParam(value="accountCode", required=false) String accountCode, @RequestParam(value="startDate", required=false) String startDate, @RequestParam(value="endDate", required=false) String endDate) {
		List<MatOrderDeVO> vo = mods.selectMatOrderSearch(materialCode, accountCode, startDate, endDate);
		return vo;
	}
	
	//관리페이지
	@GetMapping("matOrderDir")
	public String getMatOrderDir(Model model) {
		List<MatOrderDeVO> mo = mods.selectMatOrderList();
		model.addAttribute("matOrderList", mo);
		model.addAttribute("actList", orderService.actAllList());
		model.addAttribute("matList", mms.getMetList());
		return "material/matOrderDir";
	}
		
	//등록, 수정, 삭제
	@PostMapping("matOrderDirSave")
	@ResponseBody
	public int matOrderDirInsert(@RequestBody GridVO<MatOrderDeVO> data) {
		 return mods.modifyMatOrder(data); 
	} 

	
}
