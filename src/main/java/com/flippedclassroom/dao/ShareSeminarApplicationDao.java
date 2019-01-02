package com.flippedclassroom.dao;

import com.flippedclassroom.entity.ShareSeminarApplication;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author DELL
 */
@Repository
public interface ShareSeminarApplicationDao {

    /**
     * createShareSeminarApplication
     * @param mainId
     * @param subId
     * @param subTeacherId
     */
    void createShareSeminarApplication(@Param("0") int mainId,
                                       @Param("1") int subId, @Param("3")int subTeacherId);


    /**
     * selectUntreatedShareSeminarApplicationByTeacherId
     * @param teacherId
     * @return
     */
    List<ShareSeminarApplication> selectUntreatedShareSeminarApplicationByTeacherId(@Param("0")int teacherId);


}
