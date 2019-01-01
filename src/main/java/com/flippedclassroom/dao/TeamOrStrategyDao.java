package com.flippedclassroom.dao;

import com.flippedclassroom.entity.TeamAndStrategy;
import com.flippedclassroom.entity.TeamOrStrategy;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import java.util.List;

/**
 * @author DELL
 */
@Repository
public interface TeamOrStrategyDao {

    void createTeamOrStrategy(@Param("0") int id, @Param("1") String strategyName, @Param("2") int strategyId);

    int selectTeamOrStrategyMaxId();

    List<TeamOrStrategy> getTeamOrStrategyByid(@Param("0") int strategyId);
}
