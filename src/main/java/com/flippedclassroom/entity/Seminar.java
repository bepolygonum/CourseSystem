package com.flippedclassroom.entity;

import java.sql.Timestamp;

/**
 * @author KEKE
 */
public class Seminar {
    private int id;
    private int courseId;
    private int roundId;
    private String seminarName;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCourseId() {
        return courseId;
    }

    public void setCourseId(int courseId) {
        this.courseId = courseId;
    }

    public int getRoundId() {
        return roundId;
    }

    public void setRoundId(int roundId) {
        this.roundId = roundId;
    }

    public String getSeminarName() {
        return seminarName;
    }

    public void setSeminarName(String seminarName) {
        this.seminarName = seminarName;
    }

    public String getIntroduction() {
        return introduction;
    }

    public void setIntroduction(String introduction) {
        this.introduction = introduction;
    }

    public int getMaxTeam() {
        return maxTeam;
    }

    public void setMaxTeam(int maxTeam) {
        this.maxTeam = maxTeam;
    }

    public int getIsVisible() {
        return isVisible;
    }

    public void setIsVisible(int isVisible) {
        this.isVisible = isVisible;
    }

    public int getSeminarSerial() {
        return seminarSerial;
    }

    public void setSeminarSerial(int seminarSerial) {
        this.seminarSerial = seminarSerial;
    }

    public Timestamp getEnrollStartTime() {
        return enrollStartTime;
    }

    public void setEnrollStartTime(Timestamp enrollStartTime) {
        this.enrollStartTime = enrollStartTime;
    }

    public Timestamp getEnrollEndTime() {
        return enrollEndTime;
    }

    public void setEnrollEndTime(Timestamp enrollEndTime) {
        this.enrollEndTime = enrollEndTime;
    }

    private String introduction;
    private int maxTeam;
    private int isVisible;
    private int seminarSerial;
    private Timestamp enrollStartTime;
    private Timestamp enrollEndTime;


}
