package com.flippedclassroom.dao;

import com.flippedclassroom.entity.Team;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
/**
 * @author KEKE
 */
@Repository
public interface TeamDao {
    /**
     * get Team By CourseID
     * @param courseId
     * @return
     */
    List<Team> getTeamByCourseID(@Param("0") int courseId);

    /**
     * get Team By Id
     * @param teamid
     * @return
     */
    Team getTeamById(@Param("0") int teamid);

    /**
     * getTeamIdById
     * @param id
     * @return
     */
    List getTeamIdByStudentId(@Param("0") int id);

    /**
     * getStudentByTeamID
     * @param id
     * @return
     */
    List getStudentIdByTeamId(@Param("0") int id);

    /**
     * getTeamByKlassID
     * @param ids
     * @return
     */
    List<Integer> getTeamIdByKlassId(List<Integer> ids);

    /**
     * getTeamByIds
     * @param ids
     * @return
     */
    List<Team> getTeamByIds(List<Integer> ids);
}
