package com.flippedclassroom.dao;

import org.apache.ibatis.annotations.Param;

/**
 * @author DELL
 */
public interface ShareTeamApplicationDao {
    /**
     * createShareTeamApplication
     * @param mainId
     * @param subId
     * @param subTeacherId
     */
    void createShareTeamApplication(@Param("0") int mainId,
                                    @Param("1")int subId,@Param("2") int subTeacherId);
}
