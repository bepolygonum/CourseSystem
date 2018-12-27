package com.flippedclassroom.dao;

import com.flippedclassroom.entity.CourseMemberLimitStrategy;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

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

}
