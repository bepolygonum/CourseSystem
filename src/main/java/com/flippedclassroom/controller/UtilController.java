package com.flippedclassroom.controller;

import com.flippedclassroom.entity.Student;
import com.flippedclassroom.service.SendByEmailTools;
import com.flippedclassroom.service.StudentServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;

/**
 *
 * @author KEKE
 */
@Controller
public class UtilController {
    @Autowired
    @Qualifier("sendByEmail")
    private SendByEmailTools service;
    @Autowired
    StudentServiceImpl studentService;

    @RequestMapping(value = "/send",method = RequestMethod.POST)
    public void send(String account, HttpServletResponse response,HttpServletRequest request) throws IOException {
        Student student=studentService.getStudentByAccounti(account);
        String json="{\"msg\":\"success!\"}";
            //发送人的邮箱
            String sender = "courseSystem@163.com";
            //接受人的邮箱
            String receiver = student.getEmail();
            //标题
            String title = "重置密码";
            int res = (int) (Math.random() * 1000000);
            String str = String.format("%06d", res);

            String text = account + "，您好。\n您的验证码为" + str + "。";
            service.send(sender, receiver, title, text);
            request.getSession().setAttribute("code",str);
        try {
            response.getWriter().print(json);
            response.getWriter().flush();
            response.getWriter().close();
        }
        catch (Exception e){
            e.printStackTrace();
        }
    }

    @RequestMapping(value = "/findPwd",method = RequestMethod.POST)
    public String findPwd(String account,String code, HttpServletResponse response,HttpServletRequest request) throws IOException {
        response.setContentType("text/html;charset=gb2312");
        PrintWriter out = response.getWriter();
        String res=request.getSession().getAttribute("code").toString();
        if(res.equals(code)) {
            //sucess
            studentService.resetStudent(account);
            out.print("<script>alert('密码重置为123456');</script>");
            return "/login";
        }
        else {
            //fail
            out.print("<script>alert('验证码错误');</script>");
            return "/forgetPassword";
        }
    }

    @RequestMapping(value = "/download",method = RequestMethod.POST)
    public void downloadPPT(@RequestParam(value = "name") String fileName,
                            @RequestParam(value = "path") String realPath,HttpServletRequest request,
                            HttpServletResponse response) {
        //设置文件路径
        System.out.println(realPath);
        File file = new File(realPath);
        if (file.exists()) {
            // 设置下载不打开
            response.setContentType("application/force-download");
            // 设置文件名
            response.addHeader("Content-Disposition", "attachment;fileName=" + fileName);
            byte[] buffer = new byte[1024];
            FileInputStream fis = null;
            BufferedInputStream bis = null;
            try {
                fis = new FileInputStream(file);
                bis = new BufferedInputStream(fis);
                OutputStream os = response.getOutputStream();
                int i = bis.read(buffer);
                while (i != -1) {
                    os.write(buffer, 0, i);
                    i = bis.read(buffer);
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (bis != null) {
                    try {
                        bis.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
                if (fis != null) {
                    try {
                        fis.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
    }

}
