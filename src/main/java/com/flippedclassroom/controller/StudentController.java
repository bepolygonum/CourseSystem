package com.flippedclassroom.controller;

import com.flippedclassroom.entity.*;
import com.flippedclassroom.service.*;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;

/**
 * @author KEKE
 */
@Controller
@RequestMapping(value = "/student")
public class StudentController {
    @Autowired
    private CourseServiceImpl courseService;
    @Autowired
    private StudentServiceImpl studentService;
    @Autowired
    private RoundServiceImpl roundService;
    @Autowired
    private KlassServiceImpl klassService;
    @Autowired
    private SeminarServiceImpl seminarService;
    @Autowired
    private TeamServiceImpl teamService;
    @Autowired
    private CourseMemberLimitStrategyServiceImpl courseMemberLimitStrategyService;
    @Autowired
    private AttendanceServiceImpl attendanceService;

    @GetMapping(value = "/index")
    public String studentIndex(Model model) {
        Student student = studentService.getCurStudent();
        model.addAttribute("student", student);
        if (student.isActive() == false) {
            return "/student/activation";
        }
        return "/student/home";
    }

    @RequestMapping(value = "/newactivation", method = RequestMethod.POST)
    public String studentActivate(Model model, @RequestParam(name = "id") String sid, @RequestParam String newmail,
                                  @RequestParam String newpass) {
        int id = Integer.valueOf(sid);
        Student student = studentService.getStudentByID(id);
        studentService.setEmailByID(id, newmail);
        studentService.setPassByID(id, newpass);
        studentService.activate(id);
        model.addAttribute("student", student);
        return "/student/home";
    }

    @RequestMapping(value = "/courseManage", method = RequestMethod.POST)
    public String courseManage(Model model, @RequestParam(name = "id") String sid) {
        int id = Integer.valueOf(sid);
        List<Klass> klassList = klassService.getKlassByStudentID(id);
        List<Course> courseList = courseService.getCourseByStudentID(id);
        model.addAttribute(courseList);
        model.addAttribute(klassList);
        Student student = studentService.getStudentByID(id);
        model.addAttribute(student);
        return "/student/courseManage";
    }

    @RequestMapping(value = "/courseInfo", method = RequestMethod.POST)
    public String courseInfo(Model model, @RequestParam(name = "id") String sid,
                             @RequestParam(name = "course_id") String courseid) {
        int id = Integer.valueOf(sid);
        int courseId = Integer.valueOf(courseid);
        Course course = courseService.getCourseByCourseID(courseId);
        CourseMemberLimitStrategy courseMemberLimitStrategy = courseMemberLimitStrategyService
                .getCourseMemberLimitStrategyByCourseID(courseId);
        Student student = studentService.getStudentByID(id);
        model.addAttribute(student);
        model.addAttribute(course);
        if (courseMemberLimitStrategy != null) {
            model.addAttribute(courseMemberLimitStrategy);
        }
        return "/student/course/courseInfo";
    }

    @RequestMapping(value = "/courseScore", method = RequestMethod.POST)
    public String courseScore(Model model, @RequestParam(name = "klass_id") String klassid,
                              @RequestParam(name = "id") String sid, @RequestParam(name = "course_id") String courseid,
                              HttpServletResponse response) throws IOException {
        response.setContentType("text/html;charset=utf-8");
        PrintWriter out = response.getWriter();
        int id = Integer.valueOf(sid);
        int courseId = Integer.valueOf(courseid);
        int klassId = Integer.valueOf(klassid);
        // 获取course
        Course course = courseService.getCourseByCourseID(courseId);
        // 获取该课程所有的seminar
        List<Seminar> seminarList = seminarService.getSeminarByCourseID(courseId);
        // 获取klass
        Klass klass = klassService.getKlassByKlassID(klassId);
        // 获取team_id
        int teamid = -1;
        // 获取该team该班级的score
        if (teamService.getTeamIdByStudentIdAndCourseId(id, courseId).size() != 0) {
            teamid = teamService.getTeamIdByStudentIdAndCourseId(id, courseId).get(0);
        }
        List<SeminarScore> seminarScoreList = seminarService.getSeminarScoreByTeamIdAndKlassId(teamid, klassId);
        if (seminarScoreList == null) {
            out.print("<script>alert('成绩尚未录入！');history.go(-1);</script>");
        }
        // 获取本轮总成绩
        List<RoundScore> roundScoreList = roundService.getRoundScoreByCourseID(courseId);
        Iterator<RoundScore> it = roundScoreList.iterator();
        while (it.hasNext()) {
            RoundScore x = it.next();
            if (x.getTeamId() != teamid) {
                it.remove();
            }
        }
        List seminarIds = new ArrayList();
        for (int i = 0; i < seminarList.size(); i++) {
            seminarIds.add(seminarList.get(i).getId());
        }
        List<KlassSeminar> klassSeminarList = klassService.getKlassSeminarByCourseSeminarID(courseId, seminarIds);
        Student student = studentService.getStudentByID(id);
        model.addAttribute(klassSeminarList);
        model.addAttribute(student);
        model.addAttribute(roundScoreList);
        model.addAttribute(seminarList);
        model.addAttribute(seminarScoreList);
        model.addAttribute(klass);
        model.addAttribute(course);
        return "/student/course/courseScore";
    }

    @RequestMapping(value = "/seminar")
    public String seminarCourse(Model model, @RequestParam(name = "id") String sid) {
        int id = Integer.valueOf(sid);
        Student student = studentService.getStudentByID(id);
        model.addAttribute(student);
        List<Klass> klassList = klassService.getKlassByStudentID(id);
        List<Course> courseList = new ArrayList<>();
        for (int i = 0; i < klassList.size(); i++) {
            int courseid = klassList.get(i).getCourseId();
            if (seminarService.getSeminarByCourseID(courseid) != null) {
                courseList.add(courseService.getCourseByCourseID(courseid));
            }
        }
        model.addAttribute(courseList);
        return "/student/seminar/seminarCourse";
    }

    @RequestMapping(value = "/seminar-round")
    public String seminarRound(Model model, @RequestParam(name = "id") String sid,
                               @RequestParam(name = "courseid") String courseId) {
        int id = Integer.valueOf(sid);
        int courseid = Integer.valueOf(courseId);
        Student student = studentService.getStudentByID(id);
        Course course = courseService.getCourseByCourseID(courseid);
        List<Round> roundList = roundService.getRoundByCourseID(courseid);
        model.addAttribute(roundList);
        model.addAttribute(student);
        List<Seminar> seminarList = seminarService.getSeminarByCourseID(courseid);
        model.addAttribute(seminarList);
        model.addAttribute(course);
        return "/student/seminar/seminarRound";
    }


    @RequestMapping(value = "/seminar-detail")
    public String seminarDetail(Model model, @RequestParam(name = "id") String sid,
                                @RequestParam(name = "seminarid") String seminarId) {
        int id = Integer.valueOf(sid);
        int seminarid = Integer.valueOf(seminarId);
        Student student = studentService.getStudentByID(id);
        Seminar seminar = seminarService.getSeminarBySeminarId(seminarid);
        int teamid = teamService.getTeamIdByStudentIdAndCourseId(id, seminar.getCourseId()).get(0);
        List<KlassSeminar> status = seminarService.getSeminarStatusBySeminarAndStudentID(seminar, id);
        //判断该小组是否报名本次讨论课

        Timestamp reportDdl = status.get(0).getReportDdl();
        Timestamp now = new Timestamp(System.currentTimeMillis());
        if (reportDdl != null) {
            model.addAttribute("before", reportDdl.compareTo(now));
        }

        Timestamp enrollDdl = seminar.getEnrollEndTime();
        model.addAttribute("beforeEnroll", enrollDdl.compareTo(now));

        Timestamp enrollStart = seminar.getEnrollStartTime();
        model.addAttribute("beforeStart", enrollStart.compareTo(now));

        Attendance attendance = attendanceService.getAttendanceByKlassSeminarIdAndTeamId(status.get(0).getId(), teamid);
        if (attendance != null) {
            //已报名
            model.addAttribute("attendance", attendance);
        }
        model.addAttribute("status", status.get(0).getStatus());
        model.addAttribute(seminar);
        model.addAttribute(student);
        return "/student/seminar/seminarDetail";
    }


    @RequestMapping(value = "/enroll-detail")
    public String seminarEnrollPage(Model model, @RequestParam(name = "id") String sid,
                                    @RequestParam(name = "seminarid") String seminarId) {
        int id = Integer.valueOf(sid);
        int seminarid = Integer.valueOf(seminarId);

        Student student = studentService.getStudentByID(id);
        Seminar seminar = seminarService.getSeminarBySeminarId(seminarid);
        int teamid = teamService.getTeamIdByStudentIdAndCourseId(id, seminar.getCourseId()).get(0);
        Team team = teamService.getTeamById(teamid);
        int roundCount = 0;
        List<KlassSeminar> klassSeminars = klassService.getKlassSeminarByKlassIdAndSeminarId(team.getKlassId(),
                seminarid);
        List<Attendance> attandances = seminarService.getAttendanceByKlassSeminarId(klassSeminars.get(0).getId());
        roundCount = seminar.getMaxTeam();
        System.out.println(roundCount);
        model.addAttribute("roundCount", roundCount);
        model.addAttribute(attandances);
        model.addAttribute(seminar);
        model.addAttribute(student);
        return "/student/seminar/enrollDetail";
    }

    @RequestMapping(value = "/personalInfo", method = RequestMethod.POST)
    public String personalInformation(Model model, @RequestParam(name = "id") String sid) {
        int id = Integer.valueOf(sid);
        Student student = studentService.getStudentByID(id);
        model.addAttribute(student);
        return "/student/person/personalInfo";
    }

    @RequestMapping(value = "/modifyEmail", method = RequestMethod.POST)
    public String modifyEmail(Model model, @RequestParam(name = "id") String sid) {
        int id = Integer.valueOf(sid);
        Student student = studentService.getStudentByID(id);
        model.addAttribute(student);
        return "/student/person/modifyEmail";
    }

    @RequestMapping(value = "/newmail", method = RequestMethod.POST)
    public String newEmail(Model model, @RequestParam(name = "id") String sid, @RequestParam String newmail) {
        int id = Integer.valueOf(sid);
        studentService.setEmailByID(id, newmail);
        Student student = studentService.getStudentByID(id);
        model.addAttribute(student);
        return "/student/person/personalInfo";
    }

    @RequestMapping(value = "/modifyPassword", method = RequestMethod.POST)
    public String modifyPassword(Model model, @RequestParam(name = "id") String sid) {
        int id = Integer.valueOf(sid);
        Student student = studentService.getStudentByID(id);
        model.addAttribute(student);
        return "/student/person/modifyPassword";
    }

    @RequestMapping(value = "/newPass", method = RequestMethod.POST)
    public String modifyPassword(Model model, @RequestParam(name = "id") String sid, @RequestParam String newpass) {
        int id = Integer.valueOf(sid);
        studentService.setPassByID(id, newpass);
        Student student = studentService.getStudentByID(id);
        model.addAttribute(student);
        return "/student/person/personalInfo";
    }

    @RequestMapping(value = "/seminar-running", method = RequestMethod.GET)
    public String seminarRunning(Model model, @RequestParam(name = "id") String sid, @RequestParam String seminarid) {
        int id = Integer.valueOf(sid);
        Student student = studentService.getStudentByID(id);
        int seminarId = Integer.parseInt(seminarid);
        Seminar seminar = seminarService.getSeminarBySeminarId(seminarId);
        int klassId = klassService.getKlassIdByStudentIdAndCourseId(id, seminar.getCourseId());
        int klassSeminarId = klassService.getKlassSeminarIdByKlassIdAndSeminarId(klassId, seminar.getId());
        List<Attendance> attendances = attendanceService.getAttendanceByklassSeminarId(klassSeminarId);
        List teamids = new ArrayList();
        for (int i = 0; i < attendances.size(); i++) {
            teamids.add(attendances.get(i).getTeamId());
        }
        List<Team> teamList = teamService.getTeamByIds(teamids);
        model.addAttribute(attendances);
        model.addAttribute(teamList);
        model.addAttribute(seminar);
        model.addAttribute("student", student);
        return "/student/seminar/seminar-running";
    }

    @RequestMapping(value = "/uploadPPT", method = RequestMethod.POST)
    @ResponseBody
    public void uploadPPT(@RequestParam int id, @RequestParam int seminarId,
                          @RequestParam MultipartFile file) {
        Seminar seminar = seminarService.getSeminarBySeminarId(seminarId);
        int klassId = klassService.getKlassIdByStudentIdAndCourseId(id, seminar.getCourseId());
        int teamId = teamService.getTeamIdByStudentIdAndCourseId(id, seminar.getCourseId()).get(0);
        int klassSeminarId = klassService.getKlassSeminarIdByKlassIdAndSeminarId(klassId, seminarId);
        attendanceService.upload(file, klassSeminarId, teamId, "PPT");
    }

    @RequestMapping(value = "/uploadReport", method = RequestMethod.POST)
    @ResponseBody
    public void uploadReport(@RequestParam int id, @RequestParam int seminarId,
                             @RequestParam MultipartFile file) {
        Seminar seminar = seminarService.getSeminarBySeminarId(seminarId);
        int klassId = klassService.getKlassIdByStudentIdAndCourseId(id, seminar.getCourseId());
        int teamId = teamService.getTeamIdByStudentIdAndCourseId(id, seminar.getCourseId()).get(0);
        int klassSeminarId = klassService.getKlassSeminarIdByKlassIdAndSeminarId(klassId, seminarId);
        attendanceService.upload(file, klassSeminarId, teamId, "report");
    }

    @RequestMapping(value = "/seminar-score")
    public String seminarScore(Model model, @RequestParam String id, @RequestParam String seminarId) {
        Student student = studentService.getStudentByID(Integer.parseInt(id));
        Seminar seminar = seminarService.getSeminarBySeminarId(Integer.parseInt(seminarId));
        int klassId = klassService.getKlassIdByStudentIdAndCourseId(student.getId(), seminar.getCourseId());
        int klassSeminarId = klassService.getKlassSeminarIdByKlassIdAndSeminarId(klassId, seminar.getId());
        List<SeminarScore> seminarScoreList = seminarService.getSeminarScoreByKlassSeminarID(klassSeminarId);
        List teamids = new ArrayList();
        for (int i = 0; i < seminarScoreList.size(); i++) {
            teamids.add(seminarScoreList.get(i).getTeamId());
        }

        List<Team> teamList = teamService.getTeamByIds(teamids);
        model.addAttribute(teamList);
        model.addAttribute(seminarScoreList);
        return "/student/seminar/seminarScore";
    }

    @RequestMapping(value = "/dismiss", method = RequestMethod.POST)
    public String dismiss(Model model, @RequestParam(name = "id") String sid, @RequestParam String teamid) {
        int id = Integer.valueOf(sid);
        int team = Integer.valueOf(teamid);
        teamService.dimissByTeamID(team);
        List<Klass> klassList = klassService.getKlassByStudentID(id);
        List<Course> courseList = courseService.getCourseByStudentID(id);
        Student student = studentService.getStudentByID(id);
        model.addAttribute(courseList);
        model.addAttribute(klassList);
        model.addAttribute(student);
        return "/student/courseManage";
    }

    @RequestMapping(value = "/courseTeam", method = RequestMethod.POST)
    public String courseTeam(Model model, @RequestParam(name = "klass_id") String klassid,
                             @RequestParam(name = "id") String sid, @RequestParam(name = "course_id") String courseid, int flags) {
        int id = Integer.valueOf(sid);
        int courseId = Integer.valueOf(courseid);
        int klassId = Integer.valueOf(klassid);
        Team myteam = new Team();
        int teamid = -1;
        Student student = studentService.getStudentByID(id);
        List<KlassStudent> klassStudents = klassService.getKlassStudentByStudentIdAndKlassId(id, klassId);
        Klass klass = klassService.getKlassByKlassID(klassId);
        model.addAttribute("student", student);
        model.addAttribute("course", courseService.getCourseByCourseID(courseId));
        // 查出所有team ，未组队的人，本team成员
        // 找到teamid
        model.addAttribute("klass", klass);
        if (klassStudents != null) {
            if (teamService.getTeamIdByStudentIdAndCourseId(id, courseId).size() != 0) {
                teamid = teamService.getTeamIdByStudentIdAndCourseId(id, courseId).get(0);
            }
            // course下的所有klass的所有team
            List<Klass> klasses = klassService.getKlassByCourseID(courseId);
            model.addAttribute("klasses", klasses);
            List klassIds = new ArrayList();
            for (int i = 0; i < klasses.size(); i++) {
                klassIds.add(klasses.get(i).getId());
            }
            List list = teamService.getTeamIdByKlassId(klassIds);
            List<Team> teamList = teamService.getTeamByIds(list);
            if (teamList.size() != 0) {
                model.addAttribute("teamList", teamList);
            }
            // 添加所有队伍
            List<List<Student>> listOfStudents = new ArrayList<List<Student>>();
            for (int i = 0; i < teamList.size(); i++) {
                List<Student> members = teamService.getStudentByTeamID(teamList.get(i).getId());
                if (members != null) {
                    listOfStudents.add(members);
                }
            }
            if (listOfStudents != null) {
                model.addAttribute("listOfStudents", listOfStudents);
            }
            // 未组队的人
            List<Student> noTeam = teamService.getStudentWithNoTeams(listOfStudents, courseId);

            if (noTeam != null) {
                model.addAttribute("noTeams", noTeam);
            }
            model.addAttribute("teamid", teamid);

            if (flags == 0) {
                return "/student/course/team/teamList";
            } else {
                if (teamid == -1) {
                    return "/student/course/team/submitTeam";
                } else {
                    myteam = teamService.getTeamById(teamid);
                    model.addAttribute("myteam", myteam);
                }
                // 找到同course下的本小组成员

                List<Student> memberTeam = teamService.getStudentByTeamID(teamid);
                if (memberTeam.size() != 0) {
                    model.addAttribute("memberTeam", memberTeam);
                }
                if (myteam.getLeaderId() == id) {
                    return "student/course/team/leaderTeam";
                } else {
                    return "student/course/team/memberTeam";
                }
            }
        }
        return "";
    }

    @RequestMapping(value = "/check", method = RequestMethod.POST)
    @ResponseBody
    public void check(@RequestParam(value = "team") String[] team, String sid, int teamid, String klassId, String courseId, String teamname) throws IOException {
        int id = Integer.valueOf(sid);
        int courseid = Integer.valueOf(courseId);
        int klassid = Integer.valueOf(klassId);
        System.out.println(team.length);
        System.out.println(sid);
        System.out.println(teamid);
        System.out.println(klassId);
        System.out.println(courseId);
        System.out.println(teamname);
        //将学生学号转化为id
        List<Integer> list = new ArrayList<>();
        for (int i = 0; i < team.length; i++) {
            list.add(studentService.getStudentByAccounti(team[i]).getId());
        }
        boolean state = true;
        if (teamid != -1) {
            Team tempteam = teamService.getTeamByTeamID(teamid);
            teamService.dimissByTeamID(tempteam.getId());
            if (teamService.isValid(list, tempteam.getCourseId())) {
                teamService.createTeam(tempteam.getKlassId(), tempteam.getCourseId(), id, tempteam.getTeamName(), tempteam.getTeamSerial(), tempteam.getKlassSerial(), list, state);
                System.out.println("Success Valid Change");
            } else {
                state = false;
                teamService.createTeam(tempteam.getKlassId(), tempteam.getCourseId(), id, tempteam.getTeamName(), tempteam.getTeamSerial(), tempteam.getKlassSerial(), list, state);
                System.out.println("Success Invalid change");
            }
        } else {
            int teamSerial = teamService.getMaxTeamSerialByKlassId(klassid) + 1;
            int klassserial = teamService.getKlassSerialByKlassId(klassid);
            if (teamService.isValid(list, courseid)) {
                teamService.createTeam(klassid, courseid, id, teamname, teamSerial, klassserial, list, state);
                System.out.println("Success Valid Create");
            } else {
                state = false;
                teamService.createTeam(klassid, courseid, id, teamname, teamSerial, klassserial, list, state);
                System.out.println("Success Invalid Create");
            }
        }
    }

    @RequestMapping(value = "/apply", method = RequestMethod.POST)
    public String apply(Model model, @RequestParam(name = "id") String sid, @RequestParam(name = "course_id") String courseId) {
        int id = Integer.valueOf(sid);
        int courseid=Integer.valueOf(courseId);
        Course course=courseService.getCourseByCourseID(courseid);
        Student student = studentService.getStudentByID(id);
        model.addAttribute(student);
        model.addAttribute("course",course);
        return "/student/course/team/applyReason";
    }

    @RequestMapping(value = "/application", method = RequestMethod.POST)
    public String application(Model model, @RequestParam(name = "id") String sid, @RequestParam String reason, @RequestParam(name = "course_id") String courseid) {
        int id = Integer.valueOf(sid);
        int courseId = Integer.valueOf(courseid);
        int team = teamService.getTeamIdByLeaderIdAndCourseId(id,courseId);
        int teacher = courseService.getTeacherIdByCourseId(courseId);
        teamService.sendApplication(team, teacher, reason);
        teamService.changeStatusByTeamId(team);
        Student student = studentService.getStudentByID(id);
        List<Klass> klassList = klassService.getKlassByStudentID(id);
        List<Course> courseList = courseService.getCourseByStudentID(id);
        model.addAttribute(courseList);
        model.addAttribute(klassList);
        model.addAttribute(student);
        return "/student/courseManage";
    }

}