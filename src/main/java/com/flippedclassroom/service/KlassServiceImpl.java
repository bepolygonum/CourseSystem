package com.flippedclassroom.service;

import com.flippedclassroom.dao.*;
import com.flippedclassroom.entity.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/**
 * @author KEKE
 */
@Service(value = "KlassService")
public class KlassServiceImpl {
    @Autowired
    KlassDao klassDao;
    @Autowired
    KlassStudentDao klassStudentDao;
    @Autowired
    KlassSeminarDao klassSeminarDao;
    @Autowired
    SeminarScoreDao seminarScoreDao;
    @Autowired
    KlassRoundDao klassRoundDao;

    public List<SeminarScore> getSeminarScoreByCourseSeminarID(int courseId, List<Integer> seminarIds)
    {
        //根据课程id获得所有班级id
        List<Integer> klassIds=klassDao.getKlassIDByCourseID(courseId);
        List<Integer> klassSeminarIds=klassSeminarDao.getKlassSeminarIDByKlassIdSeminarID(klassIds,seminarIds);
        List<SeminarScore> seminarScores=seminarScoreDao.getSeminarScoreByKlassSeminarID(klassSeminarIds);
        return  seminarScores;
    }

    public List<KlassSeminar> getKlassSeminarByCourseSeminarID(int courseId, List<Integer> seminarIds)
    {
        //根据课程id获得所有班级id
        List<Integer> klassIds=klassDao.getKlassIDByCourseID(courseId);
        List<KlassSeminar> klassSeminars=klassSeminarDao.getKlassSeminarByKlassIdSeminarID(klassIds,seminarIds);
        return klassSeminars;
    }

    public List<Klass> getKlassByStudentID(int id) {
        List klassid=klassDao.getKlassIDByStudentID(id);
        List<Klass> klasses=new ArrayList<Klass>();
        Iterator it = klassid.iterator();
        while(it.hasNext()){
            klasses.add(klassDao.getKlassByKlassID(Integer.valueOf(it.next().toString())));
        }
        return  klasses;
    }

    public List<KlassStudent> getKlassStudentByCourseID(int courseId)
    {
        return klassStudentDao.getKlassStudentByCourseID(courseId);
    }


    public List<Klass> getKlassByCourseID(int courseId)
    {
        return klassDao.getKlassByCourseID(courseId);
    }


    public List<KlassStudent> getKlassStudentByStudentIdAndKlassId(int studentId, int klassid) {
        return klassStudentDao.getKlassStudentByStudentIdAndKlassId(studentId,klassid);
    }


    public Klass getKlassByKlassID(int klassId) {
        return klassDao.getKlassByKlassID(klassId);
    }

    public List<Klass> getKlassesByKlassIDs(List<Integer> klassIds)
    {
        List<Klass> klassList=new ArrayList<>();
        for(int i=0;i<klassIds.size();i++)
        {
            if(!klassList.contains(klassIds.get(i)))
            {
                klassList.add(klassDao.getKlassByKlassID(klassIds.get(i)));
            }
        }
        return klassList;
    }

    public List<KlassSeminar> getKlassSeminarBySeminarID(List<Integer> seminarIds){
        return klassSeminarDao.getKlassSeminarBySeminarID(seminarIds);
    }

    public List<KlassSeminar> getKlassSeminarByKlassIdAndSeminarId(int klassId, int seminarid) {
        List list=new ArrayList(),list1=new ArrayList();
        list.add(klassId);
        list1.add(seminarid);
        return klassSeminarDao.getKlassSeminarByKlassIdSeminarID(list,list1);
    }

    public void createAKlass(int courseId,int grade,int klassSerial,String klassTime,String location)
    { klassDao.createAKlass(courseId,grade,klassSerial,klassTime,location);}

    public void deleteKlassByKlassId(int klassId)
    {
        klassDao.deleteKlassByKlassId(klassId);
    }

    public void deleteKlassStudentByKlassId(int klassId)
    {
        klassStudentDao.deleteKlassStudentByKlassId(klassId);
    }

    public  List<KlassSeminar> getKlassSeminarRunning(List klassIds){
        return klassSeminarDao.getKlassSeminarRunning(klassIds);
    }

    public int getKlassSeminarByKlassIDSeminarID(int klassId, int seminaeId) {
        return klassSeminarDao.getKlassSeminarByKlassIDSeminarID(klassId,seminaeId) ;
    }

    public Integer getKlassIdByStudentIdAndCourseId(int id, int courseId) {
        return klassStudentDao.getKlassIdByStudentIdAndCourseId(id,courseId);
    }

    public int getKlassSeminarIdByKlassIdAndSeminarId(int klassId, int id) {
        return klassSeminarDao.getKlassSeminarByKlassIDSeminarID(klassId,id);
    }

    public void updateKlassRoundByRoundIdKlassId(int klassId,int roundId,int enrollNumber)
    {klassRoundDao.updateKlassRoundByRoundIdKlassId(klassId,roundId,enrollNumber);}

    public KlassSeminar getKlassSeminarByKlassSeminarId(int klassSeminarId)
    {return klassSeminarDao.getKlassSeminarByKlassSeminarId(klassSeminarId);}

    public void createKlassSeminar(int klassId,int seminarId,int status)
    { klassSeminarDao.createKlassSeminar(klassId,seminarId,status);}

    public void createKlassRound(int klassId,int roundId,int enrollNumber)
    {klassRoundDao.createKlassRound(klassId,roundId,enrollNumber);}

    public List<Klass> getNewKlassesByKlassIds(List<Integer> klassIds)
    {
        return klassDao.getNewKlassesByKlassIds(klassIds);
    }
}
