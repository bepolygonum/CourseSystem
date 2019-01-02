package com.flippedclassroom.service;

import com.flippedclassroom.dao.*;
import com.flippedclassroom.entity.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.security.KeyStore;
import java.util.ArrayList;
import java.util.List;

/**
 * @author KEKE
 */
@Service(value = "TeamService")
public class TeamServiceImpl {
    @Autowired
    TeamDao teamDao;
    @Autowired
    StudentServiceImpl studentService;
    @Autowired
    KlassStudentDao klassStudentDao;
    @Autowired
    KlassDao klassDao;
    @Autowired
    CourseDao courseDao;
    @Autowired
    TeamStudentDao teamStudentDao;
    @Autowired
    TeamValidApplicationDao teamValidApplicationDao;
    @Autowired
    MemberLimitStrategyDao memberLimitStrategyDao;
    @Autowired
    TeamStrategyDao teamStrategyDao;
    @Autowired
    TeamAndStrategyDao teamAndStrategyDao;
    @Autowired
    TeamOrStrategyDao teamOrStrategyDao;
    @Autowired
    CourseMemberLimitStrategyDao courseMemberLimitStrategyDao;
    @Autowired
    ConflictCourseStrategyDao conflictCourseStrategyDao;


    public List<Team> getTeamByCourseID(int courseId) {
        //根据课程id获得所有team
        List<Team> teams = teamDao.getTeamByCourseID(courseId);
        return teams;
    }

    public Team getTeamById(int teamid) {
        return teamDao.getTeamById(teamid);
    }

    public List<Integer> getTeamIdByStudentIdAndCourseId(int id, int courseid) {
        List<Integer> list1 = teamDao.getTeamIdByStudentId(id);
        List klassIds = klassDao.getKlassIDByCourseID(courseid);
        List teamList = teamDao.getTeamIdByKlassId(klassIds);
        list1.retainAll(teamList);
        return list1;
    }

    public List<Student> getStudentByTeamID(int id) {
        List students = teamDao.getStudentIdByTeamId(id);
        if (students.size() == 0) {
            return null;
        } else {
            return studentService.getStudentByStudentID(students);
        }
    }

    public List<Student> getStudentWithNoTeams(List<List<Student>> listOfStudents, int courseId) {
        List<Student> studentList = new ArrayList<>();
        for (int i = 0; i < listOfStudents.size(); i++) {
            for (int j = 0; j < listOfStudents.get(i).size(); j++) {
                studentList.add(listOfStudents.get(i).get(j));
            }
        }
        List list = new ArrayList();
        List<KlassStudent> klassStudent = klassStudentDao.getKlassStudentByCourseID(courseId);
        for (int i = 0; i < klassStudent.size(); i++) {
            list.add(klassStudent.get(i).getStudentId());
        }
        List<Student> allStudents = studentService.getStudentByStudentID(list);

        for (int i = 0; i < studentList.size(); i++) {
            for (int j = 0; j < allStudents.size(); j++) {
                if (studentList.get(i).getId() == allStudents.get(j).getId()) {
                    allStudents.remove(j);
                }
            }
        }
        return allStudents;
    }

    public List getTeamIdByKlassId(List klassIds) {
        return teamDao.getTeamIdByKlassId(klassIds);
    }

    public List<Team> getTeamByIds(List ids) {
        return teamDao.getTeamByIds(ids);
    }


    public List<TeamStudent> getTeamStudentsByTeamIds(List<Integer> teamIds) {
        return teamStudentDao.getTeamStudentsByTeamIds(teamIds);
    }

    public void dimissByTeamID(int team) {
        teamDao.dismissTableTeamStudent(team);
        teamDao.dismissTableKlassTeam(team);
        teamDao.dismissTableTeam(team);
    }


    public void sendApplication(int teamid, int teacherid, String reason) {
        teamValidApplicationDao.sendApplication(teamid, teacherid, reason);
    }

    public Team getTeamByTeamID(int teamId) {
        return teamDao.getTeamByTeamID(teamId);
    }

    public void createTeam(int klassId, int courseId, int id, String teamName, int teamSerial, int klassSerial, List<Integer> team,boolean valid) {
        if(valid){
            teamDao.insertValidTableTeam(klassId, courseId, id, teamName, teamSerial, klassSerial);
        }else{
            teamDao.insertInValidTableTeam(klassId, courseId, id, teamName, teamSerial, klassSerial);
        }

        int teamid = teamDao.getTeamByKlassAndId(id,klassId).getId();
        teamDao.insertTableKlassTeam(klassId, teamid);
        for (int i = 0; i < team.size(); i++) {
            teamDao.insertTableTeamStudent(teamid, team.get(i));
        }
    }

    public int createMemberLimitStrategy(int minMember, int maxMember) {
        memberLimitStrategyDao.createMemberLimitStrategy(minMember, maxMember);
        return memberLimitStrategyDao.selectMaxId();
    }

    public void createTeamStrategy(int courseId, int strategySerial, String strategyName, int strategyId) {
        teamStrategyDao.createTeamStrategy(courseId, strategySerial, strategyName, strategyId);
    }

    public int selectTeamAndStrategyMaxId() {
        return teamAndStrategyDao.selectTeamAndStrategyMaxId();
    }

    public int selectTeamOrStrategyMaxId() {
        return teamOrStrategyDao.selectTeamOrStrategyMaxId();
    }

    public void createTeamAndStrategy(int id, String strategyName, int strategyId) {
        teamAndStrategyDao.createTeamAndStrategy(id, strategyName, strategyId);
    }
    public List<TeamValidApplication> selectUntreatedTeamValidApplication(int teacherId)
    {return teamValidApplicationDao.selectUntreatedTeamValidApplicationByTeacherId(teacherId);}


    public void createTeamOrStrategy(int id, String strategyName, int strategyId) {
        teamOrStrategyDao.createTeamOrStrategy(id, strategyName, strategyId);
    }

    public boolean isValid(List<Integer> list, int courseId) {
        List<TeamStrategy> teamStrategies = teamStrategyDao.getTeamStrategyByCourseId(courseId);
        for (int i = 0; i < teamStrategies.size(); i++) {
            if (teamStrategies.get(i).getStrategyName().equals("TeamAndStrategy")) {
                List<TeamAndStrategy> teamAndStrategies = teamAndStrategyDao.getTeamAndStrategyById(teamStrategies.get(i).getStrategyId());
                for (int j = 0; j < teamAndStrategies.size(); j++) {
                    if (teamAndStrategies.get(j).getStrategyName().equals("MemberLimitStrategy")) {
                        if (memberLimitStrategyDao.getMemberLimitById(teamAndStrategies.get(j).getStrategyId()).isValid(list.size())){
                            System.out.println(teamAndStrategies.get(j).getStrategyId());
                            System.out.println("Satisfy Member Limit ");
                            return true;
                        }
                        else {
                            System.out.println(teamAndStrategies.get(j).getStrategyId());
                            System.out.println("Not  Satisfy Member Limit ");
                            return false;
                        }
                    } else if (teamAndStrategies.get(j).getStrategyName().equals("TeamOrStrategy")) {
                        List<TeamOrStrategy> teamOrStrategies = teamOrStrategyDao.getTeamOrStrategyByid(teamAndStrategies.get(j).getStrategyId());
                        int flag = 0;
                        for (int k = 0; k < teamOrStrategies.size(); k++) {
                            CourseMemberLimitStrategy courseMemberLimitStrategy = courseMemberLimitStrategyDao.getCourseMemberLimitStrategyById(teamOrStrategies.get(k).getStrategyId());
                            int number = 0;
                            for (int l = 0; l < list.size(); l++) {
                                List<KlassStudent> klassStudents=klassStudentDao.getKlassStudentByIdAndCourseId(list.get(i),courseMemberLimitStrategy.getCourseId());
                                if(klassStudents.size()!=0)
                                    number++;
                            }

                            if (courseMemberLimitStrategy.isValid(number)){
                                flag = 1;
                                System.out.println("Satisfy Team Or Strategy");
                                return true;
                            } else{
                                flag = 0;
                            }
                        }
                        if (flag == 0) {
                            System.out.println("Not Satisfy Team Or Strategy");
                            return false;
                        }
                    }

                }
            }else if(teamStrategies.get(i).getStrategyName().equals("ConflictCourseStrategy")) {
                List<ConflictCourseStrateqy> conflictCourseStrateqies=conflictCourseStrategyDao.getConflictCourseStrategy(teamStrategies.get(i).getStrategyId());
                List<List<KlassStudent>> klassstudent= new ArrayList<>();
                for(int j=0;j<conflictCourseStrateqies.size();j++){
                    for(int k=0;k<list.size();k++){
                         klassstudent.add(klassStudentDao.getKlassStudentByIdAndCourseId(list.get(k),conflictCourseStrateqies.get(j).getCourseId()));
                    }
                }
                if(klassstudent.get(0).size()==0||klassstudent.get(1).size()==0){
                    System.out.println("Satisfy Conflict");
                    return true;
                }
                else{
                    System.out.println("Not  Satisfy Conflict");
                    return false;
                }

            }
        }
        return false;
    }

    public void changeStatusByTeamId(int team) {
        teamDao.changeStatusByTeamId(team);
    }

    public Team getTeamByKlassIdAndId(int id, int klassId) {
        return teamDao.getTeamByKlassAndId(id,klassId);
    }

    public int getMaxTeamSerialByKlassId(int klass) {
        return teamDao.getMaxTeamSerialByKlassId(klass);
    }

    public int getKlassSerialByKlassId(int klassid) {
        return klassDao.getKlassSerialByKlassId(klassid);
    }

    public int getTeamIdByLeaderIdAndCourseId(int id, int courseId) {
        return teamDao.getTeamIdByLeaderIdAndCourseId(id,courseId);
    }

    public void setStatus(int teamid, int i) {
        teamValidApplicationDao.setStatus(teamid,i);
        if(i==1){
            teamDao.setValid(teamid);
        }
    }

}
