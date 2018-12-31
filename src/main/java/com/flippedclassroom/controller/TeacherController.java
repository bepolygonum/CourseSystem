package com.flippedclassroom.controller;

import com.flippedclassroom.entity.*;
import com.flippedclassroom.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.*;
import java.util.stream.Collectors;

/**
 * @author KEKE
 */
@Controller
@RequestMapping(value = "/teacher")
public class TeacherController {
    @Autowired
    private CourseServiceImpl courseService;
    @Autowired
    private KlassServiceImpl klassService;
    @Autowired
    private RoundServiceImpl roundService;
    @Autowired
    private TeamServiceImpl teamService;
    @Autowired
    private TeacherServiceImpl teacherService;
    @Autowired
    private SeminarServiceImpl seminarService;
    @Autowired
    private CourseMemberLimitStrategyServiceImpl courseMemberLimitStrategyService;
    @Autowired
    private AttendanceServiceImpl attendanceService;

    @GetMapping(value = "/index")
    public String teacherIndex(Model model) {
        Teacher teacher = teacherService.getCurTeacher();
        model.addAttribute("teacher", teacher);
        if(!teacher.isActive()){
            return "/teacher/activation";
        }
        return "/teacher/home";
    }

    @RequestMapping(value = "/newactivation", method = RequestMethod.POST)
    public String studentActivate(Model model, @RequestParam(name = "id") String sid, @RequestParam String newmail, @RequestParam String newpass) {
        int id = Integer.valueOf(sid);
        Teacher teacher = teacherService.getTeacherByTeacherID(id);
        teacherService.setEmailByID(id, newmail);
        teacherService.setPassByID(id, newpass);
        teacherService.activate(id);
        model.addAttribute("teacher", teacher);
        return "/teacher/home";
    }

    @RequestMapping(value = "/home", method = RequestMethod.POST)
    public String teacherHome(Model model, @RequestParam String id) {
        int tid = Integer.parseInt(id);
        Teacher teacher = teacherService.getTeacherByTeacherID(tid);
        model.addAttribute(teacher);
        return "teacher/home";
    }


    @RequestMapping(value = "/courseManage", method = RequestMethod.POST)
    public String findCourse(Model model, @RequestParam String id) {
        int tid = Integer.parseInt(id);
        List<Course> courseList = courseService.getCourseByTeacherID(tid);
        model.addAttribute(courseList);
        model.addAttribute("id", tid);
        return "teacher/courseManage";
    }

   @RequestMapping(value = "/course/grade")
    public String findAllGrade(Model model,@RequestParam String id,@RequestParam String courseId)
    {
        int tid=Integer.parseInt(id);
        int courseid=Integer.parseInt(courseId);

        List<Round> roundList=roundService.getRoundByCourseID(courseid);
        System.out.print(roundList);
        if(!roundList.isEmpty()) {
            model.addAttribute(roundList);
            List<RoundScore> roundScoreList=roundService.getRoundScoreByCourseID(courseid);
            System.out.print(roundScoreList);
            if(!roundScoreList.isEmpty()){
                model.addAttribute(roundScoreList);
            }

        }
        //所有rounds的id集合
        List<Integer> roundIds=roundList.stream().map(Round::getId).collect(Collectors.toList());
        if(!roundIds.isEmpty())
        {
            List<Seminar> seminarList=roundService.getSeminarByRoundID(roundIds,courseid);
            //某课程下所有seminar的id
            List<Integer> seminarIds=seminarList.stream().map(Seminar::getId).collect(Collectors.toList());
            if(!seminarIds.isEmpty())
            {
                model.addAttribute(seminarList);
                List<SeminarScore> seminarScoreList=klassService.getSeminarScoreByCourseSeminarID(courseid,seminarIds);
                if(!seminarScoreList.isEmpty())
                {
                    model.addAttribute(seminarScoreList);
                }
                List<KlassSeminar> klassSeminarList=klassService.getKlassSeminarByCourseSeminarID(courseid,seminarIds);
                if(!klassSeminarList.isEmpty())
                {
                    model.addAttribute(klassSeminarList);
                }
            }

        }

        List<Team> teamList=teamService.getTeamByCourseID(courseid);
        if(!teamList.isEmpty()){
            model.addAttribute(teamList);
        }
        else
        {
            Course course=courseService.getCourseByCourseID(courseid);
            if(course.getTeamMainCourseId()>0)
            {
                teamList=teamService.getTeamByCourseID(course.getTeamMainCourseId());
                if(!teamList.isEmpty()){
                    model.addAttribute(teamList);
                }
            }

        }
        //List<Klass> klassList=klassService.getKlassByCourseID(courseid);
        //if(klassList!=null) {
          //  model.addAttribute(klassList);
        //}
        model.addAttribute("courseId",courseid);
        model.addAttribute("id",tid);
        return "/teacher/course/grade";
    }

    @RequestMapping(value = "/course/modifyGrade")
    public String modifyAGrade(Model model,@RequestParam int id,@RequestParam int courseId,@RequestParam int teamId,
                               @RequestParam int klassSeminarId,@RequestParam int roundId,
                               @RequestParam double preScore,@RequestParam double qaScore,@RequestParam double reportScore)
    {
        seminarService.updateSeminarScoreByKlassSeminarIdTeamId(klassSeminarId,teamId,preScore,qaScore,reportScore);
        Round round=roundService.getRoundByRoundID(roundId);
        List<Integer> seminarIds=seminarService.selectSeminarIdsByRoundId(roundId);
        Team team=teamService.getTeamById(teamId);
        List<Integer> klassSeminarIds=new ArrayList<>();
        for(int i=0;i<seminarIds.size();i++)
        {
            klassSeminarIds.add(klassService.getKlassSeminarIdByKlassIdAndSeminarId(team.getKlassId(),seminarIds.get(i)));
        }
        List<SeminarScore> seminarScores=seminarService.getSeminarScoreByKlassSeminarIDTeamID(klassSeminarIds,teamId);
        double presentationScore=0,questionScore=0,reScore=0,totalScore=0;
        List<Double> scoreList=roundService.computeModifyScore(round,seminarScores,courseId);
        totalScore=scoreList.get(0);
        presentationScore=scoreList.get(1);
        questionScore=scoreList.get(2);
        reScore=scoreList.get(3);

        roundService.updateRoundScoreByRoundIdTeamId(roundId,teamId,totalScore,presentationScore,questionScore,reScore);
        String tid=String.valueOf(id);
        String courseid=String.valueOf(courseId);
        return findAllGrade(model,tid,courseid);
    }


    @RequestMapping(value = "/course/teamList")
    public String findAllTeam(Model model,@RequestParam String id,@RequestParam String courseId)
    {
        int tid=Integer.parseInt(id);
        int courseid=Integer.parseInt(courseId);

        List<Team> teamList=new ArrayList<>();
        List<Klass> klassList=new ArrayList<>();

        Course course=courseService.getCourseByCourseID(courseid);
        System.out.print(tid);
        System.out.print(course.getCourseName());
        int teamMainCourseId=course.getTeamMainCourseId();
        System.out.print(teamMainCourseId);
        if(teamMainCourseId!=0)
        {
            teamList=teamService.getTeamByCourseID(teamMainCourseId);
            klassList=klassService.getKlassByCourseID(teamMainCourseId);
            System.out.print(teamList);


        }
        else
        {
            teamList=teamService.getTeamByCourseID(courseid);
            klassList=klassService.getKlassByCourseID(courseid);
        }


        //添加所有队伍
        List<List<Student>> listOfStudents = new ArrayList<List<Student>>();
        for (int i=0;i<teamList.size();i++){
            List<Student> members=teamService.getStudentByTeamID(teamList.get(i).getId());
            if(members!=null){
                listOfStudents.add(members);
            }
        }
        if(!listOfStudents.isEmpty()) {
            model.addAttribute("listOfStudents",listOfStudents);
        }
        if(!teamList.isEmpty())
        {
            model.addAttribute("teamList",teamList);
        }
        if(!klassList.isEmpty()){
            model.addAttribute("klassList",klassList);
        }

        model.addAttribute("id",tid);
        return "/teacher/course/teamList";
    }



    @RequestMapping(value = "/course/info")
    public String findCourseInfo(Model model, @RequestParam String id, @RequestParam String courseId) {
        int tid = Integer.parseInt(id);
        int courseid = Integer.parseInt(courseId);
        System.out.print(courseid);

        int conflictId = courseService.getConflictIdByCourseID(courseid);
        if (conflictId != 0) {
            List<Integer> courseIds = courseService.getConflictCourseIdByID(conflictId);
            List<Course> courseList = courseService.getCoursesByCourseID(courseIds);
            List<Integer> teacherIds = courseList.stream().map(Course::getTeacherId).collect(Collectors.toList());
            List<Teacher> teacherList = teacherService.getTeachersByTeacherID(teacherIds);
            model.addAttribute(courseList);
            model.addAttribute(teacherList);
        }

        Course course = courseService.getCourseByCourseID(courseid);
        System.out.print(course);
        CourseMemberLimitStrategy courseMemberLimitStrategy = courseService.getCourseMemberLimitByCourseID(courseid);

        if (courseMemberLimitStrategy != null) {
            model.addAttribute(courseMemberLimitStrategy);
        }
        System.out.print(courseMemberLimitStrategy);
        model.addAttribute(course);
        model.addAttribute("id", tid);
        return "/teacher/course/info";
    }


    @RequestMapping(value = "/course/createCourse")
    public String createCourse(Model model, @RequestParam String id) {
        int tid = Integer.parseInt(id);
        List<Course> courseList = courseService.getAllCourses();
        List<Teacher> teacherList = teacherService.getAllTeachers();
        model.addAttribute("id", tid);
        model.addAttribute(courseList);
        model.addAttribute(teacherList);
        return "/teacher/course/createCourse1";
    }


     @RequestMapping(value = "/course/createCourse",method = RequestMethod.POST)
    public String createACourse(Model model, @RequestParam String id, @RequestParam String courseName, @RequestParam String courseRequest, @RequestParam String presentation,
                                @RequestParam String question, @RequestParam String report, @RequestParam String startDateTime,@RequestParam String endDateTime,
                                 HttpServletResponse response) throws IOException//
    {
        response.setContentType("text/html;charset=gb2312");
        PrintWriter out = response.getWriter();
        int tid=Integer.parseInt(id);
        Course course=new Course();
        if(courseService.getCourseByCourseName(courseName)==null)
        {
            int presentationPercentage=Integer.parseInt(presentation);
            int questionPercentage=Integer.parseInt(question);
            int reportPercentage=Integer.parseInt(report);

            String[] start=startDateTime.split("T");
            String[] end=endDateTime.split("T");
            String tstartTime=start[0]+" "+start[1]+":00";
            String tendTime=end[0]+" "+end[1]+":00";

            Timestamp teamStartTime=Timestamp.valueOf(tstartTime);
            Timestamp teamEndTime=Timestamp.valueOf(tendTime);
            courseService.createACourse(tid,courseName,courseRequest,presentationPercentage,questionPercentage,reportPercentage,teamStartTime,teamEndTime);

            course=courseService.getCourseByCourseName(courseName);
            model.addAttribute(course);
        }
        else
        {
            out.print("<script>alert('课程名相同，创建失败');history.go(-1);</script>");
        }

        List<Course> courseList=courseService.getAllCourses();
        courseList.remove(course);
        List<Teacher> teacehrList=teacherService.getAllTeachers();
        model.addAttribute(courseList);
        model.addAttribute(teacehrList);
        model.addAttribute("id",tid);
        model.addAttribute("courseId",course.getId());
        return "/teacher/course/createCourse2";
    }

    @RequestMapping(value = "/course/createCourse2",method = RequestMethod.POST)
    public String createACourse(Model model, @RequestParam int id,@RequestParam int courseId, @RequestParam(defaultValue = "0") int request,@RequestParam int max,
                                @RequestParam int min, @RequestParam List<String> elective,@RequestParam List<Integer> smax,@RequestParam List<Integer> smin,
                                @RequestParam List<String> conflict, HttpServletResponse response) throws IOException//
    {
        response.setContentType("text/html;charset=gb2312");
        PrintWriter out = response.getWriter();
        System.out.print(conflict);
        int serial=1;
        System.out.print(min);
        System.out.print(max);
        int memberLimitStrategyId=teamService.createMemberLimitStrategy(min,max);
        System.out.print(memberLimitStrategyId);

        int teamAndStrategyMaxId=teamService.selectTeamAndStrategyMaxId();
        teamService.createTeamAndStrategy(teamAndStrategyMaxId+1,"MemberLimitStrategy",memberLimitStrategyId);

        teamService.createTeamStrategy(courseId,serial,"TeamAndStrategy",teamAndStrategyMaxId+1);
        serial=serial+1;

        if(elective.size()>1)
        {
            if(request==0)
            {
                for(int i=0;i<elective.size();i++)
                {
                    int electiveCourseId=Integer.parseInt(elective.get(i));
                    if(electiveCourseId!=0)
                    {
                        System.out.print(electiveCourseId);
                        System.out.print(smin.get(i));
                        System.out.print(smax.get(i));
                        int courseMemberLimitId=courseMemberLimitStrategyService.createCourseMemberLimitStrategy(courseId,smin.get(i),smax.get(i));
                        teamService.createTeamAndStrategy(teamAndStrategyMaxId+1,"CourseMemberLimitStrategy",courseMemberLimitId);
                    }
                }

            }
            else
            {
                int teamOrStrategyMaxId=teamService.selectTeamOrStrategyMaxId();
                for(int i=0;i<elective.size();i++)
                {
                    int electiveCourseId=Integer.parseInt(elective.get(i));
                    if(electiveCourseId!=0)
                    {
                        int courseMemberLimitId=courseMemberLimitStrategyService.createCourseMemberLimitStrategy(courseId,smin.get(i),smax.get(i));
                        teamService.createTeamOrStrategy(teamOrStrategyMaxId+1,"CourseMemberLimitStrategy",courseMemberLimitId);
                    }
                }
                teamService.createTeamAndStrategy(teamAndStrategyMaxId+1,"TeamOrStrategy",teamOrStrategyMaxId+1);

            }
            System.out.print(request);
        }
        else
        {
            int electiveCourseId=Integer.parseInt(elective.get(0));
            if(electiveCourseId!=0)
            {
                System.out.print(electiveCourseId);
                System.out.print(smin.get(0));
                System.out.print(smax.get(0));
                int courseMemberLimitId=courseMemberLimitStrategyService.createCourseMemberLimitStrategy(courseId,smin.get(0),smax.get(0));
                teamService.createTeamAndStrategy(teamAndStrategyMaxId+1,"CourseMemberLimitStrategy",courseMemberLimitId);
            }
        }

        int maxId=0;
        maxId=courseService.selectConflictCourseStrategyMaxId();
        int cid;
        for(int i=0;i<conflict.size();i++)
        {
            cid=Integer.parseInt(conflict.get(i));
            if(cid!=0)
            {
                courseService.createConflictCourse(maxId+1,courseId,cid);
                teamService.createTeamStrategy(courseId,serial,"ConflictCourseStrategy",maxId+1);
                serial=serial+1;
            }
        }

        List<Course> courseList=courseService.getCourseByTeacherID(id);
        model.addAttribute("id",id);
        model.addAttribute(courseList);
        return "/teacher/courseManage";
    }

    

    @RequestMapping(value = "/course/klassList")
    public String findAllKlasses(Model model, @RequestParam String id, @RequestParam String courseId) {
        int tid = Integer.parseInt(id);
        int courseid = Integer.parseInt(courseId);
        List<Klass> klassList = klassService.getKlassByCourseID(courseid);
        model.addAttribute(klassList);
        model.addAttribute("courseId", courseid);
        model.addAttribute("id", tid);
        return "/teacher/course/klassList";
    }

    @RequestMapping(value = "/course/klass/createKlass")
    public String createKlass(Model model, @RequestParam String id, @RequestParam String courseId) {
        int tid = Integer.parseInt(id);
        int courseid = Integer.parseInt(courseId);
        model.addAttribute("courseId", courseid);
        model.addAttribute("id", tid);
        return "teacher/course/klass/createKlass";

    }

    @RequestMapping(value = "/course/seminar")
    public String findAllSeminar(Model model, @RequestParam String id, @RequestParam String courseId) {
        int tid = Integer.parseInt(id);
        int courseid = Integer.parseInt(courseId);
        Course course = courseService.getCourseByCourseID(courseid);
        List<Round> roundList = roundService.getRoundByCourseID(courseid);
        List<Seminar> seminarList = seminarService.getSeminarByCourseID(courseid);
        List<Klass> klassList = klassService.getKlassByCourseID(courseid);

        List<Integer> seminarIds = seminarList.stream().map(Seminar::getId).collect(Collectors.toList());
        List<KlassSeminar> klassSeminarList = klassService.getKlassSeminarBySeminarID(seminarIds);

        model.addAttribute(course);
        model.addAttribute(roundList);
        model.addAttribute(seminarList);
        model.addAttribute(klassList);
        model.addAttribute(klassSeminarList);
        model.addAttribute("id", tid);
        return "teacher/course/seminarList";
    }

    @RequestMapping(value = "/course/share")
    public String findAllShare(Model model, @RequestParam String id, @RequestParam String courseId) {
        int tid = Integer.parseInt(id);
        int courseid = Integer.parseInt(courseId);
        List<Teacher> teacherList1 = new ArrayList<>();
        List<Teacher> teacherList2 = new ArrayList<>();
        Course course = courseService.getCourseByCourseID(courseid);
        //course为主课程
        int seminarMainCourseId = course.getSeminarMainCourseId();
        int teamMainCourseId = course.getTeamMainCourseId();
        List<Course> seminarCourseList = new ArrayList<>();
        Course seminarMainCourse = new Course();
        List<Course> teamCourseList = new ArrayList<>();
        Course teamMainCourse = new Course();

        if (seminarMainCourseId != 0) {
            seminarMainCourse = courseService.getCourseByCourseID(seminarMainCourseId);
            int teacherId = seminarMainCourse.getTeacherId();
            if (teacherId != 0) {
                teacherList1.add(teacherService.getTeacherByTeacherID(seminarMainCourse.getTeacherId()));
            }
        } else {
            seminarCourseList = courseService.getCourseBySeminarMainCourseID(courseid);
            List<Integer> teacherIds = seminarCourseList.stream().map(Course::getTeacherId).collect(Collectors.toList());
            if (!teacherIds.isEmpty()) {
                teacherList1.addAll(teacherService.getTeachersByTeacherID(teacherIds));
            }
        }

        if (teamMainCourseId != 0) {
            teamMainCourse = courseService.getCourseByCourseID(teamMainCourseId);
            int teacherId = teamMainCourse.getTeacherId();
            if (teacherId != 0) {
                teacherList2.add(teacherService.getTeacherByTeacherID(teamMainCourse.getTeacherId()));
            }
        } else {
            teamCourseList = courseService.getCourseByTeamMainCourseID(courseid);
            List<Integer> teacherIds = teamCourseList.stream().map(Course::getTeacherId).collect(Collectors.toList());
            if (!teacherIds.isEmpty()) {
                teacherList2.addAll(teacherService.getTeachersByTeacherID(teacherIds));
            }
        }
        model.addAttribute("seminarCourseList", seminarCourseList);
        model.addAttribute("seminarMainCourse", seminarMainCourse);
        model.addAttribute("teamCourseList", teamCourseList);
        model.addAttribute("teamMainCourse", teamMainCourse);
        model.addAttribute("teacherList1", teacherList1);
        model.addAttribute("teacherList2", teacherList2);
        model.addAttribute(course);
        model.addAttribute("id", tid);
        return "/teacher/course/shareList";
    }

    @RequestMapping(value = "course/seminar/createSeminar")
    public String createSeminarPage(Model model, @RequestParam String id, @RequestParam String courseId) {
        int tid = Integer.parseInt(id);
        int courseid = Integer.parseInt(courseId);
        int max = 0;
        Course course = courseService.getCourseByCourseID(courseid);
        List<Round> roundList = roundService.getRoundByCourseID(courseid);
        for (int i = 0; i < roundList.size(); i++) {
            if (roundList.get(i).getRoundSerial() > max) {
                max = roundList.get(i).getRoundSerial();
            }
        }
        //排序
        Collections.sort(roundList, new Round());
        //Round entity implement
        //第一个参数为List 第二个参数为对象的一个实例
        List<Seminar> seminarList = seminarService.getSeminarByCourseID(courseid);
        model.addAttribute(course);
        model.addAttribute("id", tid);
        model.addAttribute(roundList);
        model.addAttribute(seminarList);
        return "/teacher/course/seminar/createSeminar";
    }

    @RequestMapping(value = "course/seminar/createSeminar", method = RequestMethod.POST)
    public String createASeminar(Model model, @RequestParam String id, @RequestParam String courseId, @RequestParam String seminarName, @RequestParam String mainContent,
                                 @RequestParam String serial, @RequestParam String isVisible, @RequestParam String startDate, @RequestParam String endDate,
                                 @RequestParam String number, @RequestParam String round, HttpServletResponse response) throws IOException {
        response.setContentType("text/html;charset=gb2312");
        PrintWriter out = response.getWriter();
        int tid = Integer.parseInt(id);
        int courseid = Integer.parseInt(courseId);

        if (seminarService.getSeminarBySeminarName(seminarName) == null) {
            int seminarSerial = Integer.parseInt(serial);
            int teamNumber = Integer.parseInt(number);
            int roundId = Integer.parseInt(round);
            int nisVisible;
            if (isVisible.isEmpty()) {
                nisVisible = 0;
            } else {
                nisVisible = 1;
            }


            System.out.print(startDate);
            System.out.print(endDate);
            String[] start = startDate.split("T");
            String[] end = endDate.split("T");

            String tstartTime = start[0] + " " + start[1] + ":00";
            String tendTime = end[0] + " " + end[1] + ":00";


            if (roundId == 0) {
                int max = 0;
                List<Round> roundList = roundService.getRoundByCourseID(courseid);
                for (int i = 0; i < roundList.size(); i++) {
                    if (roundList.get(i).getRoundSerial() > max) {
                        max = roundList.get(i).getRoundSerial();
                    }
                }
                roundId = max + 1;
            }


            Timestamp teamStartTime = Timestamp.valueOf(tstartTime);
            Timestamp teamEndTime = Timestamp.valueOf(tendTime);
            seminarService.createASeminar(courseid, roundId, seminarName, mainContent, teamNumber, nisVisible, seminarSerial, teamStartTime, teamEndTime);

        } else {
            out.print("<script>alert('讨论课名相同，创建失败');history.go(-1);</script>");
        }

        Course course = courseService.getCourseByCourseID(courseid);
        List<Round> roundList = roundService.getRoundByCourseID(courseid);
        List<Seminar> seminarList = seminarService.getSeminarByCourseID(courseid);
        List<Klass> klassList = klassService.getKlassByCourseID(courseid);

        List<Integer> seminarIds = seminarList.stream().map(Seminar::getId).collect(Collectors.toList());
        List<KlassSeminar> klassSeminarList = klassService.getKlassSeminarBySeminarID(seminarIds);

        model.addAttribute(course);
        model.addAttribute(roundList);
        model.addAttribute(seminarList);
        model.addAttribute(klassList);
        model.addAttribute(klassSeminarList);
        model.addAttribute("id", tid);
        return "/teacher/course/seminarList";
    }

    @RequestMapping(value = "/course/roundSet")
    public String roundSet(Model model, @RequestParam int id, @RequestParam int courseId,@RequestParam int roundId) {
        Round round=roundService.getRoundByRoundID(roundId);
        List<Seminar> seminarList=seminarService.selectSeminarsByRoundId(roundId);
        if(!seminarList.isEmpty())
        {model.addAttribute("seminarList",seminarList);}
        int count=seminarList.size();
        List<Integer> numbers=new ArrayList<>();
        for(int i=1;i<=count;i++)
        {
            numbers.add(i);
        }
        List<Klass> klassList=klassService.getKlassByCourseID(courseId);
        if(!klassList.isEmpty()){model.addAttribute("klassList",klassList);}
        model.addAttribute("numbers",numbers);
        model.addAttribute(round);
        model.addAttribute("id",id);
        model.addAttribute("courseId",courseId);
        return "/teacher/course/roundSet";
    }

    @RequestMapping(value = "/course/setRound",method = RequestMethod.POST)
    public String modifyRound(Model model, @RequestParam int id, @RequestParam int courseId,@RequestParam int roundId,
                              @RequestParam int pre,@RequestParam int question,@RequestParam int report,
                              @RequestParam List<Integer> klassIds,@RequestParam List<Integer> apply) {
        roundService.updateRoundByRoundId(roundId,pre,report,question);
       // List<Klass> klassList=klassService.getKlassesByKlassIDs(klassIds);
        for(int i=0;i<klassIds.size();i++)
        {
            klassService.updateKlassRoundByRoundIdKlassId(klassIds.get(i),roundId,apply.get(i));
        }
        String tid=String.valueOf(id);
        String courseid=String.valueOf(courseId);
        return findAllSeminar(model,tid,courseid);
    }


    @RequestMapping(value = "/course/createShare")
    public String createShare(Model model, @RequestParam String id, @RequestParam String courseId) {
        int tid = Integer.parseInt(id);
        int courseid = Integer.parseInt(courseId);
        List<Course> courseList = courseService.getAllCourses();
        List<Teacher> teacherList = teacherService.getAllTeachers();
        model.addAttribute("courseId", courseid);
        model.addAttribute("id", tid);
        model.addAttribute(courseList);
        model.addAttribute(teacherList);
        return "teacher/course/createShare";
    }

    @RequestMapping(value = "/course/seminar/createKlass", method = RequestMethod.POST)
    public String createAKlass(Model model, @RequestParam String id, @RequestParam String courseId, @RequestParam int grade, @RequestParam int klass,
                               @RequestParam String firstCourse, @RequestParam String secondCourse, @RequestParam String location, HttpServletResponse response) throws IOException {
        response.setContentType("text/html;charset=gb2312");
        PrintWriter out = response.getWriter();
        int tid = Integer.parseInt(id);
        int courseid = Integer.parseInt(courseId);
        int second = Integer.parseInt(secondCourse);
        String time;
        if (klassService.getKlassByKlassID(klass) == null) {
            if (second <= 4) {
                time = "上午" + firstCourse + "," + secondCourse + "节";
            } else if (second <= 8) {
                time = "下午" + firstCourse + "," + secondCourse + "节";
            } else {
                time = "晚上" + firstCourse + "," + secondCourse + "节";
            }
            klassService.createAKlass(courseid, grade, klass, time, location);
        } else {
            out.print("<script>alert('班级名相同，创建失败');history.go(-1);</script>");
        }

        List<Klass> klassList = klassService.getKlassByCourseID(courseid);
        model.addAttribute(klassList);
        model.addAttribute("courseId", courseid);
        model.addAttribute("id", tid);
        return "/teacher/course/klassList";
    }

    @RequestMapping(value = "/course/createShare", method = RequestMethod.POST)
    public String createAShare(Model model, @RequestParam String id, @RequestParam String courseId, @RequestParam int shareType,
                               @RequestParam int shareCourse, HttpServletResponse response) throws IOException {
        response.setContentType("text/html;charset=gb2312");
        PrintWriter out = response.getWriter();
        int tid = Integer.parseInt(id);
        int courseid = Integer.parseInt(courseId);
        Course course = courseService.getCourseByCourseID(courseid);
        Course shareSubCourse = courseService.getCourseByCourseID(shareCourse);

        int mainCourseConflictId = courseService.getConflictIdByCourseID(courseid);
        int subCourseConflictId = courseService.getConflictIdByCourseID(shareCourse);

        if (mainCourseConflictId == subCourseConflictId) {
            out.print("<script>alert('两个课程冲突，不能建立共享');</script>");
        } else {
            int shareTeacherId = shareSubCourse.getTeacherId();
            //1:共享分组
            if (shareType == 1) {
                if (shareSubCourse.getTeamMainCourseId() == courseid) {
                    out.print("<script>alert('两个课程已经建立分组共享了');</script>");
                } else {
                    courseService.createShareTeamApplication(courseid, shareCourse, shareTeacherId);
                    out.print("<script>alert('已经发送分组共享请求');</script>");
                }
            } else {
                if (shareSubCourse.getSeminarMainCourseId() == courseid) {
                    out.print("<script>alert('两个课程已经建立讨论课共享了');</script>");
                } else {
                    courseService.createShareSeminarApplication(courseid, shareCourse, shareTeacherId);
                    out.print("<script>alert('已经发送讨论课共享请求');</script>");
                }
            }
        }
        List<Teacher> teacherList1 = new ArrayList<>();
        List<Teacher> teacherList2 = new ArrayList<>();
        //course为主课程
        int seminarMainCourseId = course.getSeminarMainCourseId();
        int teamMainCourseId = course.getTeamMainCourseId();
        List<Course> seminarCourseList = new ArrayList<>();
        Course seminarMainCourse = new Course();
        List<Course> teamCourseList = new ArrayList<>();
        Course teamMainCourse = new Course();
        if (seminarMainCourseId == 0) {
            seminarCourseList = courseService.getCourseBySeminarMainCourseID(courseid);
            List<Integer> teacherIds = seminarCourseList.stream().map(Course::getTeacherId).collect(Collectors.toList());
            if (!teacherIds.isEmpty()) {
                teacherList1.addAll(teacherService.getTeachersByTeacherID(teacherIds));
            }
        } else {
            seminarMainCourse = courseService.getCourseByCourseID(seminarMainCourseId);
            int teacherId = seminarMainCourse.getTeacherId();
            if (teacherId != 0) {
                teacherList1.add(teacherService.getTeacherByTeacherID(seminarMainCourse.getTeacherId()));
            }
        }
        if (teamMainCourseId == 0) {
            teamCourseList = courseService.getCourseByTeamMainCourseID(courseid);
            List<Integer> teacherIds = teamCourseList.stream().map(Course::getTeacherId).collect(Collectors.toList());
            if (!teacherIds.isEmpty()) {
                teacherList2.addAll(teacherService.getTeachersByTeacherID(teacherIds));
            }
        } else {
            teamMainCourse = courseService.getCourseByCourseID(teamMainCourseId);
            int teacherId = teamMainCourse.getTeacherId();
            if (teacherId != 0) {
                teacherList2.add(teacherService.getTeacherByTeacherID(teamMainCourse.getTeacherId()));
            }
        }
        model.addAttribute("seminarCourseList", seminarCourseList);
        model.addAttribute("seminarMainCourse", seminarMainCourse);
        model.addAttribute("teamCourseList", teamCourseList);
        model.addAttribute("teamMainCourse", teamMainCourse);
        model.addAttribute("teacherList1", teacherList1);
        model.addAttribute("teacherList2", teacherList2);
        model.addAttribute(course);
        model.addAttribute("id", tid);
        return "/teacher/course/shareList";
    }

    @RequestMapping(value = "/course/delete", method = RequestMethod.POST)
    public String deleteCourse(Model model, @RequestParam int id, @RequestParam int courseId) {
        courseService.deleteCourseByCourseId(courseId);
        List<Course> courseList = courseService.getCourseByTeacherID(id);
        model.addAttribute(courseList);
        model.addAttribute("id", id);
        return "teacher/courseManage";
    }

    @RequestMapping(value = "/course/klass/delete", method = RequestMethod.POST)
    public String deleteCourse(Model model, @RequestParam int id, @RequestParam int courseId, @RequestParam int klassId) {
        klassService.deleteKlassByKlassId(klassId);
        klassService.deleteKlassStudentByKlassId(klassId);
        List<Klass> klassList = klassService.getKlassByCourseID(courseId);
        model.addAttribute(klassList);
        model.addAttribute("courseId", courseId);
        model.addAttribute("id", id);
        return "/teacher/course/klassList";
    }

    @RequestMapping(value = "/course/share/delete", method = RequestMethod.POST)
    public String deleteCourse(Model model, @RequestParam int id, @RequestParam int courseId, @RequestParam int shareCourseId,
                               @RequestParam String flag) {
        String subSeminar = "subSeminar";
        String subTeam = "subTeam";
        String mainSeminar = "mainSeminar";
        String mainTeam = "mainTeam";
        if (subSeminar.equals(flag)) {
            courseService.updateCourseSeminarMainIdByCourseId(courseId);
        } else if (subTeam.equals(flag)) {
            courseService.updateCourseTeamMainIdByCourseId(courseId);
        } else if (mainSeminar.equals(flag)) {
            courseService.updateCourseSeminarMainIdByCourseId(shareCourseId);
        } else if (mainTeam.equals(flag)) {
            courseService.updateCourseTeamMainIdByCourseId(shareCourseId);
        }


        List<Teacher> teacherList1 = new ArrayList<>();
        List<Teacher> teacherList2 = new ArrayList<>();
        Course course = courseService.getCourseByCourseID(courseId);
        //course为主课程
        int seminarMainCourseId = course.getSeminarMainCourseId();
        int teamMainCourseId = course.getTeamMainCourseId();
        List<Course> seminarCourseList = new ArrayList<>();
        Course seminarMainCourse = new Course();
        List<Course> teamCourseList = new ArrayList<>();
        Course teamMainCourse = new Course();

        if (seminarMainCourseId != 0) {
            seminarMainCourse = courseService.getCourseByCourseID(seminarMainCourseId);
            int teacherId = seminarMainCourse.getTeacherId();
            if (teacherId != 0) {
                teacherList1.add(teacherService.getTeacherByTeacherID(seminarMainCourse.getTeacherId()));
            }
        } else {
            seminarCourseList = courseService.getCourseBySeminarMainCourseID(courseId);
            List<Integer> teacherIds = seminarCourseList.stream().map(Course::getTeacherId).collect(Collectors.toList());
            if (!teacherIds.isEmpty()) {
                teacherList1.addAll(teacherService.getTeachersByTeacherID(teacherIds));
            }
        }

        if (teamMainCourseId != 0) {
            teamMainCourse = courseService.getCourseByCourseID(teamMainCourseId);
            int teacherId = teamMainCourse.getTeacherId();
            if (teacherId != 0) {
                teacherList2.add(teacherService.getTeacherByTeacherID(teamMainCourse.getTeacherId()));
            }
        } else {
            teamCourseList = courseService.getCourseByTeamMainCourseID(courseId);
            List<Integer> teacherIds = teamCourseList.stream().map(Course::getTeacherId).collect(Collectors.toList());
            if (!teacherIds.isEmpty()) {
                teacherList2.addAll(teacherService.getTeachersByTeacherID(teacherIds));
            }
        }
        System.out.print(seminarCourseList);
        System.out.print(teamCourseList);
        System.out.print(teacherList1);
        System.out.print(teacherList2);
        model.addAttribute("seminarCourseList", seminarCourseList);
        model.addAttribute("seminarMainCourse", seminarMainCourse);
        model.addAttribute("teamCourseList", teamCourseList);
        model.addAttribute("teamMainCourse", teamMainCourse);
        model.addAttribute("teacherList1", teacherList1);
        model.addAttribute("teacherList2", teacherList2);
        model.addAttribute(course);
        model.addAttribute("id", id);
        return "/teacher/course/shareList";

    }

    @RequestMapping(value = "/personalInfo", method = RequestMethod.POST)
    public String personalInformation(Model model, @RequestParam(name = "id") String tid) {
        int id = Integer.valueOf(tid);
        Teacher teacher = teacherService.getTeacherByTeacherID(id);
        model.addAttribute(teacher);
        return "/teacher/person/personalInfo";
    }

    @RequestMapping(value = "/modifyEmail", method = RequestMethod.POST)
    public String modifyEmail(Model model, @RequestParam(name = "id") String tid) {
        int id = Integer.valueOf(tid);
        Teacher teacher = teacherService.getTeacherByTeacherID(id);
        model.addAttribute(teacher);
        return "/teacher/person/modifyEmail";
    }

    @RequestMapping(value = "/newmail", method = RequestMethod.POST)
    public String newEmail(Model model, @RequestParam(name = "id") String tid, @RequestParam String newmail) {
        int id = Integer.valueOf(tid);
        teacherService.setEmailByID(id, newmail);
        Teacher teacher = teacherService.getTeacherByTeacherID(id);
        model.addAttribute(teacher);
        return "/teacher/person/personalInfo";
    }


    @RequestMapping(value = "/modifyPassword", method = RequestMethod.POST)
    public String modifyPassword(Model model, @RequestParam(name = "id") String tid) {
        int id = Integer.valueOf(tid);
        Teacher teacher = teacherService.getTeacherByTeacherID(id);
        model.addAttribute(teacher);
        return "/teacher/person/modifyPassword";
    }


    @RequestMapping(value = "/newpass", method = RequestMethod.POST)
    public String newPass(Model model, @RequestParam(name = "id") String tid, @RequestParam String newpass) {
        int id = Integer.valueOf(tid);
        teacherService.setPassByID(id, newpass);
        Teacher teacher = teacherService.getTeacherByTeacherID(id);
        model.addAttribute(teacher);
        return "/teacher/person/personalInfo";
    }

    /**
     * 需要传的值
     * 教师
     * 所有课程名
     * 所有正在进行的讨论课（包括seminar的课程班级）
     * */
    @RequestMapping(value = "/seminar",method = RequestMethod.GET)
    public String seminar(Model model,@RequestParam(name="id") String tid){
        int id = Integer.valueOf(tid);
        Teacher teacher = teacherService.getTeacherByTeacherID(id);
        List<Course> coursesList = courseService.getCourseByTeacherID(teacher.getId());
        //添加所有klass
        List<Klass> klassList=new ArrayList<>();
        for(int i=0;i<coursesList.size();i++){
            klassList.addAll(klassService.getKlassByCourseID(coursesList.get(i).getId()));
        }
        //添加所有klassId
        List klassIds=new ArrayList<>();
        for(int i=0;i<klassList.size();i++){
            klassIds.add(klassList.get(i).getId());
        }
        //添加所有running的讨论课
        List<KlassSeminar> klassSeminarList=klassService.getKlassSeminarRunning(klassIds);
        List<Seminar> seminarList = new ArrayList<>();
        klassList.clear();
        for(int i=0;i<klassSeminarList.size();i++){
            seminarList.add(seminarService.getSeminarBySeminarId(klassSeminarList.get(i).getSeminarId()));
            klassList.add(klassService.getKlassByKlassID(klassSeminarList.get(i).getKlassId()));
        }
        //添加所有running的讨论课的课程
        List<Integer> courseIds=new ArrayList<>();
        for(int i=0;i<klassList.size();i++){
            courseIds.add(klassList.get(i).getCourseId());
        }
        List<Course> courseKlassList=new ArrayList<>();
        for(int i=0;i<courseIds.size();i++) {
            courseKlassList.add(courseService.getCourseByCourseID(courseIds.get(i)));
        }
        model.addAttribute("courseKlassList",courseKlassList);
        model.addAttribute(seminarList);
        model.addAttribute(klassList);
        model.addAttribute(coursesList);
        model.addAttribute(teacher);
        return "teacher/seminar/seminar-home";
    }

    @RequestMapping(value = "/seminarRunning",method = RequestMethod.GET)
    String running(Model model,@RequestParam String klassid,@RequestParam String seminarid){
        int klassId=Integer.parseInt(klassid);
        int seminarId=Integer.parseInt(seminarid);
        Seminar seminar=seminarService.getSeminarBySeminarId(seminarId);
        int klassSeminarId = klassService.getKlassSeminarByKlassIDSeminarID(klassId,seminarId);
        List<Attendance> attendances = attendanceService.getAttendanceByklassSeminarId(klassSeminarId);
        List teamIds=new ArrayList();
        for(int i=0;i<attendances.size();i++){
            teamIds.add(attendances.get(i).getTeamId());
        }
        List<Team> teamList = teamService.getTeamByIds(teamIds);
        model.addAttribute("seminar",seminar);
        //展示的team，按展示顺序排列
        model.addAttribute(teamList);
        //展示的attendance，按展示顺序排列
        model.addAttribute(attendances);
        return "teacher/seminar/seminar-running";
    }


}
