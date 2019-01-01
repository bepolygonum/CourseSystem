package com.flippedclassroom.service;
import com.flippedclassroom.dao.StudentDao;
import com.flippedclassroom.entity.Student;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author KEKE
 */
@Service(value = "StudentService")
public class StudentServiceImpl {
    @Autowired
    StudentDao studentDao;
    /**
     * 第一次登录时获取该学生信息
     */
    public Student getCurStudent(){
        UserDetails userDetails=(UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String account=userDetails.getUsername();
        return studentDao.getStudentByAccounti(account);
    }

    public Student getStudentByID(int studentId) {
        return studentDao.getStudentByID(studentId);
    }

    public Student getStudentByAccount(String account, String password) {
        return studentDao.getStudentByAccount(account,password);
    }
    public Student getStudentByAccounti(String account) {
        return studentDao.getStudentByAccounti(account);
    }

    public void setEmailByID(int studentId, String newmail) {studentDao.setEmailByID(studentId, newmail);}

    public List<Student> getStudentByStudentID(List<Integer> studentIds)
    {
        return studentDao.getStudentByStudentID(studentIds);
    }

    public void setPassByID(int id, String newpass) {studentDao.setPassByID(id, newpass);
    }

    public void activate(int id) {
        studentDao.activate(id);
    }

    public void resetStudent(String account){
        studentDao.resetStudent(account);
    }

}
