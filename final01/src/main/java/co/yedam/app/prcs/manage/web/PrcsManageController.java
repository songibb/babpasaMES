package co.yedam.app.prcs.manage.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import co.yedam.app.common.comm.service.CommCodeService;
import co.yedam.app.common.grid.service.GridVO;
import co.yedam.app.prcs.manage.service.PrcsManageService;
import co.yedam.app.prcs.manage.service.PrcsManageVO;
//20230823 백송이 - 공정 관리
@Controller
public class PrcsManageController {
	
	@Autowired
	PrcsManageService prcsManageService;
	
	@Autowired
	CommCodeService commCodeService;

	//공정관리 조회 - 호출
	@GetMapping("prcsManageList")
	public String getPrcsManageAllList(Model model){
		//model.addAttribute("prcsManageList",prcsManageService.selectPrcsManageList());
		model.addAttribute("prcsTypeList", commCodeService.searchCommCodeUse("PRCS-TYPE"));
		model.addAttribute("semiYnList", commCodeService.searchCommCodeUse("0U"));
		return "process/prcsManageList";
	}
	
	//공정관리 조회 - 리스트
	@GetMapping("selectPrcsManageList")
	@ResponseBody
	public List<PrcsManageVO> getPrcsManageList(){
		List<PrcsManageVO> list = prcsManageService.selectPrcsManageList();
		return list;
	}

	//공정관리 등록, 수정, 삭제
	@PostMapping("updatePrcsManage")
	@ResponseBody
	public int updatePrcsManage(@RequestBody GridVO<PrcsManageVO> data) {		
		return prcsManageService.updatePrcsManage(data);
	}
	

	
	
	
}
