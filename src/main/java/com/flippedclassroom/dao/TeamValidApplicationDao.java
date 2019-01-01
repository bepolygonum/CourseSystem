package com.flippedclassroom.dao;

import com.flippedclassroom.entity.TeamValidApplication;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;


import java.util.List;

/**
 * @author DELL
 */
public interface TeamValidApplicationDao {
    /**
     * selectAllTeamValidApplication
     * @return
     */
    List<TeamValidApplication> selectUntreatedTeamValidApplicationByTeacherId(@Param("0")int teacherId);

    /**
     * send invalid reason
     * @param reason
     * @return
     */
    void sendApplication(@Param("0") int teamid, @Param("1") int teacherid, @Param("2") String reason);

}
