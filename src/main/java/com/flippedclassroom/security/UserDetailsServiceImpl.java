package com.flippedclassroom.security;


import com.flippedclassroom.entity.Student;
import com.flippedclassroom.entity.Teacher;
import com.flippedclassroom.dao.TeacherDao;
import com.flippedclassroom.dao.StudentDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.security.Security;
import java.util.LinkedList;
import java.util.List;


/**
 * @author KEKE
 */

@Service
public class UserDetailsServiceImpl implements UserDetailsService {

    private final StudentDao studentDao;
    private final TeacherDao teacherDao;
    private final PasswordEncoder passwordEncoder;

    @Autowired
    UserDetailsServiceImpl(StudentDao studentDao, TeacherDao teacherDao, PasswordEncoder passwordEncoder){
        this.studentDao=studentDao;
        this.teacherDao=teacherDao;
        this.passwordEncoder=passwordEncoder;
    }
    @Override
    public UserDetails loadUserByUsername(String account) throws UsernameNotFoundException{
        List<GrantedAuthority> roleList = new LinkedList<>();
        Teacher teacher = teacherDao.getTeacherByAccounti(account);
        if (teacher!=null) {
            roleList.add(new SimpleGrantedAuthority("ROLE_TEACHER"));
            String password = passwordEncoder.encode(teacher.getPassword());
            return new User(account, password, roleList);
        }
        Student student = studentDao.getStudentByAccounti(account);
        if (student!=null) {
            roleList.add(new SimpleGrantedAuthority("ROLE_STUDENT"));
            String password = passwordEncoder.encode(student.getPassword());
            return new User(account, password, roleList);
        }
        throw new UsernameNotFoundException("User " + account + " not found!");
    }
}
