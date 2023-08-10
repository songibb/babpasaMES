package co.yedam.app.common.err.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import co.yedam.app.common.err.service.ErrCodeService;
import co.yedam.app.common.err.service.ErrCodeVO;

@Controller
public class ErrCodeController {
	
	@Autowired
	ErrCodeService errCodeService;
	
	@GetMapping("/errCodeList")
	public String errCodeList(Model model) {
		model.addAttribute("errList", errCodeService.selectErrCodeList());
		return "common/errCodeList";
	}
	
	@GetMapping("errCodeSearch")
	@ResponseBody
	public List<ErrCodeVO> errCodeSearch(@RequestParam String errName){
		List<ErrCodeVO> vo = errCodeService.searchSelectErrCode(errName);
		return vo;
	}
}
