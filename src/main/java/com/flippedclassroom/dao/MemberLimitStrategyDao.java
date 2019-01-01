package com.flippedclassroom.dao;

import com.flippedclassroom.entity.MemberLimitStrategy;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface MemberLimitStrategyDao {
    /**
     * createMemberLimitStrategy
     * @param minMember
     * @param maxMember
     */
    void createMemberLimitStrategy(@Param("0") int minMember,@Param("1") int maxMember);

    /**
     * selectMaxId
     * @return
     */
    int selectMaxId();

    MemberLimitStrategy getMemberLimitById(@Param("0") int strategyId);
}
