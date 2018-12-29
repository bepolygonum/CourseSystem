package com.flippedclassroom.dao;

import com.flippedclassroom.entity.Student;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author KEKE
 */
@Repository
public interface StudentDao {
    /**
     * get Student By Account
     * @param account
     * @param password
     * @return
     */
    Student getStudentByAccount(@Param("0") String account, @Param("1") String password);

    /**
     * get Student By StudentID
     * @param studentIds
     * @return
     */
    List<Student> getStudentByStudentID(List<Integer> studentIds);

    /**
     * get Student By ID
     * @param studentId
     * @return
     */
    Student getStudentByID(@Param("0") int studentId);

    /**
     * setEmailByID
     * @param studentId
     * @param newmail
     */
    void setEmailByID(@Param("0") int studentId, @Param("1") String newmail);

    /**
     * setPassByID
     * @param id
     * @param newpass
     */
    void setPassByID(@Param("0") int id, @Param("1") String newpass);

    /**
     * getStudentByAccount
     * @param account
     * @return
     */
    Student getStudentByAccounti(String account);

    /**
     * active
     * @param id
     */
    void activate(int id);

    /**
     * resetStudent
     * @param account
     */
    void resetStudent(String account);
}
