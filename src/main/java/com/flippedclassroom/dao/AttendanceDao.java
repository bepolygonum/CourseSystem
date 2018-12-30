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
     * @param teamid
     * @param seminarid
     * @param order
     */
    void insertAttendByTeamIdAndSeminarId(@Param("0") int teamid,@Param("1")  int seminarid, @Param("2") int order);

    /**
     * getAttendanceByKlassSeminarId
     * @param klassSeminarId
     * @return
     */
    List<Attendance> getAttendanceByKlassSeminarId(@Param("0") int klassSeminarId);
}
