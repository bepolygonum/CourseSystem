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
     * updateQuestionScoreByKlassSeminarIdAndTeamId
     * @param questionScore
     * @param klassSeminarId
     * @param teamId
     * @return
     */
   Integer updateQuestionScoreByKlassSeminarIdAndTeamId(Integer questionScore, Integer klassSeminarId, Integer teamId);

    /**
     * updatePresentationScoreByKlassSeminarIdAndTeamId
     * @param presentationScore
     * @param klassSeminarId
     * @param teamId
     * @return
     */
   Integer updatePresentationScoreByKlassSeminarIdAndTeamId(Integer presentationScore, Integer klassSeminarId, Integer teamId);
}
