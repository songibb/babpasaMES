package co.yedam.app.material.in.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import co.yedam.app.common.grid.service.GridVO;
import co.yedam.app.material.in.service.MatInService;
import co.yedam.app.material.in.service.MatInVO;
import co.yedam.app.material.in.service.MatModalService;
import co.yedam.app.material.in.service.MatModalVO;
import co.yedam.app.material.order.de.service.MatOrderDeService;
import co.yedam.app.material.rt.service.MatRtService;
import co.yedam.app.material.rt.service.MatTestVO;
import co.yedam.app.material.search.service.SearchVO;
import co.yedam.app.material.stock.service.MatLotStockVO;

@Controller
public class MatInController {
	//조회
	@Autowired
	MatInService mis;
	
	//거래처 모달
	@Autowired
	MatOrderDeService mods;
	
	//자재목록 모달
	@Autowired
	MatModalService mms;
	
	//검수완료목록
	@Autowired
	MatRtService mrs;
	
	//조회
	@GetMapping("matInList")
	public String getMatInList(Model model) {
		model.addAttribute("inList", mis.selectMatInList());
		model.addAttribute("actList", mods.getActMatModal());
		model.addAttribute("matList", mms.getMetList());
		return "material/matInList";
	}
	
	//검색 ajax
	@GetMapping("getMatInFilter")
	@ResponseBody
	public List<MatInVO> getMatInFilter(SearchVO vo) {
		List<MatInVO> findVO = mis.selectMatInSearch(vo);
		return findVO;
	}
	
	//조회
	@GetMapping("getMatAll")
	@ResponseBody
	public List<MatInVO> getMatAll(Model model) {
		List<MatInVO> vo = mis.selectMatInList();
		return vo;
	}
	

	//관리페이지
	@GetMapping("matInDir")
	public String getMatInDir(Model model) {
		model.addAttribute("inList", mis.selectMatInList());
		model.addAttribute("actList", mods.getActMatModal());
		model.addAttribute("matList", mms.getMetList());
		model.addAttribute("testList", mis.selectMatTestFinishList());
		return "material/matInDir";
	}
	
	//test목록 ajax
	@GetMapping("getMatTestInFilter")
	@ResponseBody
	public List<MatTestVO> getMatTestInFilter(){
		List<MatTestVO> vo = mis.selectMatTestFinishList();
		return vo;
	}
	
	//삭제한 행 1번 그리드로 가는 ajax
	@PostMapping("getDeletedMatInfo")
	@ResponseBody
	public List<MatTestVO> getDeletedMatInfo(@RequestBody List<MatInVO> list) {
		
		return mis.getDeletedMatTest(list);
	}
	
	//등록, 수정, 삭제
	@PostMapping("matInDirSave")
	@ResponseBody
	public int matInDirSave(@RequestBody GridVO<MatInVO> data) {
		return mis.modifyMatIn(data);
	}
	
	//정산 페이지에서 matLot 조회
	@GetMapping("getMatLotList")
	@ResponseBody
	public List<MatInVO> getMatLotList(MatLotStockVO vo){
		return mis.getMatLotModal(vo);
	}
	
	
	//자재모달창 검색 ajax
	@GetMapping("getMatModalSearch")
	@ResponseBody
	public List<MatModalVO> getMatModalSearch(String matName){
		return mms.selectModalSearch(matName);
	}
}
