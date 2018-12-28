package com.flippedclassroom.controller;

import com.flippedclassroom.service.SendByEmailTools;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 *
 * @author KEKE
 */
@RestController
public class SendByEmailController {
    @Autowired
    @Qualifier("sendByEmail")
    private SendByEmailTools service;

    @GetMapping("/send")
    public void send(){
        //这个是发送人的邮箱
        String sender="courseSystem@163.com";
        //这个是接受人的邮箱
        String receiver="961646438@qq.com";
        //标题
        String title="约翰福音";
        String text="【约3:16】“　神爱世人，甚至将他的独生子赐给他们，叫一切信他的，不至灭亡，反得永生。";

        service.send(sender, receiver, title, text);
    }

}
