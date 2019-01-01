package com.flippedclassroom.dao;

import com.flippedclassroom.entity.TeamValidApplication;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author DELL
 */
public interface TeamValidApplicationDao {
    /**
     * selectAllTeamValidApplication
     * @return
     */
    List<TeamValidApplication> selectUntreatedTeamValidApplicationByTeacherId(@Param("0")int teacherId);

}
