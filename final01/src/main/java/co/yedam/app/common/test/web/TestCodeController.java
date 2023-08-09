package co.yedam.app.common.test.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import co.yedam.app.common.test.service.TestCodeService;
import co.yedam.app.common.test.service.TestCodeVO;

@Controller
public class TestCodeController {
	
	@Autowired
	TestCodeService testCodeService;
	
	//전체조회
	@GetMapping("/testCodeList")
	public String testCodeList(Model model) {
		model.addAttribute("testCodeList",testCodeService.selectTestCodeList());
		return "common/testCodeList";
	}
	
	//테스트명 검색 조회
	@GetMapping("/testCodeSearch")
	@ResponseBody
	public List<TestCodeVO> testCodeSearch(@RequestParam String testName){
	List<TestCodeVO> vo = testCodeService.searchSelectTestCode(testName);
	return vo;
	}
}
