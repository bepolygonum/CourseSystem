package com.flippedclassroom.controller;

import com.flippedclassroom.entity.Student;
import com.flippedclassroom.entity.Teacher;
import com.flippedclassroom.service.StudentServiceImpl;
import com.flippedclassroom.service.TeacherServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * @author KEKE
 */
@Controller
public class LoginController {
    @Autowired
    private TeacherServiceImpl teacherService;
    @Autowired
    private StudentServiceImpl studentService;

    @GetMapping(value = "/pc/login")
    public String loginOnPc(){
        return "pc/PcLoginPage";
    }

    @GetMapping(value = "/login")
    public String login(){
        return "login";
    }

    @GetMapping(value = "/")
    public String login1(){
        return "login";
    }

    @GetMapping(value = "/forgetPassword")
    public String forget(){
        return "forgetPassword";
    }

}
