package com.flippedclassroom.dao;

import com.flippedclassroom.entity.CourseMemberLimitStrategy;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import javax.jws.WebParam;

/**
 * @author KEKE
 */
@Repository
public interface CourseMemberLimitStrategyDao {
    /**
     * get CourseMemberLimitStrategy By CourseID
     * @param courseId
     * @return
     */
    CourseMemberLimitStrategy getCourseMemberLimitStrategyByCourseID(@Param("0") int courseId);

    /**
     * createCourseMemberLimitStrategy
     * @param courseId
     * @param min
     * @param max
     */
    void createCourseMemberLimitStrategy(@Param("0")int courseId,@Param("1") int min,@Param("2") int max);

    /**
     * selectCourseMemberLimitStrategyMaxId
     * @return
     */
    int selectCourseMemberLimitStrategyMaxId();

    CourseMemberLimitStrategy getCourseMemberLimitStrategyById(@Param("0") int strategyId);
}
