package com.flippedclassroom.dao;

import com.flippedclassroom.entity.Klass;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
/**
 * @author KEKE
 */
@Repository
public interface KlassDao {
    /**
     * get KlassID By CourseID
     * @param courseId
     * @return
     */
    List<Integer> getKlassIDByCourseID(@Param("0") int courseId);

    /**
     *  get KlassID By StudentID
     * @param id
     * @return
     */
    List getKlassIDByStudentID(@Param("0") int id);

    /**
     * get Klass By KlassID
     * @param id
     * @return
     */
    Klass getKlassByKlassID(@Param("0") int id);

    /**
     *  get Klass By CourseID
     * @param courseId
     * @return
     */
    List<Klass> getKlassByCourseID(@Param("0") int courseId);

    /**
     *  createAKlass
     * @param courseId
     * @param grade
     * @param klassSerial
     * @param klassTime
     * @param location
     */
    void createAKlass(@Param("0") int courseId, @Param("1") int grade,
                      @Param("2") int klassSerial,@Param("3")  String klassTime,
                      @Param("4") String location);

    void deleteKlassByKlassId(@Param("0")int klassId);
}
