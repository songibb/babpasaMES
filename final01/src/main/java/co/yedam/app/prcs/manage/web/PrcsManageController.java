package co.yedam.app.prcs.manage.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import co.yedam.app.prcs.manage.service.PrcsManageService;
import co.yedam.app.prcs.manage.service.PrcsManageVO;

@Controller
public class PrcsManageController {
	
	@Autowired
	PrcsManageService prcsManageService;

	//공정관리 조회 - 호출
	@GetMapping("prcsManageList")
	public String getPrcsManageList(Model model){
		model.addAttribute("prcsManageList",prcsManageService.getPrcsManageList());
		return "proces"
				+ "s/prcsManageList";
	}
	
	//공정관리 조회 - 리스트
	@GetMapping("selectPrcsManageList")
	@ResponseBody
	public List<PrcsManageVO> getPrcsManageList(){
		List<PrcsManageVO> list = prcsManageService.getPrcsManageList();
		return list;
	}
	
	//공정관리 조회 - 검색
	@GetMapping("selectPrcsManageSearch")
	@ResponseBody
	public List<PrcsManageVO> getSearchPrcsManage(@RequestParam String prcsSearch){
		PrcsManageVO pVO = new PrcsManageVO();
		pVO.setPrcsSearch(prcsSearch);
		List<PrcsManageVO> list = prcsManageService.getPrcsManageSearch(pVO);
		return list;
	}
	
	
	
	
	
}
