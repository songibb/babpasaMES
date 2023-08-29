package co.yedam.app.quality.mat.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import co.yedam.app.common.comm.service.CommCodeService;
import co.yedam.app.common.comm.service.CommCodeVO;
import co.yedam.app.common.emp.service.EmpInfoService;
import co.yedam.app.common.emp.service.EmpInfoVO;
import co.yedam.app.common.grid.service.GridVO;
import co.yedam.app.quality.mat.service.MatChkService;
import co.yedam.app.quality.mat.service.MatChkVO;

//2023-08-19 장서영 -자재 검수 

@Controller
public class MatChkController {
	
	@Autowired
	MatChkService matChkService;
	
	@Autowired
	EmpInfoService empInfoService;
	
	@Autowired
	CommCodeService commCodeService;
	
	
	//전체조회
	@GetMapping("MatQualChk")
	public String getMatChkList(Model model) {
		List<MatChkVO> vo = matChkService.selectMatChkList();
		model.addAttribute("matChkList", vo);
		
		return "quality/MatQualChk";
		
	}
	
	//ajax
	@GetMapping("/ajaxMatQualList")
	@ResponseBody
	public List<MatChkVO> ajaxMatQualList(){
		List<MatChkVO> matqualList = matChkService.selectMatChkList();
		return matqualList;
	}
	
	//자재 상세 발주 조회 (모달)
	@GetMapping("notChkMatList")
	@ResponseBody
	public List<MatChkVO> selectNotChkMatList(){
		List<MatChkVO> list = matChkService.selectNotChkMatList();
		return list;
	}
	
	//자재 검사 결과 등록
	@PostMapping("matChkDirSave")
	@ResponseBody
	public int matChkDirSave(@RequestBody GridVO<MatChkVO> data) {
		return matChkService.modifyMatChk(data);
	}
	

	//AJAX - 사원조회
	@GetMapping("empCodeList1") 
	@ResponseBody
	public List<EmpInfoVO> empCodeList(){
		List<EmpInfoVO> list = empInfoService.selectEmpInfoList();
		return list;
	}
		
	//AJAX - 불량코드 조회
	@GetMapping("errCodeList") 
	@ResponseBody
	public List<CommCodeVO> errCodeList(){
		List<CommCodeVO> errlist = commCodeService.searchCommCodeUse("ERR-TYPE");
		return errlist;
	}
	
	//AJAX - 불량 반품 상태 조회
	@GetMapping("matReturnCode") 
	@ResponseBody
	public List<CommCodeVO> matReturnCode(){
		List<CommCodeVO> matreturnlist = commCodeService.searchCommCodeUse("0I");
		return matreturnlist;
	}
		
	//자재 검색
	@GetMapping("/searchMatChk")
	@ResponseBody
	public List<MatChkVO> SearchMatChk(@RequestParam String matName){
		List<MatChkVO> vo = matChkService.searchMatChk(matName);
		return vo;
	}
}
