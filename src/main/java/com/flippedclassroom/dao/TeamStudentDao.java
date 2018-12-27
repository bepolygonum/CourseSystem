package com.flippedclassroom.dao;

import com.flippedclassroom.entity.TeamStudent;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author KEKE
 */
public interface TeamStudentDao {
    /**
     * getTeamStudentsByTeamIds
     * @param teamIds
     * @return
     */
    List<TeamStudent> getTeamStudentsByTeamIds(@Param("teamIds") List<Integer> teamIds);
}
