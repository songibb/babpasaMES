package co.yedam.app.material.stock.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import co.yedam.app.material.stock.service.MatLotStockService;
import co.yedam.app.material.stock.service.MatLotStockVO;
import co.yedam.app.material.stock.service.MatStockService;

@Controller
public class MatStockController {
	
	@Autowired
	MatStockService mss;
	
	@Autowired
	MatLotStockService mlss;
	
	@GetMapping("matStockList")
	public String getMatStockList(@RequestParam(value="materialCode", required=false) String materialCode, Model model) {
		model.addAttribute("stockList", mss.selectMatStockList(materialCode));
		return "material/matStockList";
	}
	
	//전체 재고에서 선택하면 해당 제품 LOT별 조회
	@GetMapping("matLotStockList")
	@ResponseBody
	public List<MatLotStockVO> getMatLotStckList(@RequestParam(value="materialCode", required=false) String materialCode){
		List<MatLotStockVO> vo = mlss.selectMatLotStockList(materialCode);
		return vo;
	}
}
