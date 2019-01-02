package com.flippedclassroom.dao;

import com.flippedclassroom.entity.Course;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.sql.Timestamp;
import java.util.List;

/**
 * @author KEKE
 */
@Repository

public interface CourseDao {
    /**
     * get all courses by its teacher id
     * @param id teacher id
     * @return List of course
     */
    List<Course> getCourseByTeacherID(@Param("0") int id);

    /**
     * get all courses by list of course id
     * @param courseIds
     * @return
     */
    List<Course> getCoursesByCourseID(List<Integer> courseIds);

    /**
     * get all courses by student id
     * @param id
     * @return
     */
    List getCourseByStudentID(@Param("0")int id);

    /**
     * get all courses by course id
     * @param id
     * @return
     */
    Course getCourseByCourseID(@Param("0")int id);

    /**
     * get all courses by SeminarMainCourseID
     * @param id
     * @return
     */
    List<Course> getCourseBySeminarMainCourseID(@Param("0")int id);

    /**
     * get all courses by TeamMainCourseID
     * @param id
     * @return
     */
    List<Course> getCourseByTeamMainCourseID(@Param("0")int id);

    /**
     * getAllCourses
     * @return
     */
    List<Course> getAllCourses();

    /**
     * getCourseByCourseName
     * @param courseName
     * @return
     */
    Course getCourseByCourseName(@Param("0")String courseName);

    /**
     * createACourse
     * @param teacherId
     * @param courseName
     * @param introduction
     * @param presentationPercentage
     * @param questionPercentage
     * @param reportPercentage
     * @param teamStartTime
     * @param teamEndTime
     */
    void createACourse(@Param("0")int teacherId, @Param("1")String courseName, @Param("2")String introduction,
                       @Param("3")int presentationPercentage, @Param("4")int questionPercentage,
                       @Param("5")int reportPercentage,@Param("6") Timestamp teamStartTime,
                       @Param("7")Timestamp teamEndTime);

    /**
     * updateCourseSeminarMainIdByCourseId
     * @param courseId
     */
    void updateCourseSeminarMainIdByCourseId(@Param("0") int courseId);

    /**
     * updateCourseTeamMainIdByCourseId
     * @param courseId
     */
    void updateCourseTeamMainIdByCourseId(@Param("0") int courseId);

    /**
     * deleteCourseByCourseId
     * @param courseId
     */
    void deleteCourseByCourseId(@Param("0") int courseId);

    int getTeacherIdByCourseId(@Param("0") int courseId);

    void setCourseTeamMainIdByCourseId(@Param("0") int maincourseid,@Param("1")  int subcourseid);
}
