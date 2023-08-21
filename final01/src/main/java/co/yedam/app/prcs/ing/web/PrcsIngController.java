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
import co.yedam.app.prcs.plan.service.PrcsSearchVO;
//20230821 백송이 - 생산 관리, 진행 공정
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
	
	//작업 시작 전 사용 가능한 설비 조회 (진행공정 모달)
	@PostMapping("waitEquipList")
	@ResponseBody
	public List<EquipVO> getPrcsWaitEquipList(@RequestBody PrcsIngVO prcsIngVO){
		List<EquipVO> list = prcsIngService.selectWaitEquipList(prcsIngVO);
		return list;
	}
		
	//작업 시작 후 선택된 설비 조회 (진행공정 모달)
	@PostMapping("selectEquip")
	@ResponseBody
	public List<EquipVO> getEquipList(@RequestParam String prcsDirDeCode, @RequestParam String prcsCode){
		List<EquipVO> list = prcsIngService.selectEquip(prcsDirDeCode, prcsCode);
		return list;
	}
	
	//투입 자재별 소모량 조회 (진행공정 모달)
	@PostMapping("matBomList")
	@ResponseBody
	public List<BomCodeVO> getMatBomList(@RequestBody PrcsIngVO prcsIngVO){
		List<BomCodeVO> list = prcsIngService.selectMatBomList(prcsIngVO);
		return list;
	}
	
	//작업시작 => 공정상태&설비 수정, 공정실적관리 등록 (진행공정 모달)
	@PostMapping("callPrcsStart")
	@ResponseBody
	public int callPrcsStart(PrcsIngVO prcsIngVO) {	
		return prcsIngService.callPrcsStart(prcsIngVO);
	}
	
	//작업종료 => 공정상태&설비 수정, 공정실적관리 수정 (진행공정 모달)
	@PostMapping("callPrcsEnd")
	@ResponseBody
	public int callPrcsEnd(PrcsIngVO prcsIngVO) {	
		return prcsIngService.callPrcsEnd(prcsIngVO);
	}
	
	//데이터 입력된 경우, 공정 실적 관리 조회 (진행공정 모달)
	@GetMapping("selectPrcsInfoList")
	@ResponseBody
	public PrcsIngVO selectPrcsInfoList(@RequestParam String prcsDirDeCode, @RequestParam String prcsCode) {	
		return prcsIngService.selectPrcsInfoList(prcsDirDeCode, prcsCode);
	}
	
	
	//공정 실적 조회 - 페이지 호출
	@GetMapping("prcsResultList")
	public String getPrcsResultList() {
		return "process/prcsResultList";
	}
	
	//공정 실적 조회 (+검색)
	@GetMapping("selectPrcsResultList")
	@ResponseBody
	public List<PrcsIngVO> selectPrcsResultList(PrcsSearchVO prcsSearchVO) {
		return prcsIngService.selectPrcsResultList(prcsSearchVO);
	}
	

	
}
