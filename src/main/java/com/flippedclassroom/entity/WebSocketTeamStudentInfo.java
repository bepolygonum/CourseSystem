package com.flippedclassroom.entity;

/**
 * @author ChenHao
 */
public class WebSocketTeamStudentInfo {
    private Integer teamId;
    private Integer teamSerial;
    private Integer classSerial;
    private Integer studentId;
    private String studentName;

    public WebSocketTeamStudentInfo(Integer teamId,Integer teamSerial, Integer classSerial, Integer studentId, String studentName ){
        this.teamId = teamId;
        this.teamSerial = teamSerial;
        this.classSerial = classSerial;
        this.studentId = studentId;
        this.studentName = studentName;
    }

    public void setTeamSerial(Integer teamSerial) {
        this.teamSerial = teamSerial;
    }

    public Integer getClassSerial() {
        return classSerial;
    }

    public int getTeamSerial() {
        return teamSerial;
    }

    public void setTeamSerial(int teamSerial) {
        this.teamSerial = teamSerial;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public void setTeamId(int teamId) {
        this.teamId = teamId;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public String getStudentName() {
        return studentName;
    }

    public int getStudentId() {
        return studentId;
    }

    public int getTeamId() {
        return teamId;
    }
}
