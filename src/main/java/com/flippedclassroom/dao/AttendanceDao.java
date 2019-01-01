package com.flippedclassroom.dao;

import com.flippedclassroom.entity.Attendance;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author KEKE
 */
@Repository
public interface AttendanceDao {
    /**
     * insert Attend By Team Id And SeminarId
     *
     * @param teamid
     * @param klassSeminarid
     * @param order
     */
    void insertAttendByTeamIdAndSeminarId(@Param("0") int teamid, @Param("1") int klassSeminarid, @Param("2") int order);

    /**
     * getAttendanceByKlassSeminarId
     *
     * @param klassSeminarId
     * @return
     */
    List<Attendance> getAttendanceByKlassSeminarId(@Param("0") int klassSeminarId);

    /**
     * getAttendanceByKlassSeminarIdAndTeamId
     *
     * @param id
     * @param teamid
     * @return
     */
    Attendance getAttendanceByKlassSeminarIdAndTeamId(@Param("0") int id, @Param("1") int teamid);

    /**
     * uploadPPT
     *
     * @param url
     * @param fileName
     * @param klassSeminarId
     * @param teamId
     */
    void uploadPPT(@Param("0") String url, @Param("1") String fileName,
                   @Param("2") int klassSeminarId, @Param("3") int teamId);

    /**
     * uploadReport
     *
     * @param url
     * @param fileName
     * @param klassSeminarId
     * @param teamId
     */
    void uploadReport(@Param("0") String url, @Param("1") String fileName,
                      @Param("2") int klassSeminarId, @Param("3") int teamId);

    /**
     *  updateAttendByTeamIdAndSeminarId
     * @param teamid
     * @param klassSeminarid
     * @param order
     */
    void updateAttendByTeamIdAndSeminarId(@Param("0") int teamid, @Param("1") int klassSeminarid, @Param("2") int order);

    /**
     *  deleteEnroll
     * @param teamid
     * @param klassSeminarId
     */
    void deleteEnroll(@Param("0") int teamid,@Param("1")  int klassSeminarId);
}
