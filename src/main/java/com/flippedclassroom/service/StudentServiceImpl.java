package com.flippedclassroom.service;
import com.flippedclassroom.dao.StudentDao;
import com.flippedclassroom.entity.Student;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author KEKE
 */
@Service(value = "StudentService")
public class StudentServiceImpl {
    @Autowired
    StudentDao studentDao;

    public Student getStudentByID(int studentId) {
        return studentDao.getStudentByID(studentId);
    }

    public Student getStudentByAccount(String account, String password) {
        return studentDao.getStudentByAccount(account,password);
    }

    public void setEmailByID(int studentId, String newmail) {studentDao.setEmailByID(studentId, newmail);}

    public List<Student> getStudentByStudentID(List<Integer> studentIds)
    {
        return studentDao.getStudentByStudentID(studentIds);
    }

    public void setPassByID(int id, String newpass) {studentDao.setPassByID(id, newpass);
    }
}
