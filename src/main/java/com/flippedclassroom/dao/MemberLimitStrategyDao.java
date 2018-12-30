package com.flippedclassroom.dao;

import org.apache.ibatis.annotations.Param;

/**
 * @author DELL
 */
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
}
