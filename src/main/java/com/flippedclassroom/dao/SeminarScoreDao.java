package com.flippedclassroom.dao;

import com.flippedclassroom.entity.SeminarScore;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
/**
 * @author KEKE
 */
@Repository
public interface SeminarScoreDao {
    /**
     * get SeminarScore By KlassSeminarID
     * @param klassSeminarIds
     * @return
     */
    List<SeminarScore> getSeminarScoreByKlassSeminarID(List<Integer> klassSeminarIds);

    /**
     * insert Enroll By TeamId And SeminarId
     * @param teamid
     * @param seminarid
     */
    void insertEnrollByTeamIdAndSeminarId(@Param("0") int teamid, @Param("1") int seminarid);

    /**
     * updateSeminarScoreByKlassSeminarIdTeamId
     * @param klassSeminarId
     * @param teamId
     * @param preScore
     * @param qaScore
     * @param reportScore
     */
    void updateSeminarScoreByKlassSeminarIdTeamId(@Param("0") int klassSeminarId,@Param("1") int teamId,@Param("2") double preScore,@Param("3") double qaScore,@Param("4") double reportScore);

    List<SeminarScore> getSeminarScoreByKlassSeminarIDTeamID(@Param("klassSeminarIds") List<Integer> klassSeminarIds,@Param("0")int teamId);

    /**
     * updateSeminarReportScoreByKlassSeminarIdTeamId
     * @param klassSeminarId
     * @param teamId
     * @param reportScore
     */
    void updateSeminarReportScoreByKlassSeminarIdTeamId(@Param("0") int klassSeminarId,@Param("1") int teamId,@Param("2") double reportScore);

}
