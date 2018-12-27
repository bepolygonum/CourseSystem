package com.flippedclassroom.service;
import com.flippedclassroom.dao.TeacherDao;
import com.flippedclassroom.entity.Teacher;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author KEKE
 */
@Service(value = "TeacherService")
public class TeacherServiceImpl {
    @Autowired
    TeacherDao teacherDao;

    public Teacher getTeacherByAccount(String account, String password) {
        return teacherDao.getTeacherByAccount(account,password);
    }

    public List<Teacher> getTeacherByInfo(String info) {
        return teacherDao.getTeacherByInfo(info);
    }

    public List<Teacher> getTeachersByTeacherID(List<Integer> teacherIds)
    {
        return teacherDao.getTeachersByTeacherID(teacherIds);
    }

    public  Teacher getTeacherByTeacherID(int teacherId){return teacherDao.getTeacherByTeacherID(teacherId);}

    public List<Teacher> getAllTeachers() {return teacherDao.getAllTeachers();}

    public void setEmailByID(int teacherId, String newmail) {teacherDao.setEmailByID(teacherId, newmail);}

}
