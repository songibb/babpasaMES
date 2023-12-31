package co.yedam.app.material.out.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import co.yedam.app.material.in.service.MatModalService;
import co.yedam.app.material.order.de.service.MatOrderDeService;
import co.yedam.app.material.out.service.MatOutService;
import co.yedam.app.material.out.service.MatOutVO;

@Controller
public class MatOutController {
	//전체조회
	@Autowired
	MatOutService mos;
	
	//거래처 모달
	@Autowired
	MatOrderDeService mods;
	
	//자재목록 모달
	@Autowired
	MatModalService mms;
		
	//전체조회
	@GetMapping("matOutList")
	public String getMatOutList(@RequestParam(value="materialCode", required=false) String materialCode, @RequestParam(value="accountCode", required=false) String accountCode, @RequestParam(value="startDate", required=false) String startDate, @RequestParam(value="endDate", required=false) String endDate, Model model) {
		model.addAttribute("outList", mos.selectMatOutListAll());
		model.addAttribute("actList", mods.getActMatModal());
		model.addAttribute("matList", mms.getMetList());
		return "material/matOutList";
	}
	//검색 ajax
	@GetMapping("getMatOutFilter")
	@ResponseBody
	public List<MatOutVO> getMatOutFilter(@RequestParam(value="materialCode", required=false) String materialCode, @RequestParam(value="accountCode", required=false) String accountCode, @RequestParam(value="startDate", required=false) String startDate, @RequestParam(value="endDate", required=false) String endDate) {
		List<MatOutVO> vo = mos.selectMatOutList(materialCode, accountCode, startDate, endDate);
		return vo;
	}
}
