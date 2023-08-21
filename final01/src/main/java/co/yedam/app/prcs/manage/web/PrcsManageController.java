package co.yedam.app.prcs.manage.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;


import co.yedam.app.prcs.manage.service.PrcsManageService;
import co.yedam.app.prcs.manage.service.PrcsManageVO;
//20230821 백송이 - 공정 관리
@Controller
public class PrcsManageController {
	
	@Autowired
	PrcsManageService prcsManageService;

	//공정관리 조회 - 호출
	@GetMapping("prcsManageList")
	public String getPrcsManageAllList(Model model){
		//model.addAttribute("prcsManageList",prcsManageService.getPrcsManageList());
		return "process/prcsManageList";
	}
	
	//공정관리 조회 - 리스트
	@GetMapping("selectPrcsManageList")
	@ResponseBody
	public List<PrcsManageVO> getPrcsManageList(){
		List<PrcsManageVO> list = prcsManageService.selectPrcsManageList();
		return list;
	}

	//공정관리 등록 - 리스트가져오기

	
	//공정관리 수정
	
	//공정관리 삭제
	
	
	
	
}
