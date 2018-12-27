package com.flippedclassroom.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author KEKE
 */
@Repository
public interface ConflictCourseStrategyDao {

    /**
     * get course_2_id by course id
     * @param courseId 课程id
     * @return List of course_2_id
     */
    List<Integer> getCourse2IDByCourseID(@Param("0") int courseId);

    /**
     * get course_1_id by course id
     * @param courseId 课程id
     * @return List of course_1_id
     */
    List<Integer> getCourse1IDByCourseID(@Param("0") int courseId);

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
}
