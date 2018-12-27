package com.flippedclassroom.controller;

import com.flippedclassroom.entity.Student;
import com.flippedclassroom.entity.Teacher;
import com.flippedclassroom.service.StudentServiceImpl;
import com.flippedclassroom.service.TeacherServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
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

    @RequestMapping(value = "/")
    public String index(Model model){
        return "login";
    }

    @RequestMapping(value = "/index", method = RequestMethod.POST)
    public String index(Model model, @RequestParam String account, @RequestParam String password, HttpServletResponse response) throws IOException {
        response.setContentType("text/html;charset=gb2312");
        PrintWriter out = response.getWriter();
        Teacher teacher = teacherService.getTeacherByAccount(account,password);
        Student student = studentService.getStudentByAccount(account,password);
        if(teacher!=null){
            model.addAttribute(teacher);
            return "teacher/home";
        }
        if(student!=null){
            model.addAttribute(student);
            return "student/home";
        }
        else {
            out.print("<script>alert('用户名或密码错误');history.go(-1);</script>");
        }
        return "";
    }

}
