package com.flippedclassroom.controller;

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
//    @MessageMapping("/hello")
//    @SendTo("/topic/greetings")
//    public String greeting(String message) throws Exception {
//        System.out.println("收到：" + "消息" + message.toString());
//        return message;
//    }

    @MessageMapping("/student/send/")
    @SendTo("/teacher-websocket/accept")
    /**
    *message字段中加入其他信息和return信息中加入其他信息，交给前端判断？
    */
    public String studentSendMessage(String message) throws Exception{
        System.out.println("Class: WebSocketConfig; " + "Method: studentSendMessage; " + " message: " + message);
        return "student/send";
    }

    @MessageMapping("/teacher/send")
    @SendTo("/student-websocket/accept")
    public String teacherSendMessage(@RequestParam("teacherId")String teacherId, String message) throws Exception{
        System.out.println("Class: WebSocketConfig; " + "Method: teacherSendMessage; " + " message: " + message);
        return "teacher/send";
    }
}
