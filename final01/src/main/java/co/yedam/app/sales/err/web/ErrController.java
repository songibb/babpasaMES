package co.yedam.app.sales.err.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import co.yedam.app.common.grid.service.GridVO;
import co.yedam.app.sales.err.service.ErrService;
import co.yedam.app.sales.err.service.ErrVO;

@Controller
public class ErrController {

	@Autowired
	ErrService errService;
	
	//전체조회
	@GetMapping("ErrDisList")
	public String getErrDisList(Model model){
		model.addAttribute("disList", errService.getErrList());
		return "sales/errList";
	}
	
	//관리페이지
	@GetMapping("ErrDisDir")
	public String getErrDisDir(Model model) {
		model.addAttribute("disList", errService.getErrList());
		return "sales/errMng";
	}
	
	//등록, 수정, 삭제
	@PostMapping("ErrDisDirSave")
	@ResponseBody
	public int errDisDirSave(@RequestBody GridVO<ErrVO> data) {
		return errService.modifyErrDis(data);
	}
}
