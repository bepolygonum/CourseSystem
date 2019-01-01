package com.flippedclassroom.service;
import com.flippedclassroom.dao.KlassDao;
import com.flippedclassroom.dao.KlassStudentDao;
import com.flippedclassroom.dao.StudentDao;
import com.flippedclassroom.entity.Klass;
import com.flippedclassroom.entity.KlassStudent;
import com.flippedclassroom.entity.Student;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * @author KEKE
 */
@Service(value = "ImportFileService")
public class ImportFileServiceImpl {
    @Autowired
    private StudentDao studentDao;
    @Autowired
    private KlassStudentDao klassStudentDao;
    @Autowired
    private KlassDao klassDao;

    public void saveBath(List<String[]> list,String klassid) {
        int klassId=Integer.parseInt(klassid);
        Klass klass=klassDao.getKlassByKlassID(klassId);
        int courseId=klass.getCourseId();
        klassStudentDao.deleteKlassStudentByKlassId(klassId);
        for (String[] strings : list) {
            Student student=studentDao.getStudentByAccounti(strings[0]);
            if(student==null){
                studentDao.addStudent(strings[0],strings[1]);
                student=studentDao.getStudentByAccounti(strings[0]);
            }
            if(klassStudentDao.getKlassStudentByStudentIdAndKlassId(student.getId(),klassId).size()==0) {
                klassStudentDao.addStudent(student.getId(),klassId,courseId);
            }
        }
    }
}