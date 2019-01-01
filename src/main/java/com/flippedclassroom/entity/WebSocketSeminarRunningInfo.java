package com.flippedclassroom.entity;

/**
 * @author ChenHao
 */
public class WebSocketSeminarRunningInfo {
    /**
     * 当前展示小组下标
     */
    private Integer currentTeamIndex = 0;
    /**
     * 当前讨论课在线人数
     */
    private Integer currentStudents = 0;

    /**
     * 如果当教师进入讨论课时，当前讨论课的信息未建立，则新建一份 默认构造函数
     */
    public WebSocketSeminarRunningInfo(){
        this.currentStudents = 0;
        this.currentTeamIndex = 0;
    }

    public void setCurrentTeamIndex(Integer currentTeamIndex) {
        this.currentTeamIndex = currentTeamIndex;
    }

    public void setCurrentStudents(Integer currentStudents) {
        this.currentStudents = currentStudents;
    }

    public Integer getCurrentTeamIndex() {
        return currentTeamIndex;
    }

    public  Integer getCurrentStudents() {
        return currentStudents;
    }
}
