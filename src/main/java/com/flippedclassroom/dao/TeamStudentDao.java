package com.flippedclassroom.dao;

import com.flippedclassroom.entity.TeamStudent;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author KEKE
 */
@Repository
public interface TeamStudentDao {
    /**
     * getTeamStudentsByTeamIds
     * @param teamIds
     * @return
     */
    List<TeamStudent> getTeamStudentsByTeamIds(@Param("teamIds") List<Integer> teamIds);
}
