package com.flippedclassroom.dao;

import com.flippedclassroom.entity.MemberLimitStrategy;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface MemberLimitStrategyDao {

    MemberLimitStrategy getMemberLimitByCourseId(@Param("0") int id);


}
