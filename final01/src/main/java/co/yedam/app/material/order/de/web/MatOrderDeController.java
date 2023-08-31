package co.yedam.app.material.order.de.web;


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
import co.yedam.app.material.order.de.service.MatOrderDeService;
import co.yedam.app.material.order.de.service.MatOrderDeVO;
import co.yedam.app.material.stock.service.MatStockVO;
import co.yedam.app.sales.order.service.OrderVO;


@Controller
public class MatOrderDeController {
	//전체조회
	@Autowired
	MatOrderDeService mods;
	
	//자재목록 모달
	@Autowired
	MatModalService mms;
	//전체조회
	@GetMapping("matOrderList")
	public String getMatOrderList(Model model) {
		
		model.addAttribute("matOrderList", mods.getMatListPageOrderList());
		model.addAttribute("actList", mods.getActMatModal());
		model.addAttribute("matList", mms.getMetList());
		return "material/matOrderList";
	}
	
	//상세 그리드
	@GetMapping("getMatOrderDeList")
	@ResponseBody
	public List<MatOrderDeVO> getMatOrderDeList(String matOdCd) {
		return mods.getMatListPageOrderDeList(matOdCd);
	}
	
	//검색 ajax
	@GetMapping("getMatOrderFilter")
	@ResponseBody
	public List<MatOrderDeVO> getMatOrderFilter(@RequestParam(value="materialCode", required=false) String materialCode, @RequestParam(value="accountCode", required=false) String accountCode, @RequestParam(value="startDate", required=false) String startDate, @RequestParam(value="endDate", required=false) String endDate, @RequestParam(value="before", required=false) String before, @RequestParam(value="comple", required=false) String comple) {
		List<MatOrderDeVO> vo = mods.selectMatOrderSearch(materialCode, accountCode, startDate, endDate, before, comple);
		return vo;
	}
	
	//조회 페이지 검색 ajax
	@GetMapping("getMatOrderListFilter")
	@ResponseBody
	public List<MatOrderDeVO> getMatListPageOrderListSearch(@RequestParam(value="accountCode", required=false) String accountCode, @RequestParam(value="startDate", required=false) String startDate, @RequestParam(value="endDate", required=false) String endDate) {
		List<MatOrderDeVO> vo = mods.getMatListPageOrderListSearch(accountCode, startDate, endDate);
		return vo;
	}
	
	//관리페이지
	@GetMapping("matOrderDir")
	public String getMatOrderDir(Model model) {
		List<MatOrderDeVO> mo = mods.selectMatOrderList();
		model.addAttribute("matOrderList", mo);
		model.addAttribute("actList", mods.getActMatModal());
		model.addAttribute("matList", mms.getMetList());
		//신규생산계획 조회
		model.addAttribute("stockList", mods.getNewPrcsPlan());
		return "material/matOrderDir";
	}
		
	//등록, 수정, 삭제
	@PostMapping("matOrderDirSave")
	@ResponseBody
	public int matOrderDirInsert(@RequestBody GridVO<MatOrderDeVO> data) {
		 return mods.modifyMatOrder(data); 
	} 
	
	//plan Grid 데이터 리셋
	@GetMapping("getResetPlanGridData")
	@ResponseBody
	public List<MatStockVO> getResetPlanGridData(){
		return mods.getNewPrcsPlan();
	}
	
	//거래처 목록 모달 ajax(검색용)
	@GetMapping("getActMatModalSearch")
	@ResponseBody
	public List<OrderVO> getActMatModalSearch(String actName){
		return mods.getActMatModalSearch(actName);
	}
	
	//해당 자재 거래처 찾기
	@GetMapping("getMatBuyAct")
	@ResponseBody
	public List<MatOrderDeVO> getMatBuyAct(String matCode){
		return mods.getMatBuyAct(matCode);
	}
	
}
