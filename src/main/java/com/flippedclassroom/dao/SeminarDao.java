package com.flippedclassroom.dao;

import com.flippedclassroom.entity.Attendance;
import com.flippedclassroom.entity.Seminar;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.sql.Timestamp;
import java.util.List;
/**
 * @author KEKE
 */
@Repository
public interface SeminarDao {
    /**
     * get Seminar By RoundID
     * @param roundIds
     * @param courseId
     * @return
     */
    List<Seminar> getSeminarByRoundID( @Param("roundIds") List<Integer> roundIds, @Param("courseId") int courseId);

    /**
     * get Seminar By CourseID
     * @param courseid
     * @return
     */
    List<Seminar> getSeminarByCourseID(@Param("0") int courseid);

    /**
     * getSeminarBySeminarID
     * @param seminarid
     * @return
     */
    Seminar getSeminarBySeminarID(@Param("0") int seminarid);


    /**
     * getSeminarBySeminarName
     * @param seminarName
     * @return
     */
    Seminar getSeminarBySeminarName(@Param("0") String seminarName);

    /**
     * createASeminar
     * @param courseId
     * @param roundId
     * @param seminarName
     * @param introduction
     * @param maxTeam
     * @param isVisible
     * @param seminarSerial
     * @param startTime
     * @param endTime
     */
    void createASeminar(@Param("0") int courseId, @Param("1") int roundId,
                        @Param("2") String seminarName, @Param("3") String introduction,
                        @Param("4") int maxTeam, @Param("5") int isVisible,
                        @Param("6") int seminarSerial,@Param("7") Timestamp startTime,
                        @Param("8") Timestamp endTime);

    /**
     * selectSeminarIdsByRoundId
     * @param roundId
     * @return
     */
    List<Integer> selectSeminarIdsByRoundId(@Param("0") int roundId);

    List<Seminar> selectSeminarsByRoundId(@Param("0") int roundId);


    int getSeminarMaxId();

    Integer getSeminarMaxSerialByCourseId(int courseId);
}
