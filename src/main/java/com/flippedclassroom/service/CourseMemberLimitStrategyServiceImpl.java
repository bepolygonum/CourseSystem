package com.flippedclassroom.service;

import com.flippedclassroom.dao.CourseMemberLimitStrategyDao;
import com.flippedclassroom.entity.CourseMemberLimitStrategy;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author KEKE
 */
@Service(value = "CourseMemberLimitStrategyService")
public class CourseMemberLimitStrategyServiceImpl {
    @Autowired
    CourseMemberLimitStrategyDao courseMemberLimitStrategyDao;

    public CourseMemberLimitStrategy getCourseMemberLimitStrategyByCourseID(int courseId) {
        return courseMemberLimitStrategyDao.getCourseMemberLimitStrategyByCourseID(courseId);
    }

    public int createCourseMemberLimitStrategy(int courseId,int min,int max)
    {
        courseMemberLimitStrategyDao.createCourseMemberLimitStrategy(courseId,min,max);
        return courseMemberLimitStrategyDao.selectCourseMemberLimitStrategyMaxId();
    }
}
