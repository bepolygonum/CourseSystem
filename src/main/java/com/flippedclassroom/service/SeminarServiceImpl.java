package com.flippedclassroom.service;

import com.flippedclassroom.dao.*;
import com.flippedclassroom.entity.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/**
 * @author KEKE
 */
@Service(value = "SeminarService")
public class SeminarServiceImpl {
    @Autowired
    SeminarDao seminarDao;
    @Autowired
    SeminarScoreDao seminarScoreDao;
    @Autowired
    KlassSeminarDao klassSeminarDao;
    @Autowired
    KlassServiceImpl klassService;
    @Autowired
    AttendanceDao attendanceDao;

    public List<Seminar> getSeminarByCourseID(int courseId) {
        return seminarDao.getSeminarByCourseID(courseId);
    }

    public List<SeminarScore> getSeminarScoreByTeamIdAndKlassId(int teamid, int klassId) {

        List<Integer> klassSeminarId=klassSeminarDao.getKlassSeminarIDByKlassId(klassId);
        if(klassSeminarId.isEmpty())
        {
            return null;
        }
        List <SeminarScore> seminarScores= seminarScoreDao.getSeminarScoreByKlassSeminarID(klassSeminarId);
        Iterator<SeminarScore> it = seminarScores.iterator();
        while(it.hasNext()){
            SeminarScore x = it.next();
            if(x.getTeamId()!=teamid){
                it.remove();
            }
        }
        return seminarScores;
    }

    public Seminar getSeminarBySeminarId(int seminarid) {
        return seminarDao.getSeminarBySeminarID(seminarid);
    }

    public List<KlassSeminar> getSeminarStatusBySeminarAndStudentID(Seminar seminar, int id) {
        List<Klass> klasses=klassService.getKlassByStudentID(id);
        Klass klass = new Klass();
        for(int i=0;i<klasses.size();i++)
        {
            if(klasses.get(i).getCourseId()==seminar.getCourseId()){
                klass=klasses.get(i);
                break;
            }
        }
        List list=new ArrayList() ;
        List list1=new ArrayList() ;
        list.add(klass.getId());
        list1.add(seminar.getId());
        return  klassSeminarDao.getKlassSeminarByKlassIdSeminarID(list,list1);
    }



    public List<Attendance> getAttendanceByKlassSeminarId(int klassSeminarId) {
        return  attendanceDao.getAttendanceByKlassSeminarId(klassSeminarId);

    }

    public Seminar getSeminarBySeminarName(String seminarName)
    {return seminarDao.getSeminarBySeminarName(seminarName);}

    public void createASeminar(int courseId, int roundId, String seminarName, String introduction,
                               int maxTeam, int isVisible, int seminarSerial, Timestamp startTime, Timestamp endTime)
    {
        seminarDao.createASeminar(courseId,roundId, seminarName, introduction,
                maxTeam,  isVisible, seminarSerial, startTime, endTime);
    }

    public void updateSeminarScoreByKlassSeminarIdTeamId(int klassSeminarId,int teamId, double preScore,double qaScore,double reportScore)
    {
        seminarScoreDao.updateSeminarScoreByKlassSeminarIdTeamId(klassSeminarId,teamId,preScore,qaScore,reportScore);
    }

    public List<Integer> selectSeminarIdsByRoundId(int roundId)
    { return seminarDao.selectSeminarIdsByRoundId(roundId);}

    //public List<SeminarScore> getSeminarScoreByKlassSeminarID(List<Integer> klassSeminarIds)
    //{ return seminarScoreDao.getSeminarScoreByKlassSeminarID(klassSeminarIds);}

    public List<SeminarScore> getSeminarScoreByKlassSeminarIDTeamID(List<Integer> klassSeminarIds,int teamId)
    {
        return seminarScoreDao.getSeminarScoreByKlassSeminarIDTeamID(klassSeminarIds,teamId);
    }

    public List<Seminar> selectSeminarsByRoundId(int roundId)
    {return seminarDao.selectSeminarsByRoundId(roundId);}

    public void updateSeminarReportScoreByKlassSeminarIdTeamId(int klassSeminarId,int teamId,double report)
    {seminarScoreDao.updateSeminarReportScoreByKlassSeminarIdTeamId(klassSeminarId,teamId,report);}

    public List<SeminarScore> getSeminarScoreByKlassSeminarID(List<Integer> klassSeminarIds)
    {return seminarScoreDao.getSeminarScoreByKlassSeminarID(klassSeminarIds);}

    public int getSeminarMaxSerialByRoundId(int roundId)
    {return seminarDao.getSeminarMaxSerialByRoundId(roundId);}

    public int getSeminarMaxId(){return seminarDao.getSeminarMaxId();}

    public List<SeminarScore> getSeminarScoreByKlassSeminarID(int klassSeminarId) {
        List list=new ArrayList();
        list.add(klassSeminarId);
        return seminarScoreDao.getSeminarScoreByKlassSeminarID(list);
    }
    public void insertEnrollByTeamIdAndSeminarId(int teamid, int klassSeminarid,int order) {
        List list=new ArrayList();
        list.add(klassSeminarid);
        if(seminarScoreDao.getSeminarScoreByKlassSeminarIDTeamID(list,teamid).size()==0) {
            seminarScoreDao.insertEnrollByTeamIdAndSeminarId(klassSeminarid, teamid);
            attendanceDao.insertAttendByTeamIdAndSeminarId(klassSeminarid, teamid, order);
        }
        else {
            attendanceDao.updateAttendByTeamIdAndSeminarId(klassSeminarid, teamid, order);
        }
    }
    public void deleteEnroll(int teamid, int klassSeminarId) {
        seminarScoreDao.deleteEnroll(teamid,klassSeminarId);
        attendanceDao.deleteEnroll(teamid,klassSeminarId);
    }
}