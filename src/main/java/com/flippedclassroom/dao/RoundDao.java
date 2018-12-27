package com.flippedclassroom.dao;

import com.flippedclassroom.entity.Round;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
/**
 * @author KEKE
 */
@Repository
public interface RoundDao {
    /**
     * get Round By CourseID
     * @param courseId
     * @return
     */
    List<Round> getRoundByCourseID(@Param("0") int courseId);

}
