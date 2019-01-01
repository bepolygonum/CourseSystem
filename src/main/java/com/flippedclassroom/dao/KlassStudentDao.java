package com.flippedclassroom.dao;

import com.flippedclassroom.entity.KlassStudent;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author KEKE
 */
@Repository
public interface KlassStudentDao {
    /**
     * get KlassStudent By CourseID
     * @param courseId
     * @return
     */
    List<KlassStudent> getKlassStudentByCourseID(@Param("0") int courseId);

    /**
     * get KlassStudent By StudentId And KlassId
     * @param studentId
     * @param klassid
     * @return
     */
    List<KlassStudent> getKlassStudentByStudentIdAndKlassId(@Param("0") int studentId, @Param("1") int klassid);


    /**
     * deleteKlassStudentByKlassId
     * @param klassId
     */
    void deleteKlassStudentByKlassId(@Param("0") int klassId);

    /**
     * getKlassIdByStudentIdAndSeminarId
     * @param id
     * @param courseid
     * @return
     */
    int getKlassIdByStudentIdAndCourseId(@Param("0")int id, @Param("1")int courseid);

    /**
     * addStudent
     * @param id
     * @param klassId
     * @param courseId
     */
    void addStudent(@Param("0")int id, @Param("1")int klassId, @Param("2")int courseId);
}
