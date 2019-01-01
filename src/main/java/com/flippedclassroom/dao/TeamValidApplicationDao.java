package com.flippedclassroom.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface TeamValidApplicationDao {

    /**
     * send invalid reason
     * @param reason
     * @return
     */
    void sendApplication(@Param("0") int teamid, @Param("1") int teacherid, @Param("2") String reason);
}
