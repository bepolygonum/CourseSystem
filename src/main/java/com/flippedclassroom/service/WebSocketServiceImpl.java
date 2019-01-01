package com.flippedclassroom.service;

import com.flippedclassroom.dao.KlassSeminarDao;
import com.flippedclassroom.dao.SeminarScoreDao;
import com.flippedclassroom.dao.TeamDao;
import com.flippedclassroom.dao.TeamStudentDao;
import com.flippedclassroom.entity.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

/**
 * @author ChenHao
 */
@Service
public class WebSocketServiceImpl {
    /**
     * HashMap<Integer, WebSocketSeminarRunningInfo> seminarInfoMap 维持一张HashMap(key为当前seminarId,value为正在进行的讨论课信息(包括在线人数和当前正在展示的小组下标）
     */
    private static HashMap<Integer, WebSocketSeminarRunningInfo> seminarInfoMap = new HashMap<Integer, WebSocketSeminarRunningInfo>();
    /**
     * HashMap<Integer, List<WebSocketTeamStudentInfo>> questionStudentListMap 维持一张HashMap(key为当前seminarId，value为当前讨论课的提问学生列表
     */
    private static HashMap<Integer, List<WebSocketTeamStudentInfo>> questionStudentListMap = new HashMap<Integer, List<WebSocketTeamStudentInfo>>();

    @Autowired
    private TeamDao teamDao;

    @Autowired
    private TeamStudentDao teamStudentDao;

    @Autowired
    private SeminarScoreDao seminarScoreDao;

    @Autowired
    private KlassSeminarDao klassSeminarDao;

    /**
     * 教师进入讨论课，返回当前提问学生信息列表
     * @param webSocketMessage
     * @return
     */
    public void teacherEnterSeminar(WebSocketMessage webSocketMessage){
        Integer seminarId = webSocketMessage.getSeminarId();
        WebSocketSeminarRunningInfo webSocketSeminarRunningInfo = seminarInfoMap.get(seminarId);
        List<WebSocketTeamStudentInfo> webSocketTeamStudentInfoList = questionStudentListMap.get(seminarId);
        // 如果当前讨论课信息没有，则新建一份
        if(webSocketSeminarRunningInfo == null){
            System.out.println("教师进入当前讨论课时，当前讨论课信息不存在！新建讨论课的ID为: " + seminarId);
            WebSocketSeminarRunningInfo newWebSocketSeminarRunningInfo = new WebSocketSeminarRunningInfo();
            seminarInfoMap.put(seminarId, newWebSocketSeminarRunningInfo);
            // 如果当前讨论课提问学生信息没有，则新建一份，返回 null
            if(webSocketTeamStudentInfoList == null){
                questionStudentListMap.put(seminarId, new ArrayList<WebSocketTeamStudentInfo>());
                webSocketMessage.setCurrentQuestionStudentInfoList(new ArrayList<WebSocketTeamStudentInfo>());
            }else{
                webSocketMessage.setCurrentQuestionStudentInfoList(webSocketTeamStudentInfoList);
            }
        }else{
            webSocketMessage.setCurrentTeamIndex(webSocketSeminarRunningInfo.getCurrentTeamIndex());
            webSocketMessage.setCurrentStudents(webSocketSeminarRunningInfo.getCurrentStudents());
            if(webSocketTeamStudentInfoList == null){
                questionStudentListMap.put(seminarId, new ArrayList<WebSocketTeamStudentInfo>());
                webSocketMessage.setCurrentQuestionStudentInfoList(new ArrayList<WebSocketTeamStudentInfo>());
            }else{
                webSocketMessage.setCurrentQuestionStudentInfoList(webSocketTeamStudentInfoList);
            }
        }
    }

    /**
     * 学生进入讨论课
     * @param webSocketMessage
     * @return
     * @throws Exception
     */
    public void studentEnterSeminar(WebSocketMessage webSocketMessage) throws Exception{
        Integer seminarId = webSocketMessage.getSeminarId();
        WebSocketSeminarRunningInfo webSocketSeminarRunningInfo = seminarInfoMap.get(seminarId);
        if(webSocketSeminarRunningInfo == null){
            throw new Exception("学生访问当前的讨论课信息不存在！");
        }else{
            webSocketSeminarRunningInfo.setCurrentStudents(webSocketSeminarRunningInfo.getCurrentStudents()+1);
            webSocketMessage.setCurrentTeamIndex(webSocketSeminarRunningInfo.getCurrentTeamIndex());
            webSocketMessage.setCurrentStudents(webSocketSeminarRunningInfo.getCurrentStudents());
        }
    }

    /**
     * 教师开始下一组
     * @param seminarId
     * @return 返回下一小组的下标
     */
    public Integer teacherNextTeam(Integer seminarId) throws Exception{
        WebSocketSeminarRunningInfo webSocketSeminarRunningInfo = seminarInfoMap.get(seminarId);
        if(webSocketSeminarRunningInfo == null){
            throw new Exception("教师进行下一组操作时，当前课程信息不存在！");
        }else{
            webSocketSeminarRunningInfo.setCurrentTeamIndex(webSocketSeminarRunningInfo.getCurrentTeamIndex() + 1);
            return webSocketSeminarRunningInfo.getCurrentTeamIndex();
        }
    }

    /**
     * 学生发起提问
     * @param seminarId
     * @param studentId
     * @param studentName
     * @return
     */
    public WebSocketTeamStudentInfo addQuestionStudent(Integer seminarId, Integer studentId, String studentName) throws Exception{
        WebSocketSeminarRunningInfo webSocketSeminarRunningInfo = seminarInfoMap.get(seminarId);
        if(webSocketSeminarRunningInfo == null){
            throw new Exception("学生发起提问操作时，当前讨论课信息却不存在！");
        }else{
            List<WebSocketTeamStudentInfo> webSocketTeamStudentInfoList = questionStudentListMap.get(seminarId);
            Integer teamId = teamStudentDao.getTeamIdByStudentId(studentId);
            Team team = teamDao.getTeamById(teamId);
            WebSocketTeamStudentInfo webSocketTeamStudentInfo = new WebSocketTeamStudentInfo(teamId, team.getTeamSerial(), team.getKlassSerial(), studentId, studentName);
            webSocketTeamStudentInfoList.add(webSocketTeamStudentInfo);
            return webSocketTeamStudentInfo;
        }
    }


    /**
     * 教师抽取当前提问学生进行提问（默认抽取第一个学生）
     * @param seminarId
     * @return 返回当前抽取的提问学生信息
     * @throws Exception
     */
    public WebSocketTeamStudentInfo ExtractOneStudent(Integer seminarId) throws Exception {
        WebSocketSeminarRunningInfo webSocketSeminarRunningInfo = seminarInfoMap.get(seminarId);
        if (webSocketSeminarRunningInfo == null) {
            throw new Exception("教师抽取当前讨论课提问学生进行提问时，当前讨论课信息不存在！");
        } else {
            List<WebSocketTeamStudentInfo> webSocketTeamStudentInfoList = questionStudentListMap.get(seminarId);
            if (webSocketTeamStudentInfoList.size() == 0) {
                return null;
            } else {
                WebSocketTeamStudentInfo webSocketTeamStudentInfo = webSocketTeamStudentInfoList.get(0);
                webSocketTeamStudentInfoList.remove(0);
                return webSocketTeamStudentInfo;
            }
        }
    }

    public void  modifyQuestionScore(Integer questionScore, Integer klassSeminarId, Integer teamId){
        seminarScoreDao.updateQuestionScoreByKlassSeminarIdAndTeamId(questionScore, klassSeminarId, teamId);
    }

    public void modifyPresentationScore(Integer presentationScore, Integer klassSeminarId, Integer teamId){
        seminarScoreDao.updatePresentationScoreByKlassSeminarIdAndTeamId(presentationScore, klassSeminarId, teamId);
    }

    public void modifyReportDdl (Integer klassSeminarId, Date reportDdl){
        klassSeminarDao.updateReportDdlByKlassSeminarId(klassSeminarId, reportDdl);
    }
}
