package com.flippedclassroom.entity;

import org.springframework.stereotype.Component;

import java.util.List;

/**
 * @author ChenHao
 */
public class WebSocketMessage {
    private String role;
    private String action;
    private Integer seminarId;
    private Integer studentId;
    private String studentName;
    private Integer currentTeamIndex;
    private Integer currentStudents;
    private WebSocketTeamStudentInfo newQuestionStudentInfo;
    private List<WebSocketTeamStudentInfo> currentQuestionStudentInfoList;

    public void setNewQuestionStudentInfo(WebSocketTeamStudentInfo newQuestionStudentInfo) {
        this.newQuestionStudentInfo = newQuestionStudentInfo;
    }

    public WebSocketTeamStudentInfo getNewQuestionStudentInfo() {
        return newQuestionStudentInfo;
    }

    public Integer getCurrentStudents() {
        return currentStudents;
    }

    public Integer getCurrentTeamIndex() {
        return currentTeamIndex;
    }

    public void setCurrentStudents(Integer currentStudents) {
        this.currentStudents = currentStudents;
    }

    public void setCurrentTeamIndex(Integer currentTeamIndex) {
        this.currentTeamIndex = currentTeamIndex;
    }

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public List<WebSocketTeamStudentInfo> getCurrentQuestionStudentInfoList() {
        return currentQuestionStudentInfoList;
    }

    public void setCurrentQuestionStudentInfoList(List<WebSocketTeamStudentInfo> currentQuestionStudentInfoList) {
        this.currentQuestionStudentInfoList = currentQuestionStudentInfoList;
    }

    public void setSeminarId(Integer seminarId) {
        this.seminarId = seminarId;
    }

    public Integer getSeminarId() {
        return seminarId;
    }

    public void setStudentId(Integer studentId) {
        this.studentId = studentId;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getRole() {
        return role;
    }

    public String getAction() {
        return action;
    }

    public Integer getStudentId() {
        return studentId;
    }

    public void setAction(String action) {
        this.action = action;
    }
}
