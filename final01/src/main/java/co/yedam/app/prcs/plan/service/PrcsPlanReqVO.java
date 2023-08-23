package co.yedam.app.prcs.plan.service;

import java.util.List;

import lombok.Data;

@Data
public class PrcsPlanReqVO {
	PrcsPlanVO prcsPlanVO;
	List<PrcsPlanVO> insertList;
	
	List<PrcsPlanVO> updateList;
	List<PrcsPlanVO> updateDeList;
	
}
