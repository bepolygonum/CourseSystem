package com.flippedclassroom.dao;

import com.flippedclassroom.entity.ShareTeamApplication;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author DELL
 */
@Repository
public interface ShareTeamApplicationDao {
    /**
     * createShareTeamApplication
     * @param mainId
     * @param subId
     * @param subTeacherId
     */
    void createShareTeamApplication(@Param("0") int mainId,
                                    @Param("1")int subId,@Param("2") int subTeacherId);


    /**
     * selectUntreatedShareTeamApplicationByTeacherId
     * @param teacherId
     * @return
     */
    List<ShareTeamApplication> selectUntreatedShareTeamApplicationByTeacherId(@Param("0")int teacherId);

    void setStatus(@Param("0")  int maincourseid, @Param("1") int subcourseid, @Param("2") int i);
}
