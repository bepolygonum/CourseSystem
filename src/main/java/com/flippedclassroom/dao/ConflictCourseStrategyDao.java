package com.flippedclassroom.dao;

import com.flippedclassroom.entity.ConflictCourseStrateqy;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author KEKE
 */
@Repository
public interface ConflictCourseStrategyDao {


    /**
     * getIdByCourseID
     * @param courseId
     * @return
     */
    int getIdByCourseID(@Param("0") int courseId);

    /**
     * getCourseIdByID
     * @param cid
     * @return
     */
    List<Integer> getCourseIdByID(@Param("0") int cid);

    /**
     *  getAllConflictId
     * @return
     */
    List<Integer> getAllConflictId();

    /**
     * create Harf Of Conflict Course
     * @param id
     * @param courseId
     */
    void createHarfOfConflictCourse(@Param("0") int id, @Param("1") int courseId);

    /**
     * selectConflictCourseStrategyMaxId
     * @return
     */
    int selectConflictCourseStrategyMaxId();

    List<ConflictCourseStrateqy> getConflictCourseStrategy(@Param("0") int strategyId);
}
