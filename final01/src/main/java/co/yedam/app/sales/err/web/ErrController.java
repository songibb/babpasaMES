package co.yedam.app.sales.err.web;

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
import co.yedam.app.sales.err.service.ErrService;
import co.yedam.app.sales.err.service.ErrVO;
import co.yedam.app.sales.rt.service.RtService;
import co.yedam.app.sales.rt.service.RtVO;

@Controller
public class ErrController {

	@Autowired
	ErrService errService;
	
	@Autowired
	RtService rtService;
	
	//전체조회
	@GetMapping("ErrDisList")
	public String getErrDisList(Model model){
		model.addAttribute("disList", errService.getErrList());
		model.addAttribute("prodList", rtService.prodAllList());
		return "sales/errList";
	}
	
	//관리페이지
	@GetMapping("ErrDisDir")
	public String getErrDisDir(Model model) {
		model.addAttribute("disList", errService.getErrList());
		model.addAttribute("prodList", rtService.prodAllList());
		model.addAttribute("chkList", errService.ModalDisList());
		return "sales/errMng";
	}
	
	//등록, 수정, 삭제
	@PostMapping("ErrDisDirSave")
	@ResponseBody
	public int errDisDirSave(@RequestBody GridVO<ErrVO> data) {
		return errService.modifyErrDis(data);
	}
	
	// 검색 ajax
	@GetMapping("/errListFilter")
	@ResponseBody
	public List<ErrVO> errListFilter(@RequestParam(value = "prodCode", required = false) String prodCode,
			@RequestParam(value = "startDate", required = false) String startDate,
			@RequestParam(value = "endDate", required = false) String endDate) {
		List<ErrVO> vo = errService.searchErrList(prodCode, startDate, startDate);
		return vo;
	}
	
	//모달 ajax(검색용) - 검수
	@GetMapping("errSearchList")
	@ResponseBody
	public List<ErrVO> errSearchList(String prodName){
		return errService.ErrSearchList(prodName);
	}
}
