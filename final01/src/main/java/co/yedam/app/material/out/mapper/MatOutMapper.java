package co.yedam.app.material.out.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import co.yedam.app.material.out.service.MatOutVO;

public interface MatOutMapper {
	public List<MatOutVO> selectMatOutList(@Param("materialCode")String materialCode, @Param("accountCode")String accountCode, @Param("startDate")String startDate, @Param("endDate")String endDate);
}
