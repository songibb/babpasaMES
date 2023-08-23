package co.yedam.app.common.mat.web;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import co.yedam.app.common.comm.service.CommCodeService;
import co.yedam.app.common.emp.service.EmpInfoService;
import co.yedam.app.common.grid.service.GridVO;
import co.yedam.app.common.mat.service.MatCodeService;
import co.yedam.app.common.mat.service.MatCodeVO;

@Controller
public class MatCodeController {

	@Autowired
	MatCodeService matCodeService;
	
	@Autowired
	CommCodeService commCodeService;
	
	@Autowired
	EmpInfoService empInfoService;
	
	//자재 관리페이지
	@GetMapping("/matCodeList")
	public String matCodeList(Model model) {
		model.addAttribute("matList", matCodeService.selectMatCodeList());
		model.addAttribute("unitList", commCodeService.searchCommCodeUse("0Y"));
		model.addAttribute("empList", empInfoService.selectEmpInfoList());
		
		return "admincom/matCodeAdmin";
	}
	
	//ajax 조회
	@GetMapping("/ajaxMatCodeList")
	@ResponseBody
	public List<MatCodeVO> ajaxMatCodeList(){
		List<MatCodeVO> matList = matCodeService.selectMatCodeList();
		
		return matList;
	}
	
	
	//자재명 검색조회
	@GetMapping("/searchMatCodeList")
	@ResponseBody
	public List<MatCodeVO> searchMatCodeList(@RequestParam String matName){
	List<MatCodeVO> vo = matCodeService.searchMatCode(matName);
	return vo;
	}
	
	
	
	@PostMapping("/updateMatCode")
	@ResponseBody
	public Map<String, Object> updateMatCode(@RequestBody GridVO<MatCodeVO> data) {
		return matCodeService.updateMatCode(data);
	}
}
