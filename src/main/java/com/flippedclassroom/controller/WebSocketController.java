package com.flippedclassroom.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.flippedclassroom.dao.KlassSeminarDao;
import com.flippedclassroom.dao.SeminarScoreDao;
import com.flippedclassroom.entity.WebSocketMessage;
import com.flippedclassroom.entity.WebSocketTeamStudentInfo;
import com.flippedclassroom.service.WebSocketServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageExceptionHandler;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
/**
* 所有@MessageMapping前端请求时，要加上WebSocketConfig中配置的前缀,
* 目前配置的前缀为 /websocket
* @author ChenHao
*/
public class WebSocketController {
    private final String TEACHER_ROLE = "teacher";
    private final String STUDENT_ROLE = "student";
    private final String ENTER_ACTION = "enter";
    private final String QUESTION_ACTION = "question";
    private final String NEXT_ACTION = "next";

    @Autowired
    private WebSocketServiceImpl webSocketService;

    /**
     * 教师进入讨论课
     * 教师进入界面时自动请求这个接口,返回当前提问学生信息列表(前端教师：对应要更新提问学生信息列表）
     * @param message
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/teacher_websocket/seminar/enter", method = RequestMethod.POST)
    @ResponseBody
    public String teacherEnterSeminar(@RequestParam("message") String message){
        ObjectMapper objectMapper = new ObjectMapper();
        try{
            WebSocketMessage webSocketMessage = objectMapper.readValue(message, WebSocketMessage.class);
            if(TEACHER_ROLE.equals(webSocketMessage.getRole()) && ENTER_ACTION.equals(webSocketMessage.getAction())){
                System.out.println("Class: WebSocketController; " + "Method: teacherEnterSeminar; " + "教师进入讨论课");
                // 获取 currentTeamIndex currentStudents currentQuestionStudentInfoList
                webSocketService.teacherEnterSeminar(webSocketMessage);
                return objectMapper.writeValueAsString(webSocketMessage);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }
    @RequestMapping(value = "/student_websocket/seminar/enter", method = RequestMethod.POST)
    @ResponseBody
    public String studentEnterSeminar0(@RequestParam("message") String message){
        ObjectMapper objectMapper = new ObjectMapper();
        try{
            WebSocketMessage webSocketMessage = objectMapper.readValue(message, WebSocketMessage.class);
            if(STUDENT_ROLE.equals(webSocketMessage.getRole()) && ENTER_ACTION.equals(webSocketMessage.getAction())){
                System.out.println("Class: WebSocketController; " + "Method: teacherEnterSeminar; " + "学生进入讨论课");
                // 获取 currentTeamIndex currentStudents
                webSocketService.studentEnterSeminar(webSocketMessage);
                return objectMapper.writeValueAsString(webSocketMessage);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 教师给学生广播信息
     * 开始下一小组(前端教师：判断当前是否还有小组可以进行下一组）
     * 所有学生进入界面自动订阅 @SendTo("/student-websocket/seminar/all")
     * 前端学生：seminarId 判断是否是自己的讨论课，是则更新界面，不是则不管
     * @param message
     * @return
     */
    @MessageMapping("/teacher/seminar/info")
    @SendTo("/student-websocket/seminar/all")
    public String teacherBroadcastInfo(String message){
        try{
            ObjectMapper objectMapper = new ObjectMapper();
            WebSocketMessage webSocketMessage = objectMapper.readValue(message, WebSocketMessage.class);
            if(TEACHER_ROLE.equals(webSocketMessage.getRole()) && NEXT_ACTION.equals(webSocketMessage.getAction())){
                System.out.println("Class: WebSocketController; " + "Method: teacherBroadcastInfo;" + "教师广播信息: " + webSocketMessage.getAction());
                // 教师开始下一组
                Integer currentTeamIndex = webSocketService.teacherNextTeam(webSocketMessage.getSeminarId());
                // 更新 currentTeamIndex
                webSocketMessage.setCurrentTeamIndex(currentTeamIndex);
                return objectMapper.writeValueAsString(webSocketMessage);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 学生进入讨论课
     * 使当前讨论课人数加1
     * 教师订阅 @SendTo("/teacher-websocket/seminar/all") 可以接收当前讨论课在线人数(前端教师可以考虑：更新当前讨论课在线人数）
     * 默认返回 null
     * @param message
     * @return
     * @throws Exception
     */
    @MessageMapping("/student/seminar/enter")
    @SendTo("/teacher-websocket/seminar/all")
    public String studentEnterSeminar1(String message){
        try {
            ObjectMapper objectMapper = new ObjectMapper();
            WebSocketMessage webSocketMessage = objectMapper.readValue(message, WebSocketMessage.class);
            if (STUDENT_ROLE.equals(webSocketMessage.getRole()) && ENTER_ACTION.equals(webSocketMessage.getAction())) {
                System.out.println("Class: WebSocketController; " + "Method: studentEnterSeminar;" + "学生进入讨论课");
                // 当前课程人数加1
                // 更新 currentStudents
                webSocketService.studentEnterSeminar(webSocketMessage);
                return objectMapper.writeValueAsString(webSocketMessage);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 学生提问
     * 提问学生订阅@SendTo("/student/seminar/questionsomeone") 接收教师抽取提问信息
     * 教师进入讨论课界面订阅 @SendTo("/teacher-websocket/seminar/question")接口 获取当前讨论课提问学生信息
     * 默认返回 null
     * 前端教师：根据返回的 teamId, teamSerial, studentId, studentName 修改当前提问的学生列表
     * @param message
     * @return
     */
    @MessageMapping("/student/seminar/question")
    @SendTo("/teacher-websocket/seminar/question")
    public String studentAskQuestion(String message){
        try{
            ObjectMapper objectMapper = new ObjectMapper();
            WebSocketMessage webSocketMessage = objectMapper.readValue(message, WebSocketMessage.class);
            if(STUDENT_ROLE.equals(webSocketMessage.getRole()) && QUESTION_ACTION.equals(webSocketMessage.getAction())) {
                System.out.println("Class: WebSocketController; " + "Method: studentAskQuestion; " + "学生开始提问!");
                // 返回新添加的提问学生的信息
                WebSocketTeamStudentInfo newQuestionStudentInfo = webSocketService.addQuestionStudent(webSocketMessage.getSeminarId(), webSocketMessage.getStudentId(), webSocketMessage.getStudentName());
                webSocketMessage.setNewQuestionStudentInfo(newQuestionStudentInfo);
                return objectMapper.writeValueAsString(webSocketMessage);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 教师抽取提问
     * 学生订阅 @SendTo("/student-websocket/seminar/questionsomeone") 接口
     * 前端学生：根据返回的 seminarId, studentId, studentName判断是不是和自己的一样来开始提问
     * 默认返回 null
     */
    @MessageMapping("/teacher/seminar/questionsomeone")
    @SendTo("/student-websocket/seminar/questionsomeone")
    public String teacherQuestionSomeone(String message) throws Exception{
        try{
            ObjectMapper objectMapper = new ObjectMapper();
            WebSocketMessage webSocketMessage = objectMapper.readValue(message, WebSocketMessage.class);
            if(TEACHER_ROLE.equals(webSocketMessage.getRole()) && QUESTION_ACTION.equals(webSocketMessage.getAction())){
                System.out.println("Class: WebSocketController; " + "Method: teacherQuestionSomeone; ");
                // 获取当前所有提问学生信息列表的首个
                WebSocketTeamStudentInfo result = webSocketService.ExtractOneStudent(webSocketMessage.getSeminarId());
                // 更新返回的信息
                webSocketMessage.setStudentId(result.getStudentId());
                webSocketMessage.setStudentName(result.getStudentName());
                return objectMapper.writeValueAsString(webSocketMessage);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 教师修改当前小组的提问分数
     * @param questionScore
     * @param klassSeminarId
     * @param teamId
     * @return
     */
    @RequestMapping(value = "/modifyQuestionScore", method = RequestMethod.POST)
    @ResponseBody
    public void modifyQuestionScore(@RequestParam("questionScore")String questionScore, @RequestParam("klassSeminarId")String klassSeminarId,
                                        @RequestParam("teamId")String teamId){
        Integer tempQuestionScore;
        if(questionScore.equals("")){
            tempQuestionScore = 0;
        }else{
            tempQuestionScore = Integer.parseInt(questionScore);
        }
        Integer tempKlassSeminarId = Integer.parseInt(klassSeminarId);
        Integer tempTeamId = Integer.parseInt(teamId);
        webSocketService.modifyQuestionScore(tempQuestionScore, tempKlassSeminarId, tempTeamId);
    }

    /**
     * 教师修改当前小组的展示分数
     * @param presentationScore
     * @param klassSeminarId
     * @param teamId
     */
    @RequestMapping(value = "/modifyPresentationScore", method = RequestMethod.POST)
    @ResponseBody
    public void modifyPresentationScore(@RequestParam("presentationScore")String presentationScore, @RequestParam("klassSeminarId")String klassSeminarId,
                                          @RequestParam("teamId")String teamId){
        Integer tempPresentationScore;
        if(presentationScore.equals("")){
            tempPresentationScore = 0;
        }else{
            tempPresentationScore = Integer.parseInt(presentationScore);
        }
        Integer tempKlassSeminarId = Integer.parseInt(klassSeminarId);
        Integer tempTeamId = Integer.parseInt(teamId);
        webSocketService.modifyPresentationScore(tempPresentationScore, tempKlassSeminarId, tempTeamId);
    }

    @RequestMapping(value = "/modifyReportDdl", method = RequestMethod.POST)
    @ResponseBody
    public void modifyReportDdl (@RequestParam("reportDdl")String reportDdl, @RequestParam("klassSeminarId")String klassSeminarId){
        try{
            Date tempReportDdl = new Date();
            if(!reportDdl.equals("")){
                SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
                tempReportDdl = simpleDateFormat.parse(reportDdl);
            }
            Integer tempKlassSeminarId = Integer.parseInt(klassSeminarId);
            webSocketService.modifyReportDdl(tempKlassSeminarId, tempReportDdl);
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
