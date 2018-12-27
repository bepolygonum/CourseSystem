package com.flippedclassroom.entity;

import java.sql.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

/**
 * @author KEKE
 */
public class Course {
    private int id;
    private int teacherId;
    private String courseName;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getTeacherId() {
        return teacherId;
    }

    public void setTeacherId(int teacherId) {
        this.teacherId = teacherId;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public String getIntroduction() {
        return introduction;
    }

    public void setIntroduction(String introduction) {
        this.introduction = introduction;
    }

    public int getPresentationPercentage() {
        return presentationPercentage;
    }

    public void setPresentationPercentage(int presentationPercentage) {
        this.presentationPercentage = presentationPercentage;
    }

    public int getQuestionPercentage() {
        return questionPercentage;
    }

    public void setQuestionPercentage(int questionPercentage) {
        this.questionPercentage = questionPercentage;
    }

    public int getReportPercentage() {
        return reportPercentage;
    }

    public void setReportPercentage(int reportPercentage) {
        this.reportPercentage = reportPercentage;
    }

    public int getTeamMainCourseId() {
        return teamMainCourseId;
    }

    public void setTeamMainCourseId(int teamMainCourseId) {
        this.teamMainCourseId = teamMainCourseId;
    }

    public int getSeminarMainCourseId() {
        return seminarMainCourseId;
    }

    public void setSeminarMainCourseId(int seminarMainCourseId) {
        this.seminarMainCourseId = seminarMainCourseId;
    }

    private String introduction;
    private int presentationPercentage;
    private int questionPercentage;
    private int reportPercentage;
    private int teamMainCourseId;
    private int seminarMainCourseId;

    public Timestamp getTeamStartTime() {
        return teamStartTime;
    }

    public void setTeamStartTime(Timestamp teamStartTime) {
        this.teamStartTime = teamStartTime;
    }

    public Timestamp getTeamEndTime() {
        return teamEndTime;
    }

    public void setTeamEndTime(Timestamp teamEndTime) {
        this.teamEndTime = teamEndTime;
    }

    private Timestamp teamStartTime;
    private Timestamp teamEndTime;

   /* private Date startTime;
    private String teamStartTime;

    private Date endTime;
    private String teamEndTime;



    public void setStartTime(Date startTime) {
        this.startTime = startTime;

        SimpleDateFormat startSdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String time = startSdf.format(startTime);
        setTeamStartTime(time);
    }


    public void setEndTime(Date endTime) {
        this.endTime = endTime;
        SimpleDateFormat endSdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String time = endSdf.format(endTime);
        setTeamEndTime(time);
    }
*/

}
