package com.flippedclassroom.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.messaging.handler.annotation.MessageExceptionHandler;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.HtmlUtils;


@Controller
/**
* 所有@MessageMapping前端请求时，要加上WebSocketConfig中配置的前缀,
* 目前配置的前缀为 /websocket
* @author KEKE
*/
public class WebSocketController {
    // 除了message，还要有一个地方存储当前讨论课信息（我是这样认为的）
    // messageEntity:{
    //              "role": enum ["teacher", "student"],
    //              "action":
    //                      enter 教师开始讨论课，学生进入讨论课
    //                      question: 教师开始抽取提问，学生提问
    //                      next: 教师开始下一小组
    //                      end: //待定
    //               "studentId": 学生提问时发送自己的id
    //
    //          }

    // 学生初始进入讨论课，判断是否可以进入讨论课，
    //      判断成功，每人建立一条WebSocket Connection，
    //      判断失败，拒绝进入讨论课
    // 教师进入讨论课，建立WebSocket Connection 订阅@SendTo("/teacher-websocket/seminar/enter");
    // 监听事件，可以获取当前讨论课人数，可以发送给教师
    @MessageMapping("/student/seminar/enter")
    @SendTo("/teacher-websocket/seminar/all")
    public String studentEnterSeminar(String message) throws Exception{

        try{
            System.out.println("Class: WebSocketController; " + "Method: studentEnterSeminar; ");
//            ObjectMapper objectMapper = new ObjectMapper();
//            objectMapper.readValue(message, )

        }catch (Exception e){
            e.printStackTrace();
        }
        return message;
    }

    // 教师开始讨论课，建立WebSocket Connection
    // 教师操作：开始下一小组，发送到这个接口
    // 学生订阅 @SendTo("/student-websocket/seminar/all") 整个讨论课所有学生可以获取教师发送给学生的所有信息
    @MessageMapping("/teacher/seminar/begin")
    @SendTo("/student-websocket/seminar/all")
    public String teacherBeginSeminar(String message) throws Exception{
        try{
            System.out.println("Class: WebSocketController; " + "Method: teacherBeginSeminar; ");
        }catch (Exception e){
            e.printStackTrace();
        }
        return message;
    }

    // 学生提问接口@MessageMapping("student/seminar/question")，提问信息发送到这个接口，
    // 同时提问学生订阅@SendTo("/student/seminar/questionsomeone")，接收教师抽取提问信息
    // 学生操作：提问
    // 教师订阅 @SendTo("/teacher-websocket/seminar/question")，来获取当前讨论课提问信息
    @MessageMapping("/student/seminar/question")
    @SendTo("/teacher-websocket/seminar/question")
    public String studentAskQuestion(String message) throws Exception{
        try{
            System.out.println("Class: WebSocketController; " + "Method: studentAskQuestion; ");

        }catch (Exception e){
            e.printStackTrace();
        }
        return message;
    }

    // 教师开始抽取提问
    @MessageMapping("/teacher/seminar/questionsomeone")
    @SendTo("/student-websocket/seminar/questionsomeone")
    public String teacherQuestionSomeone(String message) throws Exception{
        try{
            System.out.println("Class: WebSocketController; " + "Method: teacherQuestionSomeone; ");

        }catch (Exception e){
            e.printStackTrace();
        }
        return message;
    }
}
