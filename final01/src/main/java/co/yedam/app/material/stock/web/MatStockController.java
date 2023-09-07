package co.yedam.app.material.stock.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import co.yedam.app.material.in.service.MatModalService;
import co.yedam.app.material.stock.service.MatLotStockService;
import co.yedam.app.material.stock.service.MatLotStockVO;
import co.yedam.app.material.stock.service.MatStockService;
import co.yedam.app.material.stock.service.MatStockVO;

@Controller
public class MatStockController {
	//전체조회 중 header
	@Autowired
	MatStockService mss;
	
	//전체조회 중 detail
	@Autowired
	MatLotStockService mlss;
	
	//자재목록 모달
	@Autowired
	MatModalService mms;
	
	@GetMapping("matStockList")
	public String getMatStockList(@RequestParam(value="materialCode", required=false) String materialCode, Model model) {
		model.addAttribute("stockList", mss.selectMatStockList(materialCode));
		model.addAttribute("matList", mms.getMetList());
		return "material/matStockList";
	}
	
	//전체 재고에서 선택하면 해당 제품 LOT별 조회
	@GetMapping("matLotStockList")
	@ResponseBody
	public List<MatLotStockVO> getMatLotStckList(MatLotStockVO vo){
		List<MatLotStockVO> findVO = mlss.selectMatLotStockList(vo);
		return findVO;
	}
	
	//검색 ajax
	@GetMapping("getMatStockFilter")
	@ResponseBody
	public List<MatStockVO> getMatStockFilter(@RequestParam(value="materialCode", required=false) String materialCode) {
		List<MatStockVO> vo = mss.selectMatStockList(materialCode);
		return vo;
	}
}
