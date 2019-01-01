package com.flippedclassroom.dao;

import com.flippedclassroom.entity.RoundScore;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
/**
 * @author KEKE
 */
@Repository
public interface RoundScoreDao {
    /**
     * get RoundScore By RoundID
     *
     * @param roundIds
     * @return
     */
    List<RoundScore> getRoundScoreByRoundID(@Param("roundIds") List<Integer> roundIds);

    /**
     * updateRoundScoreByRoundIdTeamId
     *
     * @param roundId
     * @param teamId
     * @param totalScore
     * @param preScore
     * @param qaScore
     * @param reportScore
     */
    void updateRoundScoreByRoundIdTeamId(@Param("0") int roundId, @Param("1") int teamId, @Param("2") double totalScore, @Param("3") double preScore, @Param("4") double qaScore, @Param("5") double reportScore);

}