package co.yedam.app.prcs.ing.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import co.yedam.app.prcs.ing.service.PrcsIngService;
import co.yedam.app.prcs.ing.service.PrcsIngVO;

@Controller
public class PrcsIngController {

	@Autowired
	PrcsIngService prcsIngService;
	

	//진행 공정 조회
	@GetMapping("prcsIngList")
	@ResponseBody
	public List<PrcsIngVO> getPrcsIngList(@RequestParam String prcsDirDeCode, @RequestParam String prodCode){
		List<PrcsIngVO> list = prcsIngService.getPrcsIngList(prcsDirDeCode, prodCode);
		return list;
	}
	
	//공정 실적 조회

	
}
