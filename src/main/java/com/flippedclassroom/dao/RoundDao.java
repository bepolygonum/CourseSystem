package com.flippedclassroom.dao;

import com.flippedclassroom.entity.Round;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
/**
 * @author KEKE
 */
@Repository
public interface RoundDao {
    /**
     * get Round By CourseID
     * @param courseId
     * @return
     */
    List<Round> getRoundByCourseID(@Param("0") int courseId);

    Round getRoundByRoundID(@Param("0") int roundId);

    void updateRoundByRoundId(@Param("0")int roundId,@Param("1")int presentationScoreMethod,@Param("2")int reportScoreMethod,@Param("3")int questionScoreMethod);

    void createRound(@Param("0")int courseId,@Param("1")int roundSerial,@Param("2")int preMethod,@Param("3")int reMethod,@Param("4")int qaMethod);

    int getRoundMaxId();
}
