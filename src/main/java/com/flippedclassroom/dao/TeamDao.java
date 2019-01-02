package com.flippedclassroom.dao;

import com.flippedclassroom.entity.Team;
import com.flippedclassroom.entity.TeamStrategy;
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

    void dismissTableTeamStudent(@Param("0") int team);

    void dismissTableKlassTeam(@Param("0") int team);

    void dismissTableTeam(@Param("0") int team);

    Team getTeamByTeamID(@Param("0") int teamId);

    void insertValidTableTeam(@Param("0") int klassId, @Param("1") int courseId, @Param("2") int id, @Param("3") String teamName, @Param("4") int teamSerial, @Param("5") int klassSerial);

    void insertTableTeamStudent(@Param("0") int teamid, @Param("1") int team);

    void insertTableKlassTeam(@Param("0") int klassId, @Param("1") int teamid);

    void insertInValidTableTeam(@Param("0") int klassId, @Param("1") int courseId, @Param("2") int id, @Param("3") String teamName, @Param("4") int teamSerial, @Param("5") int klassSerial);

    void changeStatusByTeamId(@Param("0") int team);

    Team getTeamByKlassAndId(@Param("0") int id,@Param("1") int klassId);

    int getMaxTeamSerialByKlassId(@Param("0") int klass);

    int getTeamIdByLeaderIdAndCourseId(@Param("0") int id,@Param("1") int courseId);
}
