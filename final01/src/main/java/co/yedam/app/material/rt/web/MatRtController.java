package co.yedam.app.material.rt.web;

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
import co.yedam.app.material.in.service.MatModalService;
import co.yedam.app.material.rt.service.MatRtService;
import co.yedam.app.material.rt.service.MatRtVO;
import co.yedam.app.material.rt.service.MatTestVO;
import co.yedam.app.sales.order.service.OrderService;

@Controller
public class MatRtController {
	//전체조회
	@Autowired
	MatRtService mrs;
	
	//거래처 모달
	@Autowired
	OrderService orderService;
		
	//자재목록 모달
	@Autowired
	MatModalService mms;
	
	//전체조회
	@GetMapping("matRtList")
	public String getMatRtList(Model model){
		model.addAttribute("rtList", mrs.selectMatRtList());
		model.addAttribute("actList", orderService.actAllList());
		model.addAttribute("matList", mms.getMetList());
		
		return "material/matRtList";
	}
	
	//검색 ajax
	@GetMapping("getMatRtFilter")
	@ResponseBody
	public List<MatRtVO> getMatRtFilter(@RequestParam(value="materialCode", required=false) String materialCode, @RequestParam(value="accountCode", required=false) String accountCode, @RequestParam(value="startDate", required=false) String startDate, @RequestParam(value="endDate", required=false) String endDate) {
		List<MatRtVO> vo = mrs.selectMatRtSearch(materialCode, accountCode, startDate, endDate);
		return vo;
	}
	
	//삭제한 행 1번 그리드로 가는 ajax
	@PostMapping("getDeletedRtInfo")
	@ResponseBody
	public List<MatTestVO> getDeletedMatInfo(@RequestBody List<MatRtVO> list) {
			
		return mrs.getDeletedRowsInfo(list);
	}
	
	//관리페이지
	@GetMapping("matRtDir")
	public String getMatRtDir(Model model) {
		model.addAttribute("rtList", mrs.selectMatRtList());
		model.addAttribute("testList", mrs.selectMatTestFinishList());
		model.addAttribute("actList", orderService.actAllList());
		model.addAttribute("matList", mms.getMetList());
		return "material/matRtDir";
	}
	
	//test목록 ajax
	@GetMapping("getMatTestRtFilter")
	@ResponseBody
	public List<MatTestVO> getMatTestRtFilter(){
		List<MatTestVO> vo = mrs.selectMatTestFinishList();
		return vo;
	}
	
	//등록
	@PostMapping("matRtDirSave")
	@ResponseBody
	public int matInDirSave(@RequestBody GridVO<MatRtVO> data) {
		return mrs.modifyMatRt(data);
	}

	
	@GetMapping("loginForm")
	public String getloginForm() {
	
		return "login/loginForm";
	}
}
