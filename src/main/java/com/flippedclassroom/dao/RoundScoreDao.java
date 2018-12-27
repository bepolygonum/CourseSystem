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
     * @param roundIds
     * @return
     */
    List<RoundScore> getRoundScoreByRoundID(@Param("roundIds") List<Integer> roundIds);
}
