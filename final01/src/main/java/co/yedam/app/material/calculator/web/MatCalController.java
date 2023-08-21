package co.yedam.app.material.calculator.web;

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
import co.yedam.app.material.calculator.service.MatCalService;
import co.yedam.app.material.calculator.service.MatCalVO;
import co.yedam.app.material.in.service.MatModalService;

@Controller
public class MatCalController {
	
	@Autowired
	MatCalService mcs;
	
	//자재목록 모달
	@Autowired
	MatModalService mms;
	
	@GetMapping("matCalculateList")
	public String getMatCalListPage(Model model) {
		model.addAttribute("calList", mcs.getMatCalList());
		model.addAttribute("matList", mms.getMetList());
		return "material/matCalculateList";
	}
	
	//검색 ajax
	@GetMapping("matCalFilterList")
	@ResponseBody
	public List<MatCalVO> getMatCalFilterList(@RequestParam(value="materialCode", required=false) String materialCode, 
											@RequestParam(value="calIn", required=false) String calIn, 
											@RequestParam(value="calOut", required=false) String calOut, 
											@RequestParam(value="startDate", required=false) String startDate, 
											@RequestParam(value="endDate", required=false) String endDate){
		
		return mcs.getMatCalSearch(materialCode, calIn, calOut, startDate, endDate);
	}
	
	//관리페이지
	@GetMapping("matCalculateDir")
	public String getMatCalDirPage(Model model) {
		model.addAttribute("calList", mcs.getMatCalList());
		model.addAttribute("matList", mms.getMetList());
		return "material/matCalculateDir";
	}
	
	//insert
	@PostMapping("matCalDirSave")
	@ResponseBody
	public int modifyMatCal(@RequestBody GridVO<MatCalVO> data) {
		return mcs.modifyMatCal(data);
	}
}
