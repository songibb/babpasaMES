package co.yedam.app.prcs.ing.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import co.yedam.app.common.bom.service.BomCodeVO;
import co.yedam.app.equip.service.EquipVO;
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
		List<PrcsIngVO> list = prcsIngService.selectPrcsIngList(prcsDirDeCode, prodCode);
		return list;
	}
	
	//사용 가능한 설비 조회 (진행공정 모달)
	@PostMapping("waitEquipList")
	@ResponseBody
	public List<EquipVO> getPrcsWatiEquipList(@RequestBody PrcsIngVO prcsIngVO){
		List<EquipVO> list = prcsIngService.selectWaitEquipList(prcsIngVO);
		return list;
	}

		
	//투입 자재별 소모량 조회 (진행공정 모달)
	@PostMapping("matBomList")
	@ResponseBody
	public List<BomCodeVO> getMatBomList(@RequestBody PrcsIngVO prcsIngVO){
		List<BomCodeVO> list = prcsIngService.selectMatBomList(prcsIngVO);
		return list;
	}
	
	
	
	//공정 실적 조회
	@GetMapping("prcsResultList")
	public String getPrcsDirAllList() {
		return "process/prcsResultList";
	}
	
}
