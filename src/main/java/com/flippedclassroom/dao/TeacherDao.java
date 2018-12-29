package com.flippedclassroom.dao;

import com.flippedclassroom.entity.Teacher;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author KEKE
 */
@Repository
public interface TeacherDao {
    /**
     * get Teacher By Account
     * @param account
     * @param password
     * @return
     */
    Teacher getTeacherByAccount(@Param("0") String account, @Param("1") String password);

    /**
     * get Teacher By Info
     * @param info
     * @return
     */
    List<Teacher> getTeacherByInfo(@Param("0") String info);

    /**
     * get Teachers By TeacherID
     * @param teacherIds
     * @return
     */
    List<Teacher> getTeachersByTeacherID(List<Integer> teacherIds);

    /**
     * get Teacher By TeacherID
     * @param teacherId
     * @return
     */
    Teacher getTeacherByTeacherID(@Param("0") int teacherId);

    /**
     * getAllTeachers
     * @return
     */
    List<Teacher> getAllTeachers();

    /**
     * setEmailByID
     * @param teacherId
     * @param newmail
     */
    void setEmailByID(@Param("0")int teacherId, @Param("1")String newmail);

    /**
     * getTeacherByAccount
     * @param account
     * @return
     */
    Teacher getTeacherByAccounti(String account);

    void setPassByID(@Param("0") int id, @Param("1") String newpass);

    void activate(@Param("0")int id);
}
