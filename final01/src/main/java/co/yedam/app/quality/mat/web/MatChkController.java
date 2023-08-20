package co.yedam.app.quality.mat.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import co.yedam.app.common.grid.service.GridVO;
import co.yedam.app.material.in.service.MatInVO;
import co.yedam.app.quality.mat.service.MatChkService;
import co.yedam.app.quality.mat.service.MatChkVO;

@Controller
public class MatChkController {

	@Autowired
	MatChkService matChkService;
	
	//전체조회
	@GetMapping("MatQualChk")
	public String getMatChkList(Model model) {
		List<MatChkVO> vo = matChkService.selectMatChkList();
		model.addAttribute("matChkList", vo);
		
		return "quality/MatQualChk";
		
	}
	
	//자재 상세 발주 조회 (모달)
	@GetMapping("notChkMatList")
	@ResponseBody
	public List<MatChkVO> selectNotChkMatList(){
		List<MatChkVO> list = matChkService.selectNotChkMatList();
		return list;
	}
	
	//등록, 수정, 삭제
	@PostMapping("matChkDirSave")
	@ResponseBody
	public int matChkDirSave(@RequestBody GridVO<MatChkVO> data) {
		return matChkService.modifyMatChk(data);
	}
}
