package co.yedam.app.common.comm.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.fasterxml.jackson.annotation.JsonCreator.Mode;

import co.yedam.app.common.comm.service.CommCodeService;

@Controller
public class CommCodeController {
	
	@Autowired
	CommCodeService commCodeService;
	
	//공통코드 전체 조회
	@GetMapping("/commCodeList")
	public String commCodeList(Model model) {
		model.addAttribute("commCodeList", commCodeService.selectCommCodeList());
		return "common/commCodeList";
	}
	

}
